# Itens mágicos mesa (DMG) — modelo ideal

Documento de referência para levar cada item do Cap. 7 à **mesma profundidade** que classes na mesa (`C009`/`C010` + recursos) e itens Valdas já wired (`C013` + grants + `permanentEffects`).

**Não é um plano Cursor.** É o ideal + fases manuais. Implementar fase a fase, item a item (ou lote pequeno), sem “executar tudo”.

Fontes:

- Catálogo DMG: `database/seeds/dmg/D010_phb_item.sql` · índice `docs/source/dmg-2024-itens-magicos-az-index.md` · status lotes `docs/source/dmg-wiring-status.md`
- Regras Treasure × gaps: `docs/architecture/treasure-rules-vs-sistema.md`
- Economia de classe: `.cursor/skills/rpg-class-mesa-api/references/economia-painel.md`
- Economia de item (Valdas): `database/seeds/combat/C013_phb_item_economy_action.sql`
- Recursos de item: `database/seeds/valdas/V020_phb_item_resource_grant.sql`
- Passivos numéricos: `src/game/inventory/domain/permanent-item-effects.ts`
- Catálogo mecânico: `docs/architecture/catalog-patterns.md` §9

---

## 0. Ordem de ataque — tipos do mais fácil ao mais difícil

Contagens aproximadas no `D010` atual (~338). **Dentro de cada tipo**, preferir itens com 1 habilidade antes dos multi-poder / artefato.

| # | Tipo / padrão | ~N | Por que esta posição | Wiring típico |
|---|---------------|----|----------------------|---------------|
| 1 | **Poção / Óleo / Pergaminho** (consumo 1×) | ~30 | Uma ação, sem attune, sem pool contínuo | 1 economy `action`/`bonus` + resource max 1 **ou** lembrete “consumir”; item some na mesa |
| 2 | **Passivo numérico puro** (qualquer categoria) | subset | Só `permanentEffects`; zero botão | UPDATE `properties` — ex. Anel de Proteção (+1 CA / salvaguardas) |
| 3 | **Cobertura** (template sobre peça base) | subset | Taxonomia §3.1 + overlay inventário | Overlay feito (`P021` / attach-detach / sintonia / munição) |
| 4 | **1 uso / amanhecer** (maravilhoso simples) | subset | Igual estatueta Valdas | 1 resource max 1 + 1 `spend-resource` |
| 5 | **1 pool + 1 botão** (cargas fixas) | subset | Igual Anel dos Barris | 1 resource max N + 1 economy |
| 6 | **Anel / item com 2–3 habilidades, pool opcional** | ~22 anéis (mistos) | Várias rows, mesmo `item_id` | Padrão Trono |
| 7 | **Varinha** (cargas + lista de magias) | ~16 | Pool compartilhado + N botões cast-like | resource + N economy (`spend_amount` por magia) |
| 8 | **Cajado** (cargas, muitas magias, às vezes arma) | ~17 | Como varinha + possível `weapon` / passivo | resource + N economy + às vezes `permanentEffects` |
| 9 | **Maravilhoso multi-modo** (bolsas, mantos ativos, veículos…) | grande parte dos ~180 | Texto longo, estados, tabelas | N reminders + pools pontuais; handlers só se estado importar |
| 10 | **Gasto variável 1–N no mesmo poder** | poucos | UI/seed mais verboso | K botões `spend_amount` 1..K |
| 11 | **Artefato / baralho / itens com tabelas e maldições** | poucos | Muitas faces, efeitos permanentes na campanha | Lembrete + tracking manual no MVP; wiring fino por último |

**Fila sugerida (não executar de uma vez):**

1. Poções de cura / consumo óbvio  
2. Passivos +1 “peça única” (anel/capa simples)  
3. **Coberturas** (arma/armadura/escudo/munição +1/+2/+3, adamantina, prata, mitral…) — quando chegar nesses slugs  
4. “1× amanhecer”  
5. Um anel de cargas simples  
6. **Anel das Estrelas Cadentes** (valida multi-ação + pool)  
7. Lote de varinhas  
8. Lote de cajados  
9. Maravilhosos restantes por complexidade  
10. Artefatos  

