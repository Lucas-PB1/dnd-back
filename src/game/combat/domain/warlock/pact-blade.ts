/**
 * Heurística melee PHB: ammunition sem thrown ⇒ só à distância.
 */
export function isMeleeWeaponFromPropertyIds(
  propertyIds: readonly string[] | null | undefined,
): boolean {
  const ids = propertyIds ?? [];
  if (ids.includes('ammunition') && !ids.includes('thrown')) {
    return false;
  }
  return true;
}

export function propertyIdsFromItemProperties(
  properties: Record<string, unknown> | null | undefined,
): string[] {
  const raw = properties?.propertyIds;
  if (!Array.isArray(raw)) return [];
  return raw.filter((id): id is string => typeof id === 'string');
}
