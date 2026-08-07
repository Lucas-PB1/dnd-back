# Backlog — o que ainda falta

Único plano ativo do **dnd-api** (+ front). Só itens **não feitos**.  
Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-07-29 — mecânica por classe em [`class-mechanics.md`](class-mechanics.md)

Mecânica jogável por classe/subclasse → **[`class-mechanics.md`](class-mechanics.md)** (Pistoleiro, Bárbaro, Guerreiro, Ladino, Monge, Paladino, Guardião e Clérigo feitos; 5 PHB pendentes).

---

## Estado atual (snapshot)

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / dados | Pronto |
| Campanha + encontro (API + UI) | Pronto |
| HP / CA / ataque / feat options / granted spells | Pronto (magias concedidas fechado) |
| Deploy front / E2E | Pronto (API campaign e2e + Cypress smoke) |
| UI ataques (aba Ações) + erros HTTP PT | Pronto |
| Combate situacional / monstros / iniciativa extra | **Adiado** |

---

## Checklist — gaps a corrigir

**P0:** nenhum.

### Ativo

*(nenhum — próximos itens só sob pedido)*

### Referência (feito)

- Catálogo mecânico de combate no banco — [`combat-mechanical-catalog.md`](combat-mechanical-catalog.md)

### Adiado — polish / ops

Não priorizar. Só retomar com pedido explícito.

### Referência — modelo de dados (proposta)

Consolidação de schema pós-auditoria (`analise`):  
[`adr-schema-consolidation.md`](../architecture/adr-schema-consolidation.md) ·  
[`schema-equivalence-map.md`](../architecture/schema-equivalence-map.md) ·  
[`schema-consolidation-plan.md`](schema-consolidation-plan.md)  
Status: **Aceito** — consolidação agressiva A→G em andamento (`db:setup`).

- [ ] Monstros de catálogo no tracker (hoje: criaturas manuais)
- [ ] Iniciativa PC: fontes além de DEX + Alerta — **traços** e **condições** (não magias)

### Adiado — combate situacional (ex-P1)

Não priorizar. Só retomar com pedido explícito.

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

---

## Ordem sugerida

1. ~~UI de ataques / erros PT~~ — feito  
2. ~~Resto~~ — adiado (só sob pedido)  

---

## Como usar

1. Remover o item da lista quando **feito e testado** (não deixar `[x]` histórico).  
2. Contrato: Swagger `/api`.
