import { slotRefundMatches } from './slot-refund-on-die-match';

describe('slotRefundMatches', () => {
  it('reembolsa quando o 1d4 iguala o círculo (1–4)', () => {
    expect(
      slotRefundMatches({ slotLevel: 3, dieRoll: 3, maxSlotLevel: 4 }),
    ).toBe(true);
  });

  it('não reembolsa círculo acima do máximo nem dado diferente', () => {
    expect(
      slotRefundMatches({ slotLevel: 5, dieRoll: 5, maxSlotLevel: 4 }),
    ).toBe(false);
    expect(
      slotRefundMatches({ slotLevel: 2, dieRoll: 4, maxSlotLevel: 4 }),
    ).toBe(false);
  });
});
