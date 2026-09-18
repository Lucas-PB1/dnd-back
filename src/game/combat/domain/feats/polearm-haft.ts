const POLEARM_HAFT_ITEM_SLUGS = new Set([
  'quarterstaff',
  'spear',
  'lance',
  'glaive',
  'halberd',
  'pike',
]);

/** Cajado, Lança, ou arma com Extensão + Pesado (PAM Golpe de Haste). */
export function isPolearmHaftEligibleWeapon(input: {
  itemSlug: string;
  propertySlugs?: readonly string[] | null;
}): boolean {
  if (POLEARM_HAFT_ITEM_SLUGS.has(input.itemSlug)) return true;
  const props = input.propertySlugs ?? [];
  return props.includes('reach') && props.includes('heavy');
}

export function assertPolearmHaftBonusAttack(input: {
  featSlugs: readonly string[];
  mode?: 'melee' | 'ranged';
  itemSlug: string;
  propertySlugs?: readonly string[] | null;
}): void {
  if (!input.featSlugs.includes('polearm-master')) {
    throw new Error('Golpe de Haste exige o talento Mestre em Armas de Haste');
  }
  if (input.mode !== 'melee') {
    throw new Error('Golpe de Haste exige ataque corpo a corpo');
  }
  if (
    !isPolearmHaftEligibleWeapon({
      itemSlug: input.itemSlug,
      propertySlugs: input.propertySlugs,
    })
  ) {
    throw new Error(
      'Golpe de Haste exige Cajado, Lança ou arma Extensão+Pesado',
    );
  }
}
