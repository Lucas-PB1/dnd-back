# DB-0b — Fold runtime (skirmish, flags, wild shape, vehicle…)

**Status:** aberto · **Pai:** [`db-0-reorg-migrations.md`](db-0-reorg-migrations.md) · **Dep:** DB-0a · **Tam:** M

## Skills / rules

`postgresql-sql` · `catalog-sql-first` · `typeorm` · `dry`  
`catalog-sql-first.mdc` · `game-folder-conventions.mdc` (se entity)

## Escopo

Fold no CREATE canônico (exemplos conhecidos):

- `sacred_weapon_active` → `0129_player_character_state.sql` (e entity)
- Skirmish tables (`20260917_skirmish*.sql`) → `020_tables/` se ainda só em migration
- Wild shape modular / companion / spirit / vehicle metrics / heritage options / views filtro
- Qualquer `ADD COLUMN` restante das migrations 20260912–17

## Fora

- Esvaziar pasta (→ DB-0c)

## DoD

- [ ] Drift conhecido no CREATE
- [ ] Entities TypeORM alinhadas às colunas foldadas
- [ ] Schema sozinho cria objetos que hoje dependem dessas migrations
