import {
  buildMagicMissileCastNote,
  magicMissileDartCount,
  magicMissileExtraDarts,
} from './features';

describe('magic missile mage helpers', () => {
  it('scales extra darts by level', () => {
    expect(magicMissileExtraDarts(2)).toBe(0);
    expect(magicMissileExtraDarts(3)).toBe(1);
    expect(magicMissileExtraDarts(6)).toBe(2);
    expect(magicMissileExtraDarts(10)).toBe(3);
    expect(magicMissileExtraDarts(14)).toBe(4);
  });

  it('counts darts with upcast and extras', () => {
    expect(magicMissileDartCount(3, null)).toBe(4);
    expect(magicMissileDartCount(14, 3)).toBe(3 + 2 + 4);
  });

  it('builds cast note with free cast and modifiers', () => {
    const note = buildMagicMissileCastNote({
      level: 14,
      slotLevelUsed: null,
      usedFreeResource: true,
      missileShield: true,
      gigaMissile: true,
      intModifier: 4,
    });
    expect(note).toContain('7 dardo');
    expect(note).toContain('uso gratuito');
    expect(note).toContain('Escudo de Mísseis');
    expect(note).toContain('Giga-Míssil');
    expect(note).toContain('+4 de Força');
  });
});
