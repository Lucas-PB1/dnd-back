# Auditoria create wizard — subclasses PHB 2024

**Data:** 2026-08-12  
**Escopo:** 48 subclasses em `database/seeds/phb/S026_phb_subclass.sql` vs wizard de criação (create) e merge de magias concedidas.  
**Referência PHB:** `S027_phb_subclass_feature.sql`  
**Relacionado:** [`backlog.md`](backlog.md) (itens de implementação)

## Legenda

| Símbolo | Significado |
|---------|-------------|
| **OK** | Nada obrigatório faltando no create no nível de desbloqueio |
| **Parcial** | Pick ou grant incompleto |
| **Gap** | Escolha PHB sem `option_def`/wizard ou grant crítico ausente |
| **Mesa** | Mecânica de mesa; fora do escopo create |
| **N/A** | Nível de personagem ainda não alcança a subclasse |

**Nível de desbloqueio:** L3 na maioria das classes; **L4** no Paladino (`phb_class.subclass_unlock_level`).

## Como medimos

| Eixo | SSOT | Runtime |
|------|------|---------|
| Escolhas obrigatórias | `S004` + `S005` (`phb_option_def` / `phb_option_value`, `scope = subclass`) | `GET /subclasses/:slug/options`; validação em `CharacterCreateRequirementsValidator` |
| Magias always_prepared | `S028` → view `V007_v_phb_subclass_prepared_spell` | `LoadGrantedSpellCatalog.loadSubclassGrantedSpells` + merge |
| Conjuradores 1/3 | `S008`–`S010` | Passo de magias do wizard (lista Mago) |

Validação de picks: todas as `option_key` com `unlock_level ≤ level` do personagem devem estar em `subclassOptions`.

---

## Scorecard

| Classe | OK | Parcial | Gap |
|--------|-----|---------|-----|
| Bárbaro | 3 | 1 | 0 |
| Bardo | 2 | 1 | 1 |
| Bruxo | 4 | 0 | 0 |
| Clérigo | 4 | 0 | 0 |
| Druida | 2 | 1 | 1 |
| Feiticeiro | 4 | 0 | 0 |
| Patrulheiro | 4 | 0 | 0 |
| Guerreiro | 3 | 1 | 0 |
| Ladino | 4 | 0 | 0 |
| Mago | 0 | 1 | 3 escolas + Versado |
| Monge | 2 | 2 | 0 |
| Paladino | 4* | 0 | 0 |

\* create ≥ L4

**Totais aproximados:** ~32 OK · ~8 parciais · ~5 gaps de pick · ~~1 bug de merge (Terra)~~ **corrigido na API**.

---

## Status da implementação (2026-08-12)

| Item | API | Front |
|------|-----|-------|
| Terra — pick terreno + filtro merge | ✅ `S011` + `filter-subclass-granted-spells` | ✅ picker `terrain` |
| Saber — 3 perícias + Descobertas Mágicas L6 | ✅ `S011` + validação/proficiências | ✅ pickers `skill_list` / `spell` |
| BM Estudioso da Guerra | ✅ `S011` | ✅ pickers ferramenta/perícia |
| Versado Mago (4 escolas) | ✅ `S011` + quota grimório | ✅ picker `spell` por escola |
| S028 grants faltantes | ✅ `S078` | — |
| Valdas (`high-roller`, `secret-agent`) | — | backlog separado |

Seeds: `database/seeds/subclass/S011_phb_subclass_option_land_lore_bm_wizard.sql`, `database/seeds/phb/S078_phb_subclass_granted_spell_supplement.sql`.

## Subclasses com `option_def` hoje (`S004`)

| Slug | Picks |
|------|-------|
| `draconic` | Afinidade Elemental L6 |
| `clockwork` | Manifestação da Ordem L3 |
| `fiend` | Resistência Ínfera L10 |
| `stars` | Forma do Mapa Estelar + Constelação L3 |
| `hunter` | Presa L3; Táticas Defensivas L7 |
| `beast-master` | Companheiro Primal L3 |
| `fey-wanderer` | Dádiva Feérica + Perícia L3 |
| `gloom-stalker` | Salvaguarda Mente de Ferro L7 |
| `champion` | Estilo de Luta adicional L7 |
| `battle-master` | Manobras 1–3 L3 (**sem** Estudioso da Guerra) |
| `wild-heart` | Aspectos Fúria L3; Aspecto L6; Poder L14 |
| `zealot` | Tipo dano Fúria Divina L3 |
| `elements` | Resistência Ápice Elemental L17 |

---

## 1. Bárbaro (L3)

### Trilha da Árvore do Mundo (`world-tree`) — OK

| Nv | Característica | Create |
|----|----------------|--------|
| 3 | Vitalidade da Árvore | Mesa |
| 6+ | Ramos, Raízes, Percorrer | Mesa |

### Trilha do Berserker (`berserker`) — OK

