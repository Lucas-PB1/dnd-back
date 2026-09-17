# Magia em combate (`phb_spell_combat`)

Tabela tipada para resolução de magias em skirmish / duelo / encontro (sem hardcode por slug).

| Camada | Onde |
|--------|------|
| Schema | `database/schema/020_tables/0167_phb_spell_combat.sql` |
| Seeds | `pilot` · `cantrips` · `level-1` · `level-2-3` · `level-4-6` · `level-7-9` · `gaps-backfill` |
| Auditoria | [`spell-combat-audit.md`](spell-combat-audit.md) |
| Domain | `src/game/combat/domain/resolve-combat-spell.ts` |
| Load | `LoadSpellCombat` (`src/game/combat/application/load-spell-combat.ts`) |

## `resolution`

| Kind | Efeito |
|------|--------|
| `auto_damage` | Dano automático (ex.: Mísseis Mágicos; unidades × slot) |
| `spell_attack` | Ataque mágico vs CA (`cantrip_scale` / `dice_count_*` + `spell_level`; `per_die_attack` = N ataques) |
| `save_damage` | Save vs CD; `save_success_outcome` = `none` \| `half` \| `full` |
| `heal_combatant` | Cura o conjurador (`include_spellcasting_mod` soma o mod de conjuração) |
| `arena_darkness` | Escuridão na arena (duelo) |

Ausência de row → `slot_only` (nota). Utilitários sem combate tipado ficam assim de propósito.

Expansão: pacotes PVE-1* / PVE-2* no [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md).

Relacionado: [`effect-engine-read-path.md`](effect-engine-read-path.md) · ADR effects (combate de magia usa tabela própria).
