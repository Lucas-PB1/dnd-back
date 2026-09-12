export function resolveEncounterCreatureName(input: {
  templateName: string;
  index: number;
  count: number;
  nameOverride?: string | null;
}): string {
  const trimmed = input.nameOverride?.trim();
  if (input.count === 1 && trimmed) return trimmed.slice(0, 120);
  const base = trimmed || input.templateName;
  if (input.count <= 1) return base.slice(0, 120);
  const suffix = ` #${input.index}`;
  const maxBase = Math.max(1, 120 - suffix.length);
  return `${base.slice(0, maxBase)}${suffix}`;
}
