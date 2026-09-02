import type { BlastInvocationSlug } from '../features';

export type EldritchInvocationCatalogRow = {
  slug: string;
  name: string;
  minLevel: number;
  requiresPactSlug: string | null;
  requiresInvocationSlug: string | null;
  repeatable: boolean;
};

/** Linha com efeitos de combate / free cast (catálogo completo). */
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

/** Metadados mínimos do truque para elegibilidade PHB 2024. */
export type EldritchCantripEligibility = {
  slug: string;
  /** Truque (nível 0) conhecido como magia de Bruxo. */
  isWarlockCantrip: boolean;
  requiresAttackRoll: boolean;
  /** Alcance em metros (heurística a partir do texto do catálogo). */
  rangeMeters: number | null;
  /**
   * Causa dano: ataque, salvaguarda típica de dano, ou descrição com dado de dano.
   * Sem coluna dedicada na view — heurística documentada.
   */
  dealsDamage: boolean;
};

/** Presente das Profundezas: free cast 1×/Descanso Longo (demais free_cast = à vontade). */
export const GIFT_OF_THE_DEPTHS_SLUG = 'gift-of-the-depths';

export type EldritchFreeCastResolution = {
  invocationSlug: string;
  invocationName: string;
  economy: 'at_will' | 'once_per_long_rest';
};
