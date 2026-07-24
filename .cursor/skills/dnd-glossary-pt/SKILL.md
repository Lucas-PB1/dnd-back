---
name: dnd-glossary-pt
description: Glossário PHB 2024 PT-BR e convenções de slug da API. Use quando nomear endpoints, campos ou explicar regras do jogo.
---

# Glossário PT-BR + slugs

Ver [`terms-pt-br.md`](references/terms-pt-br.md)

## Slugs no banco / URL

| Tipo | Slug | Exemplo URL |
|------|------|-------------|
| Classe, espécie, antecedente, item, arma, armadura | **EN** kebab | `/classes/fighter`, `/species/dwarf`, `/armor/leather-armor` |
| Magia (muitas) | **PT** kebab | `/spells/bola-de-fogo` |
| Atributo | **PT** sem acento | `forca`, `destreza` |

- JSON: `name` / textos user-facing em **PT**
- Código TypeScript: identificadores em **inglês**
- Rotas de equipamento: `/armor`, `/weapons`, `/tools`, `/items` — **não** `/equipment/armor`

## Uso

Termos oficiais PHB 2024 PT-BR nos textos. Para roteamento técnico → `nestjs-bounded-context` → `slug-routing.md`.
