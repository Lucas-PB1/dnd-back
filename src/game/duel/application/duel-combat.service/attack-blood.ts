import { BadRequestException } from '@nestjs/common';
import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '@game/sheet/domain/validation/class-options/subclass-option-effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  BLOOD_CONDITION_WITHERING,
  BLOOD_STRIKE_TABLE_ACTION,
  isBloodHoundSubclass,
} from '@game/combat/domain/fighter';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import {
  findStrikeOptionForTableAction,
  type StrikeOption,
} from '@game/combat/domain/strike-option';
import {
  addPendingEffect,
  consumePendingEffect,
} from '@game/combat/domain/pending-combat-effect';
import {
  halfDamage,
  rollStrikeSecondaryDice,
  type StrikeHitPackage,
} from '@game/combat/domain/resolve-strike-hit-package';
import { asArenaEffects, setMagicalDarkness } from '../../domain/arena-effects';
import { appendCombatLog } from '../../domain/combat-log';
import { mergeConditions } from '../../domain/duel-spell-resolve';
import { applyDuelDamageToTarget } from '../../domain/apply-duel-damage';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import type { DuelCombatSnapshot } from '../duel-combat-snapshot';
import { loadConditions, type ConditionsDeps } from './conditions';
import { afterDamage, type TurnDeps } from './turn';

