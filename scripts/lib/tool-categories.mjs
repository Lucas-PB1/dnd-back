/** Categorias de ferramentas PHB (Ferramentas de Artesão, Suprimentos, etc.). */
export const TOOL_CATEGORIES = [
  { slug: "artisan", name: "Ferramentas de Artesão", sortOrder: 1 },
  { slug: "supplies", name: "Suprimentos", sortOrder: 2 },
  { slug: "utensils", name: "Utensílios", sortOrder: 3 },
  { slug: "kit", name: "Kit", sortOrder: 4 },
  { slug: "instrument", name: "Instrumento Musical", sortOrder: 5 },
  { slug: "other", name: "Ferramentas Diversas", sortOrder: 6 },
];

export function toolCategorySlug(toolId) {
  if (toolId.startsWith("suprimentos-")) return "supplies";
  if (toolId.startsWith("utensilios-")) return "utensils";
  if (toolId.startsWith("kit-de-")) return "kit";
  if (toolId === "instrumento-musical") return "instrument";
  if (toolId.startsWith("ferramentas-de-")) return "artisan";
  return "other";
}
