/** Categorias de ferramentas PHB (Ferramentas de Artesão, Suprimentos, etc.). */
export const TOOL_CATEGORIES = [
  { slug: "artisan", name: "Ferramentas de Artesão", sortOrder: 1 },
  { slug: "supplies", name: "Suprimentos", sortOrder: 2 },
  { slug: "utensils", name: "Utensílios", sortOrder: 3 },
  { slug: "kit", name: "Kit", sortOrder: 4 },
  { slug: "instrument", name: "Instrumento Musical", sortOrder: 5 },
  { slug: "other", name: "Ferramentas Diversas", sortOrder: 6 },
];

/** Nomes de categoria nos JSON de antecedente (podem diferir de TOOL_CATEGORIES.name). */
export const TOOL_CATEGORY_ALIASES = {
  "Kit de Jogos": "kit",
};

export function categorySlugFromName(categoryName) {
  if (!categoryName) return null;
  if (TOOL_CATEGORY_ALIASES[categoryName]) return TOOL_CATEGORY_ALIASES[categoryName];
  return TOOL_CATEGORIES.find((c) => c.name === categoryName)?.slug ?? null;
}

export function toolCategorySlug(toolId) {
  if (toolId.startsWith("suprimentos-")) return "supplies";
  if (toolId.startsWith("utensilios-")) return "utensils";
  if (toolId.startsWith("kit-de-")) return "kit";
  if (toolId === "instrumento-musical") return "instrument";
  if (toolId.startsWith("ferramentas-de-")) return "artisan";
  return "other";
}
