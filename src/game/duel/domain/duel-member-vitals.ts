import type { DuelMember } from '../infrastructure/duel-member.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { hitPointsOf } from '../application/to-dto';

export type AppliedCombatantDamage = {
  damageTotal: number;
  absorbedByTempHp: number;
  hitPointsBefore: number;
  hitPointsAfter: number;
  tempHpBefore: number;
  tempHpAfter: number;
};

export function snapshotMemberVitalsFromCharacter(
  member: DuelMember,
  character: PlayerCharacter,
  tempHp = 0,
  conditions: string[] = [],
): void {
  const hp = hitPointsOf(character);
  member.hitPointsMax = hp.max;
  member.hitPointsCurrent = hp.current;
  member.tempHp = Math.max(0, tempHp);
  member.conditions = [...conditions];
  member.speedPenaltyM = 0;
}

export function applyDamageToMemberVitals(
  member: DuelMember,
  damage: number,
): AppliedCombatantDamage {
  const damageTotal = Math.max(0, damage);
  const tempHpBefore = member.tempHp ?? 0;
  const absorbedByTempHp = Math.min(tempHpBefore, damageTotal);
  const remaining = damageTotal - absorbedByTempHp;
  const tempHpAfter = tempHpBefore - absorbedByTempHp;
  const hitPointsBefore = member.hitPointsCurrent ?? 0;
  const hitPointsAfter = Math.max(0, hitPointsBefore - remaining);

  member.tempHp = tempHpAfter;
  member.hitPointsCurrent = hitPointsAfter;

  return {
    damageTotal,
    absorbedByTempHp,
    hitPointsBefore,
    hitPointsAfter,
    tempHpBefore,
    tempHpAfter,
  };
}

export function healMemberVitals(
  member: DuelMember,
  amount: number,
): { before: number; after: number } {
  const before = member.hitPointsCurrent ?? 0;
  const max = member.hitPointsMax ?? before;
  const after = Math.min(max, before + Math.max(0, amount));
  member.hitPointsCurrent = after;
  return { before, after };
}

export function addMemberCondition(member: DuelMember, condition: string): void {
  const current = member.conditions ?? [];
  if (!current.includes(condition)) {
    member.conditions = [...current, condition];
  }
}

export function removeMemberCondition(
  member: DuelMember,
  condition: string,
): void {
  member.conditions = (member.conditions ?? []).filter((c) => c !== condition);
}
