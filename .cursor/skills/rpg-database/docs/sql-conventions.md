# Convenções PostgreSQL v4

Roadmap: [plano-final.md](plano-final.md)

## Alvo

PostgreSQL **14+** (15+ recomendado para `UNIQUE NULLS NOT DISTINCT`), schema `rpg`.

## Nomenclatura

| Item | Padrão |
|------|--------|
| Schema | `rpg` |
| Catálogo | `phb_<entidade>` |
| Ficha (fase 5) | `player_character`, `player_character_*` |
| PK catálogo | `id BIGSERIAL` + `slug TEXT UNIQUE` |
| PK ficha (fase 5) | `id TEXT` (slug do personagem) |
| ENUMs | `rpg.<domínio>` (ex.: `rpg.item_type`) |

## Modelo catálogo (v4)

1. **Normalização** — preferir tabelas/colunas tipadas sobre JSONB
2. **Slug estável** — identificador canônico para API e JSON
3. **Views** — camada de leitura para a aplicação
4. **JSONB residual** — só onde estrutura é irregular (`phb_item.cost`, `phb_species.source_meta`)

## JSONB permitido (catálogo)

- `phb_item.cost`, `phb_item.properties`
- `phb_species.source_meta`

## JSONB evitado (normalizado)

- `phb_feat.benefits` → `phb_feat_benefit`
- `phb_weapon.property_ids` → `phb_weapon_property_link`
- `phb_class.skill_choices` → `phb_class_skill_pool`

## Comandos

```bash
npm run generate:sql-schema   # regenera database/schema.sql
npm run validate:db           # valida estrutura
npm run generate:seed-phb     # regenera seed PHB
npm run seed:all              # schema + seed + validação
npm run seed:run              # aplica no PostgreSQL local
```

## Índices

### Atual (catálogo)

- B-tree em FKs (`school_id`, `class_id`, `category_id`)
- B-tree em filtros (`phb_spell.level`)
- GIN trgm em `name` — autocomplete (`phb_spell`, `phb_feat`, `phb_class`, `phb_item`)

### Fase 5 (fichas)

- GIN `jsonb_path_ops` em `player_character.sheet`
- GIN trgm em `player_character.name`
- B-tree composto `(class_id, level)`, `(edition_id)`

## Deploy

| Ambiente | Comando | Nota |
|----------|---------|------|
| Dev local | `npm run seed:run` | `dev-reset.sql` + schema + PHB |
| Staging/Prod | `npm run migrate:run` → `npm run seed:prod` | **Nunca** DROP SCHEMA |

Ver [plano-final.md § fase 2](plano-final.md#fase-2--operação-e-migrations-).
