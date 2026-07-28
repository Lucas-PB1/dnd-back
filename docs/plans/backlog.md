# Backlog — o que ainda falta

Único plano ativo do **dnd-api** (+ front). Só itens **não feitos**.  
Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-07-28 — gate Jest coverage ≥80% passando (~92% stmts / ~82% branches)

---

## Estado atual (snapshot)

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / dados | Pronto |
| Campanha + encontro (API + UI) | Pronto |
| HP / CA / ataque / feat options / granted spells (in-scope) | Fechado; gaps P1 abaixo |
| Deploy front / E2E | Pendente |

---

## Checklist — gaps a corrigir

**P0:** nenhum.

### P1 — cobertura PHB / mecânica incompleta

#### Magias concedidas / conjuração
- [ ] Economia: usos sem espaço / 1× por descanso longo
- [ ] Atributo de conjuração de talento/espécie → CD e bônus de ataque mágico
- [ ] Troca do truque de Alto Elfo após Descanso Longo (choice persistida)

#### CA / defesa (efeitos não permanentes)
- [ ] Buffs temporários / reações de CA (`defensive-duelist`, Defesa Gloriosa, magias Escudo/Armadura Arcana, Forma Selvagem, etc.)

#### PV (além do máximo permanente)
- [ ] PV temporários (`tempHp` na mesa + fontes)
- [ ] Cura / recuperação reativa e pools de efeito (ex.: Proteção Arcana)

#### Ataques / combate situacional
- [ ] Fúria / Ataque Imprudente / dano situacional de subclasse
- [ ] Estilos e talentos condicionais: GWF, TWF/Dual, Charger, Polearm Master, Ataque Direcionado, Savage/Piercer/Crusher/Slasher, Sharpshooter
- [ ] Maestria de arma como sistema de combate (além da escolha na ficha)
- [ ] Vantagem / desvantagem / cobertura no cálculo de ataque (mesa)

### P2 — polish / front

- [ ] **Front:** wizard auto-preencher magias de feat/espécie (API já sync no create; falta catálogo no client)
- [ ] **Front:** UI de ataques além do mínimo na aba Ações

### Ops / qualidade

- [ ] Deploy Vercel + E2E browser (Cypress/Playwright) — `dnd-front`
- [ ] E2E Supertest da campanha MVP / encontros — `dnd-api`
- [ ] Mensagens de erro HTTP em PT (user-facing)
- [ ] Monstros de catálogo no tracker (hoje: criaturas manuais)
- [ ] Iniciativa PC: fontes além de DEX + Alerta (quando modeladas)

---

## Ordem sugerida

1. **P1 magias concedidas** (CD/ataque + economia + Alto Elfo)  
2. **P2 front wizard magias** (precisa endpoints de granted ou preview)  
3. Deploy front / E2E  
4. **P1 combate situacional** (lotes)  
5. Ops restantes  

---

## Como usar

1. Remover o item da lista quando **feito e testado** (não deixar `[x]` histórico).  
2. Contrato: Swagger `/api` · `npm run openapi:export`.