| Nv | Característica | Create |
|----|----------------|--------|
| 3 | Frenesi | Mesa |
| 6+ | Fúria Irracional, Retaliação, Presença | Mesa |

### Trilha do Coração Selvagem (`wild-heart`) — Parcial

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | Arauto da Fauna (rituais `falar-com-animais`, `sentido-feral`) | grant | Parcial — fora de `S028`/merge |
| 3 | Fúria dos Selvagens (Águia/Lobo/Urso) | `wildRageAspect` | OK |
| 6 | Aspecto (Coruja/Pantera/Salmão) | `wildAspect` | OK se create ≥ L6 |
| 10 | Arauto da Natureza (ritual `comunhao-com-a-natureza`) | grant | Parcial |
| 14 | Poder dos Selvagens | `wildPower` | OK se create ≥ L14 |

**Nit:** PHB diz “apenas como Rituais”, não always_prepared. Backlog trata como grant — decisão de produto pendente.

### Trilha do Fanático (`zealot`) — OK

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | Fúria Divina (Necrótico/Radiante) | `divineFuryDamage` | OK |
| 3 | Campeão dos Deuses | Mesa | — |

---

## 2. Bardo (L3)

### Colégio da Bravura (`valor`) — OK

Treinamento Marcial (marcial/média/escudo) é automático via subclasse. Demais features = mesa.

### Colégio da Dança (`dance`) — OK

Sem picks no PHB L3.

### Colégio do Saber (`lore`) — Gap

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | Proficiências Bônus (**3 perícias**) | pick | **Gap** — sem `S004` |
| 6 | Descobertas Mágicas (**2 magias** Clérigo/Druida/Mago always_prepared) | pick + grant | **Gap** |

### Colégio do Glamour (`glamour`) — Parcial

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | Magia Fascinante (`enfeiticar-pessoa`, `reflexos`) | grant | Parcial — falta `S028` |
| 6 | Manto de Majestade (`comando`) | grant | Parcial (create ≥ L6) |

---

## 3. Bruxo (L3) — OK

| Subclasse | Grants L3 (`S028`) | Picks extras |
|-----------|-------------------|--------------|
| `archfey` | 5 magias pacto | — |
| `celestial` | 6 magias | — |
| `great-old-one` | 4 magias | — |
| `fiend` | 4 magias | `infernalResilience` L10 |

---

## 4. Clérigo (L3) — OK

Domínios Vida, Luz, Trapaça e Guerra: lista completa em `S028` (L3–9).

---

## 5. Druida (L3)

### Círculo da Terra (`land`) — Gap

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | Magias do Círculo (**terreno**: árido/polar/temperado/tropical) | pick + grant | **Gap** — sem pick; merge ignora `terrain_slug` |

**Bug:** `LoadGrantedSpellCatalog.loadSubclassGrantedSpells` não filtra por terreno — injetaria magias de **todos** os terrenos.

### Círculo da Lua (`moon`) — OK

Magias em `S028`. Forma selvagem = mesa.

### Círculo das Estrelas (`stars`) — Parcial

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | Mapa Estelar + Forma Estrelada | picks OK | Parcial |
| 3 | `orientacao`, `raio-guia` (Mapa Estelar) | grant | Falta `S028` |

### Círculo do Mar (`sea`) — OK

Magias em `S028`. Ira do Mar = mesa.

---

## 6. Feiticeiro (L3) — OK

| Subclasse | Picks | Grants |
|-----------|-------|--------|
| `aberrant` | — | `S028` |
| `draconic` | Afinidade L6 | `S028` |
| `clockwork` | Manifestação L3 | `S028` |
| `wild-magic` | — | Surto = mesa |

---

## 7. Patrulheiro (L3) — OK

Referência de implementação de picks:

| Subclasse | Picks L3 | Grants |
|-----------|----------|--------|
| `hunter` | `huntersPrey` | — |
| `beast-master` | `primalCompanion` | — |
| `fey-wanderer` | `feyGift` + `glamourSkill` | `S028` |
| `gloom-stalker` | Mente de Ferro L7 | `S028` |

---

## 8. Guerreiro (L3)

### Campeão (`champion`) — OK

FS adicional só L7 (`additionalFightingStyle`).

### Cavaleiro Místico (`eldritch-knight`) — OK

Conjuração 1/3 via `S008`/`S010`; magias no passo spells.

### Combatente Psíquico (`psi-warrior`) — OK no L3

Grant L18 `telecinese` always_prepared — parcial só se create ≥ L18.

### Mestre da Batalha (`battle-master`) — Parcial

| Nv | Característica | Create | Status |
|----|----------------|--------|--------|
| 3 | **Estudioso da Guerra** (ferramenta + 1 perícia Guerreiro L1) | pick | **Gap** |
| 3 | Superioridade (3 manobras) | `maneuver1–3` | OK (`S005`) |

---

## 9. Ladino (L3) — OK

