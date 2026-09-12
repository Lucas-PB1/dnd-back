---
type: Concept
title: Creature template — identidade, variante, escala, controle
description: >-
  Quatro camadas ortogonais: compêndio (template), choice/variante,
  scale binding (nível ou slot), controle do player via game_actor.
tags: [creatures, actors, scale, companion, spirit, sql-first]
timestamp: 2026-09-12
---

# Creature template — identidade, variante, escala, controle

## Regra

Toda criatura jogável na mesa é **template → `game_actor`**. Companion, spirit, montaria PHB, veículo e monstro “de estimação” **não** são ontologias distintas de criatura — diferem em **variante**, **escala** e **vínculo de controle**.

| Camada | Pergunta | SSOT |
| --- | --- | --- |
| **Identidade** | O que é no compêndio? | `phb_creature_template` (+ speed/action/trait/spell) |
| **Variante** | Qual forma desta família? | maps de choice (`phb_companion_template_map`, `phb_spell_spirit_variant`, …) |
| **Escala** | Os números sobem com o quê? | `phb_creature_scale_by_level` \| `phb_creature_scale_by_slot` (1:1 opcional) |
| **Controle** | Quem manda na mesa? | `game_actor` (`parent_character_id`, `actor_kind`, HP/CA atuais) |

## Escala (binding)

| Tabela | Binding | Uso típico |
| --- | --- | --- |
| `phb_creature_scale_by_level` | nível do personagem (+ atributo na CA) | Beast Master / Primal |
| `phb_creature_scale_by_slot` | círculo do **slot** | Summon\* / Find Steed |
| *(ausente)* | nenhuma | bestiário, montaria PHB, veículo, dragão domesticado |

Um template tem **no máximo um** perfil de escala na prática (XOR). Escala recalcula HP/CA no sync/cast; não substitui o controle de runtime.

## Controle (runtime)

Player (ou DM) opera **estado do actor**, não a receita do catálogo:

- PV atual / máximo, CA efetiva, rolagens, condições
- Vínculo: `parent_character_id` + `actor_kind` (`creature` \| `mount` \| `vehicle` \| `companion`)

Ex.: dragão domesticado = identidade fixa + controle do player + **sem** scale row.

## Spawn / origem (rótulos de produto)

| Origem | Link SQL | Variante | Escala |
| --- | --- | --- | --- |
| Subclasse companion | `phb_companion_profile` | `phb_companion_template_map` | `scale_by_level` |
| Magia spirit / steed | `phb_spell_spirit` | `phb_spell_spirit_variant` | `scale_by_slot` |
| Link montaria/veículo | endpoints character vehicles | — | — |
| Spawn genérico / encontro | `spawn-from-template` | — | — |

`spirit_actor` em [summon-vs-conjure.md](/summon-vs-conjure.md) = origem de spawn + escala por slot — **não** um tipo de criatura separado do bestiário.

## Anti-padrões

- Colunas `companion_*` / `spirit_*` na raiz do template (misturam binding com identidade)
- Tratar “só companion/spirit têm controle de player”
- Unificar Conjure\* neste modelo (é `area_effect`, sem ficha)

## Relacionados

- [Summon vs Conjure](/summon-vs-conjure.md)
- [`docs/architecture/creature-template-field-map.md`](../architecture/creature-template-field-map.md)
