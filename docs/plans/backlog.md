# Backlog — o que ainda falta

Único plano ativo do **dnd-api**. Só itens **não feitos**.  
Referência: [`docs/architecture/`](../architecture/) · Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-07-27 (encontros P022 no ar)

---

## Estado atual (snapshot)

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / dados | Pronto na API |
| Campanha (membros, links) | Pronto na API |
| Encontro + iniciativa (PCs) | Pronto — `P020`/`P021` |
| Criaturas manuais + visão jogador (PV%) | Pronto — `P022` |
| UI de encontro no front | **Próximo** |
| Catálogo de monstros no tracker | Fora / opcional depois |

**Encontro (API) — contrato resumido**

- Base: `/campaigns/:campaignId/encounters`
- DM: create, creatures, patch settings (`playersCanView`, `creatureHpVisibility`), patch/delete combatant, roll-all, next-turn, close
- PC: roll iniciativa via `combatants/:combatantId` (DEX + Alerta; mesma lógica de `/characters/:id/rolls/initiative`)
- Player: GET só se `playersCanView`; PV de criatura conforme `hidden` \| `percent` \| `exact`

---

## API (`dnd-api`)

### Opcional (baixa prioridade)

- [ ] Mensagens de erro HTTP em PT (user-facing)
- [ ] E2E Supertest da campanha MVP / encontros
- [ ] Threshold de coverage no CI (hoje `test:cov` sem gate ≥80%)
- [ ] Monstros de catálogo no tracker (hoje: criaturas manuais nome/PV/CA)
- [ ] Iniciativa PC: fontes além de DEX + Alerta (itens/traços, se modelados)

---

## Front (`dnd-front`)

### Próximo (alta prioridade)

- [ ] **UI de encontro / iniciativa**
  - [ ] Painel DM: criar/fechar, adicionar criatura, ajustar PV/CA, next turn, roll-all
  - [ ] Toggle `playersCanView` + modo de PV de criatura
  - [ ] Lista ordenada: nome, iniciativa, CA, PV (exato no DM; % no player)
  - [ ] PC: botão “rolar iniciativa” (próprio personagem)
  - [ ] Player: ver encontro ativo só quando DM permitir

### Depois

- [ ] Deploy Vercel + E2E browser (Cypress/Playwright)

---

## Ordem sugerida

1. Front: UI do encontro (DM + visão jogador)
2. Deploy front / E2E
3. Opcionais API (E2E encontros, erros PT, coverage gate)

---

## Como usar

1. Marcar `[x]` só quando **feito e testado**.  
2. Não recolocar itens concluídos na lista principal.  
3. Contrato: Swagger `/api` · `npm run openapi:export`.

### Feito recentemente (não reabrir)

- Apply prod `P019`; ASI / death saves / idiomas / encumbrance / fighting-styles
- Encontro PCs: `P020`/`P021`
- Encontro + criaturas manuais + visão jogador (PV%): `P022` — settings, POST creatures, `combatantId`, enriquecimento PC (PV/CA/nível/talentos/condições)
