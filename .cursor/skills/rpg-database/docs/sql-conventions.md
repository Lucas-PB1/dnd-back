# Convenções PostgreSQL

## Alvo

PostgreSQL **14+**, schema `rpg`, extensão `pg_trgm`.

## Nomenclatura

| Item | Padrão |
|------|--------|
| Schema | `rpg` |
| Catálogo | `phb_<entidade>` |
| Ficha | `player_character`, `player_character_*` |
| PK | slug TEXT (`barbarian`, `bjorn`) |
| ENUMs | `rpg.skill_source`, etc. |

## Modelo híbrido (regra de ouro)

1. **`sheet JSONB`** — fonte para round-trip com `data/characters/{id}.json`
2. **Projeções normalizadas** — consultas, FKs, estado mutável (PV, slots, recursos)
3. **Validação de regras** — continua no Node (`npm run fichas:all`)

## JSONB permitido

- Catálogo: `benefits`, `source_meta`, `trait_table`, pacotes de equipamento
- Ficha: `sheet`, `ac_detail`, `ability_generation`, `starting_packages`, `feat.options`

## JSONB evitado na ficha

- `resources`, `speciesChoices`, `classChoices`, `hp`, `armorClass` — use tabelas/colunas v2

## Comandos

```bash
npm run generate:sql-schema
npm run validate:db
psql -U postgres -d rpg -f database/schema.sql
```

## Índices

- GIN em `sheet` (`jsonb_path_ops`) — busca no JSON
- GIN trgm em `name` — autocomplete de personagem
- B-tree em FKs (`species_id`, `class_id`, `level`)
