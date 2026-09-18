# Backlog — o que ainda falta

Único checklist **mesa** do **dnd-api** (+ front). Só itens **abertos** — concluído **sai** daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-16 — §H Item saiu (charges na ficha, DL ≈ amanhecer, cast de item, poções de cura/heroísmo/saúde).

**Combate / PVE / DB greenfield** **não** vive no Ativo mesa → [`pve-skirmish-index.md`](pve-skirmish-index.md) (fila executável) · lista residual histórica: [`combat-real-deferred.md`](combat-real-deferred.md).

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
| 2 | [ ] DTO `actionSlug` enums vs catálogo | Validação mecânica |
| 3 | [ ] Paladino: Destruição Protetora (lembrete Cobertura na aura) | Lembrete de UI, sem motor novo |
| 4 | [ ] NL: escolhas secundárias de espécie (`choice_kind` se a ficha precisar) | Fino e só se a ficha pedir |
| 5 | [ ] GH Cap. 7 magias: overlay PT fino | Editorial |
| 6 | [ ] NL: features só texto → Passivas / economy (Provocação, Regeneração, …) | Editorial + economy pontual |
| 9 | [ ] GH Cap. 2 features: EN residual (~166 → meta <30) | Volume, não desenho |
| 10 | [ ] Mísseis Mágicos: Escudo/Giga no cast — [`mm-cast-options-modal.md`](mm-cast-options-modal.md) | API + modal, um fluxo |
| 12 | [ ] Cast de item: concentração / componentes / CD overlay | Cruza item + magia |
| 13 | [ ] GH: Skinrider's Trance (estado/actor vinculado) | Actor extra na ficha |

Treasure (mágico, propriedades, maestria) detalhe de regras: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

---

## Feature futura (mais difícil)

**PVE skirmish sem mapa: completo** (DB-0 + PVE-0…10) — índice [`pve-skirmish-index.md`](pve-skirmish-index.md). Residual tipável além do skirmish (Ward pool, PAM cabo, Gunslinger…) e **nunca** justificados ficam em [`combat-real-deferred.md`](combat-real-deferred.md).

| Trilha | Conteúdo |
|--------|----------|
| **DB-0 + PVE-0…10** | ~~feito~~ — combate tipado skirmish/duelo/encontro |
| **LEG** | ~~Limpeza código morto~~ **feito** (LEG-1…5) — [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md) |
| **RES** | ~~Padrão `resolve`~~ **feito** — [`resolve-pattern-backlog.md`](resolve-pattern-backlog.md) (**não** apagar verbo canônico) |
| **LEGAC** | ~~Padrão `legac`/`legacy`~~ **feito** (1…4) — [`legac-pattern-backlog.md`](legac-pattern-backlog.md) |
| **QA** | ~~Quality gate~~ **feito** (QA-1…2; log OKF 2026-09-18) |
| **XP / VTT** | Fora do PVE skirmish — ver Notas abaixo + deferred |

Lista residual / parqueado: [`combat-real-deferred.md`](combat-real-deferred.md).

---

## Notas (não puxar agora)

- [ ] **XP de monstro:** `phb_creature_template` tem ND (`challenge_rating`); **não** há XP de encontro/derrota (coluna, tabela CR→XP nem DTO). `xp_threshold` em `phb_character_level` é só limiar de PC. Quando for: seed + contrato no Catalog, sem calcular no front.

---

## Como usar

1. Faixa Ativo: pegar o **menor # ainda aberto**.
2. Adiado: mesmo critério, **só** com pedido explícito.
3. Item **feito e testado** → remover daqui (não acumular histórico).
4. Gap exige **alvo/dano/save de combate** → pacote em [`pve-skirmish-index.md`](pve-skirmish-index.md) (ou residual em [`combat-real-deferred.md`](combat-real-deferred.md)), não aqui.
5. Código morto / pasta órfã → [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md) (`/legado`), não inventar limpeza ad-hoc no Ativo mesa.
6. “Resolver” / `resolve-*` legado vs canônico → [`resolve-pattern-backlog.md`](resolve-pattern-backlog.md) (não renomear derive saudável).
7. Texto/stub `legacy`/`legado` (não PHB) → trilha [`legac-pattern-backlog.md`](legac-pattern-backlog.md) **fechada**.
8. Trilhas DB/PVE/LEG/RES/LEGAC/QA **fechadas** (2026-09-18); residual combate → [`combat-real-deferred.md`](combat-real-deferred.md).
9. Plano filho **concluído** → **apagar** o `.md` e tirar do índice ([`docs/README.md`](../README.md)).
10. Contrato: Swagger `/api`.
