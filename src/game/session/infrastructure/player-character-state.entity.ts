import { Entity, Column, PrimaryColumn } from 'typeorm';
import {
  readFeature,
  writeFeature,
  type StoredCharacterFeatureState,
} from '../domain/character-feature-state';

export type SpellSlotsUsed = Record<string, number>;
export type ResourcesUsed = Record<string, number>;
export type GrantedSpellUses = Record<string, number>;

@Entity({ schema: 'rpg', name: 'player_character_state' })
export class PlayerCharacterState {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ name: 'spell_slots_used', type: 'jsonb', default: {} })
  spellSlotsUsed!: SpellSlotsUsed;

  @Column({ name: 'resources_used', type: 'jsonb', default: {} })
  resourcesUsed!: ResourcesUsed;

  @Column({ name: 'granted_spell_uses', type: 'jsonb', default: {} })
  grantedSpellUses!: GrantedSpellUses;

  @Column({ name: 'concentrating_on', type: 'text', nullable: true })
  concentratingOn!: string | null;

  @Column({ type: 'text', array: true, default: [] })
  conditions!: string[];

  @Column({ name: 'temp_hp', type: 'int', default: 0 })
  tempHp!: number;

  @Column({ name: 'hit_dice_current', type: 'int', default: 0 })
  hitDiceCurrent!: number;

  @Column({ name: 'death_save_successes', type: 'int', default: 0 })
  deathSaveSuccesses!: number;

  @Column({ name: 'death_save_failures', type: 'int', default: 0 })
  deathSaveFailures!: number;

  @Column({ type: 'boolean', default: false })
  inspiration!: boolean;

  @Column({ name: 'wild_shape_actor_id', type: 'uuid', nullable: true })
  wildShapeActorId!: string | null;

  @Column({ name: 'boarded_actor_id', type: 'uuid', nullable: true })
  boardedActorId!: string | null;

  @Column({ name: 'skinrider_actor_id', type: 'uuid', nullable: true })
  skinriderActorId!: string | null;

  @Column({ name: 'mesa_circumstances', type: 'text', array: true, default: [] })
  mesaCircumstances!: string[];

  /** Sparse per-feature state; use the typed accessors below instead of reading it directly. */
  @Column({ name: 'feature_state', type: 'jsonb', default: {} })
  featureState!: StoredCharacterFeatureState;

  get highElfCantripSwapAvailable(): boolean {
    return readFeature(this.featureState, 'highElfCantripSwapAvailable');
  }
  set highElfCantripSwapAvailable(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'highElfCantripSwapAvailable', v);
  }

  get firearmChambers(): Record<string, number> {
    return readFeature(this.featureState, 'firearmChambers');
  }
  set firearmChambers(v: Record<string, number>) {
    this.featureState = writeFeature(this.featureState, 'firearmChambers', v);
  }

  get rageActive(): boolean {
    return readFeature(this.featureState, 'rageActive');
  }
  set rageActive(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'rageActive', v);
  }

  get recklessActive(): boolean {
    return readFeature(this.featureState, 'recklessActive');
  }
  set recklessActive(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'recklessActive', v);
  }

  get sacredWeaponActive(): boolean {
    return readFeature(this.featureState, 'sacredWeaponActive');
  }
  set sacredWeaponActive(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'sacredWeaponActive', v);
  }

  get personaMasks(): string[] {
    return readFeature(this.featureState, 'personaMasks');
  }
  set personaMasks(v: string[]) {
    this.featureState = writeFeature(this.featureState, 'personaMasks', v);
  }

  get bestialAspectLevel(): number {
    return readFeature(this.featureState, 'bestialAspectLevel');
  }
  set bestialAspectLevel(v: number) {
    this.featureState = writeFeature(this.featureState, 'bestialAspectLevel', v);
  }

  get missileShieldArmed(): boolean {
    return readFeature(this.featureState, 'missileShieldArmed');
  }
  set missileShieldArmed(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'missileShieldArmed', v);
  }

  get gigaMissileArmed(): boolean {
    return readFeature(this.featureState, 'gigaMissileArmed');
  }
  set gigaMissileArmed(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'gigaMissileArmed', v);
  }

  get starryFormActive(): boolean {
    return readFeature(this.featureState, 'starryFormActive');
  }
  set starryFormActive(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'starryFormActive', v);
  }

  get stellarConstellation(): string | null {
    return readFeature(this.featureState, 'stellarConstellation');
  }
  set stellarConstellation(v: string | null) {
    this.featureState = writeFeature(this.featureState, 'stellarConstellation', v);
  }

  get wildShapeActive(): boolean {
    return readFeature(this.featureState, 'wildShapeActive');
  }
  set wildShapeActive(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'wildShapeActive', v);
  }

  get wildShapeTemplateSlug(): string | null {
    return readFeature(this.featureState, 'wildShapeTemplateSlug');
  }
  set wildShapeTemplateSlug(v: string | null) {
    this.featureState = writeFeature(this.featureState, 'wildShapeTemplateSlug', v);
  }

  get wildShapeKnownSlugs(): string[] {
    return readFeature(this.featureState, 'wildShapeKnownSlugs');
  }
  set wildShapeKnownSlugs(v: string[]) {
    this.featureState = writeFeature(this.featureState, 'wildShapeKnownSlugs', v);
  }

  get wildShapeFormSwapAvailable(): boolean {
    return readFeature(this.featureState, 'wildShapeFormSwapAvailable');
  }
  set wildShapeFormSwapAvailable(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'wildShapeFormSwapAvailable', v);
  }

  get aberrantMutationActive(): string | null {
    return readFeature(this.featureState, 'aberrantMutationActive');
  }
  set aberrantMutationActive(v: string | null) {
    this.featureState = writeFeature(this.featureState, 'aberrantMutationActive', v);
  }

  get skinriderTranceActive(): boolean {
    return readFeature(this.featureState, 'skinriderTranceActive');
  }
  set skinriderTranceActive(v: boolean) {
    this.featureState = writeFeature(this.featureState, 'skinriderTranceActive', v);
  }
}
