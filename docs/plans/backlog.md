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
| Grim Hollow Cap. 6 transformações | Pronto — economy tipada API + front mesa |
| Saúde do código (Fases 0–4) | **Pronto** — dívida residual em Adiado |
| Combate situacional / monstros catálogo | **Adiado** |

---

## Ativo

_(vazio)_

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

- [ ] Estilos e talentos condicionais (GWF, TWF, Charger, PAM, …)

### Treasure / itens

Detalhe: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

- [ ] Cast de item: concentração / componentes / CD override do item
- [ ] Evento `dawn` real ≠ Descanso Longo (MVP: DL ≈ amanhecer)

### Qualidade (pós Fase 4)

Rules: `dry-quality` · `typescript-quality` · `file-size`. Skills: `audit-code-health` · `split-large-module` · `unify-game-stats`.

_(vazio — hard files >200 e `as never` em specs feitos)_

Scripts essenciais: só DB + smoke + measure — [`scripts/README.md`](../../scripts/README.md).  
Mocks em specs: `asDep` / `asHandlerDep` / `asRollDep` — `@common/testing/as-dep`.

### Editorial GH (não bloqueia mesa)

- [ ] Cap. 2 features: reduzir EN residual (~166 → meta <30)
- [ ] Cap. 7 magias: overlay PT fino

---

## Como usar

1. Item **feito e testado** → remover daqui (não acumular histórico).
2. Plano filho **concluído** → **apagar** o `.md` e tirar do índice ([`docs/README.md`](../README.md)).
3. Plano filho aberto guarda detalhe técnico; este arquivo guarda **prioridade**.
4. Contrato: Swagger `/api`.
