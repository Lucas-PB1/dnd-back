# Northlands — Character Threads (extração)

Fonte original: scrape Beyond `#CharacterThreads` (Northlands Worldbook: Heroes of the Sagas).  
Edição: `northlands-heroes-2024-en`. HTML de scrape **não** é mantido no repo — este doc é a SSOT da extração.

## Status de implementação

| Fatia | Status |
|-------|--------|
| Catálogo (`phb_character_thread*`, `N036`, `GET /character-threads`) | **feito** |
| Estado na ficha (`player_character_thread*`, mutações `/characters/:id/thread`, bundle) | **feito** |
| UI Traços + step opcional no create wizard | **feito** |
| Runtime mesa (Cursemarked brackets, Fatebound morte, economy 1/LR) | **fase 2** — pedido explícito |

Modelo: 1 thread `active` por personagem; completar mantém benefícios; abandonar limpa milestones.

---

## Propósito

Threads são posições, ocupações ou situações que o personagem **persegue enquanto aventureiro** (diferente de background = passado). Cada thread tem:

1. Um **goal** específico e alcançável (jogador + GM)
2. **Milestones** (recomendado: 4) no caminho até o goal
3. Um **benefício** por milestone (rank Least → Superior)

Regras gerais:

- **Só 1 thread por vez**
- Ao **completar** o goal: pode trocar de thread; **mantém** benefícios já ganhos
- Ao **abandonar** antes do goal: **perde** todos os benefícios daquele thread
- Spacing de milestones e duração do arco são acordados com o GM (podem ser curtos ou 1–20)

### Tiers de milestone

| Rank | Níveis tipicos | Tipos de benefício (guia) |
|------|----------------|---------------------------|
| Least | 1–4 | Proficiência (tool/skill/idioma); contato; item comum; charm menor 1× |
| Lesser | 5–10 | Expertise; favor/casa; item incomum; magia ≤2º 1/LR |
| Greater | 11–16 | Feat; título/castelo; item raro; magia ≤5º 1/LR |
| Superior | 17–20 | Mark of Prestige / gift; posição real; item muito raro; magia ≤8º 1/LR |

Em geral **um** benefício por milestone (GM pode dar mais).

---

## Threads (7)

Nomes EN canônicos. Goals = tabela d6 resumida; milestones = benefício curto (escolha quando a fonte oferece).

### Bloodsworn

Juramento de vingança quando justiça “normal” não basta. Goal = punir quem fez o mal (às vezes sem morte).

**Goals (d6):** matar quem assassinou o amado; matar usurpador do jarl; punir charlatães que arruinaram o negócio familiar; derrubar jarl que destruiu a comunidade; vingar shieldmate traidor; vingar vergonha por acusação falsa.

| Milestone | Benefício |
|-----------|-----------|
| Least | **Cunning** (prof. Deception/Insight/Intimidation) **ou** **Tool of Vengeance** (item mágico Common) |
| Lesser | **Enemy of My Enemy** (aliado + esconderijo) **ou** **Wrath** (`Wrathful Smite` 1/LR; INT/WIS/CHA) |
| Greater | **Tenacity** — fim de Frightened/Incapacitated/Paralyzed/Stunned no início do turno (1/LR) |
| Superior | **Dire Oath** — após LR, nomeia criatura: Adv em ataques e checks para achar/aprender sobre ela por 24h (recarga 7 dias) |

### Cursemarked

Azar pessoal que, ao disparar, pode ajudar aliados. Busca de expiação.

**Goals (d6):** devolver relíquia sagrada a túmulo distante; limpar nome de ancestral; derrotar gigantes marauders; forjar paz entre clãs (Freyr); passar provas de honra/valor/altruísmo; convencer Wotan a interceder junto às Norns.

**Regras especiais:** features disparam quando o d20 (save / check / attack, conforme o bracket) cai **dentro do intervalo** indicado. Features **não sobrepõem** — após trigger, não dispara outra até o início do próximo turno depois que a duração acaba. Cada tier **substitui** os benefícios anteriores do thread (exceto Least, que é o primeiro).

| Milestone | Benefício |
|-----------|-----------|
| Least | **Tides of Fate [1–3, Saves]** — −10 ft Speed; aliado +10 ft Speed. **Greater Sacrifice** opcional (Speed 0 → aliado sem OA + ignora terreno difícil; 1/LR) |
| Lesser | **Burden’s Shield [1–5, Saves/Checks]** — −2 AC; aliado +2 AC. Substitui Least. Greater Sacrifice opcional (−4/+4 ou benefício Tide) |
| Greater | **Threads Entwined [1–7, Saves/Checks/Attacks]** — sem Bonus/Reactions; aliado Reaction Dash/Help/Hide/ataque. Substitui anteriores. Greater Sacrifice opcional (só move / forgo action → aliado action extra, sem Magic) |
| Superior | **Two-Edged Gift [1–9, Saves/Checks/Attacks]** — dano metade; aliado próximo hit máximo. Substitui anteriores. Greater Sacrifice → sem dano próprio; próximo ataque do aliado = crítico automático |

### Explorer

Andarilho / descobridor. **Overlap:** pode pisar nos pés de **Rangers** — consultar o grupo.

**Goals (d6):** rota inédita pelas Bloodfjord Mountains; levar profecia para evitar Ragnarok; completar busca da mãe (Tearstain River); sapling da World Tree; delver Narvegr Maw; Frozen Palace / coroa hyperbórea.

