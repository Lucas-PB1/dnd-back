# Magia em combate (`phb_spell_combat`)

Tabela tipada para resolução de magias em skirmish / duelo / encontro (sem hardcode por slug).

| Camada | Onde |
|--------|------|
| Schema | `database/schema/020_tables/0167_phb_spell_combat.sql` |
| Seeds | `pilot` · `cantrips` · `level-1` · `level-2-3` · `conditions` · `level-4-6` · `level-7-9` · `gaps-backfill` |
| Auditoria | [`spell-combat-audit.md`](spell-combat-audit.md) |
| Concentração | `resolve-concentration-check.ts` — CD `max(10, dano/2)`; wire em `applyCombatantHpDamage` / duelo |
| Domain | `src/game/combat/domain/resolve-combat-spell.ts` |
| Load | `LoadSpellCombat` (`src/game/combat/application/load-spell-combat.ts`) |

## `resolution`

| Kind | Efeito |
|------|--------|
| `auto_damage` | Dano automático (ex.: Mísseis Mágicos; unidades × slot) |
| `spell_attack` | Ataque mágico vs CA (`cantrip_scale` / `dice_count_*` + `spell_level`; `per_die_attack` = N ataques) |
| `save_damage` | Save vs CD; `save_success_outcome` = `none` \| `half` \| `full` |
| `heal_combatant` | Cura o conjurador (`include_spellcasting_mod` soma o mod de conjuração) |
| `arena_darkness` | Escuridão na arena (skirmish + duelo); visão via Devil’s Sight |
| `apply_condition` | Save vs CD; em falha aplica `condition_slug` no alvo (ex.: Paralisar Pessoa) |

Ausência de row → `slot_only` (nota). Utilitários sem combate tipado ficam assim de propósito.

Arena: `rpg.skirmish.arena_effects` / `arena_effect_source_character_id` espelham o duelo; quebra de concentração em Escuridão limpa a arena.

Expansão: pacotes PVE no [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md).

Relacionado: [`effect-engine-read-path.md`](effect-engine-read-path.md) · ADR effects (combate de magia usa tabela própria).
