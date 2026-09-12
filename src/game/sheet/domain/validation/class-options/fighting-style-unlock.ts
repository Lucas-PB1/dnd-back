export function classHasFightingStylePick(
  unlockLevel: number | null | undefined,
  level: number,
): boolean {
  return unlockLevel != null && level >= unlockLevel;
}
