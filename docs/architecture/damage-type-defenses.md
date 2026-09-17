# Resistência / vulnerabilidade / imunidade (PVE-6c)

Tipo de dano × afinidades do alvo antes de aplicar PV / temp HP.

## Domínio

`applyDamageTypeModifiers`: imunidade → 0; só resist → metade; só vuln → dobro; resist+vuln → cancelam.

## Fontes

| Alvo | Defesas |
|------|---------|
| Actor (criatura) | `phb_creature_template_damage_affinity` via `template_slug` |
| PC | piloto: Blood Hound → resist `poison` (paridade duelo) |

Piloto seed: `elemental-do-fogo` imune fogo; `azer-*` resist fogo.

## Wire

`applyCombatantHpDamage({ damage, damageTypeSlug, dataSource })` — skirmish cast passa `combatRow.damageTypeSlug` (ex. Raio de Fogo = `fire`).

Specs: `apply-damage-type-modifiers.spec.ts` · `apply-combatant-hp-damage.spec.ts`.
