# Treasure (DMG 2024) × lacunas do sistema

Fonte: regras gerais do Cap. 7 Treasure (DMG 2024 / Beyond).  
Modelo mesa: [`dmg-item-mesa.md`](./dmg-item-mesa.md) · artefatos: [`docs/plans/audit-dmg-artifacts.md`](../../../docs/plans/audit-dmg-artifacts.md) · wiring: [`docs/source/dmg-wiring-status.md`](../source/dmg-wiring-status.md).

Objetivo: regras do capítulo (não o A–Z de itens) que **explicam falhas** ou **faltam** no wiring atual.

---

## Já cobrimos bem (não é gap)

| Regra Beyond | No sistema |
|--------------|------------|
| Categorias (Armor…Wondrous) | `item_type` + `properties.category` / raridade em `D010` |
| Cargas + botões por magia | resource grant + economy `spend-resource` + `spell_slug` (varinhas / C045 artefatos) |
| Cast sem gastar slot do personagem | `POST …/spells/cast` com `itemCast*` |
| Passivos numéricos (+CA, +atq, atributo) | `permanentEffects` (+ `abilityScoreMax` até 24) |
| 1×/amanhecer (MVP = DL) | `recover_all_on_long` / resource max 1 |
| Recover parcial 1dN no DL | `recover_on_long_dice` (`D041`) — **parcial**, não “ao amanhecer” |
| Preços PHB equipamento + câmbio de moedas | `S031` auditado; compra via `POST …/inventory/purchase` (carrinho) + add; venda ½ / discard; qty PATCH cobrado; serviços sem inventariar; stats view/purchase |
| Cap. 6 extras (variantes, montarias, veículos, serviços, scrolls 2–9) | Seedados em `S031` com `cost.text` (categorias `Varia` → `cost NULL` + filhas precificadas). Instrumentos/jogos **não** mais patchados em `S060`. Rerolar `db:seed` |
| Compartimentos (bolsa/saca/cesta) | `contained_in_item_slug` (P028) + UI Beyond por recipiente |
| Preços mágicos sugeridos (raridade) | `D010` via `generate-dmg-item-seeds.mjs` |

---

## Gaps que o Treasure esclarece (prioridade)

### P0 — comportamento errado / incompleto se o jogador espera a regra oficial

#### 1. Spells Cast from Items (regra geral)

Texto Beyond (resumo):

- Conjura no **menor círculo possível** (salvo texto do item).
- **Não gasta slot** do usuário; **sem componentes** salvo o item dizer o contrário.
- Tempo / alcance / duração normais; **Concentração** se a magia exigir.
- Se o item pede atributo de conjuração do usuário: escolhe um; se não tem, **modificador +0** + PB.

**Sistema hoje (coberto):**

| Regra | Onde |
|-------|------|
| Cast sem slot + `itemCast*` | `POST …/spells/cast` |
| Sem componentes (default) / concentração | notas Treasure em `item-cast-rules` + `concentratingOn` |
| CD / ataque do item | `properties.spellSaveDc` / `spellAttackBonus` (`D046`) → `spellSaveDcOverride` / `spellAttackBonusOverride` na response |
| Enspelled | `getEnspelledSpellStats` (sobrescreve CD/ataque) |
| Círculo | `resolveItemCastSlotLevel` + SSOT `itemCastSlotRule(s)` em properties (`D046`) — default `max(nível, spend)`; Relâmpagos/Cuspidora `charge-upcast`; Onda/Órbes fixed |
| +0 + PB | `properties.useCasterAbility: true` + classe sem `phb_class_spellcasting` |

**Gap residual:** nem todo item do A–Z com CD no texto tem `spellSaveDc` no seed (só lotes em `D046` + Enspelled). Ampliar overlay conforme uso.
#### 2. “The Next Dawn” ≠ Descanso Longo

- Recarga oficial: **próximo amanhecer** (ou horário que o Mestre definir se não houver amanhecer).

**Sistema hoje (MVP curto — documentado):**

| Regra | Onde |
|-------|------|
| Recarga de cargas / 1× | `recover_all_on_long` / `recover_on_long_dice` no **Descanso Longo** |
| Contrato de mesa | UI: título do botão DL — “cargas de item ≈ amanhecer”; docs mesa/Treasure |
| P1 (não neste PR) | evento de sessão `dawn` reusando o mesmo recover — **sem** segundo pipeline |

**Falha conhecida aceita no MVP:** DL ao meio-dia recarrega cedo; amanhecer sem DL não recarrega.
#### 3. Itens amaldiçoados

- Identify **não** revela maldição.
- Sintonização **não** pode ser encerrada voluntariamente até Remove Curse (etc.).

**Sistema hoje (coberto):**

| Regra | Onde |
|-------|------|
| Flag | `properties.cursed` (`D047`) |
| Bloqueio voluntário | `applyInventoryAttunement` → 400 sem `instance_properties.curseBroken` |
| Quebra | **um** mecanismo: `curseBroken` — setado por `POST …/spells/cast` `remover-maldicao` (também encerra sintonia) |
| Front | botão Dessintonizar desabilitado se `cursed && !curseBroken` |

**Gap residual:** Identify ainda não omite maldição na UI de identificação; efeitos mecânicos da maldição (ex. vulnerabilidade) = reminder / fora deste P0.
---

### P1 — artefatos / senciência (lembrete hoje; regras faltando)

#### 4. Artifact Properties (tabelas 1d100)

Além das props fixas do item, até:

