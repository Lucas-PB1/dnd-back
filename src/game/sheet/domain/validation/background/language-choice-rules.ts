import {
  DRUIDIC_LANGUAGE_SLUG,
  THIEVES_CANT_LANGUAGE_SLUG,
} from '../class-options/class-language-grant';

export const CLASS_EXCLUSIVE_LANGUAGE_SLUGS = [
  DRUIDIC_LANGUAGE_SLUG,
  THIEVES_CANT_LANGUAGE_SLUG,
] as const;

const CLASS_EXCLUSIVE_SET = new Set<string>(CLASS_EXCLUSIVE_LANGUAGE_SLUGS);

export function isPickableLanguageChoice(
  slug: string,
  language: { isRare: boolean },
): boolean {
  if (language.isRare) return false;
  if (CLASS_EXCLUSIVE_SET.has(slug)) return false;
  return true;
}
