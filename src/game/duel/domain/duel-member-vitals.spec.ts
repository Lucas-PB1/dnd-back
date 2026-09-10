import type { DuelMember } from '../infrastructure/duel-member.entity';
import {
  addMemberCondition,
  applyDamageToMemberVitals,
  healMemberVitals,
  removeMemberCondition,
  snapshotMemberVitalsFromCharacter,
} from './duel-member-vitals';

function memberStub(partial: Partial<DuelMember> = {}): DuelMember {
  return {
    id: 'm1',
    duelId: 'd1',
    userId: 'u1',
    characterId: 'c1',
    ready: true,
    initiative: 10,
    hitPointsCurrent: 20,
    hitPointsMax: 20,
    tempHp: 0,
    conditions: [],
    speedPenaltyM: 0,
    joinedAt: new Date(),
    ...partial,
  } as DuelMember;
}

describe('duel-member-vitals', () => {
  it('snapshots HP from character and optional temp/conditions', () => {
    const member = memberStub({
      hitPointsCurrent: null,
      hitPointsMax: null,
      tempHp: 99,
      conditions: ['poisoned'],
    });
    snapshotMemberVitalsFromCharacter(
      member,
      {
        hitPointsCurrent: 14,
        hitPointsMax: 18,
      } as never,
      3,
      ['frightened'],
    );
    expect(member.hitPointsCurrent).toBe(14);
    expect(member.hitPointsMax).toBe(18);
    expect(member.tempHp).toBe(3);
    expect(member.conditions).toEqual(['frightened']);
    expect(member.speedPenaltyM).toBe(0);
  });

  it('applies damage through temp HP then current HP', () => {
    const member = memberStub({ hitPointsCurrent: 10, tempHp: 4 });
    const result = applyDamageToMemberVitals(member, 7);
    expect(result.damageTotal).toBe(7);
    expect(result.absorbedByTempHp).toBe(4);
    expect(result.tempHpAfter).toBe(0);
    expect(result.hitPointsBefore).toBe(10);
    expect(result.hitPointsAfter).toBe(7);
    expect(member.hitPointsCurrent).toBe(7);
    expect(member.tempHp).toBe(0);
  });

  it('heals up to max and manages conditions', () => {
    const member = memberStub({ hitPointsCurrent: 5, hitPointsMax: 12 });
    expect(healMemberVitals(member, 20)).toEqual({ before: 5, after: 12 });
    addMemberCondition(member, 'prone');
    addMemberCondition(member, 'prone');
    expect(member.conditions).toEqual(['prone']);
    removeMemberCondition(member, 'prone');
    expect(member.conditions).toEqual([]);
  });
});
