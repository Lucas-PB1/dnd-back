import {
  DRUIDIC_LANGUAGE_SLUG,
  THIEVES_CANT_LANGUAGE_SLUG,
} from '../class-options/class-language-grant';

/** Idiomas concedidos só por classe — nunca como escolha livre de antecedente. */
export const CLASS_EXCLUSIVE_LANGUAGE_SLUGS = [
  DRUIDIC_LANGUAGE_SLUG,
  THIEVES_CANT_LANGUAGE_SLUG,
] as const;

const CLASS_EXCLUSIVE_SET = new Set<string>(CLASS_EXCLUSIVE_LANGUAGE_SLUGS);

/** PHB 2024: escolhas de antecedente/classe usam idiomas padrão (não raros). */
export function isPickableLanguageChoice(
  slug: string,
  language: { isRare: boolean },
): boolean {
  if (language.isRare) return false;
  if (CLASS_EXCLUSIVE_SET.has(slug)) return false;
  return true;
}
