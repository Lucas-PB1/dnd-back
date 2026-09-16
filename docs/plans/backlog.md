# Backlog — o que ainda falta

Único checklist **mesa** do **dnd-api** (+ front). Só itens **abertos** — concluído **sai** daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-16 — saíram do SSOT as áreas já prontas (ficha, GH, NL/Steinhardt, motor, qualidade) e as seções Adiado vazias.

**Combate personagem×alvo** (dano, saves de combate, encontro simulado) **não** vive aqui → [`combat-real-deferred.md`](combat-real-deferred.md).

---

## Snapshot

| Área | Status |
|------|--------|
| Classes mesa PHB (13) | **Ativo** — apply **só ficha** no checklist §B/C; combate → lista combate real |
| Itens DMG mesa | **Ativo** — grants+economy+apply **de ficha** no checklist §H |

---

## Ativo

- [ ] Efeitos + mesa — **categoria** [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · **fonte** [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) · só o que **movimenta ficha/estado** (cura, PV temp., CA, pools, toggles)

---

## Adiado — polish / ops

Só retomar com pedido explícito. **Não** é combate real.

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

### Editorial / residual fino (não bloqueia mesa)

- [ ] GH Cap. 2 features: reduzir EN residual (~166 → meta <30)
- [ ] GH Cap. 7 magias: overlay PT fino
- [ ] GH Cap. 1: sub-escolhas de traço (tipo dano / arma / skill / truque)
- [ ] GH: Skinrider's Trance (estado/actor vinculado)
- [ ] NL: features só texto → Passivas / economy futura (Provocação, Regeneração, …)
- [ ] NL: escolhas secundárias de espécie só narrativas (`choice_kind` se a ficha precisar)
- [ ] NL: Ulfberht dual mastery só em jsonb (limitação de modelo)
- [ ] DTO `actionSlug` enums hardcodados → validar vs catálogo

---

## Feature futura (outra lista)

- [ ] **Combate real** — [`combat-real-deferred.md`](combat-real-deferred.md) (dano/alvo/saves/encontro; **não** priorizar no ciclo mesa)

---

## Como usar

1. Item **feito e testado** → remover daqui (não acumular histórico).
2. Gap exige **alvo/dano/save de combate** → [`combat-real-deferred.md`](combat-real-deferred.md), não aqui.
3. Plano filho **concluído** → **apagar** o `.md` e tirar do índice ([`docs/README.md`](../README.md)).
4. Contrato: Swagger `/api`.
