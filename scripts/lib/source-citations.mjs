/** Citações de origem PHB — slug estável para FK no catálogo. */

const EDITION_BY_BOOK = {
  "Livro do Jogador 2024": "phb-2024-pt",
};

export function sourceCitationSlug(source) {
  if (!source) return null;
  const editionSlug = EDITION_BY_BOOK[source.book] ?? "phb-2024-pt";
  const pages = (source.pdfPages ?? []).join("-") || "0";
  return `${editionSlug}:ch${source.chapter}:${pages}`;
}

export function collectSourceCitations(...entityLists) {
  const map = new Map();
  for (const entities of entityLists) {
    for (const entity of entities) {
      const source = entity.source ?? entity.sourceMeta;
      if (!source) continue;
      const slug = sourceCitationSlug(source);
      if (!slug || map.has(slug)) continue;
      map.set(slug, {
        slug,
        editionSlug: EDITION_BY_BOOK[source.book] ?? "phb-2024-pt",
        chapter: source.chapter,
        chapterTitle: source.chapterTitle ?? null,
        pdfPath: source.pdfPath ?? null,
        pdfPages: source.pdfPages ?? [],
        extractedAt: source.extractedAt ?? null,
      });
    }
  }
  return [...map.values()];
}
