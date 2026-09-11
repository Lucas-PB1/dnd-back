import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { PhbEffectCastEconomy } from './phb-effect-cast-economy.entity';
import { PhbEffectCheckAdvantage } from './phb-effect-check-advantage.entity';
import { PhbEffectCombatMod } from './phb-effect-combat-mod.entity';
import { PhbEffectCombatFlag } from './phb-effect-combat-flag.entity';
import { PhbEffectCompanion } from './phb-effect-companion.entity';
import { PhbEffectDamageDie } from './phb-effect-damage-die.entity';
import { PhbEffectDamageType } from './phb-effect-damage-type.entity';
import { PhbEffectEnvironmentalImmunity } from './phb-effect-environmental-immunity.entity';
import { PhbEffectCondition } from './phb-effect-condition.entity';
import { PhbEffectSave } from './phb-effect-save.entity';
import { PhbEffectForcedMovement } from './phb-effect-forced-movement.entity';
import { PhbEffectDice } from './phb-effect-dice.entity';
import { PhbEffectFeat } from './phb-effect-feat.entity';
import { PhbEffectLanguage } from './phb-effect-language.entity';
import { PhbEffectNote } from './phb-effect-note.entity';
import { PhbEffectNumeric } from './phb-effect-numeric.entity';
import { PhbEffectProficiency } from './phb-effect-proficiency.entity';
import { PhbEffectPurchaseDiscount } from './phb-effect-purchase-discount.entity';
import { PhbEffectReach } from './phb-effect-reach.entity';
import { PhbEffectResource } from './phb-effect-resource.entity';
import { PhbEffectRestQuirk } from './phb-effect-rest-quirk.entity';
import { PhbEffectSaveAdvantage } from './phb-effect-save-advantage.entity';
import { PhbEffectSense } from './phb-effect-sense.entity';
import { PhbEffectSpell } from './phb-effect-spell.entity';
import { PhbEffectWeapon } from './phb-effect-weapon.entity';

