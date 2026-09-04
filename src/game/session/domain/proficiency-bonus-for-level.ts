/** PB 5e: L1–4 → 2, L5–8 → 3, … */
export function proficiencyBonusForLevel(level: number): number {
  return 2 + Math.floor((level - 1) / 4);
}
