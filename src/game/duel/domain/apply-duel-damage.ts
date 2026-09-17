import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { isBloodHoundSubclass } from '@game/combat/domain/fighter';
import {
  resolveConcentrationCheck,
  type ConcentrationCheckResult,
} from '@game/combat/domain/resolve-concentration-check';
import {
  applyDamageTypeModifiers,
  emptyDamageTypeDefenses,
} from '@game/combat/domain/apply-damage-type-modifiers';
import { hitPointsOf } from '../application/to-dto';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { applyDamageToMemberVitals } from './duel-member-vitals';

export type AppliedDuelDamage = {
  damageTotal: number;
  absorbedByTempHp: number;
  hitPointsBefore: number;
  hitPointsAfter: number;
  tempHpBefore: number;
  tempHpAfter: number;
  concentration: ConcentrationCheckResult;
};

const NO_CONCENTRATION: ConcentrationCheckResult = {
  attempted: false,
  broken: false,
  dc: 10,
  total: 0,
  spellSlug: null,
};

function pcDefenses(target: PlayerCharacter) {
  if (isBloodHoundSubclass(target.subclassSlug)) {
    return {
      immunities: [] as string[],
      resistances: ['poison'],
      vulnerabilities: [] as string[],
    };
  }
  return emptyDamageTypeDefenses();
}

async function maybeBreakConcentration(input: {
  state?: CharacterStateRepository;
  target: PlayerCharacter;
  damageTaken: number;
}): Promise<ConcentrationCheckResult> {
  if (!input.state || input.damageTaken <= 0) {
    return NO_CONCENTRATION;
  }
  const before = await input.state.buildResponse(input.target);
  const mods = computeAbilityModifiers(input.target.abilityScores);
  const concentration = resolveConcentrationCheck({
    damageTaken: input.damageTaken,
    constitutionModifier: mods.constituicao,
    concentratingOn: before.concentratingOn,
  });
  if (concentration.broken) {
    await input.state.patch(input.target, { concentratingOn: null });
  }
  return concentration;
}

export async function applyDuelDamageToTarget(input: {
  state?: CharacterStateRepository;
  member?: DuelMember;
  target: PlayerCharacter;
  damage: number;
  damageType?: string | null;
}): Promise<AppliedDuelDamage> {
  const modified = applyDamageTypeModifiers({
    damage: input.damage,
    damageTypeSlug: input.damageType,
    defenses: pcDefenses(input.target),
  });
  const damageTotal = modified.damage;

  if (input.member != null && input.member.hitPointsCurrent != null) {
    const applied = applyDamageToMemberVitals(input.member, damageTotal);
    const concentration = await maybeBreakConcentration({
      state: input.state,
      target: input.target,
      damageTaken: damageTotal,
    });
    return { ...applied, concentration };
  }

  if (!input.state) {
    throw new Error('applyDuelDamageToTarget requires state or member vitals');
  }

  const stateBefore = await input.state.buildResponse(input.target);
  const tempHpBefore = stateBefore.tempHp ?? 0;
  const absorbedByTempHp = Math.min(tempHpBefore, damageTotal);
  const remaining = damageTotal - absorbedByTempHp;
  const tempHpAfter = tempHpBefore - absorbedByTempHp;

  if (absorbedByTempHp > 0) {
    await input.state.patch(input.target, { tempHp: tempHpAfter });
  }

  const hitPointsBefore = hitPointsOf(input.target).current;
  const hitPointsAfter = Math.max(0, hitPointsBefore - remaining);
  if (remaining > 0 || hitPointsAfter !== hitPointsBefore) {
    await input.state.applyCurrentHitPoints(input.target, hitPointsAfter);
    input.target.hitPointsCurrent = hitPointsAfter;
  }

  const concentration = resolveConcentrationCheck({
    damageTaken: damageTotal,
    constitutionModifier: computeAbilityModifiers(input.target.abilityScores)
      .constituicao,
    concentratingOn: stateBefore.concentratingOn,
  });
  if (concentration.broken) {
    await input.state.patch(input.target, { concentratingOn: null });
  }

  return {
    damageTotal,
    absorbedByTempHp,
    hitPointsBefore,
    hitPointsAfter,
    tempHpBefore,
    tempHpAfter,
    concentration,
  };
}
