import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { isBloodHoundSubclass } from '@game/combat/domain/fighter';
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
};

function applyPoisonResist(
  damage: number,
  target: PlayerCharacter,
  damageType?: string | null,
): number {
  let damageTotal = Math.max(0, damage);
  if (
    damageType === 'poison' &&
    isBloodHoundSubclass(target.subclassSlug)
  ) {
    damageTotal = Math.floor(damageTotal / 2);
  }
  return damageTotal;
}

export async function applyDuelDamageToTarget(input: {
  state?: CharacterStateRepository;
  member?: DuelMember;
  target: PlayerCharacter;
  damage: number;
  damageType?: string | null;
}): Promise<AppliedDuelDamage> {
  const damageTotal = applyPoisonResist(
    input.damage,
    input.target,
    input.damageType,
  );

  if (input.member != null && input.member.hitPointsCurrent != null) {
    return applyDamageToMemberVitals(input.member, damageTotal);
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

  return {
    damageTotal,
    absorbedByTempHp,
    hitPointsBefore,
    hitPointsAfter,
    tempHpBefore,
    tempHpAfter,
  };
}
