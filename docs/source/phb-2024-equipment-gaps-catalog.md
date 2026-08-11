# PHB Equipment — gaps vs catálogo (S031)

Compilado a partir do Cap. 6 Equipment (Beyond) — scrape local removido do repo; audit histórico.
Objetivo: comparar Cap. 6 Beyond vs `S031` (slugs PT). Variantes/montarias/serviços foram seedados — este doc serve de auditoria.

## Resumo

| Bloco | Entradas Beyond | Já no S031 (slug PT) | Faltando |
|--------|-----------------|----------------------|----------|
| Montarias / animais | 8 | 8 | **0** |
| Arnês / veículos terrestres | 10 | 10 | **0** |
| Veículos grandes (ar/água) | 7 | 7 | **0** |
| Variantes (foco / munição / jogos / instrumentos) | 30 | 30 | **0** |
| Lifestyle / comida / viagem / hirelings / magia | tabelas de serviço | seedados como `other` (`kind:service`) | ver S031 |
| Barding | regra (armadura ×4 custo, ×2 peso) | 12 (`barding-*` em S031) | **0** |

## Já cobrimos (não repetir)

- Armas, armaduras, ferramentas, gear de aventura, poção de cura, pergaminhos truque/1º — ver `S031` + audit `phb-2024-equipment-prices-audit.md`.
- Itens mágicos DMG A–Z — `D010` (preço por raridade).
- Venda de equipamento = ½ custo (já no fluxo de inventário em campanha).

## 1. Montarias e outros animais


| Nome EN | Slug sugerido | Capacidade | Custo EN | Custo PT | No S031? |
| --- | --- | --- | --- | --- | --- |
| Camel | `camelo` | 450 lb. | 50 GP | 50 PO | sim |
| Elephant | `elefante` | 1,320 lb. | 200 GP | 200 PO | sim |
| Horse, Draft | `cavalo-de-carga` | 540 lb. | 50 GP | 50 PO | sim |
| Horse, Riding | `cavalo-de-montaria` | 480 lb. | 75 GP | 75 PO | sim |
| Mastiff | `mastim` | 195 lb. | 25 GP | 25 PO | sim |
| Mule | `mula` | 420 lb. | 8 GP | 8 PO | sim |
| Pony | `ponei` | 225 lb. | 30 GP | 30 PO | sim |
| Warhorse | `cavalo-de-guerra` | 540 lb. | 400 GP | 400 PO | sim |

**Nota de modelo:** montaria não é “gear” puro — precisa de capacidade de carga e (idealmente) vínculo com bloco de monstro do Apêndice B. Para loja MVP: `item_type: other` + `properties.kind: mount` + `carryingCapacityLb`.

## 2. Arnês, selas e veículos puxados


| Nome EN | Slug sugerido | Peso | Custo EN | Custo PT | No S031? |
| --- | --- | --- | --- | --- | --- |
| Carriage | `carruagem` | 600 lb. | 100 GP | 100 PO | sim |
| Cart | `carroca` | 200 lb. | 15 GP | 15 PO | sim |
| Chariot | `carro-de-guerra` | 100 lb. | 250 GP | 250 PO | sim |
| Feed per day | `racao-animal-por-dia` | 10 lb. | 5 CP | 5 PC | sim |
| Exotic Saddle | `sela-exotica` | 40 lb. | 60 GP | 60 PO | sim |
| Military Saddle | `sela-militar` | 30 lb. | 20 GP | 20 PO | sim |
| Riding Saddle | `sela-de-montaria` | 25 lb. | 10 GP | 10 PO | sim |
| Sled | `treno` | 300 lb. | 20 GP | 20 PO | sim |
| Stabling per day | `estabulo-por-dia` | — | 5 SP | 5 PP | sim |
| Wagon | `vagao` | 400 lb. | 35 GP | 35 PO | sim |

> Barding: Armadura de montaria = 4× custo e 2× peso da armadura correspondente.

**Barding:** seedado em `S031` como `barding-{armorSlug}` (`kind:barding`, custo ×4, peso ×2). Domínio: `src/game/inventory/domain/barding.ts`.

## 3. Veículos grandes (ar / água)

| Nome EN | Slug | Speed | Crew | Passengers | Cargo (tons) | AC | HP | DT | Custo PT | No S031? |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Airship | `aeronave` | 8 mph | 10 | 20 | 1 | 13 | 300 | — | 40.000 PO | sim |
| Galley | `galera` | 4 mph | 80 | — | 150 | 15 | 500 | 20 | 30.000 PO | sim |
| Keelboat | `barco-de-quilla` | 1 mph | 1 | 6 | 1/2 | 15 | 100 | 10 | 3.000 PO | sim |
| Longship | `navio-longo` | 3 mph | 40 | 150 | 10 | 15 | 300 | 15 | 10.000 PO | sim |
| Rowboat | `bote` | 1½ mph | 1 | 3 | — | 11 | 50 | — | 50 PO | sim |
| Sailing Ship | `navio-a-vela` | 2 mph | 20 | 20 | 100 | 15 | 300 | 15 | 10.000 PO | sim |
| Warship | `navio-de-guerra` | 2½ mph | 60 | 60 | 200 | 15 | 500 | 20 | 25.000 PO | sim |



