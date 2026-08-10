import { resolveStartingGoldPieces } from './resolve-starting-gold';

describe('resolveStartingGoldPieces', () => {
  it('credits background gold package option', () => {
    expect(
      resolveStartingGoldPieces({
        equipment: [{ source: 'background', packageSlug: 'gold', sortOrder: 0 }],
        background: { equipmentGoldOption: 50 },
        classEquipmentRows: [],
        backgroundEquipmentRows: [],
      }),
    ).toBe(50);
  });

  it('sums class package gold_amount rows', () => {
    expect(
      resolveStartingGoldPieces({
        equipment: [
          { source: 'class', packageSlug: 'b', sortOrder: 0 },
          { source: 'background', packageSlug: 'a', sortOrder: 1 },
        ],
        background: { equipmentGoldOption: 15 },
        classEquipmentRows: [
          { packageSlug: 'b', goldAmount: 155 },
          { packageSlug: 'a', goldAmount: 99 },
        ],
        backgroundEquipmentRows: [{ packageSlug: 'a', packageGold: 10 }],
      }),
    ).toBe(165);
  });

  it('ignores gold package when background has no option', () => {
    expect(
      resolveStartingGoldPieces({
        equipment: [{ source: 'background', packageSlug: 'gold', sortOrder: 0 }],
        background: { equipmentGoldOption: null },
        classEquipmentRows: [],
        backgroundEquipmentRows: [],
      }),
    ).toBe(0);
  });
});