Item Maravilhoso (~180) **não** é um bloco único: classificar cada um nas linhas 2–5 ou 9 da tabela acima.

---

## 1. Princípio

**1 item ≠ 1 botão.** Um item pode ter:

- passivos contínuos (CA, ataque, atributo…);
- várias habilidades ativas (buckets diferentes);
- um ou mais pools de carga/uso;
- efeitos só de mesa (lembrete, sem gasto automático).

SSOT:

| Camada | Onde vive |
|--------|-----------|
| Texto / raridade / attune | `rpg.phb_item` (`D010`) + `properties` |
| Passivo numérico | `properties.permanentEffects` |
| Pool (cargas / 1× amanhecer) | `phb_resource_definition` (scope `item`) + `phb_resource_grant` |
| Cada habilidade na aba Ações | `phb_class_economy_action` com **`item_id`** (XOR owner) |
| Ativo na ficha | equipado + (sem attune **ou** `attuned`) |

Fluxo (igual Valdas):

```
D010 (item)
  ├─ permanentEffects  → resolve no inventário / rolls
  ├─ resource def+grant → state.classResources (slug do item)
  └─ N rows economy    → GET /combat-mechanical-catalog
                              → aba Ações (filtro activeItemSlugs)
                              → Usar = spend-resource | lembrete
```

**Anti-padrões**

- Uma única row “usar item” que junta 4 poderes.
- Mecânica só no texto da descrição, sem economy/resource/passivo.
- `POST …/item/table-action` no MVP (classes têm table-action; itens Valdas usam `spend-resource` + lembrete).
- Overlay inventário (charm / coverage / artifact-regen): um `POST …/inventory/actions` com `actionSlug` — sem micro-rotas dedicadas.
- Hardcode de slugs de item no TypeScript — seed + catálogo.

---

## 2. Paridade com o que já temos

### Classes (mesa)

- Economy `C009`: `action_id`, bucket, `resource_slug`, `table_action`, `spend_amount`, texto jogável.
- Recursos de verdade (não contador decorativo).
- `table_action = spend-resource` **ou** slug de handler **ou** `NULL` (lembrete / ± ainda aparece se houver resource).

### Itens Valdas (exemplar)

| Item | Padrão |
|------|--------|
| Anel dos Barris | 1 economy + pool `ringBarrelCharges` + `spend-resource` |
| Trono da Indolência | **3** economy no **mesmo** `item_id` (pairar / servo / banquete); só banquete gasta `throneFeast` |
| Encantos de arma | `properties.weaponCharm` + bônus no domínio de combate |
| Hook / cannonballs | economy com `table_action` NULL (lembrete de mesa) |

### Passivos (`permanentEffects`)

Campos parseados hoje:

- `acBonus`, `attackBonus`, `damageBonus`
- `abilityBonuses` / `savingThrowBonuses` (`forca`…`carisma`)
- `speedBonusMeters`, `hpBonus`
- `abilityScoreMax` (só se o item ultrapassar o teto 20)

Passivo **não numérico** (vantagem situacional, imunidade narrativa, etc.): nota na economy (`summary`/`description`) ou nota de combate — não forçar número falso.

---

## 3. Taxonomia de cada habilidade

Ao ler o texto do item, quebrar em **habilidades**. Para cada uma, classificar:

| `tipo` | Significado | Wiring ideal |
|--------|-------------|--------------|
| `passive-numeric` | Bônus fixo enquanto ativo | `permanentEffects` |
| `passive-note` | Passivo sem número limpo | texto / nota; sem resource |
| `spend-fixed` | Gasta N fixo do pool | resource + economy `spend-resource` + `spend_amount` |
| `spend-variable` | Gasta 1–K | MVP: K botões com `spend_amount` 1..K (mesmo pool); depois UI |
| `reminder` | Ação/toggle sem gasto automático | economy, `table_action` NULL |
| `cast-like` | Conjura magia / efeito complexo | lembrete no MVP; handler só se precisar estado |
| `coverage` | Template mágico sobre peça base (§3.1) | Overlay na peça base (`attached_coverage_*`) |

