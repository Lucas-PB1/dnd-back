# Backlog — o que ainda falta

Único plano ativo do **dnd-api**. Só itens **não feitos**.  
Referência de arquitetura: [`docs/architecture/`](../architecture/) · Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-07-27

---

## API (`dnd-api`)

### Conteúdo / catálogo

- [ ] **Mais `feat_option_def`** — estender seeds para talentos com opções incompletas (`npm run db:audit:feat-options`)

### Game

- [ ] **Carga / encumbrance** ao carregar inventário (peso vs Força) — flag ou 400
- [ ] **Combate / iniciativa / encontro** (7D) — modelo + rotas; campanha MVP já existe em `src/game/campaign/`

### Opcional (baixa prioridade)

- [ ] Mensagens de erro HTTP em PT (user-facing)
- [ ] E2E Supertest da campanha MVP
- [ ] Threshold de coverage no CI (hoje roda `test:cov` sem gate ≥80%)

---

## Front (`dnd-front`)

- [ ] Consumir `GET /fighting-styles` onde fizer sentido
- [ ] Deploy Vercel + E2E browser (Cypress/Playwright)

---

## Ordem sugerida

1. Feat options faltantes  
2. Encumbrance  
3. Fighting styles no front  
4. Combate 7D (épico)  
5. Deploy front / E2E

---

## Como usar

1. Marcar `[x]` só quando **feito e testado**.  
2. Não recolocar itens concluídos neste arquivo.  
3. Detalhe de rotas/Swagger: app em `/api` + `npm run openapi:export`.

### Feito recentemente (não reabrir)

- Apply prod `P019` (death saves / inspiration)
- Front: cotas progression (já existia), ASI no level-up, death saves + inspiration na mesa
- Idiomas concedidos pelo antecedente (`phb_background_language`, `GET /backgrounds/:slug/languages`, validação na ficha)
