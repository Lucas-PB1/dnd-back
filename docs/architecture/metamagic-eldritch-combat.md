# Metamagia e Punição Mística (PVE-6a)

Efeitos tipados no cast/ataque de combate (não só gastar recurso + nota de mesa).

## Metamagia no cast

| Slug | Efeito | Onde |
|------|--------|------|
| `heightened-spell` | Save do alvo com **desvantagem** | `resolveCombatSpell` (save_damage / apply_condition) |
| `seeking-spell` | Rejogar d20 se o ataque mágico **errar** | `resolveCombatSpell` (spell_attack) |

Gasto: `spendCombatMetamagic` → `sorceryPoints` (catálogo `phb_metamagic`).  
DTO: `metamagicSlug` em skirmish/duelo cast.

Outras metamagias (Acelerada, Potencializada, …) ficam mesa/`catalog_metamagic` até tipar.

## Eldritch Smite

Flag `eldritchSmite` + `smiteSlotLevel`: Bruxo nv.5+ com invocação `eldritch-smite` → `Nd8` Energético, gasta slot de Pacto; nota de derrubar ≤ Enorme.

Wire: `applyWarlockExtras` no pipeline de dano · paridade skirmish/encontro via `CombatAttackFlagsDto`.

Specs: `resolve-combat-spell.spec` · `spend-combat-metamagic.spec` · `eldritch-smite.spec` · `roll-damage.class-rules.spec`.