export type EffectKind =
  | 'grant_spell'
  | 'free_cast'
  | 'grant_resource'
  | 'combat_mod'
  | 'temp_hp'
  | 'heal'
  | 'spend_resource'
  | 'recover_resource'
  | 'recover_resource_to_max'
  | 'toggle_combat_flag'
  | 'sync_companion'
  | 'companion_command'
  | 'table_roll'
  | 'check_boost'
  | 'catalog_maneuver'
  | 'catalog_metamagic'
  | 'convert_spell_points'
  | 'firearm_reload'
  | 'firearm_fire'
  | 'wild_resurgence'
  | 'set_starry_form'
  | 'strike_self_cost'
  | 'set_tracker'
  | 'start_concentration'
  | 'missile_mage_arm'
  | 'resource_fallback_spend'
  | 'moon_combat_wild_shape'
  | 'restore_resource_from_slot'
  | 'bind_pact_weapon'
  | 'psychic_blade_attack'
  | 'table_note'
  | 'initiative_pb'
  | 'grant_inspiration'
  | 'combat_note'
  | 'grant_proficiency'
  | 'purchase_discount'
  | 'damage_reroll_choice'
  | 'damage_die_override'
  | 'check_advantage'
  | 'damage_bonus'
  | 'scaled_damage_dice'
  | 'add_proficiency_bonus'
  | 'death_save_advantage'
  | 'hit_die_roll_twice_keep_high'
  | 'reduce_exhaustion_on_rest'
  | 'grant_expertise'
  | 'grant_language'
  | 'spellcasting_ability'
  | 'grant_spell_by_level'
  | 'damage_resistance_reaction'
  | 'damage_reduce_reaction'
  | 'stabilize_on_death_save'
  | 'grant_magic_item_choice'
  | 'identify_magic_item'
  | 'vehicle_check_advantage'
  | 'advantage_until_consumed'
  | 'extra_melee_attack_on_crit'
  | 'craft_item_on_long_rest'
  | 'choose_ability_for_check'
  | 'initiative_advantage_vs_target'
  | 'increase_ability_score'
  | 'speed_bonus'
  | 'grant_climb_speed'
  | 'grant_swim_speed'
  | 'grant_fly_speed'
  | 'damage_resistance'
  | 'dash_speed_bonus'
  | 'ac_bonus'
  | 'attack_bonus'
  | 'save_bonus'
  | 'spell_attack_bonus'
  | 'spell_save_dc_bonus'
  | 'spell_range_bonus'
  | 'feature_dc'
  | 'light_bonus_ability_mod'
  | 'damage_die_floor'
  | 'damage_die_reroll'
  | 'damage_die_flip'
  | 'damage_die_explode'
  | 'extra_melee_attack'
  | 'succeed_failed_save'
  | 'mounted_attack_advantage'
  | 'ignore_damage_resistance'
  | 'ignore_exhaustion_penalties'
  | 'grant_weapon_mastery'
  | 'grant_weapon_property'
  | 'grant_sense'
  | 'wield_two_handed_one_hand'
  | 'versatile_one_hand_full_damage'
  | 'add_ability_mod_to_check'
  | 'carry_as_larger_size'
  | 'improve_critical'
  | 'override_weapon_range'
  | 'bind_focus_to_weapon'
  | 'expand_spell_list'
  | 'slot_elevate'
  | 'slot_reduce'
  | 'magic_item_save_dc'
  | 'expend_hit_dice'
  | 'recover_spell_slot'
  | 'reduce_target_speed_on_hit'
  | 'inspiration_refund_on_fail'
  | 'grant_all_skill_proficiencies'
  | 'miss_becomes_hit'
  | 'heal_bonus'
  | 'slot_refund_on_die_match'
  | 'survive_at_zero'
  | 'teleport_after_action'
  | 'modify_d20_roll'
  | 'redirect_damage_reaction'
  | 'bonus_action_disengage'
  | 'slow_fall'
  | 'extra_damage_on_nat20'
  | 'heal_from_dice_pool'
  | 'grant_feat'
  | 'save_advantage'
  | 'reroll_d20_on_nat1'
  | 'reach_bonus'
  | 'rest_quirk'
  | 'environmental_immunity'
  | 'speed_set'
  | 'attack_disadvantage'
  | 'apply_condition'
  | 'forced_movement'
  | 'feature_save'
  | 'ability_mod_damage'
  | 'self_damage'
  | 'extra_damage_dice'
  | 'replace_attack_with_save'
  | 'ignore_target_armor'
  | 'add_arena_effect';

export type EffectOwnerKind =
  | 'class'
  | 'subclass'
  | 'species'
  | 'feat'
  | 'item'
  | 'heritage'
  | 'character_thread'
  | 'weapon_mastery';

export type EffectTrigger =
  | 'passive'
  | 'on_build'
  | 'on_table_action'
  | 'on_resource_spend'
  | 'on_cast'
  | 'on_purchase'
  | 'on_damage_roll'
  | 'on_d20_nat1'
  | 'on_bloodied'
  | 'on_rest_short'
  | 'on_rest_long'
  | 'on_death_save'
  | 'on_critical_hit'
  | 'on_hit'
  | 'on_miss'
  | 'on_option_use'
  | 'on_save_fail';

