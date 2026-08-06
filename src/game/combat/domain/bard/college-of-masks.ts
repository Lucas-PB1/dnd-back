/**
 * Máscaras do Colégio das Máscaras — validação.
 * Catálogo: `rpg.phb_persona_mask` / `v_phb_persona_mask`.
 */

export type PersonaMaskSlug = string;

/** Máscaras equipadas simultaneamente: 2 a partir do nv. 14 (Mestre de Muitas Faces). */
export function maxEquippedPersonaMasks(level: number): 1 | 2 {
  return level >= 14 ? 2 : 1;
}

/** Máscaras conhecidas: 3 (nv.3), 4 (nv.6), 5 (nv.14). */
export function knownPersonaMaskCount(level: number): 3 | 4 | 5 {
  if (level >= 14) return 5;
  if (level >= 6) return 4;
  return 3;
}

export function isPersonaMaskSlug(
  catalogSlugs: readonly string[],
  slug: string,
): boolean {
  return catalogSlugs.includes(slug);
}

/**
 * Valida máscaras equipadas na mesa: slugs do catálogo, sem duplicata, até o máximo do nível.
 */
export function assertValidPersonaMasks(
  catalogSlugs: readonly string[],
  masks: string[],
  level: number,
): void {
  const max = maxEquippedPersonaMasks(level);
  if (masks.length > max) {
    throw new Error(
      `College of Masks allows at most ${max} equipped mask(s) at level ${level}`,
    );
  }

  const seen = new Set<string>();
  for (const mask of masks) {
    if (!isPersonaMaskSlug(catalogSlugs, mask)) {
      throw new Error(`Unknown persona mask '${mask}'`);
    }
    if (seen.has(mask)) {
      throw new Error(`Duplicate persona mask '${mask}'`);
    }
    seen.add(mask);
  }
}
