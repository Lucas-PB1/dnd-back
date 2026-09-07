/** Tabela Fabricação Rápida (PHB Artesão) — ferramenta → itens catálogo. */
export const ARTISAN_QUICK_CRAFT_BY_TOOL: Readonly<
  Record<string, readonly string[]>
> = {
  'ferramentas-de-carpinteiro': ['escada', 'tocha'],
  'ferramentas-de-coureiro': ['algibeira', 'estojo-mapa-ou-pergaminho'],
  'ferramentas-de-entalhador': ['quarterstaff', 'club', 'greatclub'],
  'ferramentas-de-ferreiro': [
    'arpeu',
    'balde',
    'esferas-de-metal',
    'estrepes',
    'pote-ferro',
  ],
  'ferramentas-de-funileiro': ['caixa-para-fogo', 'pa', 'sino'],
  'ferramentas-de-oleiro': ['jarro-4-litros', 'lampada'],
  'ferramentas-de-pedreiro': ['roldana-e-polias'],
  'ferramentas-de-tecelao': ['cesta', 'corda', 'rede', 'tenda'],
};

export const ARTISAN_CRAFT_INSTANCE_KEY = 'artisanCraftedQty' as const;

export const ARTISAN_CRAFT_ACTION_SLUG = 'artisan-craft' as const;
export const ARTISAN_FEAT_SLUG = 'artisan' as const;

export function toolSlugForCraftItem(itemSlug: string): string | undefined {
  for (const [tool, items] of Object.entries(ARTISAN_QUICK_CRAFT_BY_TOOL)) {
    if (items.includes(itemSlug)) return tool;
  }
  return undefined;
}

export function isArtisanQuickCraftItem(itemSlug: string): boolean {
  return toolSlugForCraftItem(itemSlug) != null;
}

export function readArtisanCraftedQty(
  instanceProperties: Record<string, unknown> | null | undefined,
): number {
  const raw = instanceProperties?.[ARTISAN_CRAFT_INSTANCE_KEY];
  return typeof raw === 'number' && raw > 0 ? Math.floor(raw) : 0;
}

export function withArtisanCraftedQty(
  instanceProperties: Record<string, unknown> | null | undefined,
  qty: number,
): Record<string, unknown> | null {
  const base =
    instanceProperties && typeof instanceProperties === 'object'
      ? { ...instanceProperties }
      : {};
  if (qty <= 0) {
    delete base[ARTISAN_CRAFT_INSTANCE_KEY];
    return Object.keys(base).length > 0 ? base : null;
  }
  base[ARTISAN_CRAFT_INSTANCE_KEY] = qty;
  return base;
}
