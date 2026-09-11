# Migrations forward

Schema greenfield (SSOT): **`database/schema/`** — ver [`../schema/README.md`](../schema/README.md).

Aplicação local/remoto: `npm run db:setup` (schema + seeds) ou `npm run db:migrate` / `db:migrate:all`.

## Esta pasta

Forward-only deltas **depois** do schema declarative já aplicado. Ordem lexicográfica; registro em `rpg.schema_migration`.

Arquivos atuais:

| Arquivo | Mudança |
| --- | --- |
| `20260908_player_character_state_mesa_circumstances.sql` | `ALTER` em estado de mesa (`mesa_circumstances`) |
| `20260911_phb_class_fighting_style_unlock_level.sql` | Coluna `fighting_style_unlock_level` + UPDATE classes PHB/Valdas/GH |
| `20260911_phb_class_progression_asi_or_feat.sql` | Coluna `asi_or_feat` + UPDATE calendário ASI/talento |

## Quando usar forward vs editar schema/

| Situação | Onde |
| --- | --- |
| Dev local greenfield / reset | Editar `database/schema/**` + `npm run db:setup` |
| Ambiente que já tem dados (Supabase / compartilhado) | Novo arquivo aqui (`YYYYMMDD_descricao.sql`) — **não** editar migration já aplicada |

Ver skill `postgresql-sql` → migrations versionadas; nunca reset destrutivo em banco compartilhado/prod.
