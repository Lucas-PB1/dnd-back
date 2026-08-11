# Exemplares (API) — classes concluídas (critério mesa)

Padrão alvo: **table-action**. Checklist em [`SKILL.md`](../SKILL.md).

**Concluídas** (economia + painel + handler + recursos quando gasta; front alinhado):

| Classe | Slug | Status mesa |
|--------|------|-------------|
| Guerreiro | `fighter` | **Concluída** |
| Feiticeiro | `sorcerer` | **Concluída** |
| Bruxo | `warlock` | **Concluída** |
| Mago | `wizard` | **Concluída** |
| Patrulheiro | `ranger` | **Concluída** |
| Ladino | `rogue` | **Concluída** |
| Paladino | `paladin` | **Concluída** |
| Pistoleiro | `gunslinger` | **Concluída** |
| Monge | `monk` | **Concluída** |
| Clérigo | `cleric` | **Concluída** |
| Bardo | `bard` | **Concluída** |
| Bárbaro | `barbarian` | **Concluída** |
| Druida | `druid` | **Concluída** |

Polish **adiado** (não reabre “classe done”): ver [`docs/plans/backlog.md`](../../../docs/plans/backlog.md) — MM modal, Companheiro Primal tracker, reuso de invocações / entidades / duração.

Invocações / criaturas / efeitos de duração (nas concluídas) — só nota ou uso hoje; tracker = plano futuro:

| Classe · subclasse | Feature | Mesa hoje |
|--------------------|---------|-----------|
| Mago · Ilusionista | Criaturas Espectrais | `spectral-summon` uso + nota |
| Druida | Forma Selvagem (besta) | ± `wildShape` na Economia; seletor/ficha de besta = futuro |
| Druida | Companheiro Selvagem | nota; tracker = futuro |
| Druida · Terra | Magia do Círculo sem espaço | lembrete C009; Usar dedicado adiado |
| Patrulheiro · Andarilho Feérico | Reforços Feéricos | `fey-reinforcements` uso + nota |
| Patrulheiro · Senhor das Feras | Companheiro Primal | nota; tracker em [`beast-master-primal-companion.md`](../../../docs/plans/beast-master-primal-companion.md) |
| Feiticeiro · Dracônico L18 | Companheiro Dracônico | magia / nota PHB; sem linha C009 dedicada |
| Bruxo · GOO L14 | Criar Servo | modifica Invocar Aberração no cast; sem pool próprio |
| Guerreiro | — | nada equivalente |
| Monge | Defletir / Queda Lenta | só lembrete C009 (sem Usar) |
| Ladino · Adaga Espiritual | Lâminas Psíquicas | ataques virtuais na ficha (`psychic-blade` / `-bonus`) com Furtivo/Astuto |
| Ladino · Trapaceiro Arcano | Mãos Mágicas Ligeiras | nota / conjuração (alcance à distância — **não** companion) |
| Ladino · Adaga Espiritual | Véu Psíquico | uso pré-estabelecido `psychic-veil` + nota; sem tracker de Invisível |
| Ladino · Adaga Espiritual | Sussurros / Rasgar Mente | listagem Economia/painel (gasto de uso); duração/condição = mesa |
| Ladino · Perseguidor Aracnídeo | Correia / Teia | `arachnoid-web` uso + nota; posição / condição Teia |
| Ladino · Assassino | Veneno / Golpe Mortal | toggles no ataque + nota; condições |
| Ladino (base) | Esquiva Sobrenatural / Elusivo | lembrete C009 / nota; defesa situacional |
| Paladino · Devoção L15 | Destruição Protetora | lembrete C009; Usar/handler adiado |
| Paladino · Glória L15 | Defesa Gloriosa | C009 ± `glorious-defense` + Usar `glorious-defense` |
| Paladino · Glória L3 | Atleta Inigualável (2º canal) | C009 + `peerless-athlete` |
| Pistoleiro | Manobras outras subs | C001 + C009 lembretes done; polish Assumidor / condições / Bang cast / câmaras |

---

## Feiticeiro (`sorcerer`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/sorcerer/` (`features`, `metamagic`) |
| Handler | `session/application/actions/sorcerer-actions.handler.ts` + `actions/sorcerer/` |
| HTTP | `POST …/sorcerer/table-action` |
| Economy/panel | `C009` + `C010` |

Extras: Fonte de Magia e metamagia no painel; subclasses wild-magic / clockwork / draconic / heroic-sorcery / aberrant.

## Bruxo (`warlock`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/warlock/` |
| Handler | `warlock-actions.handler.ts` + `actions/warlock/` |
| HTTP | `POST …/warlock/table-action` |
| Economy/panel | `C009` + `C010` |

Extras: invocações (free_cast no painel + aba Magias) + pact blade (UI/front).

