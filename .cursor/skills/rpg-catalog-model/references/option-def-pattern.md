# Padrão option_def / option_value

Três famílias — **não unificar** em tabela genérica.

| Domínio | Def | Value | FK composta |
|---------|-----|-------|-------------|
| Espécie | `phb_species_option_def` | `phb_species_option_value` | `(species_id, option_key)` |
| Talento | `phb_feat_option_def` | `phb_feat_option_value` | `(feat_id, option_key)` |
| Subclasse | `phb_subclass_option_def` | `phb_subclass_option_value` | `(subclass_id, option_key)` |

## Colunas extras por domínio

- **Feat:** `depends_on_option_key`, `spell_max_level`, `spell_school_slugs[]`, `spell_ritual_only` — preferir colunas aqui a novas tabelas.
- **Subclass:** `unlock_level` na def.
- **Species:** def mínima (sem label na def; label só no value).

## ENUM

`rpg.option_value_type` — compartilhado (`database/migrations/010_types/003_feat_option_value_types.sql`).

## Doc canônica

[`docs/architecture/catalog-patterns.md`](../../../../docs/architecture/catalog-patterns.md)
