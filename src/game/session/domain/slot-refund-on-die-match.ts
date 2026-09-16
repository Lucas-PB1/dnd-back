export function slotRefundMatches(input: {
  slotLevel: number;
  dieRoll: number;
  maxSlotLevel: number;
}): boolean {
  const { slotLevel, dieRoll, maxSlotLevel } = input;
  if (slotLevel < 1 || slotLevel > maxSlotLevel) return false;
  return dieRoll === slotLevel;
}