**Nota:** navios exigem hirelings skilled (ver Serviços). Stats extras → `properties` JSON.

## 4. Serviços (não são itens de inventário)

Estes blocos **não** entram bem em `phb_item` como gear. Sugestão: tabela `rpg.phb_service` ou catálogo `kind: service` + UI de loja “Serviços” (debitar sem criar item, ou criar voucher consumível).

### 4.1 Lifestyle Expenses

| Estilo | Preço EN | Preço PT |
| --- | --- | --- |
| Wretched | Free | Grátis |
| Squalid | 1 SP per Day | 1 PP / dia |
| Poor | 2 SP per Day | 2 PP / dia |
| Modest | 1 GP per Day | 1 PO / dia |
| Comfortable | 2 GP per Day | 2 PO / dia |
| Wealthy | 4 GP per Day | 4 PO / dia |
| Aristocratic | 10 GP per Day | 10 PO / dia |

### 4.2 Food, Drink, and Lodging

| Item | Custo EN | Custo PT |
| --- | --- | --- |
| Ale (mug) | 4 CP | 4 PC |
| Bread (loaf) | 2 CP | 2 PC |
| Cheese (wedge) | 1 SP | 1 PP |
| Inn Stay per Day — Squalid | 7 CP | 7 PC |
| Inn Stay per Day — Poor | 1 SP | 1 PP |
| Inn Stay per Day — Modest | 5 SP | 5 PP |
| Inn Stay per Day — Comfortable | 8 SP | 8 PP |
| Inn Stay per Day — Wealthy | 2 GP | 2 PO |
| Inn Stay per Day — Aristocratic | 4 GP | 4 PO |
| Meal — Squalid | 1 CP | 1 PC |
| Meal — Poor | 2 CP | 2 PC |
| Meal — Modest | 1 SP | 1 PP |
| Meal — Comfortable | 2 SP | 2 PP |
| Meal — Wealthy | 3 SP | 3 PP |
| Meal — Aristocratic | 6 SP | 6 PP |
| Wine (bottle) — Common | 2 SP | 2 PP |
| Wine (bottle) — Fine | 10 GP | 10 PO |

### 4.3 Travel

| Serviço | Custo EN | Custo PT |
| --- | --- | --- |
| Coach ride between towns | 3 CP per mile | 3 PC / milha |
| Coach ride within a city | 1 CP per mile | 1 PC / milha |
| Road or gate toll | 1 CP | 1 PC |
| Ship’s passage | 1 SP per mile | 1 PP / milha |

### 4.4 Hirelings

| Tipo | Custo EN | Custo PT |
| --- | --- | --- |
| Skilled hireling | 2 GP per day | 2 PO / dia |
| Untrained hireling | 2 SP per day | 2 PP / dia |
| Messenger | 2 CP per mile | 2 PC / milha |

### 4.5 Spellcasting Services

| Círculo | Disponibilidade | Custo EN | Custo PT |
| --- | --- | --- | --- |
| Cantrip | Village, town, or city | 30 GP | 30 PO |
| 1 | Village, town, or city | 50 GP | 50 PO |
| 2 | Village, town, or city | 200 GP | 200 PO |
| 3 | Town or city only | 300 GP | 300 PO |
| 4–5 | Town or city only | 2,000 GP | 2.000 PO |
| 6–8 | City only | 20,000 GP | 20.000 PO |
| 9 | City only | 100,000 GP | 100.000 PO |

## 5. Transcrição de pergaminhos (crafting, não loja)

Custo de **criar** (scribe). Valor de venda do Spell Scroll genérico = **2×** (já no PHB Equipment / aside Magic Item values).

| Nível | Tempo | Scribe EN | Scribe PT | Venda sugerida |
| --- | --- | --- | --- | --- |
| Cantrip | 1 day | 15 GP | 15 PO | 30 PO (2× scribe) |
| 1 | 1 day | 25 GP | 25 PO | 50 PO (2× scribe) |
| 2 | 3 days | 100 GP | 100 PO | 200 PO (2× scribe) |
| 3 | 5 days | 150 GP | 150 PO | 300 PO (2× scribe) |
| 4 | 10 days | 1,000 GP | 1.000 PO | 2.000 PO (2× scribe) |
| 5 | 25 days | 1,500 GP | 1.500 PO | 3.000 PO (2× scribe) |
| 6 | 40 days | 10,000 GP | 10.000 PO | 20.000 PO (2× scribe) |
| 7 | 50 days | 12,500 GP | 12.500 PO | 25.000 PO (2× scribe) |
| 8 | 60 days | 15,000 GP | 15.000 PO | 30.000 PO (2× scribe) |
| 9 | 120 days | 50,000 GP | 50.000 PO | 100.000 PO (2× scribe) |

