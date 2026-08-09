/**
 * Lâminas Psíquicas (Adaga Espiritual).
 * Stats e propriedades: catálogo `phb_item` / `phb_weapon` (seed C015) — sem hardcode.
 * Aqui só identidade (slug) e elegibilidade da subclasse.
 */
import { isRogueClass } from './sneak-attack';

/** Ataque principal — slug do catálogo. */
export const PSYCHIC_BLADE_ITEM_SLUG = 'psychic-blade';

/** Segunda lâmina (Ação Bônus) — slug do catálogo. */
export const PSYCHIC_BLADE_BONUS_ITEM_SLUG = 'psychic-blade-bonus';

export const PSYCHIC_BLADE_ITEM_SLUGS = [
  PSYCHIC_BLADE_ITEM_SLUG,
  PSYCHIC_BLADE_BONUS_ITEM_SLUG,
] as const;

export function isSoulknifeSubclass(
  classSlug: string | null | undefined,
  subclassSlug: string | null | undefined,
): boolean {
  return isRogueClass(classSlug) && subclassSlug === 'soulknife';
}

export function hasPsychicBlades(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): boolean {
  return (
    isSoulknifeSubclass(input.classSlug, input.subclassSlug) &&
    (input.level ?? 0) >= 3
  );
}

export function isPsychicBladeItemSlug(slug: string): boolean {
  return (
    slug === PSYCHIC_BLADE_ITEM_SLUG || slug === PSYCHIC_BLADE_BONUS_ITEM_SLUG
  );
}

/** Slot sintético na ficha: principal vs Ação Bônus. */
export function psychicBladeEquipmentSlot(
  slug: string,
): 'main_hand' | 'off_hand' {
  return slug === PSYCHIC_BLADE_BONUS_ITEM_SLUG ? 'off_hand' : 'main_hand';
}
