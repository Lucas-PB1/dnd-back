import { resolveItemCastSlotLevel } from './resolve-item-cast-slot-level';

describe('resolveItemCastSlotLevel', () => {
  it('uses max(spell, spend) for normal charge costs', () => {
    expect(resolveItemCastSlotLevel({ spellLevel: 1, spendAmount: 1 })).toBe(1);
    expect(resolveItemCastSlotLevel({ spellLevel: 1, spendAmount: 3 })).toBe(3);
    expect(resolveItemCastSlotLevel({ spellLevel: 3, spendAmount: 3 })).toBe(3);
    expect(resolveItemCastSlotLevel({ spellLevel: 3, spendAmount: 7 })).toBe(7);
    expect(resolveItemCastSlotLevel({ spellLevel: 6, spendAmount: 4 })).toBe(6);
  });

  it('upcasts by charge when rule is charge-upcast', () => {
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 3,
        spendAmount: 1,
        slotRule: { mode: 'charge-upcast' },
      }),
    ).toBe(3);
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 3,
        spendAmount: 2,
        slotRule: { mode: 'charge-upcast' },
      }),
    ).toBe(4);
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 3,
        spendAmount: 3,
        slotRule: { mode: 'charge-upcast' },
      }),
    ).toBe(5);
  });

  it('returns null for cantrips', () => {
    expect(resolveItemCastSlotLevel({ spellLevel: 0, spendAmount: 1 })).toBeNull();
  });

  it('forces fixed / fixed-by-spend from seed rule', () => {
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 6,
        spendAmount: 1,
        slotRule: { mode: 'fixed', slotLevel: 9 },
      }),
    ).toBe(9);
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 1,
        spendAmount: 4,
        slotRule: {
          mode: 'fixed-by-spend',
          spendAmount: 4,
          spellLevel: 1,
          slotLevel: 9,
        },
      }),
    ).toBe(9);
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 1,
        spendAmount: 1,
        slotRule: {
          mode: 'fixed-by-spend',
          spendAmount: 4,
          spellLevel: 1,
          slotLevel: 9,
        },
      }),
    ).toBe(1);
  });
});
