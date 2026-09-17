# Combate real — residual / parqueado

**Não é polish adiado.** Combate tipado (PVE skirmish sem mapa + paridade duelo/encontro) agora tem **fila executável**:

→ **[`pve-skirmish-index.md`](pve-skirmish-index.md)** (DB-0 + PVE-0…10, fatiado)

Este arquivo guarda a **fronteira mesa × combate** e itens ainda parqueados até o pacote correspondente fechar. Ao concluir um pacote do índice, remover o item daqui (ou o pacote some do índice).

SSOT mesa ativo: [`backlog.md`](backlog.md) · [`effect-mesa-checklist.md`](effect-mesa-checklist.md)  
Skill: `rpg-class-mesa-api` (critério mesa ≠ VTT / combate simulado).

Consumidor PvP: [`pvp-1v1-duel.md`](pvp-1v1-duel.md) — reusa o motor do índice (não inventar motor à parte).

**Nota 2026-09-16:** encontro ganhou MVP de **ataque vs CA + dano nos PV** (`POST .../encounters/:id/attacks`). Saves, tabuleiro, manobras no momento do acerto e o restante desta lista continuam futuros.

**Nota 2026-09-08:** o duelo ganhou um **MVP** (ataque com arma vs CA + `applyCurrentHitPoints`, depois PV temp. no pipeline) e **retrato** de PC. Magias tipadas e condições no turno do duelo ainda estão nesta lista / F4 do [`pvp-1v1-duel.md`](pvp-1v1-duel.md). **Mapa/distância/voo ficam fora do x1 por decisão de produto.** **Escuridão mágica** no x1: conjurável como efeito de arena; visão normal e Visão no Escuro **não** atravessam (só exceções tipadas, ex. Visão do Diabo) — ver BEA do duelo.

---

## Fronteira

| Mesa **agora** (apply / toggle ok) | Combate real (**esta lista**) |
|------------------------------------|-------------------------------|
| Gastar recurso / uso | Dano no alvo (PC ou monstro) |
| Cura / PV temp. na ficha | Ataque vs CA / acerto / crítico |
| CA tipada (toggle sticky) | Saves de combate (derrubar, amedrontar…) |
| Slots, concentração, inspiração | Empurrão / grapple / alcance no tabuleiro |
| Nota + declare para o resto | Iniciativa de todos, turnos automatizados |
| | Bloodied gate, 1×/turno no servidor, etc. |

Economy/painel podem **listar** o botão e devolver **nota**; falta de apply de combate **não** reabre “classe done” nem entra no backlog mesa.

---

## Parqueado (quando existir combate)

### Manobras / estilo (dano, save, ataque)

- [x] Battle Master: trip / menacing / pushing no acerto (skirmish PVE-5b) — além de Rally/`tempHp` e notas
- [ ] Parry / redução de dano no momento do acerto
- [x] Estilos no roll: GWF piso 1–2→3, TWF `light_bonus` + ability, Charger +1d8 (feat+melee) — PVE-5c · [`fighting-style-combat.md`](../architecture/fighting-style-combat.md)
- [ ] PAM: ataque do cabo / reação tipada (residual PVE-10a)
- [ ] Gunslinger: manobras `descriptive` que só fazem sentido no ataque/alvo (blindfire, ricochet, fan-the-hammer, …)
- [ ] Atacante Selvagem: enforcement 1×/turno no servidor
- [ ] Front: escolher entre 2 rolagens de dano (`alternateRolls`)

### Metamagia / invocações / cast em combate

- [ ] Metamagia: efeito no cast (não só gastar SP + descrição)
- [ ] Eldritch Smite e invocações cujo efeito é dano/condição no alvo
- [ ] Bloodied gate / craft spawn no fluxo de combate

### Condições / duração / alvo

- [ ] Condições e duração tipadas no alvo (Véu Psíquico, Rasgar Mente, Teia, Veneno, …) além de declare
- [ ] Escuridão mágica (área/arena): fortemente obscurecido; **não** atravessada por visão normal nem Visão no Escuro; exceções tipadas (ex. Visão do Diabo) — no x1 sem mapa = efeito de arena ([`pvp-1v1-duel.md`](pvp-1v1-duel.md))
- [ ] Empurrão / grappled / improvisado (Briguento de Taverna e similares)
- [ ] Attitude NPC tipado (Influenciar) se depender de combate social tipado fino
- [ ] Proteção Arcana: pool própria (≠ PV temp.), recarga por espaço, Proteção Projetada no aliado
- [ ] Centelha Divina / Auxílio da Terra: dano no alvo + save tipados (cura na ficha já é mesa)

### Encontro / atores

- [x] Combate no encontro (acerto/dano). Saves e tracker fino de summon ainda futuros. Board/spawn/tracker leve de combatentes já é mesa.
- [ ] Tracker fino de companheiro / summon em combate (além de nota/uso)

---

## Como usar

1. Achou gap que **exige alvo/dano/save de combate** → pacote em [`pve-skirmish-index.md`](pve-skirmish-index.md); se não couber, anotar **aqui** e criar pacote no índice.
2. Achou gap de **ficha** (cura, temp HP, CA, pool) → checklist mesa / backlog ativo.
3. Não misturar com “Adiado — polish” (UI, modal, editorial).
4. Lobby / match 1v1 → [`pvp-1v1-duel.md`](pvp-1v1-duel.md); combate tipado **espera** o motor do índice (não duplicar no slice `duel`).
5. Schema/migrations greenfield → pasta `database/migrations/` vazia (DB-0 feito; ver `docs/okf/log.md`).
