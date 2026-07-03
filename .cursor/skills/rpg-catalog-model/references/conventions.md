# Convenções

## Identidade
- `BIGSERIAL id` — PK interna, joins
- `slug TEXT UNIQUE` — identificador estável para API (`/classes/guerreiro`)

## Naming
- Tabelas: `phb_<entidade>`
- FKs: `<entidade>_id`
- Schema: `rpg`

## Audit columns
`created_at`, `updated_at` em: spell, class, subclass, species, background, item

## ENUMs (schema rpg)
Ver `database/migrations/010_types/002_types.sql`

## Seeds
- `database/seeds/000_truncate.sql` — ordem FK-safe
- `database/seeds/phb/S###_<tabela>.sql`
- `database/seeds/subclass/S###_<tabela>.sql`

## API vs SQL
| Camada | Identificador |
|--------|---------------|
| URL / DTO | slug |
| JOIN / FK | id |
