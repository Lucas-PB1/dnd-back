# Padrão option_def / option_value

Tabela unificada `phb_option_def` / `phb_option_value` com `scope` + `owner_id`.

| `scope` | `owner_id` | Exemplo |
|---------|------------|---------|
| `species` | `phb_species.id` | linhagem élfica |
| `feat` | `phb_feat.id` | magia de Iniciado |
| `subclass` | `phb_subclass.id` | Presa do Caçador |
| `class` | `phb_class.id` | Ordem Divina / Ordem Primal |

## Colunas extras por domínio

- **Feat:** `depends_on_option_key`, `spell_max_level`, `spell_school_slugs[]`, `spell_ritual_only` — preferir colunas aqui a novas tabelas.
- **Subclass:** `unlock_level` na def.
- **Species:** def mínima (sem label na def; label só no value).

## ENUM

`rpg.option_value_type` — compartilhado (`database/migrations/010_types/002_types.sql`).

## Doc canônica

[`docs/architecture/catalog-patterns.md`](../../../../docs/architecture/catalog-patterns.md)
