/** Predicado puro: nível atual ≥ unlock do catálogo (null = classe sem Estilo de Luta). */
export function classHasFightingStylePick(
  unlockLevel: number | null | undefined,
  level: number,
): boolean {
  return unlockLevel != null && level >= unlockLevel;
}
