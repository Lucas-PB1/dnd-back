# Paridade superfícies de combate (PVE-8)

Skirmish, duelo e encontro usam o **mesmo** motor `resolveCombatSpell` + `phb_spell_combat` (não “só 2 magias”).

## Cast

| Superfície | Endpoint | Notas |
|------------|----------|--------|
| Skirmish | `POST /skirmishes/:id/cast` | Arena + spirits na iniciativa |
| Duelo | `POST /duels/:id/cast` | Arena; alvo = oponente |
| Encontro | `POST /campaigns/:cid/encounters/:eid/cast` | Alvo explícito; sem arena tipada (`arena_darkness` → nota) |

DTO compartilhado de spend: `pickCombatSurfaceCastCommand` (slot / `itemCast*` / `spiritVariantKey` / metamagia).

## Ataque

`CombatAttackFlagsDto` + `pickCombatAttackCommand` em skirmish e encontro (PVE-5a). Duelo tem flags próprias alinhadas ao mesmo roll.

## Magias tipadas

Catálogo em `phb_spell_combat` (~100+ PHB ofensivas/cura) — ver [`spell-combat.md`](spell-combat.md) e [`spell-combat-audit.md`](spell-combat-audit.md). Ausência de row → `slot_only`.

Specs: `campaign-encounter-cast.service.spec.ts`.
