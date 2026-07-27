export type SizeCategory = 'tiny' | 'small' | 'medium' | 'large' | 'huge' | 'gargantuan';

/**
 * Deriva categoria de tamanho a partir do texto `phb_species.size`.
 * Espécies dual (“Médio … ou Pequeno …”) usam `preferred` se informado; senão medium.
 */
export function resolveSizeCategory(
  sizeText: string | null | undefined,
  preferred?: SizeCategory | null,
): SizeCategory {
  if (preferred) return preferred;

  const text = (sizeText ?? '').trim();
  if (!text) return 'medium';

  const hasSmall = /\bPequeno\b/i.test(text);
  const hasMedium = /\bM[eé]dio\b/i.test(text);
  const hasLarge = /\bGrande\b/i.test(text);
  const hasTiny = /\bMin[uú]sculo\b/i.test(text);

  if (hasMedium && hasSmall) return 'medium';
  if (hasSmall) return 'small';
  if (hasTiny) return 'tiny';
  if (hasLarge) return 'large';
  if (hasMedium) return 'medium';
  return 'medium';
}

/** Lê escolha de tamanho em speciesChoices, se existir. */
export function sizeCategoryFromChoices(
  choices: readonly { choiceKind: string; choiceSlug: string }[] | undefined,
): SizeCategory | null {
  const match = choices?.find(
    (c) =>
      c.choiceKind === 'size' ||
      c.choiceKind === 'creature_size' ||
      c.choiceKind === 'tamanho',
  );
  if (!match) return null;
  const slug = match.choiceSlug.toLowerCase();
  if (slug === 'small' || slug === 'pequeno') return 'small';
  if (slug === 'medium' || slug === 'medio' || slug === 'médio') return 'medium';
  if (slug === 'tiny' || slug === 'minusculo' || slug === 'minúsculo') return 'tiny';
  if (slug === 'large' || slug === 'grande') return 'large';
  return null;
}
