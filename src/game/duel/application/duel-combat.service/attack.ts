import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { findEquippedWeaponAttack } from '@game/dice/application/rolls/roll-weapon-context';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  BLOOD_CONDITION_CONSTRAIN,
  BLOOD_CONDITION_WITHERING,
  canUseBloodArmament,
  canUseBloodExplosion,
  hasStudiedAttacks,
  hasTacticalMaster,
  isBloodHoundSubclass,
} from '@game/combat/domain/fighter';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { strikeSaveDc, type StrikeOption } from '@game/combat/domain/strike-option';
import type { LoadEffectCatalog } from '@game/effects';
import {
  addPendingEffect,
  consumePendingEffect,
} from '@game/combat/domain/pending-combat-effect';
import {
  formatStrikeSelfCostNote,
  spendStrikeSelfCost,
} from '@game/combat/application/strike/spend-strike-self-cost';
import {
  halfDamage,
  resolveStrikeHitPackage,
  unarmoredDexArmorClass,
  type StrikeHitPackage,
} from '@game/combat/domain/resolve-strike-hit-package';
import { asArenaEffects } from '../../domain/arena-effects';
import { appendCombatLog } from '../../domain/combat-log';
import { assertCanTakeDuelAction } from '../../domain/duel-combat-gates';
import { applyDuelDamageToTarget } from '../../domain/apply-duel-damage';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import type { DuelCombatSnapshot } from '../duel-combat-snapshot';
import { loadConditions, type ConditionsDeps } from './conditions';
import { resolveAttackAdvantage, type VisionDeps } from './vision';
import {
  afterAttackAction,
  afterDamage,
  maybeSkipPendingExileTurn,
  type TurnDeps,
} from './turn';
import {
  applyMasteryEffects,
  resolveActiveMasterySlug,
  TACTICAL_MASTER_OVERRIDES,
  type AttackMasteryDeps,
} from './attack-mastery';
import {
  applyStrikeOnHitEffects,
  assertStrikeOptionReady,
  resolveBloodExplosion,
  resolveBloodshardAttack,
  type AttackBloodDeps,
} from './attack-blood';

export type AttackDeps = {
  repo: DuelRepository;
  rolls: CharacterRollsService;
  state: CharacterStateRepository;
  snapshot: DuelCombatSnapshot;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  effectCatalog: LoadEffectCatalog;
  dataSource: DataSource;
};

function conditionsDeps(deps: AttackDeps): ConditionsDeps {
  return { repo: deps.repo, state: deps.state };
}

function visionDeps(deps: AttackDeps): VisionDeps {
  return { sheet: deps.sheet };
}

function turnDeps(deps: AttackDeps): TurnDeps {
  return {
    repo: deps.repo,
    state: deps.state,
    snapshot: deps.snapshot,
  };
}

function masteryDeps(deps: AttackDeps): AttackMasteryDeps {
  return {
    rolls: deps.rolls,
    effectCatalog: deps.effectCatalog,
  };
}

function bloodDeps(deps: AttackDeps): AttackBloodDeps {
  return {
    repo: deps.repo,
    rolls: deps.rolls,
    state: deps.state,
    sheet: deps.sheet,
    snapshot: deps.snapshot,
    mechanicalCatalog: deps.mechanicalCatalog,
  };
}

