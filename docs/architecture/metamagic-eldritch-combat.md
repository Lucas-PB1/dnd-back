# Metamagia e Punição Mística

Efeitos tipados no cast/ataque de combate (não só gastar recurso + nota de mesa).

## Metamagia no cast

| Slug | Efeito | Onde |
|------|--------|------|
| `heightened-spell` | Save do alvo com **desvantagem** | `resolveCombatSpell` (save_damage / apply_condition) |
| `seeking-spell` | Rejogar d20 se o ataque mágico **errar** | `resolveCombatSpell` (spell_attack) |
| `empowered-spell` | Re-rolar até N dados de dano mais baixos (N = mod Carisma, mín. 1) | `resolveCombatSpell` (auto_damage / save_damage / spell_attack) |
| `careful-spell` | Aliados em `carefulExcludeTargetIds` passam no save / sem efeito | `resolveCombatSpell` + DTO cast |

Gasto: `spendCombatMetamagic` → `sorceryPoints` (catálogo `phb_metamagic`).  
DTO: `metamagicSlug` (+ `carefulExcludeTargetIds`) em skirmish/duelo/encontro.

Ainda mesa-only / não tipadas: `quickened`, `twinned`, `distant`, `subtle`, `transmuted`.

## Eldritch Smite

Flag `eldritchSmite` + `smiteSlotLevel`: Bruxo nv.5+ com invocação `eldritch-smite` → `Nd8` Energético, gasta slot de Pacto; nota de derrubar ≤ Enorme.

Wire: `applyWarlockExtras` no pipeline de dano · paridade skirmish/encontro via `CombatAttackFlagsDto`.

Specs: `resolve-combat-spell.spec` · `spend-combat-metamagic.spec` · `eldritch-smite.spec` · `roll-damage.class-rules.spec`.
