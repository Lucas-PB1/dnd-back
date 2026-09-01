# Backlog — o que ainda falta

Único checklist ativo do **dnd-api** (+ front). Só itens **abertos** — concluído sai daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-01

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / campanha / encontro | Pronto |
| Classes mesa PHB (13) | Pronto |
| Steinhardt + Northlands (Waves 1–4 + Cap. 5 + veículos) | Pronto — ref. [`northlands-audit.md`](northlands-audit.md) |
| Itens DMG mesa | Pronto — [`dmg-wiring-status.md`](../source/dmg-wiring-status.md) |
| Grim Hollow Cap. 2 mesa + Cap. 1 heranças | **Quase** — residual em [`grim-hollow-mesa-audit.md`](grim-hollow-mesa-audit.md) |
| Grim Hollow Cap. 4 talentos | Pronto |
| Grim Hollow Cap. 6 transformações | Catálogo pronto; **ficha/mesa** aberto — [`grim-hollow-cap6-transformations.md`](grim-hollow-cap6-transformations.md) |
| Saúde do código | **Ativo** — [`code-health-audit.md`](code-health-audit.md) |
| Combate situacional / monstros catálogo | **Adiado** (seção abaixo) |

---

## Ativo

### Grim Hollow

- [ ] **Mesa Cap. 2 + Cap. 1 (residual):** companion Primordial Spirit, smoke UI heranças, sub-escolhas de traço (se bloquear). Plano: [`grim-hollow-mesa-audit.md`](grim-hollow-mesa-audit.md).
- [ ] **Cap. 6 transformações:** persistência ficha + UI read + opções J060. Plano: [`grim-hollow-cap6-transformations.md`](grim-hollow-cap6-transformations.md).

### Northlands

- [ ] **Character Threads — fase 2 / mesa:** Cursemarked (brackets d20), Fatebound na morte, economy 1/LR. MVP ficha feito. Extração: [`northlands-character-threads.md`](northlands-character-threads.md).
- [ ] **Pente fino residual (opcional):** M6 features só texto; Greater Freyr usos PB/dia — [`northlands-audit.md`](northlands-audit.md).

### Saúde do código

Plano faseado: [`code-health-audit.md` § Plano de melhoria](code-health-audit.md#plano-de-melhoria). Rule: `dry-quality`. Skills: `split-large-module` · `unify-game-stats`.

#### Fase 0 — Limpeza

- [ ] **0.1** Apagar `scripts/lib/ghpg-cap5-requirements.mjs`
- [ ] **0.2** Remover `@deprecated` em `ghpg-html-utils.mjs` (`findGhpgCap2Html` → `findGhpgChapterHtml`)
- [ ] **0.3** Arquivar ou apagar `scripts/_*.mjs` (13 arquivos)
- [ ] **0.4** Criar `scripts/README.md`

#### Fase 1 — SSOT stats + harness → nota **B**

- [ ] **1.1** `abilityMod` → `abilityModifier` (3 arquivos combat)
- [ ] **1.2** Extrair `hasStyleOrFeat` compartilhado
- [ ] **1.3** CA ficha = mesmo resolver que combate
- [ ] **1.4** Harness `table-action-handler.harness.ts`
- [ ] **1.5** Remover `as never` prod (`cast-notes`, `cast-eldritch-prelude`)

#### Fase 2 — Testes + splits críticos → nota **B+**

- [ ] **2.1** Migrar 14 `*-actions.handler.spec.ts` para harness
- [ ] **2.2** Enxugar `weapon-attack.spec.ts` (<300 linhas)
- [ ] **2.3** Enxugar `roll-damage.spec.ts` (<300 linhas)
- [ ] **2.4** Split `mechanical-catalog.fixtures.ts`
- [ ] **2.5** Split `class-resources.ts` + SQL em infrastructure
- [ ] **2.6** Split `barbarian/subclass-actions.ts` (template outras classes)
- [ ] **2.7** Política de testes em `code-standards.md`

#### Fase 3 — DB unificado

- [ ] **3.0** Inventário SQL cru em validators
- [ ] **3.1** `spell-progression-queries.ts` → view ou bundle RPC
- [ ] **3.2** `class-resources.ts` queries em infrastructure
- [ ] **3.3** `firearm-ops` + `roll-weapon-context` → repository
- [ ] **3.4** Validators spells/feats → views/RPC
- [ ] **3.5** Validators class-options restantes
- [ ] **3.6** ADR domain vs `infrastructure/validation/`
- [ ] **3.7** Matriz runtime em `catalog-patterns.md`

#### Fase 4 — Estrutura pré-prod → nota **A−**

- [ ] **4.1** Squash migrations (baseline único)
- [ ] **4.2** Barrel policy (`session/dto/index.ts`, …)
- [ ] **4.3** `combat/domain/notes/` para combat-notes
- [ ] **4.4** Split `inventory/application`
- [ ] **4.5** `CatalogLookupService` vs queries — caminho único escrita ficha
- [ ] **4.6** DTOs `Omit`/`Pick`; slugs em `constants.ts`
- [ ] **4.7** Pastas leaf >4: `session/application/actions` (raiz)

---

## Adiado — polish / ops

Só retomar com pedido explícito.

### Classe / UI

- [ ] Mísseis Mágicos: Escudo/Giga no cast — [`mm-cast-options-modal.md`](mm-cast-options-modal.md)
- [ ] Senhor das Feras: Companheiro Primal na mesa — [`beast-master-primal-companion.md`](beast-master-primal-companion.md)
- [ ] Duração / condições na mesa (Véu Psíquico, Rasgar Mente, Arachnoid, Assassino, …)
- [ ] Paladino: Destruição Protetora (lembrete Cobertura na aura)
- [ ] Pistoleiro: Assumidor de risco; White Hat; Bang; polish câmaras

### Combate / campanha

- [ ] Monstros de catálogo no tracker (hoje: criaturas manuais)
- [ ] Iniciativa PC: fontes além de DEX + Alerta
- [ ] Buffs temporários / reações de CA
- [ ] PV temporários (`tempHp` na mesa + fontes) e cura/pools reativos
- [ ] Fúria / Imprudente / dano situacional de subclasse
- [ ] Estilos e talentos condicionais (GWF, TWF, Charger, PAM, …)
- [ ] Maestria de arma como sistema de combate
- [ ] Vantagem / desvantagem / cobertura no ataque (mesa)

### Treasure / itens

Detalhe: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

- [ ] Cast de item: concentração / componentes / CD override do item
- [ ] Evento `dawn` real ≠ Descanso Longo (MVP: DL ≈ amanhecer)

### Editorial GH (não bloqueia mesa)

- [ ] Cap. 2 features: reduzir EN residual (~166 → meta <30)
- [ ] Cap. 7 magias: overlay PT fino

---

## Como usar

1. Item **feito e testado** → remover daqui (não acumular histórico).
2. Plano filho **concluído** → **apagar** o `.md` e tirar do índice (`docs/README.md`).
3. Plano filho aberto guarda detalhe técnico; este arquivo guarda **prioridade**.
4. Contrato: Swagger `/api`.
