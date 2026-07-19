# Roadmap — produto e entrega

Documento **vivo** do caminho até app consumidor 100% baseado na API.

| Repo | Papel |
|------|-------|
| **dnd-api** | Postgres PHB + API NestJS + regras de ficha |
| **dnd-front** | Next.js — compêndio, wizard, ficha, mesa |

Relacionados: [`api-plan.md`](api-plan.md) (referência REST) · [`equipment-catalog-plan.md`](equipment-catalog-plan.md) (itens/armas/armaduras) · [`game-advanced-plan.md`](game-advanced-plan.md) (mesa/inventário) · [`../dnd-front/docs/CHARACTER-SHEET-PLAN.md`](../dnd-front/docs/CHARACTER-SHEET-PLAN.md) (ficha front)

**Última revisão:** 2026-07-19

---

## Status geral

| Marco | Progresso | Notas |
|-------|-----------|-------|
| Banco PHB + seeds | **100%** | Local + Supabase (`schema rpg`) |
| API catálogo (P0–P3) | **100%** | Ver [`api-plan.md`](api-plan.md) |
| API infra (Swagger, errors, health) | **100%** | `/api` em dev |
| Auth JWT + RLS | **100%** | JWKS + `P004_player_rls.sql` |
| Game — ficha PHB (API) | **100%** | CRUD + escolhas + `characterFeats` / `featOptions` |
| Game — mesa 7A–7C (API) | **100%** | level-up, inventário, state, cast, rest |
| **dnd-front** — MVP ficha | **~95%** | Wizard PHB, ficha leitura/edição, mesa |
| **dnd-front** — compêndio | **~85%** | + talentos, equipamento; ver [`equipment-catalog-plan.md`](equipment-catalog-plan.md) p/ gaps mecânicos |
| Deploy produção (Fase 6) | **em andamento** | Ver [`DEPLOY.md`](DEPLOY.md) |
| Campanha / combate (7D) | **0%** | Fora do escopo atual |

**Testes automatizados:** API 88 · Front 35 · ambos passando localmente (jul/2026).

---

## Fases concluídas (API)

### Fase 1 — Banco e infra ✅

| Item | Status |
|------|--------|
| Schema `rpg` + migrations | [x] |
| Seeds PHB | [x] |
| Scripts `db:migrate`, `db:seed`, `db:setup` | [x] |

### Fase 2 — API catálogo ✅

Checklist detalhado em [`api-plan.md`](api-plan.md). Todos os módulos P0–P3 implementados.

### Fase 3 — Identity + Game ✅

| Item | Status |
|------|--------|
| `SupabaseAuthGuard` + CRUD `/characters` | [x] |
| Validação slugs + `CharacterSheetValidator` | [x] |
| HP / PB derivados | [x] |
| RLS Supabase | [x] |
| Level-up | [x] |
| `test:cov` ≥ 80% no CI | [ ] |

### Fase 4 — Ficha PHB completa (API) ✅

| Escolha | Campo API |
|---------|-----------|
| Perícias de classe | `classSkillSlugs` |
| Traços de espécie | `speciesChoices` |
| Opções de subclasse | `subclassOptions` |
| Magias | `characterSpells` |
| Talentos | `characterFeats` (+ `featOptions`, `featSlugs` derivado) |
| Equipamento inicial | `equipment` |
| Idiomas | `languageSlugs` |

Ver [`game-advanced-plan.md`](game-advanced-plan.md) para inventário, state e level-up.

---

## Fase 5 — App Next.js (`dnd-front`) — em uso

Plano de bootstrap (stack, ports, env): [`rpg-web-plan.md`](rpg-web-plan.md).  
Detalhe da ficha: [`CHARACTER-SHEET-PLAN.md`](../dnd-front/docs/CHARACTER-SHEET-PLAN.md).

### 5.1 Setup ✅

