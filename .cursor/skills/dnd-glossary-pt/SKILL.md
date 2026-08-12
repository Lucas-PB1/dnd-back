---
name: dnd-glossary-pt
description: Glossário PHB 2024 PT-BR e convenções de slug da API. Use quando nomear endpoints, campos ou explicar regras do jogo.
---

# Glossário PT-BR + slugs

SSOT de nomes: [`docs/glossary/termos-traduzidos.json`](../../../docs/glossary/termos-traduzidos.json)  
(+ override de mesa em `terms-pt-br.md`, ex.: Ranger → **Patrulheiro**).  
Resumo operacional: [`terms-pt-br.md`](references/terms-pt-br.md)

## Slugs no banco / URL

| Tipo | Slug | Exemplo URL |
|------|------|-------------|
| Classe, espécie, antecedente, item, arma, armadura | **EN** kebab | `/classes/fighter`, `/species/dwarf`, `/armor/leather-armor` |
| Magia (muitas) | **PT** kebab | `/spells/bola-de-fogo` |
| Atributo | **PT** sem acento | `forca`, `destreza` |

- JSON: `name` / textos user-facing em **PT** (glossário)
- Código TypeScript: identificadores em **inglês**
- Rotas de equipamento: `/armor`, `/weapons`, `/tools`, `/items` — **não** `/equipment/armor`

## Uso

Em conflito entre convenção antiga do repo e o glossário, **reescreva para o glossário**. Para roteamento técnico → `nestjs-bounded-context` → `slug-routing.md`.