## Mago (`wizard`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/wizard/` |
| Handler | `wizard-actions.handler.ts` + `actions/wizard/` |
| HTTP | `POST …/wizard/table-action` |
| Economy/panel | `C009` + `C010` |
| Recursos | `C014_wizard_subclass_resources.sql` |

Polish adiado: modal Escudo/Giga no cast — [`mm-cast-options-modal.md`](../../../docs/plans/mm-cast-options-modal.md).

## Guerreiro (`fighter`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/fighter/` |
| Handler | `fighter-actions.handler.ts` + `actions/fighter/` |
| HTTP | `POST …/fighter/table-action` (+ `GET …/fighter/maneuvers` para lista BM) |
| Economy | `C009` (`second-wind`, `action-surge`, `tactical-mind`, `psi:*`, BM `superiority-dice`, pool `dungeon-precautions`) |
| Panel | `C010` (base + psi); BM/Dungeoneer = UI com seletor |

Manobras BM: `actionSlug: use-maneuver` + `maneuverSlug`. Precaução: `dungeon-precaution` + `spellSlug`. Pool Dungeoneer: só **C009** (±); sem espelho no painel.

## Patrulheiro (`ranger`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/ranger/` |
| Handler | `ranger-actions.handler.ts` + `actions/ranger/` |
| HTTP | `POST …/ranger/table-action` |
| Economy/panel | `C009` + `C010` |

Pools base (Marca / Incansável / Véu): só **C009 Economia** com `resource_slug` (UI: ± sempre; Usar se `table_action`) — painel não lista `remaining/max`. Subclasses no C010: fey / beast-master / hunter-defense / gloom-dodge; beastborne = UI Aspecto + `feral-howl` + Carnificina no dano (`bestialAspectLevel`).

Polish adiado: tracker Companheiro Primal — [`beast-master-primal-companion.md`](../../../docs/plans/beast-master-primal-companion.md).

## Ladino (`rogue`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/rogue/` |
| Handler | `rogue-actions.handler.ts` + `actions/rogue/` |
| HTTP | `POST …/rogue/table-action` |
| Economy/panel | `C009` + `C010` |
| Catálogo legado Soulknife | `C004` (slugs alinhados ao handler: `guided-strike`, `psychic-teleport`) |

Pools/usos: `soulknife-psi-dice` + free uses Soulknife; `spell-thief`; `arachnoid-web`; `strokeOfLuck` (± na Economia, gasto nas rolls). Painel = poderes de subclasse (sem lâminas). **Lâminas Psíquicas** = ataques virtuais na ficha (`psychic-blade`) com Furtivo/Golpe Astuto no card. Sussurros/Rasgar/Véu = listagem + gasto de uso (sem tracker de duração).

Polish adiado: Teia/posição, condições persistentes — ver tabela no topo + backlog Adiado.

## Paladino (`paladin`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/paladin/` |
| Handler | `paladin-actions.handler.ts` + `actions/paladin/` |
| HTTP | `POST …/paladin/table-action` |
| Economy/panel | `C009` + `C010` |

Pools: `layOnHands` + `channelDivinity` (C009 ±; Sentido Divino com `table_action`). Economia por juramento: canais nomeados (`oath-channel` / `peerless-athlete`) + pools L15/L20 (`holy-nimbus`, `glorious-defense`, `undying-sentinel`, …; Folia `reveler` / `party-animal`). Painel: cura com amount + Curar Veneno; canais C010 com `resource_slug`. Destruição Divina no card de ataque.

Polish adiado: Destruição Protetora (lembrete de Cobertura na aura). Defesa Gloriosa: Usar ligado.

## Pistoleiro (`gunslinger`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/gunslinger/` |
| Handler | `gunslinger-actions.handler.ts` (+ ops marciais existentes) |
| HTTP | `POST …/gunslinger/table-action` (`use-maneuver`, `recover-risk`); `GET …/maneuvers` lista |
| Economy/panel | `C009` (`risk` ±, Tempo Bala, Tiro na Cabeça + lembretes por sub Valdas) + `C010` (`recover-risk`) |

Pool: `risk` (Dados de Risco). Painel: seletor de manobras (C001 base + **todas** as subs Valdas / Pistolero) via table-action; Gambito Terrível recupera 1 risk. Firearms reload/fire legado permanece. Tiro na Cabeça: toggle no card (gasta 3× risk).

Polish adiado: Assumidor de risco (d6 grátis); condições White Hat; Bang cast dedicado; polish câmaras.

## Monge (`monk`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/monk/` |
| Handler | `monk-actions.handler.ts` + `actions/monk/` |
| HTTP | `POST …/monk/table-action` |
| Economy/panel | `C009` + `C010` |

