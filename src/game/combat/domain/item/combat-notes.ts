/** Lembretes passivos de item (`properties.combatNotes`) para Passivas. */

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

export function combatNotesFromProperties(
  properties: Record<string, unknown> | null | undefined,
): string[] {
  if (!isRecord(properties)) return [];
  const raw = properties.combatNotes;
  if (!Array.isArray(raw)) return [];
  return raw
    .filter((line): line is string => typeof line === 'string')
    .map((line) => line.trim())
    .filter(Boolean);
}

export function itemCombatNotes(input: {
  itemSlugs: readonly string[];
  /** Catálogo `phb_item.properties` por slug (SSOT). */
  propertiesBySlug?: ReadonlyMap<string, Record<string, unknown> | null>;
}): string[] {
  const notes: string[] = [];
  const seen = new Set<string>();
  const propsMap = input.propertiesBySlug;

  for (const slug of input.itemSlugs) {
    if (seen.has(slug)) continue;
    seen.add(slug);
    const lines = combatNotesFromProperties(propsMap?.get(slug) ?? null);
    for (const line of lines) notes.push(line);
  }

  return notes;
}