- 4 minor + 2 major **benéficas**
- 4 minor + 2 major **prejudiciais**

Mudam a cada aparição do artefato.

**Sistema hoje:** tabelas em `rpg.dmg_artifact_random_property` (`T075` / `D043`). Quotas por artefato em `properties.artifactRandomQuota` (`D045`). Na **primeira sintonização**, rola e grava em `player_character_item.instance_properties.artifactRandom` (`P027`). PE numéricos (`+1 CA`, `+2 atributo máx. 24`, `+3 m`) entram no resolve ativo. Magias roladas (`artifactSpell`) → cast `artifactRandomCast` (CD 18); após o cast rola **d6** (1–5 suprime até DL; 6 libera de novo). Regen → `POST …/inventory/actions` (`artifact-regen`). **Nova aparição** → `actionSlug: artifact-reroll` (limpa `artifactRandom` + re-rola; mantém senciência). `abilityPenalty` (−2) em `abilityPenalties` até Restauração Maior. Resto = reminder na ficha. Dessintonizar **não** apaga o roll.

**Ainda falta:** condition immunities / vulnerabilidades como PE; Charm 1d12 h / suprime poderes após falha no conflito (só nota de mesa hoje).

Mapeamento útil → PE já existentes:

| Prop típica | Wiring |
|-------------|--------|
| +1 CA / +2 atributo max 24 / +3 m deslocamento | `permanentEffects` (já mergeado da instância) |
| Resistência / Imunidade condição | lembrete **ou** futuro `conditionImmunities` |
| Magia 1º–7º | `artifactSpell` + cast + d6 1–5 |
| Regen 1d6/turno | botão na ficha (`inventory/actions` · `artifact-regen`) |
| −2 atributo até Restauração Maior | `abilityPenalties` (combate/salvaguarda/arma) |
| Desvantagem em salvaguardas / vulnerabilidade | lembrete; PE negativo ainda não modelado |

#### 5. Sentient Magic Items + Conflict

- Item tem alinhamento, comunicação, sentidos, propósito (tabelas).
- Conflito: CAR CD **12 + mod de Carisma do item**; demandas; falha → Charm 1d12 h / suprime poderes / impede sintonizar.

**Sistema hoje:** tabelas de geração em `rpg.dmg_sentient_trait_table` (`T076` / `D044`) + `rollSentientTraits` (domínio, testes). Artefatos nomeados: `properties.sentience` fixa (`D045`) copiada para `instance_properties.sentience` na 1ª sintonia. UI Beyond mostra o bloco. **Conflito:** `POST …/inventory/actions` `actionSlug: sentient-conflict` → CD + nota de mesa (sem automatizar Charm).

**Gap residual:** geração genérica de arma senciente fora de artefato nomeado; efeitos pós-falha do conflito.
#### 6. Magic Item Resilience / destruir artefato

- Maioria dos itens mágicos: **Resistência a todo dano** (exceto poção/pergaminho).
- Artefato: **indestrutível** salvo método especial (já no texto `D010` por item).

Sem tracking de HP de objeto / indestrutível no inventário.

---

### P2 — regras de suporte (baixo impacto na ficha agora)

| Regra | Conteúdo | Gap |
|-------|----------|-----|
| Attunement Prerequisites | Classe / “spellcaster” = conjura ≥1 magia por traço/feature, **não** via item | Validação de sintonia frouxa |
| Command Word | Falha sob Silence | Lembrete |
| Consumable | Perde magia ao usar | Poções: wiring parcial; sumir do inventário nem sempre |
| Crafting | Arcana + ferramenta por categoria + tabelas de custo/tempo | Fora do combate |
| Paired items / anatomia | Exceções de tamanho / um só de um par | Mesa |
| Awarding / hoards | Tabelas de recompensa | Campanha / loot, não ficha |

---

## Spells Cast from Items — texto de referência (EN)

> Some magic items allow the user to cast a spell from the item. The spell is cast at the lowest possible spell and caster level, doesn’t expend any of the user’s spell slots, and requires no components unless the item’s description notes otherwise. […] Concentration if required. […] If the user doesn’t have a spellcasting ability, their spellcasting ability modifier is +0 for the item, and the user’s Proficiency Bonus applies.

## Conflict — texto de referência (EN)

> Charisma saving throw (DC 12 plus the item’s Charisma modifier). On a failed save, demands (Chase My Dreams / Get Rid of It / It’s Time for a Change / Keep Me Close). Refusal → prevent attunement / suppress properties / control attempt (Charm 1d12 hours; on damage repeat save; 1× until next dawn).

---

## Ordem sugerida se formos fechar gaps

1. **Documentar na UI** MVP amanhecer≈DL + CD de item na descrição da ação (barato).
2. **`cursed` + bloqueio de dessintonizar** (poucos itens, alto fidelidade).
3. **Cast de item:** CD override + “sem componentes / slot” explícitos no note do cast.
4. **Conflict senciente** (tabelas + `sentience` na instância já existem).
5. Economy/handlers das props aleatórias reminder (magia 1d6, regen, condições).
6. Evento de sessão **dawn** (substitui MVP).

---

## Fora do escopo deste doc

- Catálogo A–Z de itens → `D010` / [`docs/source/dmg-2024-itens-magicos-az-index.md`](../source/dmg-2024-itens-magicos-az-index.md).
- Tabelas de hoard / gems / art objects → loot, não economy da ficha.
- Crafting completo → feature de downtime separada.
