import { resolveItemCastSlotLevel } from './resolve-item-cast-slot-level';

describe('resolveItemCastSlotLevel', () => {
  it('uses max(spell, spend) for normal charge costs', () => {
    expect(resolveItemCastSlotLevel({ spellLevel: 1, spendAmount: 1 })).toBe(1);
    expect(resolveItemCastSlotLevel({ spellLevel: 1, spendAmount: 3 })).toBe(3);
    expect(resolveItemCastSlotLevel({ spellLevel: 3, spendAmount: 3 })).toBe(3);
    expect(resolveItemCastSlotLevel({ spellLevel: 3, spendAmount: 7 })).toBe(7);
    expect(resolveItemCastSlotLevel({ spellLevel: 6, spendAmount: 4 })).toBe(6);
  });

  it('upcasts Relâmpagos / Cuspidora by charge', () => {
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 3,
        spendAmount: 1,
        resourceSlug: 'varinhaRelampagosCharges',
      }),
    ).toBe(3);
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 3,
        spendAmount: 2,
        resourceSlug: 'varinhaCuspidoraFogoCharges',
      }),
    ).toBe(4);
    expect(
      resolveItemCastSlotLevel({
        spellLevel: 3,
        spendAmount: 3,
        resourceSlug: 'varinhaRelampagosCharges',
      }),
    ).toBe(5);
  });

  it('returns null for cantrips', () => {
    expect(resolveItemCastSlotLevel({ spellLevel: 0, spendAmount: 1 })).toBeNull();
  });
});
