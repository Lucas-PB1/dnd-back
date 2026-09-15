---
type: Concept
title: Wild Shape (Forma Selvagem) — modular
description: >-
  Forma Selvagem como filtro sobre bestas do catálogo (CR × nível/círculo),
  known forms na ficha, listagem HTTP e game_actor de transformação.
tags: [druid, wild-shape, creatures, sql-first]
timestamp: 2026-09-14
---

# Wild Shape — modular

## Decisão

Wild Shape **não** é uma ontologia de “formas de druida”. É **elegibilidade + transform** sobre templates Beast já existentes no bestiário.

| Camada | SSOT |
| --- | --- |
| Identidade | `phb_creature_template` (`creature_type` Beast, `challenge_rating`) |
| Elegibilidade base | `phb_wild_shape_cr_band` + domínio (`maxWildShapeCr`, fly) |
| Formas conhecidas | `phb_wild_shape_known_band` (4@2 / 6@4 / 8@8) + estado na ficha |
| Elegibilidade Moon | CR = ⌊nível/3⌋; fly ainda pela tabela base |
| Runtime | `wild_shape_*` na ficha + `game_actor` (`creature`, parent = PC) |
| Economia / painel | `wild-shape`, `moon-combat-wild-shape`, `wild-shape-end`, set/replace known |

Quando o catálogo ganhar bestas com ND maior, elas entram **sozinhas** se couberem na regra — sem seed `wild-shape-*`.

## Onda 1 (feita)

- Kind `wild_shape`; apply exige `templateSlug`.
- Temp HP: base = nível; Moon = 3×nível; Moon CA máx(besta, 13+SAB).
- Long rest limpa flags; `wild-shape-end` encerra sem gastar uso.

## Onda 2 (feita)

- **Known forms**: `set-wild-shape-known-forms` (`templateSlugs[]`) e `replace-wild-shape-known-form` (`replaceSlug` + `templateSlug`, 1× após DL).
- Gate: `wild-shape` / Moon só com slug nas conhecidas.
- **Listagem**: `GET /characters/:id/druid/wild-shape/eligible` (bestas elegíveis + known + swap).
- **Painel / economy**: ações set/replace no SQL.
- **`game_actor`**: spawn `creature` ao entrar; delete no end / long rest; HP do PC; CA efetiva (Moon floor).

## Dívida (onda 3+)

- _(nenhuma imediata para Wild Shape / Companion)_

## Catálogo Beast (PHB 2024 App. B + MM Animals)

- PHB App. B: extract `docs/source/extracts/phb/creature-stat-blocks-beasts.json` + `seed.phb-beasts.sql` (43).
- MM Animals: extract `docs/source/extracts/mm/animals-beasts.json` + `seed.mm-animals.sql` (42 novas; sem Swarm/não-Beast).
- Reusa slugs do Find Familiar; CR/fly alimentam elegibilidade automaticamente.

## Companheiro Selvagem (feita)

- Ação `wild-companion`: Magic action; gasta **Forma Selvagem** *ou* `slotLevel`; `spiritVariantKey`.
- Reusa mapa `convocar-familiar` → Beast CR0; marca actor como **Fey**; some no Descanso Longo.

## Relacionados

- [Template / escala / controle](/creature-template-scale-control.md)
- [Summon vs Conjure](/summon-vs-conjure.md)
