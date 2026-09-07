# Backlog — o que ainda falta

Único checklist **mesa** do **dnd-api** (+ front). Só itens **abertos** — concluído **sai** daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-07 — fronteira mesa vs combate real

**Combate personagem×alvo** (dano, saves de combate, encontro simulado) **não** vive aqui → [`combat-real-deferred.md`](combat-real-deferred.md).

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / campanha / encontro (board leve) | Pronto |
| Classes mesa PHB (13) | **Revisão ativa** — §B apply **só ficha** (Rally/Proteção Arcana `tempHp` + curas tipadas); resto de combate → lista combate real |
| Steinhardt + Northlands (Waves 1–4 + Cap. 5 + veículos) | **Revisão ativa** — subclass/thread/espécie NL no checklist |
| Itens DMG mesa | **Revisão ativa** — grants+economy+apply **de ficha** no checklist |
| Grim Hollow Cap. 2 mesa + Cap. 1 heranças | **Revisão ativa** — subclass/heritage no checklist |
| Grim Hollow Cap. 4 talentos | Pronto |
| Grim Hollow Cap. 6 transformações | **§A fechado** (mesa) |
| Saúde do código (Fases 0–4) | **Pronto** — dívida residual em Adiado |
| Motor de efeitos (`phb_effect`) | **Ativo** — [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · apply = ficha; combate real → [`combat-real-deferred.md`](combat-real-deferred.md) |

---

## Ativo

- [ ] Efeitos + mesa — **categoria** [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · **fonte** [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) · só o que **movimenta ficha/estado** (cura, PV temp., CA, pools, toggles)

---

## Adiado — polish / ops

Só retomar com pedido explícito. **Não** é combate real.

### Motor / UI (mesa)

- [ ] Artesão: craft on rest / spawn item (ficha)
- [ ] Transferir inspiração (aliados / mesa)
- [ ] Terrain snow / frio extremo tipado fino (Snowrunner, Cold Plunge) — se for toggle/nota de ficha

### Classe / UI

- [ ] Mísseis Mágicos: Escudo/Giga no cast — [`mm-cast-options-modal.md`](mm-cast-options-modal.md)
- [ ] Senhor das Feras: Companheiro Primal na mesa — [`beast-master-primal-companion.md`](beast-master-primal-companion.md)
- [ ] Paladino: Destruição Protetora (lembrete Cobertura na aura)
- [ ] Pistoleiro: Assumidor de risco; White Hat; Bang; polish câmaras (fora de dano no alvo)

### Treasure / itens

Leva mesa (mágico, propriedades, maestria, economies de ficha) → checklist [`effect-mesa-checklist.md`](effect-mesa-checklist.md) §H.  
Detalhe: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

- [ ] Cast de item: concentração / componentes / CD override do item (mesa)
- [ ] Evento `dawn` real ≠ Descanso Longo (MVP: DL ≈ amanhecer)

### Qualidade (pós Fase 4)

Rules: `dry-quality` · `typescript-quality` · `file-size`. Skills: `audit-code-health` · `split-large-module` · `unify-game-stats`.

_(vazio — hard files >200 e `as never` em specs feitos)_

Scripts essenciais: só DB + smoke + measure — [`scripts/README.md`](../../scripts/README.md).

### Editorial GH (não bloqueia mesa)

- [ ] Cap. 2 features: reduzir EN residual (~166 → meta <30)
- [ ] Cap. 7 magias: overlay PT fino

---

## Feature futura (outra lista)

- [ ] **Combate real** — [`combat-real-deferred.md`](combat-real-deferred.md) (dano/alvo/saves/encontro; **não** priorizar no ciclo mesa)

---

## Como usar

1. Item **feito e testado** → remover daqui (não acumular histórico).
2. Gap exige **alvo/dano/save de combate** → [`combat-real-deferred.md`](combat-real-deferred.md), não aqui.
3. Plano filho **concluído** → **apagar** o `.md` e tirar do índice ([`docs/README.md`](../README.md)).
4. Contrato: Swagger `/api`.
