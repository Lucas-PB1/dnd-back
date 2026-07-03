---
name: rpg-catalog-model
description: Explica tabelas, FKs, views e clusters do catálogo PHB 2024 no schema rpg. Use quando o usuário perguntar sobre relações de dados, associações entre tabelas, slug vs id, ou modelo do banco.
---

# Catálogo PHB — modelo de dados

## Quando usar

- Dúvidas sobre tabelas, FKs, views ou ENUMs
- Mapear relações entre entidades (class → subclass, item → weapon)
- Decidir slug vs id em API ou SQL

## Workflow

1. Ler [`docs/data-model.md`](../../../docs/data-model.md) para visão geral
2. Abrir referência específica em `references/`:
   - [`clusters.md`](references/clusters.md) — 7 domínios
   - [`fk-map.md`](references/fk-map.md) — FKs e chaves compostas
   - [`views.md`](references/views.md) — read models
   - [`conventions.md`](references/conventions.md) — slug, ENUMs, audit

## Regras rápidas

- API/contratos: **slug** · joins SQL: **id**
- Itens: sempre partir de `phb_item`; subtipo em weapon/armor/tool
- Catálogo read-only na aplicação
