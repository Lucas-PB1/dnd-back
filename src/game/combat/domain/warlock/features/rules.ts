/**
 * Regras numéricas e constantes de combate do Bruxo (PHB 2024).
 */

export function isWarlockClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'warlock';
}

export function warlockPactSlotLevel(level: number): number {
  if (level >= 9) return 5;
  if (level >= 7) return 4;
  if (level >= 5) return 3;
  if (level >= 3) return 2;
  return 1;
}

export function warlockPactSlotCount(level: number): number {
  if (level >= 17) return 4;
  if (level >= 11) return 3;
  if (level >= 2) return 2;
  return 1;
}

/** Astúcia Mágica: recupera metade dos slots (ceil). L20 Mestre Místico: todos. */
export function magicalCunningSlotRecoveryCount(level: number): number {
  const max = warlockPactSlotCount(level);
  if (level >= 20) return max;
  return Math.ceil(max / 2);
}

/** Contagem PHB 2024 — coluna Invocações da tabela do Bruxo. */
export function warlockInvocationLimit(level: number): number {
  if (level >= 18) return 10;
  if (level >= 15) return 9;
  if (level >= 12) return 8;
  if (level >= 9) return 7;
  if (level >= 7) return 6;
  if (level >= 5) return 5;
  if (level >= 2) return 3;
  if (level >= 1) return 1;
  return 0;
}

export const ELDRITCH_INVOCATION_OPTION_KEY = 'eldritch-invocation';
/** Sibling: mesmo instanceIndex da invocação de blast → slug do truque vinculado. */
export const ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY =
  'eldritch-invocation-cantrip';
/**
 * Sibling: mesmo instanceIndex de `lessons-of-the-first-ones` → talento de Origem.
 */
export const ELDRITCH_INVOCATION_ORIGIN_FEAT_OPTION_KEY =
  'eldritch-invocation-origin-feat';

export const LESSONS_OF_THE_FIRST_ONES_SLUG = 'lessons-of-the-first-ones';

export const BLAST_INVOCATION_SLUGS = [
  'agonizing-blast',
  'repelling-blast',
  'eldritch-spear',
] as const;

export type BlastInvocationSlug = (typeof BLAST_INVOCATION_SLUGS)[number];

export function isBlastInvocationSlug(
  slug: string,
): slug is BlastInvocationSlug {
  return (BLAST_INVOCATION_SLUGS as readonly string[]).includes(slug);
}

export function isLessonsOfTheFirstOnesSlug(slug: string): boolean {
  return slug === LESSONS_OF_THE_FIRST_ONES_SLUG;
}

export const MAGICAL_CUNNING_RESOURCE = 'magical-cunning';
export const DARK_ONES_LUCK_RESOURCE = 'dark-ones-luck';
export const FEY_STEPS_RESOURCE = 'fey-steps';
export const HURL_THROUGH_HELL_RESOURCE = 'hurl-through-hell';
export const SEARING_VENGEANCE_RESOURCE = 'searing-vengeance';
export const BEGUILING_DEFENSES_RESOURCE = 'beguiling-defenses';
export const CLAIRVOYANT_COMBATANT_RESOURCE = 'clairvoyant-competitor';

export function healingLightDiceMax(level: number): number {
  return 1 + level;
}
