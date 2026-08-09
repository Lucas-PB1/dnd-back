# Exemplares (API) — quatro classes de referência

Padrão alvo: **table-action**. Guerreiro = legado.

## Feiticeiro (`sorcerer`) — modelo caster

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/sorcerer/` (`features`, `metamagic`) |
| Handler | `session/application/actions/sorcerer-actions.handler.ts` + `actions/sorcerer/` |
| HTTP | `POST …/sorcerer/table-action` |
| Economy/panel | `C009` + `C010` |

Extras: Fonte de Magia e metamagia no painel; subclasses wild-magic / clockwork / draconic / heroic-sorcery / aberrant.

## Bruxo (`warlock`)

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/warlock/` |
| Handler | `warlock-actions.handler.ts` + `actions/warlock/` |
| HTTP | `POST …/warlock/table-action` |
| Economy/panel | `C009` + `C010` |

Extras: invocações (free_cast no painel + aba Magias) + pact blade (UI/front).

## Mago (`wizard`)

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/wizard/` |
| Handler | `wizard-actions.handler.ts` + `actions/wizard/` |
| HTTP | `POST …/wizard/table-action` |
| Economy/panel | `C009` + `C010` |
| Recursos | `C014_wizard_subclass_resources.sql` |

## Guerreiro (`fighter`)

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/fighter/` |
| Handler | `fighter-actions.handler.ts` + `actions/fighter/` |
| HTTP | `POST …/fighter/table-action` (+ `GET …/fighter/maneuvers` para lista BM) |
| Economy | `C009` (`second-wind`, `action-surge`, `tactical-mind`, `psi:*`) |
| Panel | `C010` (base + psi); BM/Dungeoneer = UI com seletor |

Manobras BM: `actionSlug: use-maneuver` + `maneuverSlug`. Precaução: `dungeon-precaution` + `spellSlug`.
