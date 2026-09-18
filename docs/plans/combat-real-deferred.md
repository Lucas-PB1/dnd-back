# Combate real — residual / parqueado

**PVE skirmish sem mapa (índice 0–10): fechado.** Itens abaixo são **além** do produto skirmish (mapa/VTT, pools próprias, manobras finas) ou **nunca** justificado — não reabrem “classe done” nem o backlog mesa.

→ Índice: [`pve-skirmish-index.md`](pve-skirmish-index.md) (**fechado**)

Este arquivo guarda a **fronteira mesa × combate** e itens ainda parqueados até o pacote correspondente fechar. Ao concluir um pacote do índice, remover o item daqui (ou o pacote some do índice).

SSOT mesa ativo: [`backlog.md`](backlog.md) · [`effect-mesa-checklist.md`](effect-mesa-checklist.md)  
Skill: `rpg-class-mesa-api` (critério mesa ≠ VTT / combate simulado).

Consumidor PvP: [`pvp-1v1-duel.md`](pvp-1v1-duel.md) — reusa o motor do índice (não inventar motor à parte).

**Nota 2026-09-18 (PVE-8):** encontro ganhou `POST .../encounters/:id/cast` via `resolveCombatSpell` (paridade skirmish/duelo). Doc [`surface-combat-parity.md`](../architecture/surface-combat-parity.md).

**Nota 2026-09-16:** encontro ganhou MVP de **ataque vs CA + dano nos PV** (`POST .../encounters/:id/attacks`). Tabuleiro fino e o restante desta lista continuam futuros.

**Nota 2026-09-08:** o duelo ganhou um **MVP** (ataque com arma vs CA + `applyCurrentHitPoints`, depois PV temp. no pipeline) e **retrato** de PC. Magias tipadas no duelo = motor compartilhado (`phb_spell_combat`), não subset de 2–3 slugs — ver [`pvp-1v1-duel.md`](pvp-1v1-duel.md). **Mapa/distância/voo ficam fora do x1 por decisão de produto.** **Escuridão mágica** no x1: conjurável como efeito de arena; visão normal e Visão no Escuro **não** atravessam (só exceções tipadas, ex. Visão do Diabo) — ver BEA do duelo.

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
- [x] Parry / redução de dano no momento do acerto (skirmish PVE-10a · `defenderReaction: parry`)
- [x] Estilos no roll: GWF piso 1–2→3, TWF `light_bonus` + ability, Charger +1d8 (feat+melee) — PVE-5c · [`fighting-style-combat.md`](../architecture/fighting-style-combat.md)
- [ ] PAM: ataque do cabo tipado (defer); reação “entra no alcance” = **nunca** no skirmish sem mapa (PVE-10a)
- [ ] Gunslinger: manobras `descriptive` que só fazem sentido no ataque/alvo (blindfire, ricochet, fan-the-hammer, …) — defer PVE-10a
- [x] Atacante Selvagem: enforcement 1×/turno no servidor (skirmish PVE-10a)
- [ ] Front: escolher entre 2 rolagens de dano (`alternateRolls`)

### Metamagia / invocações / cast em combate

- [x] Metamagia tipada no cast: heightened (save desvantagem) + seeking (reroll ataque) — PVE-6a · [`metamagic-eldritch-combat.md`](../architecture/metamagic-eldritch-combat.md)
- [ ] Demais metamagias (quickened, empowered, careful, …) no cast
- [x] Eldritch Smite no acerto com arma — PVE-6a
- [ ] Outras invocações cujo efeito é dano/condição no alvo (ex. Lifedrinker tipado fino)
- [ ] Bloodied gate no fluxo de combate (defer); craft spawn = **nunca** em combate (rest/downtime) — PVE-10a

### Condições / duração / alvo

- [ ] Condições e duração tipadas no alvo (Véu Psíquico, Rasgar Mente, Teia, Veneno, …) além de declare
- [x] Escuridão mágica (área/arena): fortemente obscurecido; **não** atravessada por visão normal nem Visão no Escuro; exceções tipadas (ex. Visão do Diabo) — skirmish/duelo PVE-3b; encontro sem arena (nota no cast PVE-8)
- [ ] Empurrão / grappled / improvisado (Briguento de Taverna e similares)
- [ ] Attitude NPC tipado (Influenciar) se depender de combate social tipado fino
- [ ] Proteção Arcana: pool própria (≠ PV temp.), recarga por espaço, Proteção Projetada no aliado — defer (L)
- [ ] Centelha Divina / Auxílio da Terra: dano no alvo + save tipados (cura na ficha já é mesa) — defer

### Encontro / atores

- [x] Combate no encontro (acerto/dano). Saves e tracker fino de summon ainda futuros. Board/spawn/tracker leve de combatentes já é mesa.
- [x] Tracker fino de companheiro / summon em combate (skirmish PVE-7a: iniciativa + turno + despawn) — [`spirits-skirmish-initiative.md`](../architecture/spirits-skirmish-initiative.md)
- [x] Arma Espiritual + Conjure 1-actor no skirmish (PVE-7b) — [`spiritual-conjure-skirmish.md`](../architecture/spiritual-conjure-skirmish.md)
- [x] Cast tipado no encontro + docs paridade (PVE-8) — [`surface-combat-parity.md`](../architecture/surface-combat-parity.md)
- [x] Skirmish Second Wind / Action Surge via `POST …/table-actions` (economy; PVE-10a) — [`skirmish-residuals-pve-10a.md`](../architecture/skirmish-residuals-pve-10a.md)
- [ ] Board/spawn fino no encontro de campanha (além do skirmish)

---

## Como usar

1. Achou gap que **exige alvo/dano/save de combate** → pacote em [`pve-skirmish-index.md`](pve-skirmish-index.md); se não couber, anotar **aqui** e criar pacote no índice.
2. Achou gap de **ficha** (cura, temp HP, CA, pool) → checklist mesa / backlog ativo.
3. Não misturar com “Adiado — polish” (UI, modal, editorial).
4. Lobby / match 1v1 → [`pvp-1v1-duel.md`](pvp-1v1-duel.md); combate tipado **espera** o motor do índice (não duplicar no slice `duel`).
5. Schema/migrations greenfield → pasta `database/migrations/` vazia (DB-0 feito; ver `docs/okf/log.md`).