@Entity({ schema: 'rpg', name: 'phb_effect' })
export class PhbEffect {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ type: 'text' })
  kind!: EffectKind;

  @Column({ type: 'text', name: 'owner_kind' })
  ownerKind!: EffectOwnerKind;

  @Column({ type: 'bigint', name: 'owner_id' })
  ownerId!: string;

  @Column({ type: 'text' })
  trigger!: EffectTrigger;

  @Column({ type: 'int', name: 'unlock_level', default: 1 })
  unlockLevel!: number;

  @Column({ type: 'int', name: 'sort_order', default: 0 })
  sortOrder!: number;

  @Column({ type: 'int', name: 'min_trait_takes', default: 1 })
  minTraitTakes!: number;

  @Column({ type: 'text', name: 'action_slug', nullable: true })
  actionSlug!: string | null;

  @Column({ type: 'text', name: 'resource_slug', nullable: true })
  resourceSlug!: string | null;

  @Column({ type: 'text', nullable: true })
  label!: string | null;

  @Column({ type: 'text', name: 'requires_option_key', nullable: true })
  requiresOptionKey!: string | null;

  @Column({ type: 'text', name: 'requires_option_value', nullable: true })
  requiresOptionValue!: string | null;

  @OneToOne(() => PhbEffectSpell, (row) => row.effect, { eager: true })
  spell?: PhbEffectSpell | null;

  @OneToOne(() => PhbEffectCastEconomy, (row) => row.effect, { eager: true })
  castEconomy?: PhbEffectCastEconomy | null;

  @OneToOne(() => PhbEffectNumeric, (row) => row.effect, { eager: true })
  numeric?: PhbEffectNumeric | null;

  @OneToOne(() => PhbEffectNote, (row) => row.effect, { eager: true })
  note?: PhbEffectNote | null;

  @OneToOne(() => PhbEffectResource, (row) => row.effect, { eager: true })
  resource?: PhbEffectResource | null;

  @OneToOne(() => PhbEffectCombatMod, (row) => row.effect, { eager: true })
  combatMod?: PhbEffectCombatMod | null;

  @OneToOne(() => PhbEffectProficiency, (row) => row.effect, { eager: true })
  proficiency?: PhbEffectProficiency | null;

  @OneToOne(() => PhbEffectPurchaseDiscount, (row) => row.effect, {
    eager: true,
  })
  purchaseDiscount?: PhbEffectPurchaseDiscount | null;

  @OneToOne(() => PhbEffectDamageDie, (row) => row.effect, { eager: true })
  damageDie?: PhbEffectDamageDie | null;

  @OneToOne(() => PhbEffectWeapon, (row) => row.effect, { eager: true })
  weapon?: PhbEffectWeapon | null;

  @OneToOne(() => PhbEffectFeat, (row) => row.effect, { eager: true })
  feat?: PhbEffectFeat | null;

  @OneToOne(() => PhbEffectSaveAdvantage, (row) => row.effect, { eager: true })
  saveAdvantage?: PhbEffectSaveAdvantage | null;

  @OneToOne(() => PhbEffectSense, (row) => row.effect, { eager: true })
  sense?: PhbEffectSense | null;

  @OneToOne(() => PhbEffectDamageType, (row) => row.effect, { eager: true })
  damageType?: PhbEffectDamageType | null;

  @OneToOne(() => PhbEffectLanguage, (row) => row.effect, { eager: true })
  language?: PhbEffectLanguage | null;

  @OneToOne(() => PhbEffectCheckAdvantage, (row) => row.effect, {
    eager: true,
  })
  checkAdvantage?: PhbEffectCheckAdvantage | null;

  @OneToOne(() => PhbEffectReach, (row) => row.effect, { eager: true })
  reach?: PhbEffectReach | null;

  @OneToOne(() => PhbEffectRestQuirk, (row) => row.effect, { eager: true })
  restQuirk?: PhbEffectRestQuirk | null;

  @OneToOne(() => PhbEffectEnvironmentalImmunity, (row) => row.effect, {
    eager: true,
  })
  environmentalImmunity?: PhbEffectEnvironmentalImmunity | null;

  @OneToOne(() => PhbEffectCondition, (row) => row.effect, { eager: true })
  condition?: PhbEffectCondition | null;

  @OneToOne(() => PhbEffectSave, (row) => row.effect, { eager: true })
  save?: PhbEffectSave | null;

  @OneToOne(() => PhbEffectForcedMovement, (row) => row.effect, {
    eager: true,
  })
  forcedMovement?: PhbEffectForcedMovement | null;

  @OneToOne(() => PhbEffectDice, (row) => row.effect, { eager: true })
  dice?: PhbEffectDice | null;

  @OneToOne(() => PhbEffectCombatFlag, (row) => row.effect, { eager: true })
  combatFlag?: PhbEffectCombatFlag | null;

  @OneToOne(() => PhbEffectCompanion, (row) => row.effect, { eager: true })
  companion?: PhbEffectCompanion | null;
}