Buckets: `action` | `bonus` | `reaction` | `free` (e os demais do enum do repo).

---

## 3.1 Cobertura — taxonomia

### Por que classificar

Separar no catálogo **o que a coisa é** (requisito de modelo + busca + wiring):

| Papel | O que é | Exemplo |
|-------|---------|---------|
| **Peça base** | Arma / armadura / escudo / munição mundana | Espada longa, cota de malha |
| **Cobertura** | Template DMG que *aplica-se a* uma peça (filtro no header) | Arma +1, Vorpal, Cota Ifriti |
| **Único** | Item com identidade própria (mesmo que seja “uma espada”) | Adaga Peçonhenta, Lunâmina |
| **Apetrecho / maravilhoso** | Não é arma/armadura base | Anel, amuleto, bolsa |

Cobertura no modelo **não** obriga um único fluxo de UI (“sempre anexar overlay”). Mas a classificação **entra** no produto: busca e listas usam esses papéis.

### Busca / compêndio (intenção)

- Pesquisar peça (ex. “espada”) → mundana **e** coberturas aplicáveis a esse tipo (Arma +1, Vorpal, Escara Gélida…).
- Cobertura continua listável no próprio nome/slug (aba mágica, filtro, etc.).
- Como montar a instância na ficha (overlay vs “já vem Espada +1”) fica aberto; a taxonomia cobre os dois.

### Como reconhecer

- Header `Qualquer…`, `+1/+2/+3`, material/qualidade genérica, **ou** lista explícita de tipos (`Arma (Cimitarra, …)`, `Arco Curto ou Longo`).
- Lista no header = **allowlist** (Vorpal não vira arco; Ifriti só malha/parcial).
- Em dúvida → perguntar. Analogia no repo: Valdas `weaponCharm`.

### Ficha (mínimo)

```yaml
kind: coverage
appliesTo: weapon          # weapon | armor | shield | ammunition | …
appliesFilter: "cimitarra | espada-longa | …"   # do header
# params opcionais (ex. arma-magificada → spellSlug / escola)
```

### Implementação

- Persistência: `D013` (`kind` + `appliesTo` + `appliesFilter`) + taxonomia YAML.
- Inventário overlay estilo Valdas **e/ou** atalho de busca — sem explodir D010 em N×tipos×tiers.
- Não confundir cobertura com único.

### Casos especiais

- **`arma-magificada` (Enspelled):** cobertura **com params** (escola + magia ≤ 8º).
- **`lunamina`:** único (senciente / runas) — não cobertura.
- **`lingua-flamejante`:** cobertura; corrigida em `D014` (antes slug colado).
- **`trombeta-do-valhalla`:** falso positivo.

### Decisões confirmadas (`kind: coverage`)

| Grupo | Slugs |
|-------|--------|
| +1/+2/+3 | `arma-1-2-ou-3`, `armadura-1-2-ou-3`, `escudo-1-2-ou-3`, `municao-1-2-ou-3`, `varinha-do-mago-de-guerra-1-2-ou-3`, `ataduras-do-poder-desarmado` |
| Material / qualidade | `arma-de-adamantina`, `arma-de-prata`, `armadura-adamantina`, `armadura-de-mitral`, `armadura-facil-de-tirar`, `armadura-fumegante`, `armadura-reluzente`, `armadura-do-marinheiro` |
| Qualquer… / poder genérico | `arma-implacavel`, `arma-magificada`, `arma-sempre-alerta`, `armadura-de-resistencia`, `armadura-de-vulnerabilidade`, `armadura-demoniaca`, `municao-exterminadora`, `municao-impactante`, `sorvedora-das-nove-almas`, `defensora`, `matadora-de-dragoes`, `matadora-de-gigantes`, `sacro-vingadora` |
| Lista arma | `escara-gelida`, `espada-da-precisao`, `espada-da-vinganca`, `espada-dancarina`, `espada-laceradora`, `espada-lunar`, `espada-usurpadora-de-vida`, `espada-vorpal`, `garra-silvestre`, `lamina-da-sorte`, `machado-do-carrasco`, `machado-berserker`, `lingua-flamejante`, `arco-de-energia`, `arco-do-juramento`, `martelo-do-trovao` |
| Lista armadura | `armadura-de-placas-das-formas-etereas`, `armadura-de-placas-do-povo-anao`, `cota-de-malha-elfica`, `cota-de-malha-ifriti` |

