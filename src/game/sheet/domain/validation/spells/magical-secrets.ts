/** Segredos Mágicos (Bardo L10+): listas extras para magias preparadas. */
export const MAGICAL_SECRETS_UNLOCK_LEVEL = 10;
export const MAGICAL_SECRETS_LIST_SLUGS = ['cleric', 'druid', 'wizard'] as const;

export function magicalSecretsListSlugs(
  classSlug: string | null | undefined,
  level: number,
): string[] {
  if (classSlug === 'bard' && level >= MAGICAL_SECRETS_UNLOCK_LEVEL) {
    return [...MAGICAL_SECRETS_LIST_SLUGS];
  }
  return [];
}
