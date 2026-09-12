import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  clearMagicalDarkness,
  MAGICAL_DARKNESS_SPELL_SLUG,
  setMagicalDarkness,
} from '../../domain/arena-effects';
import { appendCombatLog } from '../../domain/combat-log';
import {
  assertCanTakeDuelAction,
  resolveDuelAttackVisionMode,
} from '../../domain/duel-combat-gates';
import {
  assertValidDuelConditionSlug,
  mergeConditions,
  resolveDuelSpellEffect,
} from '../../domain/duel-spell-resolve';
import { applyDuelDamageToTarget } from '../../domain/apply-duel-damage';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import type { DuelCombatSnapshot } from '../duel-combat-snapshot';
import { loadConditions, type ConditionsDeps } from './conditions';
import { seesMagicalDarkness, type VisionDeps } from './vision';
import {
  advanceTurnFully,
  afterDamage,
  maybeSkipPendingExileTurn,
  type TurnDeps,
} from './turn';

export type SpellsDeps = {
  repo: DuelRepository;
  state: CharacterStateRepository;
  sheet: CharacterSheetRepository;
  access: PlayerCharacterAccessService;
  snapshot: DuelCombatSnapshot;
  domain: CharacterDomainService;
  dataSource: DataSource;
};

function conditionsDeps(deps: SpellsDeps): ConditionsDeps {
  return { repo: deps.repo, state: deps.state };
}

function visionDeps(deps: SpellsDeps): VisionDeps {
  return { sheet: deps.sheet };
}

function turnDeps(deps: SpellsDeps): TurnDeps {
  return {
    repo: deps.repo,
    state: deps.state,
    snapshot: deps.snapshot,
  };
}

export async function spellAttackBonus(
  deps: SpellsDeps,
  characterId: string,
): Promise<number> {
  const character = await deps.repo.findCharacterById(characterId);
  if (!character) return 0;
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const abilitySlug = await loadSpellcastingAbilitySlug(
    deps.dataSource,
    character.classSlug,
  );
  const mods = computeAbilityModifiers(character.abilityScores);
  const abilityMod = abilitySlug ? (mods[abilitySlug] ?? 0) : 0;
  return pb + abilityMod;
}

