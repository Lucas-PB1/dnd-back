import { asDep } from '@common/testing/as-dep';
import { applySlotRefundOnCast } from './apply-slot-refund-on-cast';

describe('applySlotRefundOnCast', () => {
  it('reembolsa o espaço quando o 1d4 iguala o círculo', async () => {
    const state = { spellSlotsUsed: { '3': 1 } };
    const refunded = await applySlotRefundOnCast({
      character: asDep({ id: 'c1' }),
      state: asDep(state),
      slotLevelUsed: 3,
      sheetRepository: asDep({
        load: jest.fn().mockResolvedValue({
          characterFeats: [{ featSlug: 'boon-of-spell-recall' }],
        }),
      }),
      effectCatalog: asDep({
        load: jest.fn().mockResolvedValue([
          {
            kind: 'slot_refund_on_die_match',
            dice: { die: '1d4' },
            numeric: { amountFormula: 'fixed', flat: 4 },
          },
        ]),
      }),
      rng: () => 0.5,
    });

    expect(refunded).toBe(true);
    expect(state.spellSlotsUsed['3']).toBe(0);
  });

  it('não reembolsa sem o boon', async () => {
    const refunded = await applySlotRefundOnCast({
      character: asDep({ id: 'c1' }),
      state: asDep({ spellSlotsUsed: { '2': 1 } }),
      slotLevelUsed: 2,
      sheetRepository: asDep({
        load: jest.fn().mockResolvedValue({ characterFeats: [] }),
      }),
      effectCatalog: asDep({ load: jest.fn() }),
    });
    expect(refunded).toBe(false);
  });
});
