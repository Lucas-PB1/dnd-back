# Checklist — novo conteúdo de catálogo

## Espécie / linhagem (species)

1. Tabela/opções: seguir `phb_option_*` + `catalog-patterns.md` (Lote B)
2. Seed em `database/seeds/species/`
3. Views: `v_phb_species_*` / trait choices se a API listar opções
4. Entity/ViewEntity + query Catalog
5. **Não** adicionar `switch (speciesSlug)` em Game — effects/options cobrem mecânica

## Traço / effect

1. Preferir `phb_effect` tipado (`effect-dictionary.md`) a flag booleana nova
2. Seed + load path documentado em `effect-engine-read-path.md`
3. Se for heritage GH: `phb_heritage*` — não misturar em `phb_species`

## Feat / item / magia

1. Seed no domínio certo (`feat/`, `item/`, `spell/`)
2. Grants via `phb_spell_grant` / effects — não duplicar em TS
3. Itens class-granted: `properties.grantedBy*` + helpers em `@catalog/game-port`

## Classe — meta (ex.: nível de Estilo de Luta)

1. Preferir coluna em `phb_class` (nullable) + seed `UPDATE` a `Record` de slugs em Game
2. Migration forward se o DB já existir
3. Entity `PhbClassRef` + query em `class-meta.queries.ts`
4. Predicado puro no domain; validator só resolve do catálogo

## Depois do SQL

- [ ] `npm run db:setup` (ou migrate) local
- [ ] Query/Swagger do Catalog
- [ ] Teste de lookup ou e2e mínimo se contrato público mudou
