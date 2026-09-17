import {
  applyDamageTypeModifiers,
  defensesFromAffinityRows,
  emptyDamageTypeDefenses,
} from './apply-damage-type-modifiers';

describe('applyDamageTypeModifiers', () => {
  it('Fire Bolt vs fire resistance = half (PVE-6c)', () => {
    const result = applyDamageTypeModifiers({
      damage: 10,
      damageTypeSlug: 'fire',
      defenses: {
        immunities: [],
        resistances: ['fire'],
        vulnerabilities: [],
      },
    });
    expect(result).toEqual({ damage: 5, applied: 'resistance' });
  });

  it('immunity zeros damage (PVE-6c)', () => {
    const result = applyDamageTypeModifiers({
      damage: 22,
      damageTypeSlug: 'fire',
      defenses: {
        immunities: ['fire'],
        resistances: [],
        vulnerabilities: [],
      },
    });
    expect(result).toEqual({ damage: 0, applied: 'immunity' });
  });

  it('vulnerability doubles damage', () => {
    expect(
      applyDamageTypeModifiers({
        damage: 7,
        damageTypeSlug: 'cold',
        defenses: {
          immunities: [],
          resistances: [],
          vulnerabilities: ['cold'],
        },
      }).damage,
    ).toBe(14);
  });

  it('resist + vuln cancel', () => {
    expect(
      applyDamageTypeModifiers({
        damage: 12,
        damageTypeSlug: 'fire',
        defenses: {
          immunities: [],
          resistances: ['fire'],
          vulnerabilities: ['fire'],
        },
      }),
    ).toEqual({ damage: 12, applied: 'cancel' });
  });

  it('no type or empty defenses leaves damage unchanged', () => {
    expect(
      applyDamageTypeModifiers({
        damage: 8,
        damageTypeSlug: null,
        defenses: emptyDamageTypeDefenses(),
      }).damage,
    ).toBe(8);
  });
});

describe('defensesFromAffinityRows', () => {
  it('groups kinds by damage type', () => {
    expect(
      defensesFromAffinityRows([
        { damageTypeSlug: 'Fire', kind: 'immunity' },
        { damageTypeSlug: 'cold', kind: 'resistance' },
      ]),
    ).toEqual({
      immunities: ['fire'],
      resistances: ['cold'],
      vulnerabilities: [],
    });
  });
});
