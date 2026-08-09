# Exemplares (API) — quatro classes de referência

Padrão alvo: **table-action**. Guerreiro = legado.

## Feiticeiro (`sorcerer`) — modelo caster

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/sorcerer/` (`features`, `metamagic`) |
| Handler | `session/application/actions/sorcerer-actions.handler.ts` + `actions/sorcerer/` |
| HTTP | `POST …/sorcerer/table-action` |
| Economy/panel | `C009` + `C016_sorcerer_subclass_economy_panel.sql` |

Extras: Fonte de Magia e metamagia no painel; subclasses wild-magic / clockwork / draconic / heroic-sorcery / aberrant.

## Bruxo (`warlock`)

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/warlock/` |
| Handler | `warlock-actions.handler.ts` + `actions/warlock/` |
| HTTP | `POST …/warlock/table-action` |
| Economy/panel | `C009` + `C017` / `C018` (patronos) |

Extras: invocações + pact blade (UI/front); cast mecânico de invocação ainda em dívidas.

## Mago (`wizard`)

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/wizard/` |
| Handler | `wizard-actions.handler.ts` (**ainda monólito** — dívida D2) |
| HTTP | `POST …/wizard/table-action` |
| Economy/panel | `C009` + `C014` (tradições / mísseis) |

## Guerreiro (`fighter`) — legado

| Camada | Path |
|--------|------|
| Domain | `src/game/combat/domain/fighter/` |
| Handler | `fighter-actions.handler.ts` + `actions/fighter/` |
| HTTP | `fighter-session.controller.ts` — rotas dedicadas (`second-wind`, `action-surge`, `psi-action`, manobras…) |
| Panel | UI própria (BM/psi); poucas/nenhuma linha genérica C010 |

**Não** usar como template de classe nova. Migração para table-action = dívida D7.
