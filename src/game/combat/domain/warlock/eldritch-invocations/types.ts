import type { BlastInvocationSlug } from '../features';

export type EldritchInvocationCatalogRow = {
  slug: string;
  name: string;
  minLevel: number;
  requiresPactSlug: string | null;
  requiresInvocationSlug: string | null;
  repeatable: boolean;
};

export type EldritchInvocationEffectRow = EldritchInvocationCatalogRow & {
  kind: string;
  grantedSpellSlug: string | null;
};

export type ClassOptionLike = {
  optionKey: string;
  valueId: string;
  instanceIndex?: number;
};

export type EldritchBlastCantripBinding = {
  instanceIndex: number;
  invocationSlug: BlastInvocationSlug;
  cantripSlug: string;
};

export type EldritchOriginFeatBinding = {
  instanceIndex: number;
  featSlug: string;
};

export type EldritchCantripEligibility = {
  slug: string;
  isWarlockCantrip: boolean;
  requiresAttackRoll: boolean;
  rangeMeters: number | null;
  dealsDamage: boolean;
};

export const GIFT_OF_THE_DEPTHS_SLUG = 'gift-of-the-depths';

export type EldritchFreeCastResolution = {
  invocationSlug: string;
  invocationName: string;
  economy: 'at_will' | 'once_per_long_rest';
};
