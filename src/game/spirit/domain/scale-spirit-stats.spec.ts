import { scaleSpiritCombatStats } from './scale-spirit-stats';

describe('scaleSpiritCombatStats', () => {
  const steed = {
    scaleMinSlot: 2,
    acBase: 10,
    acPerSlot: 1,
    hpBase: 5,
    hpPerSlot: 10,
    hpMode: 'per_slot' as const,
  };

  it('Montaria Sobrenatural: AC/HP por slot (L2 e L4)', () => {
    expect(scaleSpiritCombatStats(steed, 2)).toEqual({
      armorClass: 12,
      hitPointsMax: 25,
    });
    expect(scaleSpiritCombatStats(steed, 4)).toEqual({
      armorClass: 14,
      hitPointsMax: 45,
    });
  });

  it('Espírito Feérico: HP above_min (base no círculo 3)', () => {
    const fey = {
      scaleMinSlot: 3,
      acBase: 12,
      acPerSlot: 1,
      hpBase: 30,
      hpPerSlot: 10,
      hpMode: 'above_min' as const,
    };
    expect(scaleSpiritCombatStats(fey, 3)).toEqual({
      armorClass: 15,
      hitPointsMax: 30,
    });
    expect(scaleSpiritCombatStats(fey, 5)).toEqual({
      armorClass: 17,
      hitPointsMax: 50,
    });
  });

  it('Espírito Celestial Defensor: AC base inclui +2', () => {
    const defender = {
      scaleMinSlot: 5,
      acBase: 13,
      acPerSlot: 1,
      hpBase: 40,
      hpPerSlot: 10,
      hpMode: 'above_min' as const,
    };
    expect(scaleSpiritCombatStats(defender, 5)).toEqual({
      armorClass: 18,
      hitPointsMax: 40,
    });
  });
});
