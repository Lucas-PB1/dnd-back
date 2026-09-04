import {
  coverAcBonus,
  effectiveCoverForAttack,
  ignoresPartialCover,
  ignoresRangedRangePenalties,
  isCoverBlockingAttack,
} from './attack-cover';

describe('attack-cover', () => {
  it('maps cover levels to AC bonus', () => {
    expect(coverAcBonus('none')).toBe(0);
    expect(coverAcBonus('half')).toBe(2);
    expect(coverAcBonus('three_quarters')).toBe(5);
    expect(coverAcBonus('full')).toBe(0);
  });

  it('blocks full cover attacks', () => {
    expect(isCoverBlockingAttack('full')).toBe(true);
    expect(isCoverBlockingAttack('half')).toBe(false);
  });

  it('sharpshooter ignores partial cover for AC', () => {
    expect(ignoresPartialCover(['sharpshooter'])).toBe(true);
    expect(
      effectiveCoverForAttack({
        cover: 'three_quarters',
        featSlugs: ['sharpshooter'],
      }),
    ).toBe('none');
  });

  it('sharpshooter and crossbow expert ignore ranged range penalties', () => {
    expect(ignoresRangedRangePenalties(['sharpshooter'], 'ranged')).toBe(true);
    expect(ignoresRangedRangePenalties(['crossbow-expert'], 'ranged')).toBe(
      true,
    );
    expect(ignoresRangedRangePenalties(['sharpshooter'], 'melee')).toBe(false);
  });
});
