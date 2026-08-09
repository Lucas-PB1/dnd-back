# Convenções

## Identidade
- `BIGSERIAL id` — PK interna, joins
- `slug TEXT UNIQUE` — identificador estável para API (`/classes/fighter`; classes EN, magias muitas PT)

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
- `database/seeds/combat/C###_*.sql` — economia, painel, armas concedidas por classe/subclasse

### Armas concedidas (sem hardcode no domain)

Se uma classe/subclasse manifesta arma na ficha (ex.: Lâminas Psíquicas):

1. **Seed** em `phb_item` + `phb_weapon` (+ `properties` / property_link / mastery) — tipicamente `combat/C###_*.sql`.
2. Domain guarda só o **slug** estável e elegibilidade (`hasPsychicBlades`).
3. `ResolveEquippedWeaponAttacks` **carrega** a arma do catálogo por slug e injeta como peça de ataque (não inventário permanente).

**Anti-padrão:** `EquippedWeaponPiece` com damage/type/properties literais no TypeScript.
## API vs SQL
| Camada | Identificador |
|--------|---------------|
| URL / DTO | slug |
| JOIN / FK | id |