export type AttackBloodDeps = {
  repo: DuelRepository;
  rolls: CharacterRollsService;
  state: CharacterStateRepository;
  sheet: CharacterSheetRepository;
  snapshot: DuelCombatSnapshot;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

function conditionsDeps(deps: AttackBloodDeps): ConditionsDeps {
  return { repo: deps.repo, state: deps.state };
}

function turnDeps(deps: AttackBloodDeps): TurnDeps {
  return {
    repo: deps.repo,
    state: deps.state,
    snapshot: deps.snapshot,
  };
}

export async function assertStrikeOptionReady(
  deps: AttackBloodDeps,
  character: PlayerCharacter,
  optionSlug: string,
): Promise<StrikeOption> {
  if (!isBloodHoundSubclass(character.subclassSlug) || character.level < 3) {
    throw new BadRequestException('Golpe de Sangue não disponível');
  }
  const catalog = await deps.mechanicalCatalog.load();
  const option = findStrikeOptionForTableAction(
    catalog.strikeOptions,
    optionSlug,
    BLOOD_STRIKE_TABLE_ACTION,
  );
  if (!option?.costDice) {
    throw new BadRequestException(
      `Opção de Golpe de Sangue desconhecida: ${optionSlug}`,
    );
  }
  const sheet = await deps.sheet.load(character.id);
  const known = (sheet.subclassOptions ?? []).some(
    (opt) =>
      BLOOD_STRIKE_OPTION_KEY_RE.test(opt.optionKey) &&
      opt.valueId === optionSlug,
  );
  if (!known) {
    throw new BadRequestException(
      'Personagem não conhece esta opção de Golpe de Sangue',
    );
  }
  return option;
}

export async function resolveBloodExplosion(
  deps: AttackBloodDeps,
  input: {
    attackerUserId: string;
    defenderUserId: string;
    attackerCharacterId: string;
    defenderCharacterId: string;
    itemSlug: string;
    mode: 'melee' | 'ranged';
    saveDc: number;
  },
): Promise<{ damage: number; note: string }> {
  const damageRoll = await deps.rolls.rollDamage(
    input.attackerUserId,
    input.attackerCharacterId,
    {
      itemSlug: input.itemSlug,
      mode: input.mode,
      critical: false,
    },
  );
  const full = Math.max(0, damageRoll.total);
  const save = await deps.rolls.rollSavingThrow(
    input.defenderUserId,
    input.defenderCharacterId,
    { abilitySlug: 'constituicao' },
  );
  const success = save.total >= input.saveDc;
  const damage = success ? halfDamage(full) : full;
  return {
    damage,
    note: `Explosão de Sangue: CON ${save.total} vs CD ${input.saveDc} — ${success ? 'sucesso (metade)' : 'falha'} (${full} arma).`,
  };
}

export async function resolveBloodshardAttack(
  deps: AttackBloodDeps,
  input: {
    duel: Duel;
    members: DuelMember[];
    attacker: DuelMember;
    defender: DuelMember;
    attackerPc: PlayerCharacter;
    defenderPc: PlayerCharacter;
    input: {
      itemSlug: string;
      mode: 'melee' | 'ranged';
      damageTypeOverride?: 'acid' | 'necrotic' | 'poison';
    };
    strikePkg: StrikeHitPackage;
    strikeOption: StrikeOption;
    saveDc: number;
    bloodCostNote: string | null;
  },
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const damageRoll = await deps.rolls.rollDamage(
    input.attacker.userId,
    input.attacker.characterId,
    {
      itemSlug: input.input.itemSlug,
      mode: input.input.mode,
      critical: false,
    },
  );
  const piercing = rollStrikeSecondaryDice({
    option: input.strikeOption,
    level: input.attackerPc.level,
  });
  let full = Math.max(0, damageRoll.total) + piercing.total;
  const withering = consumePendingEffect(
    input.duel.arenaEffects,
    BLOOD_CONDITION_WITHERING,
    input.attacker.characterId,
  );
  input.duel.arenaEffects = asArenaEffects(withering.effects);
  if (withering.consumed) {
    full = halfDamage(full);
  }

  const save = await deps.rolls.rollSavingThrow(
    input.defender.userId,
    input.defender.characterId,
    { abilitySlug: 'destreza' },
  );
  const success = save.total >= input.saveDc;
  const damage = success ? halfDamage(full) : full;

  let log = input.duel.combatLog ?? [];
  if (input.bloodCostNote) {
    log = appendCombatLog(
      log,
      `${input.attackerPc.name}: ${input.bloodCostNote}`,
    );
  }
  log = appendCombatLog(
    log,
    `${input.attackerPc.name}: ${input.strikePkg.label} (linha) — DEX ${save.total} vs CD ${input.saveDc}: ${success ? 'sucesso (metade)' : 'falha'}. Dano ${full} (arma+${piercing.expression}).`,
  );

  const applied = await applyDuelDamageToTarget({
    state: deps.state,
    member: input.defender,
    target: input.defenderPc,
    damage,
    damageType: input.input.damageTypeOverride ?? 'piercing',
  });
  log = appendCombatLog(
    log,
    `${input.defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV (${applied.damageTotal} aplicado).`,
  );

  return afterDamage(turnDeps(deps), {
    duel: input.duel,
    members: input.members,
    log,
    attacker: input.attacker,
    attackerName: input.attackerPc.name,
    defenderName: input.defenderPc.name,
    hitPointsAfter:
      input.defender.hitPointsCurrent ?? applied.hitPointsAfter,
    bloodStrikeDamaged: applied.damageTotal > 0,
    attackerPc: input.attackerPc,
  });
}

export async function applyStrikeOnHitEffects(
  deps: AttackBloodDeps,
  input: {
    duel: Duel;
    members: DuelMember[];
    strikePkg: StrikeHitPackage;
    saveDc: number;
    attackerPc: PlayerCharacter;
    defender: DuelMember;
    defenderPc: PlayerCharacter;
  },
): Promise<string[]> {
  const lines: string[] = [];
  const { strikePkg, saveDc, defender, defenderPc, duel, members } = input;

  if (strikePkg.addsArenaEffect) {
    duel.arenaEffects = setMagicalDarkness(duel.arenaEffects);
    duel.arenaEffectSourceCharacterId = input.attackerPc.id;
    lines.push(
      `${strikePkg.label}: névoa de escuridão mágica na arena.`,
    );
  }

  if (strikePkg.onHitPendingKind) {
    duel.arenaEffects = asArenaEffects(
      addPendingEffect(
        duel.arenaEffects,
        strikePkg.onHitPendingKind,
        defenderPc.id,
      ),
    );
    lines.push(
      `${defenderPc.name}: efeito pendente (${strikePkg.onHitPendingKind}).`,
    );
  }

  if (strikePkg.noteOnly && strikePkg.saveAbility) {
    const save = await deps.rolls.rollSavingThrow(
      defender.userId,
      defender.characterId,
      { abilitySlug: strikePkg.saveAbility },
    );
    const success = save.total >= saveDc;
    lines.push(
      `${strikePkg.label}: SAB ${save.total} vs CD ${saveDc} — ${success ? 'sucesso' : 'falha'} (1v1: sem aliado para enfeitiçar).`,
    );
    return lines;
  }

  if (!strikePkg.saveAbility) {
    return lines;
  }

  const save = await deps.rolls.rollSavingThrow(
    defender.userId,
    defender.characterId,
    { abilitySlug: strikePkg.saveAbility },
  );
  const success = save.total >= saveDc;
  const abilityLabel = strikePkg.saveAbility;
  if (success) {
    lines.push(
      `${strikePkg.label}: ${abilityLabel} ${save.total} vs CD ${saveDc} — sucesso.`,
    );
    return lines;
  }

  lines.push(
    `${strikePkg.label}: ${abilityLabel} ${save.total} vs CD ${saveDc} — falha.`,
  );

  if (strikePkg.onFailCondition) {
    const current = await loadConditions(
      conditionsDeps(deps),
      defenderPc.id,
      members,
    );
    const next = mergeConditions({
      current,
      action: 'add',
      condition: strikePkg.onFailCondition,
    });
    if (defender.hitPointsCurrent != null) {
      defender.conditions = next;
    } else {
      await deps.state.patch(defenderPc, { conditions: next });
    }
    lines.push(`${defenderPc.name} fica ${strikePkg.onFailCondition}.`);
  }

  if (strikePkg.onFailPendingKind) {
    duel.arenaEffects = asArenaEffects(
      addPendingEffect(
        duel.arenaEffects,
        strikePkg.onFailPendingKind,
        defenderPc.id,
      ),
    );
    lines.push(
      `${defenderPc.name}: efeito pendente (${strikePkg.onFailPendingKind}).`,
    );
  }

  return lines;
}