| Milestone | Benefício |
|-----------|-----------|
| Least | **Celebrity Explorer** (30% desconto / grátis frequente) **ou** **Explorer’s Aptitude** (prof. Athletics/History/Perception) |
| Lesser | **Traversal Expert** (Bonus Dash + ignora Difficult Terrain + Adv Athletics climb/jump/swim; 1/SR ou LR) **ou** **Scout’s Awareness** (1h Adv saves vs traps/hazards não mágicos para você + aliados 30 ft; 1/LR) |
| Greater | **Ennobled** (título + estate; Adv Cha impressionáveis) **ou** **Wayfarer’s Steps** (não se perde; Bonus Dash + até 4 aliados Dash sem OA; 1/LR) |
| Superior | **Far Traveler** (Fast Pace sem penaldade; Adv camping/foraging; Adv Animal Handling) **e** **One With the Land** (~`Commune with Nature` em 1 min; 24h) |

### Fatebound

Sabe *como* (ou em que circunstância) vai morrer — não se vence ou perde. **Deve ser escolha consciente do jogador.**

**Fatebound e morte:** pode não poder morrer “antes da hora”, mas chega ao fim em qualquer estado. Se morrer cedo sem ressurreição: GM pode ferimento permanente, perda de item poderoso, Exhaustion até próximo milestone, etc. (acordo jogador/GM).

**Goals (d6):** morrer só após o dragão mais poderoso; morto por Utgard-Loki; pagar com a vida defendendo o povo; achar tesouro e morrer nisso; maior reaver, perecer vs World Serpent; verdade sobre Nordheim custando a vida.

| Milestone | Benefício |
|-----------|-----------|
| Least | **Dream Gift** (item Common do GM) **ou** **Fate’s Blessing** (1/dia Bloodied: Reaction Adv em save) |
| Lesser | **Strength of Wyrd** (Bloodied: +PB dano, PB usos/LR) **ou** **Enduring Wyrd** (Reaction temp HP = PB; 1/SR ou LR) |
| Greater | **Doom Delayed** (em vez de morrer → Stable 0 HP; 1/LR) **e** **Knight of Fate** (título/holdings até a morte; Adv Cha na terra) |
| Superior | **Last Act of Fate** (no momento predeterminado: 1 HP, limpa condições, 1 turno imunidade + Adv + dano +nível, depois morte permanente) **e** **Glorious End** (aliados testemunhas: Adv em d20 por 24h) |

### Herald

Contador de histórias que molda política/guerra. **Overlap:** pode pisar nos pés de **Bards** — consultar o grupo.

**Goals (d6):** avisar invasão de Jotunheim; reunir apoio para o maior raid; lisonjear Thor/Wotan vs Chernobog/Angrboda; cruzada sob Tanserhall; achar caminho a vault hyperbórea via contos; levantar povo contra rei corrupto.

| Milestone | Benefício |
|-----------|-----------|
| Least | **Storyteller’s Knack** (3 idiomas) **e** **Performer’s Reward** (≥3 dias downtime → GP = 10× nível) |
| Lesser | **Enthralling Speaker** (prof/expertise Performance; Charm Person ou Suggestion 1/LR na performance; Cha) |
| Greater | **Persuasive Words** (Cha check: d20 ≤9 → 10; Cha mod usos/LR) |
| Superior | **Heroic Saga** (após 10+ min: Luck Boon ×3 ou Wyrd Boon ×1; 7 dias) **ou** **Song of Matrimony** (noivado real) |

### Legend Hunter

Caça glória / lendas, não só sobrevivência.

**Goals (d6):** monstro lendário destruindo vilas; jotun de duas cabeças; dragão no covil; mãe de todos os krakens; cabeça de Fenris; Nidhogg sob Yggdrasil.

| Milestone | Benefício |
|-----------|-----------|
| Least | **Predator’s Mark** — Adv Survival para rastrear; falha = metade do tempo para reencontrar trilha |
| Lesser | **Unclouded Sight** (ignora obscurecimento de clima, incl. Fog Cloud/Sleet Storm, não Darkness) **ou** **Reliable Senses** (reroll Investigation/Perception/Survival; 1/LR) |
| Greater | **Finish the Fight** — após Bloodied, próximo hit = crítico (1/LR) |
| Superior | **Legend Breaker** (hit em criatura com LR/LA → forgo damage, Con save, sem Legendary Resistance/Actions) **e/ou** **The Ultimate Favor** (cura 6º–9º de um NPC curandeiro, 1×) |

### Sworn Huskarl

Servo jurado de jarl/rei/rainha para missão específica (não necessariamente vitalícia).

**Goals (d6):** achar herdeiro perdido; matar pretendente; destruir seita do Cult of Ragnarok; destruir raids de gigantes; achar coroa roubada (liberdade); servir até poder derrubar rei feiticeiro.

| Milestone | Benefício |
|-----------|-----------|
| Least | **Jarl’s Authority** — Intimidation/Persuasion vs quem respeita/teme o senhor: tratar d20 como 15 (1/LR) |
| Lesser | **Extreme Loyalty** (fim de Charmed pagando Psychic = nível; 1/LR) **ou** **Jarl’s Gift** (item Uncommon da lista / acordo GM) |
| Greater | **Undying Loyalty** — a 0 HP → HP = nível (não vs morte instantânea sem dano; 7 dias) |
| Superior | **Grand Reward** — item Very Rare (ex.: +3 Weapon, Dancing Sword, Oathbow, Staff of Thunder and Lightning, Horn of the Hrimthursar) |

---

## Referências no repo

- Backlog: fase 2 mesa em [`backlog.md`](backlog.md)
- Seeds: `database/seeds/northlands-heroes/N036_phb_character_threads.sql`
- Migrations: `T085_character_threads.sql`, `V063_character_thread_bundle.sql`, `P039_player_character_thread.sql`
- Cap. 5 (Magic and Miscellany) permanece fora deste doc