export async function attack(
  deps: AttackDeps,
  userId: string,
  duelId: string,
  input: {
    itemSlug: string;
    mode: 'melee' | 'ranged';
    bloodStrike?: { optionSlug: string; takeLowerBloodCost?: boolean };
    damageTypeOverride?: 'acid' | 'necrotic' | 'poison';
    bloodExplosionOnMiss?: boolean;
    masteryOverrideSlug?: 'push' | 'sap' | 'slow';
    graze?: boolean;
  },
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['active']);

  await maybeSkipPendingExileTurn(turnDeps(deps), duel, members);

  const attacker = members.find((m) => m.userId === userId);
  const defender = members.find((m) => m.userId !== userId);
  if (!attacker || !defender) {
    throw new BadRequestException('Duel needs two participants');
  }
  if (duel.turnCharacterId !== attacker.characterId) {
    throw new BadRequestException('Not your turn');
  }
  if ((duel.turnAttacksRemaining ?? 1) <= 0) {
    throw new BadRequestException('Sem ataques restantes neste turno');
  }

  assertCanTakeDuelAction(
    await loadConditions(conditionsDeps(deps), attacker.characterId, members),
  );

  const characters = await deps.repo.findCharactersByIds([
    attacker.characterId,
    defender.characterId,
  ]);
  const byId = new Map(characters.map((c) => [c.id, c]));
  const attackerPc = byId.get(attacker.characterId);
  const defenderPc = byId.get(defender.characterId);
  if (!attackerPc || !defenderPc) {
    throw new BadRequestException('Character not found');
  }

  let advantage = await resolveAttackAdvantage(
    visionDeps(deps),
    duel,
    attacker,
    defender,
  );
  const pendingAdv = consumePendingEffect(
    duel.arenaEffects,
    'attack-advantage',
    attacker.characterId,
  );
  duel.arenaEffects = asArenaEffects(pendingAdv.effects);
  if (pendingAdv.consumed) {
    advantage = advantage === 'disadvantage' ? 'normal' : 'advantage';
  }
  const pendingDis = consumePendingEffect(
    duel.arenaEffects,
    'attack-disadvantage',
    attacker.characterId,
  );
  duel.arenaEffects = asArenaEffects(pendingDis.effects);
  if (pendingDis.consumed) {
    advantage = advantage === 'advantage' ? 'normal' : 'disadvantage';
  }

  const constrain = consumePendingEffect(
    duel.arenaEffects,
    BLOOD_CONDITION_CONSTRAIN,
    attacker.characterId,
  );
  duel.arenaEffects = asArenaEffects(constrain.effects);
  if (constrain.consumed) {
    advantage = advantage === 'advantage' ? 'normal' : 'disadvantage';
  }

  let bloodStrikeDamaged = false;
  let bloodCostNote: string | null = null;
  let strikePkg: StrikeHitPackage | null = null;
  let strikeOption: StrikeOption | null = null;

  if (input.bloodStrike) {
    strikeOption = await assertStrikeOptionReady(
      bloodDeps(deps),
      attackerPc,
      input.bloodStrike.optionSlug,
    );
    try {
      const spent = await spendStrikeSelfCost({
        character: attackerPc,
        option: strikeOption,
        takeLowerCost: input.bloodStrike.takeLowerBloodCost,
        ports: {
          useClassResource: async (slug, amount) => {
            await deps.state.useClassResource(attackerPc, slug, amount);
          },
          applyCurrentHitPoints: async (hitPointsCurrent) => {
            if (attacker.hitPointsCurrent != null) {
              attacker.hitPointsCurrent = hitPointsCurrent;
            } else {
              await deps.state.applyCurrentHitPoints(
                attackerPc,
                hitPointsCurrent,
              );
              attackerPc.hitPointsCurrent = hitPointsCurrent;
            }
          },
        },
      });
      bloodCostNote = formatStrikeSelfCostNote(spent, 'duel');
    } catch (err) {
      throw new BadRequestException(
        err instanceof Error ? err.message : 'Golpe de Sangue inválido',
      );
    }
    strikePkg = resolveStrikeHitPackage({
      option: strikeOption,
      level: attackerPc.level,
    });
  }

  if (input.damageTypeOverride) {
    if (
      !isBloodHoundSubclass(attackerPc.subclassSlug) ||
      !canUseBloodArmament(attackerPc.level)
    ) {
      throw new BadRequestException(
        'Armamento de Sangue exige Sabujo de Sangue nível 7+',
      );
    }
  }

  if (input.bloodExplosionOnMiss) {
    if (
      !isBloodHoundSubclass(attackerPc.subclassSlug) ||
      !canUseBloodExplosion(attackerPc.level)
    ) {
      throw new BadRequestException(
        'Explosão de Sangue exige Sabujo de Sangue nível 7+',
      );
    }
  }

  if (
    input.masteryOverrideSlug &&
    (!hasTacticalMaster(attackerPc.level) ||
      !TACTICAL_MASTER_OVERRIDES.has(input.masteryOverrideSlug))
  ) {
    throw new BadRequestException(
      'Mestre Tático exige Guerreiro nível 9+ (Empurrar, Drenar ou Lento)',
    );
  }

  const saveDc = strikeSaveDc(
    abilityModifier(attackerPc.abilityScores.constituicao),
    await deps.domain.getProficiencyBonus(attackerPc.level),
  );

  // Bloodshard: DEX save em vez de attack roll
  if (strikePkg?.replacesAttackWithSave) {
    return resolveBloodshardAttack(bloodDeps(deps), {
      duel,
      members,
      attacker,
      defender,
      attackerPc,
      defenderPc,
      input,
      strikePkg,
      strikeOption: strikeOption!,
      saveDc,
      bloodCostNote,
    });
  }

  let targetAc =
    (
      await deps.snapshot.resolveArmorByCharacter([defenderPc])
    ).get(defenderPc.id) ?? 10;
  if (strikePkg?.ignoreTargetArmor) {
    targetAc = unarmoredDexArmorClass(
      abilityModifier(defenderPc.abilityScores.destreza),
    );
  }

  const { attack: weaponAttack } = await findEquippedWeaponAttack(
    {
      sheet: deps.sheet,
      domain: deps.domain,
      weaponAttacks: deps.weaponAttacks,
      dataSource: deps.dataSource,
      effectCatalog: deps.effectCatalog,
    },
    attackerPc,
    input.itemSlug,
    input.mode,
  );

  const attackRoll = await deps.rolls.rollAttack(
    userId,
    attacker.characterId,
    {
      itemSlug: input.itemSlug,
      mode: input.mode,
      targetAc,
      advantage,
    },
  );

  let log = duel.combatLog ?? [];
  if (bloodCostNote) {
    log = appendCombatLog(log, `${attackerPc.name}: ${bloodCostNote}`);
  }
  const attackLabel = attackRoll.label ?? 'Ataque';
  const hit = attackRoll.hit === true;
  const critical = attackRoll.critical === true;
  const visionNote = advantage !== 'normal' ? ` [${advantage}]` : '';

  const masterySlug = resolveActiveMasterySlug(
    weaponAttack.masterySlug,
    input.masteryOverrideSlug,
    attackerPc,
  );
  const attackAbilityMod = abilityModifier(
    attackerPc.abilityScores[weaponAttack.abilitySlug],
  );
  const proficiencyBonus = await deps.domain.getProficiencyBonus(
    attackerPc.level,
  );

  if (!hit) {
    log = appendCombatLog(
      log,
      `${attackerPc.name}: ${attackLabel}${visionNote} — errou (total ${attackRoll.total} vs CA ${attackRoll.effectiveTargetAc ?? targetAc}).`,
    );

    if (hasStudiedAttacks(attackerPc.level)) {
      duel.arenaEffects = asArenaEffects(
        addPendingEffect(
          duel.arenaEffects,
          'attack-advantage',
          attacker.characterId,
        ),
      );
      log = appendCombatLog(
        log,
        `${attackerPc.name}: Ataques Estudados — vantagem no próximo ataque.`,
      );
    }

    if (masterySlug) {
      const masteryLog = await applyMasteryEffects(masteryDeps(deps), {
        duel,
        masterySlug,
        trigger: 'on_miss',
        attackAbilityMod,
        proficiencyBonus,
        attacker,
        defender,
        damaged: false,
      });
      for (const line of masteryLog) {
        log = appendCombatLog(log, line);
      }
      if ((defender.hitPointsCurrent ?? 1) <= 0) {
        return afterDamage(turnDeps(deps), {
          duel,
          members,
          log,
          attacker,
          attackerName: attackerPc.name,
          defenderName: defenderPc.name,
          hitPointsAfter: 0,
          attackerPc,
        });
      }
    }

    if (input.bloodExplosionOnMiss) {
      const explosion = await resolveBloodExplosion(bloodDeps(deps), {
        attackerUserId: attacker.userId,
        defenderUserId: defender.userId,
        attackerCharacterId: attacker.characterId,
        defenderCharacterId: defender.characterId,
        itemSlug: input.itemSlug,
        mode: input.mode,
        saveDc,
      });
      log = appendCombatLog(log, explosion.note);
      if (explosion.damage > 0) {
        bloodStrikeDamaged = false;
        const applied = await applyDuelDamageToTarget({
          state: deps.state,
          member: defender,
          target: defenderPc,
          damage: explosion.damage,
          damageType: input.damageTypeOverride ?? null,
        });
        log = appendCombatLog(
          log,
          `Explosão: ${applied.damageTotal} de dano. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
        );
        return afterDamage(turnDeps(deps), {
          duel,
          members,
          log,
          attacker,
          attackerName: attackerPc.name,
          defenderName: defenderPc.name,
          hitPointsAfter: applied.hitPointsAfter,
          bloodStrikeDamaged,
          attackerPc,
        });
      }
    }

    return afterAttackAction(turnDeps(deps), {
      duel,
      members,
      log,
      attackerPc,
    });
  }

  const damageRoll = await deps.rolls.rollDamage(
    userId,
    attacker.characterId,
    {
      itemSlug: input.itemSlug,
      mode: input.mode,
      critical,
    },
  );

  let weaponDamage = Math.max(0, damageRoll.total);
  const withering = consumePendingEffect(
    duel.arenaEffects,
    BLOOD_CONDITION_WITHERING,
    attacker.characterId,
  );
  duel.arenaEffects = asArenaEffects(withering.effects);
  if (withering.consumed) {
    weaponDamage = halfDamage(weaponDamage);
  }

  let totalDamage = weaponDamage;
  const damageNotes: string[] = [];
  if (strikePkg) {
    totalDamage += strikePkg.extraDamage;
    if (strikePkg.extraExpression) {
      damageNotes.push(
        `+${strikePkg.extraExpression} ${strikePkg.damageType}`,
      );
    }
    bloodStrikeDamaged = totalDamage > 0;
  }

  const damageType =
    input.damageTypeOverride ??
    (strikePkg && strikePkg.extraDamage > 0 ? strikePkg.damageType : null);

  const applied = await applyDuelDamageToTarget({
    state: deps.state,
    member: defender,
    target: defenderPc,
    damage: totalDamage,
    damageType,
  });

  const tempNote =
    applied.absorbedByTempHp > 0
      ? ` (${applied.absorbedByTempHp} absorvido por PV temp.)`
      : '';
  const typeNote = input.damageTypeOverride
    ? ` [${input.damageTypeOverride}]`
    : '';
  const extraNote =
    damageNotes.length > 0 ? ` (${damageNotes.join(', ')})` : '';
  log = appendCombatLog(
    log,
    `${attackerPc.name}: ${attackLabel}${visionNote} — acerto${critical ? ' crítico' : ''}! Dano ${applied.damageTotal}${typeNote}${extraNote}${tempNote}. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
  );

  if (strikePkg) {
    const effectLog = await applyStrikeOnHitEffects(bloodDeps(deps), {
      duel,
      members,
      strikePkg,
      saveDc,
      attackerPc,
      defender,
      defenderPc,
    });
    for (const line of effectLog) {
      log = appendCombatLog(log, line);
    }
  }

  if (masterySlug) {
    const masteryLog = await applyMasteryEffects(masteryDeps(deps), {
      duel,
      masterySlug,
      trigger: 'on_hit',
      attackAbilityMod,
      proficiencyBonus,
      attacker,
      defender,
      damaged: applied.damageTotal > 0,
    });
    for (const line of masteryLog) {
      log = appendCombatLog(log, line);
    }
  }

  return afterDamage(turnDeps(deps), {
    duel,
    members,
    log,
    attacker,
    attackerName: attackerPc.name,
    defenderName: defenderPc.name,
    hitPointsAfter:
      defender.hitPointsCurrent ?? applied.hitPointsAfter,
    bloodStrikeDamaged,
    attackerPc,
  });
}
