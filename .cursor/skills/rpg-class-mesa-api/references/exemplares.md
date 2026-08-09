# Exemplares (API) — classes concluídas (critério mesa)

Padrão alvo: **table-action**. Checklist em [`SKILL.md`](../SKILL.md).

**Concluídas** (economia + painel + handler + recursos quando gasta; front alinhado):

| Classe | Slug | Status mesa |
|--------|------|-------------|
| Guerreiro | `fighter` | **Concluída** |
| Feiticeiro | `sorcerer` | **Concluída** |
| Bruxo | `warlock` | **Concluída** |
| Mago | `wizard` | **Concluída** |
| Patrulheiro | `ranger` | **Concluída** |

Polish **adiado** (não reabre “classe done”): ver [`docs/plans/backlog.md`](../../../docs/plans/backlog.md) — MM modal, Companheiro Primal tracker, reuso de invocações.

Invocações / criaturas (nas concluídas) — só nota ou uso hoje; tracker = plano futuro:

| Classe · subclasse | Feature | Mesa hoje |
|--------------------|---------|-----------|
| Mago · Ilusionista | Criaturas Espectrais | `spectral-summon` uso + nota |
| Patrulheiro · Andarilho Feérico | Reforços Feéricos | `fey-reinforcements` uso + nota |
| Patrulheiro · Senhor das Feras | Companheiro Primal | nota; tracker em [`beast-master-primal-companion.md`](../../../docs/plans/beast-master-primal-companion.md) |
| Feiticeiro · Dracônico L18 | Companheiro Dracônico | magia / nota PHB; sem linha C009 dedicada |
| Bruxo · GOO L14 | Criar Servo | modifica Invocar Aberração no cast; sem pool próprio |
| Guerreiro | — | nada equivalente |

---

## Feiticeiro (`sorcerer`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/sorcerer/` (`features`, `metamagic`) |
| Handler | `session/application/actions/sorcerer-actions.handler.ts` + `actions/sorcerer/` |
| HTTP | `POST …/sorcerer/table-action` |
| Economy/panel | `C009` + `C010` |

Extras: Fonte de Magia e metamagia no painel; subclasses wild-magic / clockwork / draconic / heroic-sorcery / aberrant.

## Bruxo (`warlock`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/warlock/` |
| Handler | `warlock-actions.handler.ts` + `actions/warlock/` |
| HTTP | `POST …/warlock/table-action` |
| Economy/panel | `C009` + `C010` |

Extras: invocações (free_cast no painel + aba Magias) + pact blade (UI/front).

## Mago (`wizard`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/wizard/` |
| Handler | `wizard-actions.handler.ts` + `actions/wizard/` |
| HTTP | `POST …/wizard/table-action` |
| Economy/panel | `C009` + `C010` |
| Recursos | `C014_wizard_subclass_resources.sql` |

Polish adiado: modal Escudo/Giga no cast — [`mm-cast-options-modal.md`](../../../docs/plans/mm-cast-options-modal.md).

## Guerreiro (`fighter`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/fighter/` |
| Handler | `fighter-actions.handler.ts` + `actions/fighter/` |
| HTTP | `POST …/fighter/table-action` (+ `GET …/fighter/maneuvers` para lista BM) |
| Economy | `C009` (`second-wind`, `action-surge`, `tactical-mind`, `psi:*`) |
| Panel | `C010` (base + psi); BM/Dungeoneer = UI com seletor |

Manobras BM: `actionSlug: use-maneuver` + `maneuverSlug`. Precaução: `dungeon-precaution` + `spellSlug`.

## Patrulheiro (`ranger`) — **concluída**

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/ranger/` |
| Handler | `ranger-actions.handler.ts` + `actions/ranger/` |
| HTTP | `POST …/ranger/table-action` |
| Economy/panel | `C009` + `C010` |

Pools base (Marca / Incansável / Véu): só **C009 Economia** com `resource_slug` (UI: ± sempre; Usar se `table_action`) — painel não lista `remaining/max`. Subclasses no C010: fey / beast-master / hunter-defense / gloom-dodge; beastborne = UI Aspecto + `feral-howl` + Carnificina no dano (`bestialAspectLevel`).

Polish adiado: tracker Companheiro Primal — [`beast-master-primal-companion.md`](../../../docs/plans/beast-master-primal-companion.md).
