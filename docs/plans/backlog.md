# Backlog — o que ainda falta

Único plano ativo do **dnd-api** (+ front). Só itens **abertos**.  
Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-08-26 (Leviathan + Character Threads MVP)

Padrão de classe jogável (mesa): skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / campanha / encontro | Pronto |
| Classes mesa PHB (critério skills) | Pronto (13 classes) |
| Packs Steinhardt + Northlands (Waves 1–4 + polish create + pente fino) | Pronto |
| Itens DMG mesa (wiring) | Pronto — [`dmg-wiring-status.md`](../source/dmg-wiring-status.md) |
| Combate situacional / monstros / iniciativa extra | **Adiado** |

---

## Ativo

- [ ] **Northlands — Character Threads (fase 2 / mesa):** gatilhos Cursemarked (brackets d20), Fatebound na morte, economy 1/LR dos benefícios. MVP ficha já feito (`T085`/`P039`/`N036` + API + Traços/wizard). Extração: [`northlands-character-threads.md`](northlands-character-threads.md).
- [ ] **Northlands — pente fino residual (opcional):** M6 features só texto; Greater Freyr usos PB/dia — ver [`northlands-audit.md`](northlands-audit.md).

---

## Adiado — polish / ops

Só retomar com pedido explícito.

- [ ] Mísseis Mágicos: Escudo/Giga no cast — [`mm-cast-options-modal.md`](mm-cast-options-modal.md)
- [ ] Senhor das Feras: Companheiro Primal na mesa — [`beast-master-primal-companion.md`](beast-master-primal-companion.md)
- [ ] Duração / condições na mesa (Véu Psíquico, Rasgar Mente, Arachnoid, Assassino, etc.) — hoje gasto/nota / toggles
- [ ] Paladino: Destruição Protetora (lembrete Cobertura na aura)
- [ ] Pistoleiro: Assumidor de risco; White Hat; Bang; polish câmaras
- [ ] Monstros de catálogo no tracker (hoje: criaturas manuais)
- [ ] Iniciativa PC: fontes além de DEX + Alerta (traços / condições)

### Treasure / itens

Detalhe: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).

- [ ] Cast de item: concentração / componentes / CD override do item (gap restante vs Treasure)
- [ ] Evento `dawn` real ≠ Descanso Longo (MVP atual: DL ≈ amanhecer)

### Combate situacional

- [ ] Buffs temporários / reações de CA
- [ ] PV temporários (`tempHp` na mesa + fontes) e cura/pools reativos
- [ ] Fúria / Imprudente / dano situacional de subclasse
- [ ] Estilos e talentos condicionais (GWF, TWF, Charger, PAM, etc.)
- [ ] Maestria de arma como sistema de combate
- [ ] Vantagem / desvantagem / cobertura no ataque (mesa)

---

## Referência rápida (feito)

- Inventário unificado: `POST …/inventory/actions`
- Schema consolidation: [`adr-schema-consolidation.md`](../architecture/adr-schema-consolidation.md)
- Catálogo mecânico: skill `rpg-catalog-model` · `GET /combat-mechanical-catalog`

## Como usar

1. Remover o item quando **feito e testado** (não acumular `[x]` histórico).
2. Contrato: Swagger `/api`.
