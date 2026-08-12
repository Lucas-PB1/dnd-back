# Backlog — o que ainda falta

Único plano ativo do **dnd-api** (+ front). Só itens **abertos**.  
Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-08-12 (limpeza docs)

Padrão de classe jogável (mesa): skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

---

## Snapshot

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / campanha / encontro | Pronto |
| Classes mesa PHB (critério skills) | Pronto (13 classes) |
| Packs Steinhardt + Northlands (Waves 1–4 + polish create) | Pronto |
| Itens DMG mesa (wiring) | Pronto — [`dmg-wiring-status.md`](../source/dmg-wiring-status.md) |
| Combate situacional / monstros / iniciativa extra | **Adiado** |

---

## Ativo

- [ ] **Northlands — Character Threads:** Bloodsworn, Cursemarked, Explorer, Fatebound, Herald, Legend Hunter, Sworn Huskarl — sistema novo. Extração: [`northlands-character-threads.md`](northlands-character-threads.md). Sem schema/API/UI.
- [ ] **Northlands — Cap. 5 (Magic and Miscellany):** magias/itens (HTML não estava no scrape); Healing Spirit do Spirit Caller se entrar no catálogo.

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
