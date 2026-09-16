export function extraFromUpcastOption(
  optionKey: string | null,
  extraSlots: number,
): { extraDice: number; extraFlat: number } {
  if (!optionKey || extraSlots <= 0) {
    return { extraDice: 0, extraFlat: 0 };
  }
  const dice = /^upcast_dice:(\d+)$/.exec(optionKey);
  if (dice) {
    return { extraDice: extraSlots * Number(dice[1]), extraFlat: 0 };
  }
  const flat = /^upcast_flat:(\d+)$/.exec(optionKey);
  if (flat) {
    return { extraDice: 0, extraFlat: extraSlots * Number(flat[1]) };
  }
  return { extraDice: 0, extraFlat: 0 };
}
