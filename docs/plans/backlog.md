# Backlog — o que ainda falta

Único checklist ativo do **dnd-api** (+ front). Só itens **abertos** — concluído **sai** daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-02

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / campanha / encontro | Pronto |
| Classes mesa PHB (13) | Pronto |
| Steinhardt + Northlands (Waves 1–4 + Cap. 5 + veículos) | Pronto — residual opcional em [`northlands-audit.md`](northlands-audit.md) |
| Itens DMG mesa | Pronto — [`dmg-wiring-status.md`](../source/dmg-wiring-status.md) |
| Grim Hollow Cap. 2 mesa + Cap. 1 heranças | Pronto — residual adiado em [`grim-hollow-mesa-audit.md`](grim-hollow-mesa-audit.md) |
| Grim Hollow Cap. 4 talentos | Pronto |
| Grim Hollow Cap. 6 transformações | Catálogo + ficha read prontos; **J060 + edit + mesa** abertos — [`grim-hollow-cap6-transformations.md`](grim-hollow-cap6-transformations.md) |
| Saúde do código (Fases 0–4) | **Pronto** — dívida residual em Adiado |
| Combate situacional / monstros catálogo | **Adiado** |

---

## Ativo

### Grim Hollow

- [ ] **Cap. 6 transformações:** J060 (`option_def` + validator) + UI edit + mesa. Persistência + UI read feitos — [`grim-hollow-cap6-transformations.md`](grim-hollow-cap6-transformations.md).

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

### Qualidade (pós Fase 4)

Rules: `dry-quality` · `typescript-quality` · `file-size`. Skills: `audit-code-health` · `split-large-module` · `unify-game-stats`.

- [ ] Specs: reduzir `as never` (harness tipado)
- [ ] Arquivos hard >200 linhas (ex.: `eldritch-invocations`, `CatalogLookupService`)
- [ ] `level-up.service.ts` — SQL cru → `infrastructure/queries`
- [ ] Scripts `_*.mjs` órfãos → archive ou apagar + `scripts/README.md`

### Editorial GH (não bloqueia mesa)

- [ ] Cap. 2 features: reduzir EN residual (~166 → meta <30)
- [ ] Cap. 7 magias: overlay PT fino

---

## Como usar

1. Item **feito e testado** → remover daqui (não acumular histórico).
2. Plano filho **concluído** → **apagar** o `.md` e tirar do índice ([`docs/README.md`](../README.md)).
3. Plano filho aberto guarda detalhe técnico; este arquivo guarda **prioridade**.
4. Contrato: Swagger `/api`.