Hoje no S031 só existem `pergaminho-magico-truque` (30 PO) e `pergaminho-magico-1-circulo` (50 PO). **Faltam** níveis 2–9 como SKUs de loja.

## 6. Variantes “Varia” — linhas concretas do Beyond

No S031 os pais (`foco-arcano`, `foco-druidico`, `simbolo-sagrado`, `municao`, `instrumento-musical`, `kit-de-jogos`) têm cost `Varia`. Abaixo, as **linhas filhas** com preço pronto para seed.

### 6.1 Ammunition

| Nome EN | Slug | Qtd | Storage | Peso | Custo PT | No S031? |
| --- | --- | --- | --- | --- | --- | --- |
| Arrows | `flechas` | 20 | Quiver | 1 lb. | 1 PO | sim |
| Bolts | `virotes` | 20 | Case | 1½ lb. | 1 PO | sim |
| Bullets, Firearm | `balas-arma-de-fogo` | 10 | Pouch | 2 lb. | 3 PO | sim |
| Bullets, Sling | `balas-de-funda` | 20 | Pouch | 1½ lb. | 4 PC | sim |
| Needles | `agulhas` | 50 | Pouch | 1 lb. | 1 PO | sim |

### 6.2 Arcane Focuses

| Nome EN | Slug | Peso | Custo PT | No S031? |
| --- | --- | --- | --- | --- |
| Crystal | `cristal` | 1 lb. | 10 PO | sim |
| Orb | `orbe` | 3 lb. | 20 PO | sim |
| Rod | `bastao` | 2 lb. | 10 PO | sim |
| Staff (also a Quarterstaff) | `cajado-arcano` | 4 lb. | 5 PO | sim |
| Wand | `varinha` | 1 lb. | 10 PO | sim |

### 6.3 Druidic Focuses

| Nome EN | Slug | Peso | Custo PT | No S031? |
| --- | --- | --- | --- | --- |
| Sprig of mistletoe | `ramo-de-visco` | — | 1 PO | sim |
| Wooden staff (also a Quarterstaff) | `cajado-de-madeira` | 4 lb. | 5 PO | sim |
| Yew wand | `varinha-de-teixo` | 1 lb. | 10 PO | sim |

### 6.4 Holy Symbols

| Nome EN | Slug | Peso | Custo PT | No S031? |
| --- | --- | --- | --- | --- |
| Amulet (worn or held) | `amuleto` | 1 lb. | 5 PO | sim |
| Emblem (borne on fabric or a Shield) | `emblema` | — | 5 PO | sim |
| Reliquary (held) | `relicario` | 2 lb. | 5 PO | sim |

### 6.5 Gaming Set (variantes)

| Nome EN | Slug | Custo PT | No S031? |
| --- | --- | --- | --- |
| Dice | `conjunto-de-dados` | 1 PP | sim |
| dragonchess | `xadrez-do-dragao` | 1 PO | sim |
| playing cards | `baralho` | 5 PP | sim |
| three-dragon ante | `ante-dos-tres-dragoes` | 1 PO | sim |

### 6.6 Musical Instrument (variantes)

| Nome EN | Slug | Peso | Custo PT | No S031? |
| --- | --- | --- | --- | --- |
| Bagpipes | `gaita-de-foles` | 6 lb. | 30 PO | sim |
| drum | `tambor` | 3 lb. | 6 PO | sim |
| dulcimer | `salterio` | 10 lb. | 25 PO | sim |
| flute | `flauta` | 1 lb. | 2 PO | sim |
| horn | `trompa` | 2 lb. | 3 PO | sim |
| lute | `alaude` | 2 lb. | 35 PO | sim |
| lyre | `lira` | 2 lb. | 30 PO | sim |
| pan flute | `flauta-de-pan` | 2 lb. | 12 PO | sim |
| shawm | `charamela` | 1 lb. | 2 PO | sim |
| viol | `viola` | 1 lb. | 30 PO | sim |

## 7. Ordem sugerida para adicionar

1. **Variantes concretas** (foco / munição / jogos / instrumentos) — dados prontos, só seed.
2. **Montarias + tack/selas/carroças** (loja de equipamento estendida).
3. **Pergaminhos mágicos 2º–9º** (SKU por círculo; preço = 2× scribe).
4. **Serviços** (lifestyle, hospedagem, hirelings, cast) — UI separada, débito sem item.
5. **Veículos grandes + barding gerado** (mais pesado; stats extras).

---

Gerado por `scripts/compile-phb-equipment-gaps-from-beyond.mjs` · 2026-08-11