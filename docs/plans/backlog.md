# Backlog — o que ainda falta

Único plano ativo do **dnd-api** (+ front). Só itens **não feitos**.  
Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-08-09

Padrão de classe jogável (mesa): skills **`rpg-class-mesa-api`** (dnd-api) · **`rpg-class-mesa-front`** (dnd-front).

---

## Estado atual (snapshot)

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / dados | Pronto |
| Campanha + encontro (API + UI) | Pronto |
| HP / CA / ataque / feat options / granted spells | Pronto |
| Deploy front / E2E | Pronto |
| UI ataques (aba Ações) + erros HTTP PT | Pronto |
| Classes mesa **concluídas** | Guerreiro · Feiticeiro · Bruxo · Mago · Patrulheiro · Ladino · Paladino · Pistoleiro (skills `rpg-class-mesa-*` / exemplares) |
| Demais classes PHB / Valdas | Seguir skills mesa sob pedido |
| Combate situacional / monstros / iniciativa extra | **Adiado** |

---

## Checklist — gaps a corrigir

**P0:** nenhum.

### Ativo

*(nenhum — próximos itens só sob pedido)*

### Referência (feito)

- Catálogo mecânico de combate no banco — skill `rpg-catalog-model` · `GET /combat-mechanical-catalog`
- Padrão classe mesa — skills `rpg-class-mesa-api` / `rpg-class-mesa-front`
- Classes **concluídas** (critério mesa): Guerreiro, Feiticeiro, Bruxo, Mago, Patrulheiro, Ladino, Paladino, Pistoleiro — ver `references/exemplares.md` nas skills
- Invocações do Bruxo: catálogo + seleção + free_cast no painel/aba Magias

### Adiado — polish / ops

Não priorizar. Só retomar com pedido explícito.

- [ ] Mísseis Mágicos: escolhas Escudo/Giga no cast (modal) — [`mm-cast-options-modal.md`](mm-cast-options-modal.md)
- [ ] Senhor das Feras: Companheiro Primal (invocar, PV, comandar na mesa) — [`beast-master-primal-companion.md`](beast-master-primal-companion.md)
- [ ] Duração / condições na mesa (família combate situacional): Invisível do Véu Psíquico, Atordoado do Rasgar Mente, Correia/Teia (Arachnoid), venenos do Assassino — hoje gasto/listagem + nota / toggles (sem tracker)
- [ ] Paladino: Defesa Gloriosa (Usar L15 dedicado no pool `glorious-defense`) — hoje ± + descrição; Destruição Protetora é lembrete (Cobertura na aura ao Destruir)
- [ ] Pistoleiro: Assumidor de risco (d6 grátis); condições White Hat; Bang cast; polish câmaras/firearms

### Referência — modelo de dados

Consolidação de schema:  
[`adr-schema-consolidation.md`](../architecture/adr-schema-consolidation.md) ·  
[`schema-equivalence-map.md`](../architecture/schema-equivalence-map.md)  
Status: **Concluído** — ver ADR DoD.

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

## Como usar

1. Remover o item da lista quando **feito e testado** (não deixar `[x]` histórico).  
2. Contrato: Swagger `/api`.
