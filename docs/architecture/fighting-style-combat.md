# Estilos de combate no roll (PVE-5c)

Enforcement no path skirmish → `rollDamage` / `computeWeaponAttacks`.

| Estilo / talento | Comportamento | Onde |
|------------------|---------------|------|
| **GWF** (`great-weapon-fighting`) | Faces 1–2 → 3 em dados de dano C/C 2H/versátil | `deriveAttackExtras` → `greatWeaponFighting` → `treatOnesAndTwosAsThree` |
| **TWF** (`two-weapon-fighting`) | Mod de atributo no ataque `light_bonus` / off-hand | `resolveDamageBonuses` + effect `light_bonus_ability_mod` |
| **Charger** (`charger` + `chargerStrike`) | +1d8; exige feat + `mode: melee` | `executeRollDamage` |
| **PAM** | Cabo tipado **defer**; reação espacial = **nunca** no skirmish sem mapa | PVE-10a · [`skirmish-residuals-pve-10a.md`](skirmish-residuals-pve-10a.md) |

Effects de estilo carregados com `featSlugs ∪ fightingStyleSlugs` em `findEquippedWeaponAttack` (paridade ficha).

Specs: `fighting-style-enforcement.spec.ts` · `weapon-attack.spec.ts` (TWF/GWF) · `roll-damage.spec.ts` (Charger).
