# Backlog — o que ainda falta

Único checklist ativo do **dnd-api** (+ front). Só itens **abertos** — concluído sai daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-02

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
| Saúde do código | **Fase 2 ✅** — Fase 3 ativa — [`code-health-audit.md`](code-health-audit.md) |
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

#### Fase 2 — Testes + splits críticos → nota **B+**

_Fase concluída (2.1–2.7). Próximo: Fase 3 abaixo._

#### Fase 3 — DB unificado

_Fase concluída (3.0–3.7). Próximo: Fase 4 abaixo._

- [x] **3.4** Validators spells/feats → views/RPC (`feat-option.queries.ts`, `spell-progression.queries.ts`)
- [x] **3.5** Validators class-options/background → `sheet/infrastructure/queries/*`
- [x] **3.6** ADR domain vs `infrastructure/validation/` → [`adr-sheet-validation-layers.md`](../architecture/adr-sheet-validation-layers.md)

#### Fase 4 — Estrutura pré-prod → nota **A−**

- [x] **4.1** Baseline greenfield → [`database/baseline/001_full_schema.sql`](../baseline/001_full_schema.sql) (~5,2k linhas; forward em `database/migrations/`)
- [x] **4.1b Read models — espelho → tabela:** 11 views combat/progression; inventário [`read-model-inventory.md`](read-model-inventory.md); ADR [`adr-read-model-layers.md`](../architecture/adr-read-model-layers.md)
- [x] **4.1c Read models — MV agregados:** 8 MVs (feat, background, species choices, economy, bundles, spell-by-class)
- [x] **4.1d Read models — MV lista fechada runtime:** +9 (slots, granted, CA/PV, boost, heritage choices) → **17 MVs**; [`read-model-inventory.md`](read-model-inventory.md)
- [x] **4.2** Barrel policy — `session/dto/index.ts` removido; imports por família (`dto/core|fighter|martial|table-actions`)
- [x] **4.3** `combat/domain/notes/` — GH + Northlands (`notes/grim-hollow/`, `notes/northlands/`)
- [x] **4.4** Split `inventory/application` — `items|query|attach|purchase|artifact|assert|effects|actions`
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