| Item | Status |
|------|--------|
| Repo `dnd-front` em `dnd-work/` | [x] |
| `NEXT_PUBLIC_API_URL` + Supabase env | [x] |
| Client HTTP (`catalogFetch` / `gameFetch`) | [x] |
| CORS `FRONTEND_URL` na API | [x] |

### 5.2 Auth ✅

| Item | Status |
|------|--------|
| Login / signup Supabase | [x] |
| Session + refresh | [x] |
| `Authorization` nas rotas game | [x] |
| Redirect 401 com `?next=` | [x] |

### 5.3 Compêndio — parcial

| Tela | Status |
|------|--------|
| Classes (lista + detalhe) | [x] |
| Espécies (lista + detalhe) | [x] |
| Antecedentes (lista + detalhe) | [x] |
| Magias (lista + detalhe) | [x] |
| Feats, skills, equipamento (páginas dedicadas) | [ ] |

### 5.4 Fichas ✅

| Tela | Status |
|------|--------|
| Lista minhas fichas | [x] |
| Wizard PHB completo | [x] |
| Ficha leitura estruturada | [x] |
| Edição por seção (PATCH) | [x] |
| DELETE + redirect | [x] |
| Mesa (state, rest, cast, inventário, level-up) | [x] |

### 5.5 Qualidade front — parcial

| Item | Status |
|------|--------|
| Erros API (404, 401) | [x] |
| Loading / empty states | [x] (básico) |
| Nomes PHB em PT (via API) | [x] |
| E2E Cypress / Playwright | [ ] |
| Deploy Vercel | [ ] |

---

## Fase 6 — Deploy produção

Guia: **[`DEPLOY.md`](DEPLOY.md)**

| Item | Status |
|------|--------|
| API na Vercel (`vercel.json`, pooler 6543) | [~] |
| Env prod: `DATABASE_URL`, `SUPABASE_URL`, `FRONTEND_URL` | [ ] |
| Front na Vercel | [ ] |
| RLS ativo em prod | [x] |
| Smoke: health + classes + login | [ ] |

---

## Próximos passos (prioridade sugerida)

| # | Área | O quê | Por quê |
|---|------|-------|---------|
| 1 | **Deploy** | Fase 6 — API + front na Vercel, env prod | Usar fora da máquina local |
| 2 | **CI** | `test:cov` API + lint/test/build front no PR | Regressão automática |
| 3 | **Compêndio** | Páginas `/feats`, `/skills`, armas/armaduras | Completar hub PHB |
| 4 | **Feats PHB** | Seeds de mais talentos com `feat_option_def` | Só 3 feats com opções internas hoje |
| 5 | **Mesa UX** | Picker de condições (`phb_condition`) em vez de texto livre | Consistência com concentração |
| 6 | **Level-up ASI** | Fluxo guiado +2/+1 no level-up (hoje via editar Atributos) | Menos fricção no marco 4/8/12… |
| 7 | **Contrato** | `GET /feats/:slug/options` nos dois `api-endpoints.md` | Documentação alinhada |
| 8 | **Campanha** | Fase 7D — mesas, iniciativa | Novo BC; escopo grande |

---

## Convenções

1. Marcar `[x]` quando **mergeado e testado** (não WIP).
2. Atualizar **Status geral** e **Última revisão** ao fechar marco.
3. Detalhes REST → [`api-plan.md`](api-plan.md). SQL → [`data-model.md`](data-model.md).

---

## Histórico de marcos

| Data | Marco |
|------|-------|
| 2026-07-03 | Catálogo API P0–P3; auth; CRUD fichas; ficha PHB API |
| 2026-07-03 | Game 7A–7C (level-up, inventário, mesa) |
| 2026-07-04 | Front: wizard PHB, ficha edição/leitura, feats com opções, Sprint 9 polish |
| 2026-07-04 | Deploy: `vercel.json`, fix pooler/pnpm, guia [`DEPLOY.md`](DEPLOY.md) |
