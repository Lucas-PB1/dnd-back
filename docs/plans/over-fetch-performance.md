# Over-fetch performance

Matriz pós-lista de personagens (`GET /characters` summary).

| Fluxo | Antes | Depois |
|---|---|---|
| Encontro (PCs) | `loadMany` sheet completa só por feat slugs + CA | SQL `loadFeatSlugsByCharacterIds` |
| Inventário list | N× `findOne` catálogo por item | `In(slugs)` + mapa no DTO |
| `GET .../state` granted casts | `sheetRepository.load` full | `loadGrantedSpellSlice` (feats/options/species/spells) |
| Labels ficha / review | `useSpells` / `useFeats` com description/benefits | `fields=summary` + `useSpellLabels` / `useFeatLabels` |
| Feats na ficha | N× detail + N× options | `GET /feats/by-slugs` + `GET /feats/options?slugs=` |
| Combat mechanical | Catálogo monolítico | `?classSlug=&subclassSlug=` na API e ficha |
| Wizard identity / tools | Listagens com description | `fields=summary` em classes/species/backgrounds/items |

## Query params

- Catálogo list: `fields=summary` (default = DTO completo / compêndio).
- Feats batch: até 40 slugs.
- Combat: filtros opcionais; cache React Query inclui chave de filtro.

## Fora desta entrega

- POST/PATCH de personagem sem devolver ficha full.
- Batch real de `loadManyCharacterSheets` sem callers.
- Índice global de links de equipment.
