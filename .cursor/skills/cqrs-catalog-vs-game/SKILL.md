---
name: cqrs-catalog-vs-game
description: Separa queries (catálogo/views) de commands (fichas/game) — CQRS leve no projeto RPG. Use ao implementar leitura PHB vs escrita de personagem ou decidir query vs command handler.
---

# CQRS leve — Catalog vs Game

Doc: [`docs/architecture.md`](../../../docs/architecture.md)

## Referências

- [`query-side-catalog.md`](references/query-side-catalog.md)
- [`command-side-game.md`](references/command-side-game.md)
- [`examples.md`](references/examples.md)

## Regra de ouro

| | Catalog | Game |
|---|---------|------|
| HTTP | GET | GET, POST, PATCH, DELETE |
| SQL | Views `v_phb_*` | Tabelas `player_*` |
| Nest | `queries/` + mapper | handlers + domain + repository |
| Auth | Público | JWT + ownership |