| Subclasse | Notas |
|-----------|-------|
| `soulknife`, `assassin`, `thief` | Passivas / mesa |
| `arcane-trickster` | 1/3 Mago via `S010` |

---

## 10. Mago (L3)

### Padrão Versado (4 escolas) — Gap

| Nv | Característica | Abj | Div | Evoc | Ilus |
|----|----------------|-----|-----|------|------|
| 3 | Versado (+2 magias escola ≤2º no grimório) | pick | pick | pick | pick |
| 3 | Feature escola | passivo | passivo | passivo | `ilusao-menor` grant |
| 6 | — | — | — | — | Criaturas Espectrais (grant) |
| 10 | Rompe-Magia | grant | — | — | — |

Nenhuma escola tem `option_def` para magias Versado.

---

## 11. Monge (L3)

| Subclasse | Grants | Veredito |
|-----------|--------|----------|
| `elements` | Falta L3 `elementalismo` | Parcial |
| `open-hand`, `mercy` | — | OK |
| `shadow` | Falta L3 `ilusao-menor` | Parcial |

Resistência Elementos L17: pick OK (`elementalResistance`).

---

## 12. Paladino (L4)

| Subclasse | Grants juramento (`S028`) | Create L3 |
|-----------|---------------------------|-----------|
| `ancients`, `devotion`, `glory`, `vengeance` | L3–9 (desde L4 paladino) | N/A |

Create ≥ L4: **OK**.

---

## Gaps de pick — implementação

| # | Subclasse | O que falta | SSOT alvo |
|---|-----------|-------------|-----------|
| 1 | `land` | Terreno (4 valores) + filtrar merge por `terrain_slug` | `S004` + merge |
| 2 | `lore` | 3× perícia L3; 2× magia cross-list L6 | `S004` + grant |
| 3 | `battle-master` | Ferramenta artesão + 1 perícia lista Guerreiro L1 | `S004` |
| 4 | 4 escolas Mago | +2 magias escola ≤2º L3; +1 por círculo novo | `S004` ou extensão grimório |
| 5 | Valdas (fora PHB) | `high-roller`, `secret-agent` | backlog separado |

Validação já pronta: `CharacterCreateRequirementsValidator` + `loadSubclassOptionKeysAtLevel`.

---

## Grants `S028` faltantes

| Subclasse | Nv | Magias | Nota |
|-----------|-----|--------|------|
| `glamour` | 3 | `enfeiticar-pessoa`, `reflexos` | always_prepared |
| `glamour` | 6 | `comando` | always_prepared |
| `stars` | 3 | `orientacao`, `raio-guia` | Mapa Estelar |
| `illusionist` | 3 | `ilusao-menor` | truque |
| `illusionist` | 6 | `convocar-feerico`, `invocar-fera` | always_prepared |
| `elements` | 3 | `elementalismo` | truque |
| `shadow` | 3 | `ilusao-menor` | truque |
| `abjurer` | 10 | `contramagia`, `dissipar-magia` | always_prepared |
| `psi-warrior` | 18 | `telecinese` | always_prepared |
| `wild-heart` | 3/10 | rituais fauna/natureza | ritual vs grant |

**Já em `S028`:** pactos, domínios, juramentos, Lua, Mar, feiticeiro (aberrante/draconic/clockwork), patrulheiro (fey/gloom).

---

## Subclasses com domínio/juramento/pacto em `S028`

`archfey`, `celestial`, `great-old-one`, `fiend`, `life`, `light`, `trickery`, `war`, `land` (com terreno no seed), `moon`, `sea`, `aberrant`, `draconic`, `clockwork`, `fey-wanderer`, `gloom-stalker`, `ancients`, `devotion`, `glory`, `vengeance`.

---

## Notas de mesa (fora do create)

- **Lua / Coração Selvagem / BM L7+ / Caçador L7+:** escolhas de nível superior — só entram se create ≥ nível.
- **EK / Trapaceiro Arcano:** magias escolhidas no passo spells; não usam `S028`.
- **Selvagem, Berserker, etc.:** economia de mesa (Fúria, manobras em combate).
- **Terra:** filtro de terreno implementado no merge (`filterSubclassGrantedSpellRows`); falta UI de pick no front.

---

## Ordem sugerida de implementação

1. ~~**Terra** — pick + filtro `terrain_slug` no merge~~ ✅ API  
2. ~~**Saber** — 3 perícias + Descobertas Mágicas L6~~ ✅ API  
3. ~~**BM Estudioso da Guerra**~~ ✅ API  
4. ~~**Versado Mago** (4 escolas)~~ ✅ API (quota + validação; auto-inject `known` opcional)  
5. ~~Lote **S028** (Glamour, Estrelas, Ilusionista, Elementos, Sombras, Abj L10, Psi L18, Coração Selvagem)~~ ✅ API  
6. ~~**Front** — pickers `terrain` / `skill_list` / `spell` em `step-subclass-options.tsx` (dnd-front)~~ ✅

Itens rastreados em [`backlog.md`](backlog.md).
