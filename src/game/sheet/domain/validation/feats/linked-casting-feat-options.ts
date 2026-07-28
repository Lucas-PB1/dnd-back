/** Talentos em que o atributo de conjuração da magia bônus deve ser o mesmo do +1 (abilityIncrease). */
export const FEATS_CASTING_ABILITY_MATCHES_ASI = ['telekinetic', 'telepathic'] as const;

export type FeatCastingLinkedToAsiSlug =
  (typeof FEATS_CASTING_ABILITY_MATCHES_ASI)[number];

export function isFeatCastingLinkedToAsi(featSlug: string): boolean {
  return (FEATS_CASTING_ABILITY_MATCHES_ASI as readonly string[]).includes(
    featSlug,
  );
}
