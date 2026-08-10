import {
  buildEnspelledCastNote,
  getEnspelledSpellStats,
} from './enspelled-weapon';

describe('getEnspelledSpellStats', () => {
  it('maps DMG table by spell level', () => {
    expect(getEnspelledSpellStats(0)).toMatchObject({
      rarity: 'uncommon',
      saveDc: 13,
      spellAttackBonus: 5,
    });
    expect(getEnspelledSpellStats(3)).toMatchObject({
      rarity: 'rare',
      saveDc: 15,
      spellAttackBonus: 7,
    });
    expect(getEnspelledSpellStats(8)).toMatchObject({
      rarity: 'legendary',
      saveDc: 18,
      spellAttackBonus: 10,
    });
  });

  it('builds cast note', () => {
    expect(buildEnspelledCastNote(5)).toMatch(/CD 17/);
    expect(buildEnspelledCastNote(5)).toMatch(/\+9/);
  });
});
