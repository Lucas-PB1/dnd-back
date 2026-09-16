# Mapeamento: stat block → schema de catálogo

Documento de referência para import do projetinho de monstros/navios.  
Runtime: `game_actor*` · Catálogo: `phb_creature_template*` / `phb_vehicle_template*`.

## Criatura (`phb_creature_template`)

| Campo no stat block (MM / JSON) | Coluna catálogo | Runtime (`game_actor`) |
|--------------------------------|-----------------|------------------------|
| Nome | `name` | `name` |
| Tamanho | `size_slug` | `size_slug` |
| Tipo / subtipo | `creature_type`, `creature_subtype` | — (notas opcionais) |
| ND / PB | `challenge_rating`, `proficiency_bonus` | `proficiency_bonus` |
| CA | `armor_class` | `armor_class` |
| PV (média / dados) | `hit_points_avg`, `hit_points_formula` | `hit_points_max` / `hit_points_current` |
| Deslocamentos | `phb_creature_template_speed` | `game_actor_speed` |
| Ilustração | `image_url` | herdado do template (`imageUrl` na API) |
| FOR–CAR | — (catálogo opcional) | `ability_scores` JSONB |
| CD magia / ataque magia | `spell_save_dc`, `spell_attack_bonus` | idem |
| Atributo conjuração | `spellcasting_ability_slug` → `phb_ability` | idem |
| Ações / ataques | `phb_creature_template_action` | `game_actor_action` |
| Magias inatas | `phb_creature_template_spell` | `game_actor_spell` |
| Traços | `phb_creature_template_trait` | `notes` ou futuro |
| Habitat / treasure / grupo (listas MM) | `phb_creature_template_list_tag` (`kind` + `value`) | — |
| Conversão stat block 2014→2024 | `phb_creature_stat_block_conversion` | — |

### Escala opcional (binding — fora da identidade)

| Binding | Tabela | Runtime |
|---------|--------|---------|
| Nível do personagem | `phb_creature_scale_by_level` | sync companion |
| Círculo do slot | `phb_creature_scale_by_slot` | sync spirit no cast |

Ver OKF [creature-template-scale-control.md](../okf/creature-template-scale-control.md).

### Magia inata

| Texto no bloco | `usage_kind` | Colunas extras |
|----------------|--------------|----------------|
| At will / à vontade | `at_will` | — |
| 1/day, 3/day | `per_day` | `uses_per_day` |
| Recharge 5–6 | `recharge` | `recharge_dice` |
| Slot 3rd (3/day) | `slot` | `slot_level`, `uses_per_day` |

**Sem** `player_character_feat` nem `list_type` known/prepared.

## Veículo (`phb_vehicle_template`)

| Campo | Catálogo | Runtime (`game_actor` / state) |
|-------|----------|--------------------------------|
| Nome | `name` | `name` |
| CA / PV / limiar | `armor_class`, `hit_points`, `damage_threshold` | `armor_class`, `hit_points_*`, `damage_threshold` |
| Tripulação / carga | `crew_capacity`, `cargo_capacity_lb` | teto no actor; `game_actor_state.crew_current` / `cargo_current_lb` |
| Passageiros | `passenger_capacity` | `game_actor_state.passenger_current` |
| Deslocamentos (sail/row) | `phb_vehicle_template_speed` | `game_actor_speed` |
| Armas | `phb_vehicle_template_action` | `game_actor_action` (combate naval fora da mesa) |

Seeds: `database/seeds/creatures/` — criaturas (M001+), veículos PHB (M002), montarias PHB (M005, fonte: `phb-cap6-mounts-extract.json`).
