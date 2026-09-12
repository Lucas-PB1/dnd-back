---
type: Concept
title: Summon vs Conjure (PHB 2024)
description: >-
  Distinção oficial Summon (ficha/espírito) vs Conjure (efeito/aura),
  convenção PT e mapa de slugs.
tags: [spells, summon, conjure, nomenclature, phb-2024]
timestamp: 2026-09-12
---

# Summon vs Conjure (PHB 2024)

## Regra

| Família EN | Mecânica | Kind | Prefixo PT canônico |
| --- | --- | --- | --- |
| **Summon\*** | Espírito com bloco de stats; actor spawnável | `spirit_actor` | **Invocar** |
| **Conjure\*** | Aura / AoE / efeito móvel; **sem** ficha atacável | `area_effect` | **Conjurar** |
| **Find Steed / Find Familiar** | Montaria sobrenatural / familiar CR0 | `find_spell` | **Convocar** (Find ≠ Summon) |

Ambas as famílias Summon e Conjure são escola **Conjuration** → slug de escola `invocacao` (correto; não renomear a escola).

## Tabela canônica

### `spirit_actor` (Summon\* + blocos embutidos)

| EN | PT canônico | Slug antigo | Slug canônico | Bloco EN | Variantes |
| --- | --- | --- | --- | --- | --- |
| Summon Beast | Invocar Fera | `invocar-fera` | `invocar-fera` | Bestial Spirit | Air / Land / Water |
| Summon Fey | Invocar Feérico | `convocar-feerico` | `invocar-feerico` | Fey Spirit | Fuming / Mirthful / Tricksy |
| Summon Celestial | Invocar Celestial | `convocar-celestial` | `invocar-celestial` | Celestial Spirit | Avenger / Defender |
| Summon Elemental | Invocar Elemental | `convocar-elemental` | `invocar-elemental` | Elemental Spirit | Air / Earth / Fire / Water |
| Summon Aberration | Invocar Aberração | `invocar-aberracao` | `invocar-aberracao` | Aberrant Spirit | Beholderkin / Slaad / Star Spawn |
| Summon Construct | Invocar Constructo | `invocar-constructo` | `invocar-constructo` | Construct Spirit | Clay / Metal / Stone |
| Summon Dragon | Invocar Dragão | `invocar-dragao` | `invocar-dragao` | Draconic Spirit | (resistência/sopro na conjuração) |
| Summon Fiend | Invocar Ínfero | `invocar-infero` | `invocar-infero` | Fiendish Spirit | Demon / Devil / Yugoloth |
| Summon Undead | Invocar Morto-Vivo | `invocar-morto-vivo` | `invocar-morto-vivo` | Undead Spirit | Ghostly / Putrid / Skeletal |
| Giant Insect | Inseto Gigante | `inseto-gigante` | `inseto-gigante` | Giant Insect | Spider / Centipede / Wasp |
| Animate Objects | Animar Objetos | `animar-objetos` | `animar-objetos` | Animated Object | tamanho do objeto |

### `find_spell`

| EN | PT canônico | Slug | Kind note |
| --- | --- | --- | --- |
| Find Steed | Convocar Montaria | `convocar-montaria` | Otherworldly Steed; tipo Celestial/Fey/Fiend |
| Find Familiar | Convocar Familiar | `convocar-familiar` | formas CR0 (bestiary; sem bloco no texto) |

### `area_effect` (Conjure\*)

| EN | PT canônico | Slug antigo | Slug canônico |
| --- | --- | --- | --- |
| Conjure Animals | Conjurar Animais | `invocar-animais` | `conjurar-animais` |
| Conjure Barrage | Conjurar Barragem | `invocar-barragem` | `conjurar-barragem` |
| Conjure Celestial | Conjurar Celestial | `invocar-celestial` | `conjurar-celestial` |
| Conjure Elemental | Conjurar Elemental | `invocar-elemental` | `conjurar-elemental` |
| Conjure Minor Elementals | Conjurar Elementais Menores | `invocar-elementais-menores` | `conjurar-elementais-menores` |
| Conjure Fey | Conjurar Feérico | `invocar-feerico` | `conjurar-feerico` |
| Conjure Volley | Conjurar Saraivada | `invocar-saraivada` | `conjurar-saraivada` |
| Conjure Woodland Beings | Conjurar Seres da Floresta | `invocar-seres-da-floresta` | `conjurar-seres-da-floresta` |

## Pares que não confundir

- **Summon Celestial** (`invocar-celestial`) ≠ **Conjure Celestial** (`conjurar-celestial`)
- **Summon Elemental** (`invocar-elemental`) ≠ **Conjure Elemental** (`conjurar-elemental`) ≠ **Conjure Minor Elementals** (`conjurar-elementais-menores`)
- **Summon Fey** (`invocar-feerico`) ≠ **Conjure Fey** (`conjurar-feerico`)

## Status

Rename de slugs **aplicado** (migration `20260912_summon_conjure_slug_rename.sql` + seeds). A coluna “Slug antigo” abaixo é histórico.

## Ordem de rename de slug

1. Família Conjure: `invocar-*` → `conjurar-*` (libera os slugs `invocar-*` conflitantes).
2. Família Summon que usava `convocar-*`: → `invocar-*`.
3. `Find*` permanece `convocar-montaria` / `convocar-familiar`.

## Dívida (fora desta onda)

- Find Familiar CR0 / Wild Shape / MM genérico
- Conjure\* como actor (não — permanece `area_effect`)

## Status `spirit_actor`

Find Steed + Summons PHB + Inseto Gigante + Animar Objetos (multi-token com orçamento mod × 1/2/3). Escala em `phb_creature_scale_by_slot`; despawn no fim/troca de concentração. `spectral-summon` / `fey-reinforcements` syncam via table-action reusando mapas Summon. Ver [creature-template-scale-control.md](/creature-template-scale-control.md).