export async function castSpell(
  deps: SpellsDeps,
  userId: string,
  duelId: string,
  input: { spellSlug: string; slotLevel?: number },
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['active']);

  const caster = members.find((m) => m.userId === userId);
  const opponent = members.find((m) => m.userId !== userId);
  if (!caster || !opponent) {
    throw new BadRequestException('Duel needs two participants');
  }
  if (duel.turnCharacterId !== caster.characterId) {
    throw new BadRequestException('Not your turn');
  }

  await maybeSkipPendingExileTurn(turnDeps(deps), duel, members);
  if (duel.turnCharacterId !== caster.characterId) {
    throw new BadRequestException('Not your turn');
  }

  assertCanTakeDuelAction(
    await loadConditions(conditionsDeps(deps), caster.characterId, members),
  );

  const casterPc = await deps.access.findOwnedOrFail(
    userId,
    caster.characterId,
  );
  const cast = await deps.state.castSpell(casterPc, {
    spellSlug: input.spellSlug,
    slotLevel: input.slotLevel,
  });

  if (
    duel.arenaEffectSourceCharacterId === caster.characterId &&
    cast.state.concentratingOn !== MAGICAL_DARKNESS_SPELL_SLUG
  ) {
    duel.arenaEffects = clearMagicalDarkness(duel.arenaEffects);
    duel.arenaEffectSourceCharacterId = null;
  }

  const defenderPc = await deps.repo.findCharacterById(opponent.characterId);
  if (!defenderPc) {
    throw new BadRequestException('Opponent not found');
  }

  const [armorMap, attackerSees, defenderSees, spellAtk] = await Promise.all([
    deps.snapshot.resolveArmorByCharacter([defenderPc]),
    seesMagicalDarkness(visionDeps(deps), caster.characterId),
    seesMagicalDarkness(visionDeps(deps), opponent.characterId),
    spellAttackBonus(deps, caster.characterId),
  ]);
  const advantage = resolveDuelAttackVisionMode({
    arenaEffects: duel.arenaEffects,
    attackerSeesMagicalDarkness: attackerSees,
    defenderSeesMagicalDarkness: defenderSees,
  });

  const resolution = resolveDuelSpellEffect({
    spellSlug: input.spellSlug,
    slotLevel: cast.slotLevelUsed ?? input.slotLevel ?? 0,
    characterLevel: casterPc.level,
    spellAttackBonus: spellAtk,
    targetAc: armorMap.get(defenderPc.id) ?? 10,
    advantage,
    castNote: cast.note ?? undefined,
  });

  let log = duel.combatLog ?? [];
  const casterName = casterPc.name;

  if (resolution.kind === 'arena_darkness') {
    duel.arenaEffects = setMagicalDarkness(duel.arenaEffects);
    duel.arenaEffectSourceCharacterId = caster.characterId;
    log = appendCombatLog(
      log,
      `${casterName} conjurou Escuridão — a arena está em escuridão mágica (Visão no Escuro não atravessa).`,
    );
    await advanceTurnFully(turnDeps(deps), duel, members, caster.characterId);
    duel.combatLog = log;
    return { duel: await deps.repo.saveDuel(duel), members };
  }

  if (resolution.kind === 'auto_damage') {
    const applied = await applyDuelDamageToTarget({
      state: deps.state,
      member: opponent,
      target: defenderPc,
      damage: resolution.damage,
    });
    log = appendCombatLog(
      log,
      `${casterName}: ${resolution.label} — ${applied.damageTotal} de dano. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
    );
    return afterDamage(turnDeps(deps), {
      duel,
      members,
      log,
      attacker: caster,
      attackerName: casterName,
      defenderName: defenderPc.name,
      hitPointsAfter: opponent.hitPointsCurrent ?? applied.hitPointsAfter,
      spendAttack: false,
    });
  }

  if (resolution.kind === 'spell_attack') {
    if (!resolution.hit) {
      log = appendCombatLog(
        log,
        `${casterName}: ${resolution.label} — errou (total ${resolution.attackTotal}).`,
      );
      await advanceTurnFully(turnDeps(deps), duel, members, caster.characterId);
      duel.combatLog = log;
      return { duel: await deps.repo.saveDuel(duel), members };
    }
    const applied = await applyDuelDamageToTarget({
      state: deps.state,
      member: opponent,
      target: defenderPc,
      damage: resolution.damage,
    });
    log = appendCombatLog(
      log,
      `${casterName}: ${resolution.label}${resolution.critical ? ' (crítico)' : ''} — acerto! Dano ${applied.damageTotal}. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
    );
    return afterDamage(turnDeps(deps), {
      duel,
      members,
      log,
      attacker: caster,
      attackerName: casterName,
      defenderName: defenderPc.name,
      hitPointsAfter: opponent.hitPointsCurrent ?? applied.hitPointsAfter,
      spendAttack: false,
    });
  }

  log = appendCombatLog(
    log,
    `${casterName} conjurou ${input.spellSlug}: ${resolution.note}`,
  );
  await advanceTurnFully(turnDeps(deps), duel, members, caster.characterId);
  duel.combatLog = log;
  return { duel: await deps.repo.saveDuel(duel), members };
}

export async function changeCondition(
  deps: SpellsDeps,
  userId: string,
  duelId: string,
  input: {
    action: 'add' | 'remove';
    target: 'self' | 'opponent';
    condition: string;
  },
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['active']);

  const actor = members.find((m) => m.userId === userId);
  const opponent = members.find((m) => m.userId !== userId);
  if (!actor || !opponent) {
    throw new BadRequestException('Duel needs two participants');
  }
  if (duel.turnCharacterId !== actor.characterId) {
    throw new BadRequestException('Not your turn');
  }

  assertCanTakeDuelAction(
    await loadConditions(conditionsDeps(deps), actor.characterId, members),
  );
  assertValidDuelConditionSlug(input.condition);

  const targetMember = input.target === 'self' ? actor : opponent;
  const targetPc = await deps.repo.findCharacterById(targetMember.characterId);
  if (!targetPc) {
    throw new BadRequestException('Target not found');
  }

  const current = await loadConditions(
    conditionsDeps(deps),
    targetPc.id,
    members,
  );
  const next = mergeConditions({
    current,
    action: input.action,
    condition: input.condition,
  });
  if (targetMember.hitPointsCurrent != null) {
    targetMember.conditions = next;
    await deps.repo.saveMember(targetMember);
  } else {
    await deps.state.patch(targetPc, { conditions: next });
  }

  const actorPc = await deps.repo.findCharacterById(actor.characterId);
  const log = appendCombatLog(
    duel.combatLog,
    `${actorPc?.name ?? 'Jogador'} ${input.action === 'add' ? 'aplicou' : 'removeu'} ${input.condition} em ${targetPc.name}.`,
  );
  await advanceTurnFully(turnDeps(deps), duel, members, actor.characterId);
  duel.combatLog = log;
  return { duel: await deps.repo.saveDuel(duel), members };
}
