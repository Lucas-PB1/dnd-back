# Residuais de combate no skirmish (PVE-10a)

Itens fechados nesta fatia + vereditos de produto para o restante.

## Fechado

| Item | Comportamento |
|------|----------------|
| **Second Wind / Action Surge** | `POST /skirmishes/:id/table-actions` → `applyDeclaredEconomyTableAction`. AS soma `turnAttacksRemaining` via budget tipado. Endpoints `/second-wind` e `/action-surge` removidos. |
| **Atacante Selvagem** | Flag `pc_savage_attacker_used` no skirmish; 1×/turno; exige efeito `damage_reroll_choice`; reset no início do turno do PC. |
| **Parry** | `defenderReaction: 'parry'` no end-turn; gasta Dado de Superioridade; reduz dano em `dado + max(FOR,DES)`. |

## Nunca / defer

| Item | Veredito | Motivo |
|------|----------|--------|
| PAM reativo | **nunca** (skirmish sem mapa) | Gate “entra no alcance” exige board; economy note permanece |
| PAM cabo | **defer** | Bonus attack d4 tipado cabe; fora desta fatia |
| Ward pool + Projected | **defer** (L) | Schema state + absorb order + reação em aliado |
| Centelha / Auxílio da Terra no alvo | **defer** | Mesa ok; tipar alvo = mini-motor feature-save |
| Gunslinger descriptive | **defer** | Lote L; tipar subconjunto miss-reroll depois |
| Bloodied gate | **defer** | Hook pós-HP; craft spawn = **nunca** em combate (rest/downtime) |

Specs: `resolve-incoming-hit.spec.ts` · `resolve-parry-reduction.spec.ts` · `skirmish-table-action-budget.spec.ts`.
