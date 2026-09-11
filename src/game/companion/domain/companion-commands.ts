export const COMPANION_COMMAND_SLUGS = [
  'strike',
  'help',
  'dash',
  'disengage',
  'dodge',
] as const;

export type CompanionCommandSlug = (typeof COMPANION_COMMAND_SLUGS)[number];

export type CompanionCommandCatalogRow = {
  slug: string;
  labelPt: string;
  noteKind: 'strike' | 'bonus_action';
};

export function isCompanionCommandSlug(
  value: string,
): value is CompanionCommandSlug {
  return (COMPANION_COMMAND_SLUGS as readonly string[]).includes(value);
}

export function formatCompanionCommandNote(
  command: CompanionCommandSlug,
  catalog: ReadonlyMap<string, CompanionCommandCatalogRow>,
  variantLabel?: string | null,
): string {
  const row = catalog.get(command);
  const label = row?.labelPt ?? command;
  const noteKind = row?.noteKind ?? (command === 'strike' ? 'strike' : 'bonus_action');
  const prefix = variantLabel ? `Companheiro (${variantLabel})` : 'Companheiro';
  if (noteKind === 'strike') {
    return `${prefix}: ${label} — sacrifique um ataque na ação Atacar ou use Ação Bônus para comandar (mesa).`;
  }
  return `${prefix}: Ação Bônus — ${label}.`;
}
