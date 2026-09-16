# Backlog — o que ainda falta

Único checklist **mesa** do **dnd-api** (+ front). Só itens **abertos** — concluído **sai** daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-16 — §H Item saiu (charges na ficha, DL ≈ amanhecer, cast de item, poções de cura/heroísmo/saúde).

**Combate personagem×alvo** (dano, saves de combate, encontro simulado) **não** vive aqui → [`combat-real-deferred.md`](combat-real-deferred.md).

Detalhe por categoria: [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · por livro: [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md).

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha PC (donos A–P) | **Fechado** no apply de mesa; Adiado = polish |

A ordem abaixo é por **custo**, não por importância. Pegue o próximo da faixa Ativo; Adiado só com pedido explícito.

---

## Ativo (fácil → difícil)

Nada nesta faixa. Próximo trabalho de mesa = Adiado **só com pedido explícito**, ou combate real na lista futura.

Economies slug a slug e efeito sem apply de ficha fecham **no PR do §**, não como fila extra.

---

## Adiado — polish (fácil → difícil)

Só retomar com pedido explícito. **Não** é combate real.

| # | Item | Por quê nesta posição |
|---|------|------------------------|
| 1 | [ ] NL: Ulfberht dual mastery só em jsonb | Limitação de modelo; quase só documentar |
| 2 | [ ] DTO `actionSlug` enums vs catálogo | Validação mecânica |
| 3 | [ ] Paladino: Destruição Protetora (lembrete Cobertura na aura) | Lembrete de UI, sem motor novo |
| 4 | [ ] NL: escolhas secundárias de espécie (`choice_kind` se a ficha precisar) | Fino e só se a ficha pedir |
| 5 | [ ] GH Cap. 7 magias: overlay PT fino | Editorial |
| 6 | [ ] NL: features só texto → Passivas / economy (Provocação, Regeneração, …) | Editorial + economy pontual |
| 7 | [ ] GH Cap. 1: sub-escolhas de traço (tipo dano / arma / skill / truque) | Wizard de criação, várias chaves |
| 8 | [ ] Pistoleiro: Assumidor de risco; White Hat; Bang; polish câmaras | Vários poderes; fora de dano no alvo |
| 9 | [ ] GH Cap. 2 features: EN residual (~166 → meta <30) | Volume, não desenho |
| 10 | [ ] Mísseis Mágicos: Escudo/Giga no cast — [`mm-cast-options-modal.md`](mm-cast-options-modal.md) | API + modal, um fluxo |
| 11 | [ ] Evento `dawn` real ≠ Descanso Longo (MVP: DL ≈ amanhecer) | Relógio de mesa novo |
| 12 | [ ] Cast de item: concentração / componentes / CD overlay | Cruza item + magia |
| 13 | [ ] GH: Skinrider's Trance (estado/actor vinculado) | Actor extra na ficha |
| 14 | [ ] Senhor das Feras: Companheiro Primal na mesa — [`beast-master-primal-companion.md`](beast-master-primal-companion.md) | Estado persistido + painel + §K |

Treasure (mágico, propriedades, maestria) detalhe de regras: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

---

## Feature futura (mais difícil)

- [ ] **Combate real** — [`combat-real-deferred.md`](combat-real-deferred.md) (dano/alvo/saves/encontro; **não** priorizar no ciclo mesa)

---

## Como usar

1. Faixa Ativo: pegar o **menor # ainda aberto**.
2. Adiado: mesmo critério, **só** com pedido explícito.
3. Item **feito e testado** → remover daqui (não acumular histórico).
4. Gap exige **alvo/dano/save de combate** → [`combat-real-deferred.md`](combat-real-deferred.md), não aqui.
5. Plano filho **concluído** → **apagar** o `.md` e tirar do índice ([`docs/README.md`](../README.md)).
6. Contrato: Swagger `/api`.
