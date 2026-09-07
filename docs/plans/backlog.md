# Backlog — o que ainda falta

Único checklist ativo do **dnd-api** (+ front). Só itens **abertos** — concluído **sai** daqui (sem histórico `[x]`).

Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`  
Padrão mesa: skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**

**Última revisão:** 2026-09-05 (checklist efeitos+mesa)

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / campanha / encontro | Pronto |
| Classes mesa PHB (13) | **Revisão ativa** — pool `E009`; economy/apply no checklist §3 |
| Steinhardt + Northlands (Waves 1–4 + Cap. 5 + veículos) | **Revisão ativa** — subclass/thread/espécie NL no checklist |
| Itens DMG mesa | **Revisão ativa** — grants+economy+apply no checklist §8 |
| Grim Hollow Cap. 2 mesa + Cap. 1 heranças | **Revisão ativa** — subclass/heritage no checklist §4·§6 |
| Grim Hollow Cap. 4 talentos | Pronto |
| Grim Hollow Cap. 6 transformações | **§A fechado** — Clemência / Cura Profana / Bestial Vigor / Mutações Aberrantes; revisão residual só se gap de mesa |
| Saúde do código (Fases 0–4) | **Pronto** — dívida residual em Adiado |
| Motor de efeitos (`phb_effect`) | **Ativo** — categoria + fonte + fase DROP — [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) · [`effect-engine.md`](effect-engine.md) |
| Combate situacional / monstros catálogo | **No checklist** §M/§P — [`effect-mesa-checklist.md`](effect-mesa-checklist.md) (não mais “só adiado”) |

---

## Ativo

- [ ] Efeitos + mesa — **categoria** [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · **fonte** [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) · DROP legado + magias espécie (collect/cast_economy) **feitos**; falta revisão mesa — [`effect-engine.md`](effect-engine.md)

---

## Adiado — polish / ops

Só retomar com pedido explícito.

### Motor de efeitos (residual wire / UI)

- [ ] Fase 6 residual UI/cast: bloodied gate, craft spawn
- [ ] Artesão: craft on rest / spawn item
- [ ] Atacante Selvagem: enforcement 1×/turno no servidor
- [ ] Front: UI escolher entre as 2 rolagens de dano (API já devolve `alternateRolls`)
- [ ] Briguento de Taverna: empurrão / grappled / improvisado além do d4
- [ ] Transferir inspiração (aliados / mesa)
- [ ] Attitude NPC (Influenciar Hostil/Indiferente tipado)
- [ ] Terrain snow / frio extremo tipado fino (Snowrunner, Cold Plunge)

### Classe / UI

- [ ] Mísseis Mágicos: Escudo/Giga no cast — [`mm-cast-options-modal.md`](mm-cast-options-modal.md)
- [ ] Senhor das Feras: Companheiro Primal na mesa — [`beast-master-primal-companion.md`](beast-master-primal-companion.md)
- [ ] Duração / condições na mesa (Véu Psíquico, Rasgar Mente, Arachnoid, Assassino, …)
- [ ] Paladino: Destruição Protetora (lembrete Cobertura na aura)
- [ ] Pistoleiro: Assumidor de risco; White Hat; Bang; polish câmaras

### Combate / campanha

- [ ] Estilos e talentos condicionais (GWF piso 3 no DTO, TWF gate, Charger, PAM, …) — seeds FS em `database/seeds/effects/` (`E001`/`E003`/`E004`)

### Treasure / itens

Leva completa (mágico, propriedades, maestria, economies) → checklist **§8** [`effect-mesa-checklist.md`](effect-mesa-checklist.md). Detalhe regras: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

Residual fino (se sobrar depois da leva):

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