Valdas `weapon-charm-*`: já overlay. Varredura atual: **sem candidatos pendentes**.

---


## 4. Ficha de análise (copiar por item)

Preencher **uma ficha por item**; dentro dela, **uma linha por habilidade**.

```yaml
item:
  slug: anel-das-estrelas-cadentes
  name: Anel das Estrelas Cadentes
  kind: unique            # unique | consumable | coverage | wondrous/apetrecho…
  category: Anel
  rarity: very-rare
  requiresAttunement: true
  attunementNote: Requer Sintonização
  source: dmg-2024-pt

passive:
  permanentEffects: null   # ou { acBonus: 1, ... }
  notes: []                # passivos não numéricos

resources:
  - slug: starRingCharges
    name: Cargas — Anel das Estrelas Cadentes
    fixedMax: 6
    recover: long   # MVP; texto oficial pode ser 1d6 ao amanhecer

abilities:
  - id: item-anel-das-estrelas-cadentes-luzes
    name: Luz / Luzes Dançantes
    tipo: reminder          # ou cast-like
    bucket: action          # ajustar ao texto
    resource: null
    table_action: null
    summary: "…"
    description: "…"
    status: backlog         # backlog | parcial | wired

  - id: item-anel-das-estrelas-cadentes-esferas
    name: Esferas de Relâmpago
    tipo: spend-fixed
    bucket: action
    resource: starRingCharges
    spend_amount: 2
    table_action: spend-resource
    summary: "…"
    status: backlog

  # … demais poderes do mesmo anel (mesmo resource se compartilhado)

mesa_complete: false
# true só quando: passivos resolvem + todas abilities wired + pools ok na aba Ações
```

### Critério `mesa_complete` (paridade classe)

1. Catálogo `D010` com texto e flags de attune.
2. Passivos numéricos em `permanentEffects` (se houver).
3. Todo pool com definition + grant.
4. Toda habilidade distinta com row economy (`action_id` estável `item-<slug>-<ability>`).
5. `summary`/`description` jogáveis (não só o nome).
6. Na ficha: item equipado/sintonizado → aparece na aba Ações; Usar/± funcionam quando aplicável.

---

## 5. Convenções de seed (quando for implementar)

Ordem de packs: `dmg` → `combat` (ver `scripts/run-seeds.mjs`).

Sugestão de arquivos (criar só na fase correspondente):

