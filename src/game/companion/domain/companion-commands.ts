export const COMPANION_COMMAND_SLUGS = [
  'strike',
  'help',
  'dash',
  'disengage',
  'dodge',
] as const;

export type CompanionCommandSlug = (typeof COMPANION_COMMAND_SLUGS)[number];

export const COMPANION_COMMAND_LABELS: Record<CompanionCommandSlug, string> = {
  strike: 'Golpe da Fera',
  help: 'Ajudar',
  dash: 'Correr',
  disengage: 'Desengajar',
  dodge: 'Esquivar',
};

export function isCompanionCommandSlug(
  value: string,
): value is CompanionCommandSlug {
  return (COMPANION_COMMAND_SLUGS as readonly string[]).includes(value);
}

export function formatCompanionCommandNote(
  command: CompanionCommandSlug,
  variantLabel?: string | null,
): string {
  const label = COMPANION_COMMAND_LABELS[command];
  const prefix = variantLabel ? `Companheiro (${variantLabel})` : 'Companheiro';
  if (command === 'strike') {
    return `${prefix}: ${label} — sacrifique um ataque na ação Atacar ou use Ação Bônus para comandar (mesa).`;
  }
  return `${prefix}: Ação Bônus — ${label}.`;
}