Pool: `focusPoints` (± na Economia). Base: Torrente / Defesa Paciente / Passos do Vento / Golpe Atordoante. Subs PHB: open-hand (Técnica, Integridade, Palma Vibrante), elements (Sintonia, Explosão nv.6/2 Foco), mercy (Cura/Dolo, Torrente Cura-Dolo, Misericórdia Final), shadow (Artes Escuridão, Passo 18 m, Aprimorado, Manto). Valdas `warrior-of-the-street`: Combinação / Movimentos / Traço / K.O. (+ recuperar 5 Foco). Defletir/Queda Lenta = lembrete. Passo Veloz / Punho de Ferro / Ápice = notes.

Polish adiado: tracker de duração Sintonia/Manto; aplicar PV na ficha em curas; Passo Veloz automático.

## Clérigo (`cleric`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/cleric/` |
| Handler | `cleric-actions.handler.ts` + `actions/cleric/` |
| HTTP | `POST …/cleric/table-action` |
| Economy/panel | `C009` + `C010` |

Pool: `channelDivinity` (± via `cleric-channel`; Usar nas linhas nomeadas). Base: Centelha (cura/dano), Expulsar Mortos-Vivos, Intervenção Divina. PHB: Vida (`preserve-life`), Luz (`radiance-of-dawn` / `warding-flare` / `crown-of-light`), Trapaça (`tricksters-blessing` + `invoke-duplicity`), Guerra (`guided-strike` / `war-priest` / `war-gods-blessing`). Valdas `dragon-domain`: Afinidade (`chromatic-affinity`), Majestade (`dragon-majesty`), Serpe L6 (`serpent-blessing`), Aspecto L17 (pool ± + Rasgar/Cauda/Asas).

Polish adiado: recuperar 1 uso de Aspecto com espaço 2+; persistir tipo de Afinidade no estado; Transposição do Trapaceiro Usar dedicado.

## Bardo (`bard`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/bard/` |
| Handler | `bard-actions.handler.ts` + `actions/bard/` |
| HTTP | `POST …/bard/table-action` |
| Economy/panel | `C009` + `C010` |

Pool: `bardicInspiration` (± via `bard-inspiration`; Usar nas linhas nomeadas). Base: Conceder Inspiração, Inspiração Superior L18. PHB: lore (`cutting-words`, `peerless-skill` L14), glamour (`mantle-of-inspiration` + PV temp, `mantle-of-majesty` 1/DL, `unbreakable-majesty` L14), dance (`unarmed-dance` DES, `coordinated-movement`, `agile-response`), valor (`combat-inspiration`; Magia de Batalha = nota). Valdas `college-of-masks`: Vestir máscaras + Usar por máscara (`persona-*` gastam Inspiração) + `virtuoso-skill` (handler, não `spend-resource`).

Polish adiado: restaurar Manto de Majestade com espaço 3+; devolver Inspiração em Perícia Inigualável se ainda falhar (mesa ±).

## Bárbaro (`barbarian`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/barbarian/` |
| Handler | `barbarian-actions.handler.ts` + `actions/barbarian/` |
| HTTP | `POST …/barbarian/table-action` |
| Economy/panel | `C009` + `C010` |

Pool: `rage` (± via `barbarian-rage`; Usar `toggle-rage`). Base: Imprudente, Fúria Persistente L15. PHB: berserker (`frenzy`, `retaliation`, `intimidating-presence` + restaurar), wild-heart (`wild-heart-eagle` + notas), world-tree (PV temp. no enter + `revitalizing-strength` / `branches-of-the-tree` / `traverse-the-tree`), zealot (`champion-of-the-gods`, `fanatical-focus`, `zealous-presence`, `rage-of-the-gods`; Fúria Divina no card de ataque). Valdas `path-of-the-muscle-wizard`: Fúria gratuita + 3 “Truques” + “Magias”/punho.

Polish adiado: persistir escolha Águia/Lobo/Urso no estado; pools 1×/DL das “Magias” do Mago Musculoso; Reação Revivificação da Fúria dos Deuses.

## Druida (`druid`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/druid/` |
| Handler | `druid-actions.handler.ts` + `actions/druid/` |
| HTTP | `POST …/druid/table-action` |
| Economy/panel | `C009` + `C010` |

Pool: `wildShape` (± na Economia; **sem** Usar de forma de besta). Base: Ressurgimento (Forma↔Slot). Subs PHB: moon (`moon-combat-wild-shape` + PV temp., `lunar-step` / `restore-lunar-step`), land (`land-aid`, `natural-recovery-1..5`, `nature-sanctuary`), stars (Arquiro/Cálice/Dragão + `stellar-guidance` / `cosmic-omen`), sea (`wrath-of-the-sea` / `ocean-manifestation`). Valdas `circle-of-the-city`: `city-shape` / `wall-warp`. Handler `wild-shape` permanece na API para polish futuro.

Polish adiado: seletor/ficha de besta; tracker Companheiro Selvagem; magia do Círculo Terra sem espaço (lembrete C009).