| Arquivo | Papel |
|---------|--------|
| `dmg/D010_phb_item.sql` | Catálogo (já existe) |
| `dmg/D011_phb_item_consumable_flag.sql` | Flag `consumable` (lote §0 #1) |
| `dmg/D012_phb_item_permanent_effects.sql` | UPDATEs de `permanentEffects` (lote §0 #2) |
| `dmg/D013_phb_item_coverage_flag.sql` | `kind=coverage` + filtros (§3.1) |
| `dmg/D014_fix_lingua_flamejante.sql` | Corrige Língua Flamejante / remove slug colado |
| `dmg/D015_phb_item_resource_grant_dawn.sql` | Resources 1×/amanhecer (lote §0 #4) |
| `dmg/D016_…_dawn_elementals.sql` | Resources elementais 1×/amanhecer |
| `dmg/D017_…_charges.sql` | Resources pool de cargas (§0 #5) |
| `dmg/D018_…_star_ring.sql` | Resource Anel das Estrelas (§0 #6) |
| `dmg/D019_…_wands.sql` | Resources varinhas (§0 #7) |
| `dmg/D020_…_staves.sql` | Resources cajados (§0 #8) |
| `dmg/D021_…_staff_swarm.sql` | Resource Cajado do Enxame (§0 #8b) |
| `dmg/D022_…_staves_simple.sql` | Resources cajados simples + Sortilégios (§0 #8c) |
| `dmg/D023_…_staff_woods.sql` | Resource + passivo Cajado das Matas (§0 #8d) |
| `dmg/D024_…_staves_rest.sql` | Resources cajados restantes (§0 #8e) |
| `dmg/D025_…_staves_final.sql` | Resources Acrobata/Poder/Magi (§0 #8f) |
| `dmg/D026_…_marvelous_simple.sql` | Resources maravilhosos simples (§0 #9a) |
| `dmg/D027_…_marvelous_simple_b.sql` | Resources maravilhosos simples lote 2 (§0 #9b) |
| `dmg/D028_…_marvelous_simple_c.sql` | Resources + Pedra da Sorte (§0 #9c) |
| `dmg/D029_…_marvelous_d.sql` | Braceletes de Defesa PE (§0 #9d) |
| `dmg/D030_…_marvelous_simple_f.sql` | Resources maravilhosos lote 6 (§0 #9f) |
| `dmg/D031_…_marvelous_rings_g.sql` | Resources 9g + anéis |
| `dmg/D032_…_rings_wands_h.sql` | Resources anéis finais + varinhas (§0 #9h) |
| `dmg/D033_…_marvelous_weapons_i.sql` | Resources + PE utilitários/armas (§0 #9i) |
| `dmg/D034_…_armor_shields_j.sql` | Resources + PE escudos/armaduras (§0 #9j) |
| `dmg/D035_…_weapons_k.sql` | Resources + PE armas únicas (§0 #9k) |
| `dmg/D036_…_marvelous_dense_l.sql` | Resources + PE densos finais (§0 #9l) |
| `combat/C016_…_dmg_consumables.sql` | economy consumíveis |
| `combat/C017_…_dmg_dawn.sql` | economy 1×/amanhecer |
| `combat/C018_…_dawn_elementals.sql` | economy elementais 1×/amanhecer |
| `combat/C019_…_charges.sql` | economy 1 pool + 1 botão |
| `combat/C020_…_star_ring.sql` | economy multi-ação + pool |
| `combat/C021_…_wands.sql` | economy varinhas multi-magia |
| `combat/C022_…_staves.sql` | economy cajados multi-magia |
| `combat/C023_…_staff_swarm.sql` | economy Cajado do Enxame |
| `combat/C024_…_staves_simple.sql` | economy cajados simples + Sortilégios |
| `combat/C025_…_staff_woods.sql` | economy Cajado das Matas |
| `combat/C026_…_staves_rest.sql` | economy cajados restantes |
| `combat/C027_…_staves_final.sql` | economy Acrobata/Poder/Magi |
| `combat/C028_…_marvelous_simple.sql` | economy maravilhosos simples |
| `combat/C029_…_marvelous_simple_b.sql` | economy maravilhosos simples lote 2 |
| `combat/C030_…_marvelous_simple_c.sql` | economy maravilhosos simples lote 3 |
| `combat/C031_…_marvelous_simple_d.sql` | economy maravilhosos simples lote 4 |
| `combat/C032_…_marvelous_simple_e.sql` | economy maravilhosos simples lote 5 |
| `combat/C033_…_marvelous_simple_f.sql` | economy maravilhosos simples lote 6 |
| `combat/C034_…_marvelous_rings_g.sql` | economy maravilhosos + anéis lote 7 |
| `combat/C035_…_rings_wands_h.sql` | economy anéis finais + varinhas lote 2 |
| `combat/C036_…_marvelous_weapons_i.sql` | economy utilitários densos + armas |
| `combat/C037_…_armor_shields_j.sql` | economy escudos / armaduras únicas |
| `combat/C038_…_weapons_k.sql` | economy armas únicas / artefatos |
| `combat/C039_…_marvelous_dense_l.sql` | economy densos finais + Orcus/Maravilhas |

Regras de row economy (iguais C013):

- `action_id` único e estável.
- `item_id` = FK do slug; class/species/feat NULL.
- Mesmo item, N rows → N `action_id`.
- Pool compartilhado → mesmo `resource_slug` em várias rows.
- Gasto só recurso → `table_action = 'spend-resource'`, `always_spends_resource = true`.
- Só lembrete → `table_action` NULL; resource opcional (aí só ±).

Naming:

- Resource camelCase: `starRingCharges`, `ringBarrelCharges`.
- Action: `item-anel-das-estrelas-cadentes-esferas`.

---

## 6. Fases de trabalho (manuais)

Cada fase é um **lote consciente**. Não misturar “auditar 338” com “seedar 338” no mesmo PR.

### Fase 0 — Este documento

- Ideal, ficha, paridade, fases.
- Status: **este arquivo**.

### Fase 1 — Taxonomia

- Percorrer o índice A–Z **na ordem da §0** (não aleatório).
- Para cada item: listar habilidades + `tipo` + bucket (ainda sem SQL).
- Artefato sugerido: `docs/source/dmg-wiring-status.md` (status por lote; detalhe por item = seeds).
- Saída: contagem por tipo (quantos só passivos, quantos multi-ação, etc.).

### Fase 2 — Passivos numéricos (§0 #2) e marcar coberturas (§0 #3 / §3.1)

- Únicos com +CA / +ataque / set de atributo → `permanentEffects`.
- Candidato a cobertura → `kind: coverage` + `appliesFilter` (lista §3.1 já decidida; ambíguo → perguntar).
- Seed de passivo só em únicos confirmados; coberturas não viram “arma fantasma” no D010.

### Fase 2b — Coberturas (wiring)

- Persistência de `kind` + filtro; busca do compêndio junta peça + coberturas aplicáveis (§3.1).
- Inventário: overlay estilo Valdas e/ou atalho “já vem com cobertura” — sem explodir o D010.

### Fase 3 — Consumo e usos simples (§0 #1, #4, #5)

- Poções/pergaminhos + 1×/DL + 1 pool/1 botão.
- `D012` + economy mínima.
- Espelhar Anel dos Barris / estatueta.

### Fase 4 — Multi-ação + pool compartilhado (§0 #6–#8)

- Anéis / varinhas / cajados com várias propriedades e um pool.
- Exemplar canônico: **Anel das Estrelas Cadentes**.
- Padrão Trono (N rows, 1 `item_id`).

### Fase 5 — Gasto variável e maravilhosos densos (§0 #9–#10)

- Ex.: gastar 1–3 cargas → botões separados.
- Maravilhosos multi-modo: reminders + pools pontuais.

### Fase 6 — Cast de item + artefatos / além do MVP (§0 #11)

- **Cast/link magia:** `spell_slug` na economy + `itemCastResourceSlug`/`itemCastSpendAmount`/`itemCastItemSlug` em `POST …/spells/cast`. Backfill: `C042`. Magi custo 0: `C044` (`cast-item-free`). Enspelled: Arma/Armadura Magificada + Cajado Magificado.
- **Nível de conjuração:** `resolveItemCastSlotLevel` — default `max(nível, spend)`; regras SSOT em `properties.itemCastSlotRule(s)` (`D046`: Relâmpagos/Cuspidora `charge-upcast`; Onda/Órbes fixed).
- **Treasure cast:** notas (componentes / concentração / +0+PB) + `spellSaveDcOverride` via `properties.spellSaveDc` / Enspelled.
- **Enspelled CD/raridade:** `getEnspelledSpellStats` / nota no cast (tabela DMG por nível da magia bound).
- **Sintonia por classe:** `parseAttunementRestriction` + gate em patch attune / attach cobertura.
- **Recover 1dN / cargas:** `recover_on_long_dice` (`T073`/`D041`) e `recover_all_on_long` no **Descanso Longo** — MVP mesa ≈ “próximo amanhecer” (Treasure §2); evento `dawn` = P1.
- **Coberturas de arma:** `D040`/`C043` (dançarina, língua, arco energia, martelo, defensora, escara, garra, lâmina sorte, juramento).
- Pendente: sorvedora tracking; sacro-vingadora só PE; gaps em `treasure-rules-vs-sistema.md`.

---

## 7. Ordem sugerida dentro de cada fase de wiring

1. Escolher **1 item** (ou lote ≤ ~10 do mesmo padrão).
2. Preencher a ficha (§4) a partir do texto em `dmg-2024-itens-magicos-az.txt` / JSON.
3. Seeds na ordem: enrich passivo → resource → economy.
4. Re-seed / apply só os arquivos tocados (preferir pooler session se `db.*` IPv6 falhar).
5. Smoke: inventário → sintonizar → aba Ações → Usar / ±.
6. Atualizar status em `docs/source/dmg-wiring-status.md` se o lote mudou.

---

## 8. Checklist rápido (por habilidade)

- [ ] Candidato a cobertura (Qualquer… / +1–+3 / lista de tipos)? → `kind: coverage` + `appliesFilter`; se ambíguo, perguntar (§3.1)
- [ ] Nome estável (`action_id`)
- [ ] Bucket correto ao texto
- [ ] Tipo classificado (§3)
- [ ] Resource existe se gasta uso/carga
- [ ] `spend_amount` coerente (ou botões 1..N)
- [ ] `table_action` = `spend-resource` | `NULL` | (fase 6) handler
- [ ] Texto `summary` + `description` jogáveis
- [ ] Attune/equipados respeitados na UI
- [ ] Passivo numérico no JSON se aplicável

---

## 9. Estado atual (snapshot)

| Peça | Estado |
|------|--------|
| `D010` catálogo (~338) | Feito |
| Taxonomia + economy consumíveis | Feito (`D011` + `C016`) |
| Taxonomia coberturas (§3.1) | Feito (`D013`; status em `dmg-wiring-status.md`) |
| Compêndio `/equipment?tab=magic` | Feito (`GET /items?magic=true`) |
| `permanentEffects` DMG (lote §0 #2) | Feito (`D012` — anel/manto de proteção) |
| Edição `dmg-2024-pt` (Fontes) | Feito (`D001`) |
| Modelo **cobertura** overlay/busca | Feito (`P021` + `inventory/actions` attach/detach + UI Beyond) |
| Resources DMG (1×/amanhecer lote) | Feito (`D015`+`C017` · `D016`+`C018` elementais) |
| Resources DMG (pool cargas §0 #5) | Feito (`D017`+`C019` — 5 itens) |
| Anel das Estrelas Cadentes (§0 #6) | Feito (`D018`+`C020` — 7 actions, pool 6) |
| Varinhas multi-magia (§0 #7) | Feito (`D019`+`C021` — 3 varinhas) |
| Cajados multi-magia (§0 #8) | Feito (`D020`–`D025` / `C022`–`C027` — 18 cajados) |
| Maravilhosos / anéis / varinhas / armas / escudos / densos (§0 #9) | Feito (`D026`–`D036` / `C028`–`C039`) |
| Cast/link magia de item | Feito (varinhas/cajados `C042`; artefatos `C045`; Magi `C044`) |
| Overlay coberturas (UI) | Feito (§3.1 / fase 2b — attach/detach + PE/ataque + toggle sintonia + munição) |

Próximo passo natural: gaps em `treasure-rules-vs-sistema.md` (dawn real, curse, CD de item).
