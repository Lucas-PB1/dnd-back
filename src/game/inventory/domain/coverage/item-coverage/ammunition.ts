import {
  normalizeCoverageText,
  type CoverageBaseContext,
} from './parse';

const AMMUNITION_NAME_HINTS = [
  'municao',
  'flecha',
  'flechas',
  'virote',
  'virotes',
  'bala',
  'balas',
  'agulha',
  'agulhas',
  'arrow',
  'arrows',
  'bolt',
  'bolts',
  'bullet',
  'bullets',
  'needle',
  'needles',
  'pedra de funda',
  'pedras de funda',
  'sling bullet',
  'sling bullets',
] as const;

const AMMUNITION_CONTAINER_HINTS = [
  'aljava',
  'estojo',
  'quiver',
  'case',
] as const;

/** Peça base é munição (não estojo/aljava). */
export function isAmmunitionBase(base: CoverageBaseContext): boolean {
  const slug = normalizeCoverageText(base.itemSlug);
  const name = normalizeCoverageText(base.itemName);
  const subtype = normalizeCoverageText(base.subtypeLabel ?? '');
  const type = normalizeCoverageText(base.itemType);

  if (type.includes('ammunition')) return true;
  if (slug === 'municao' || name === 'municao') return true;

  if (
    AMMUNITION_CONTAINER_HINTS.some(
      (hint) => slug.includes(hint) || name.includes(hint),
    )
  ) {
    return false;
  }

  const haystack = `${slug} ${name} ${subtype}`;
  return AMMUNITION_NAME_HINTS.some((hint) => haystack.includes(hint));
}
