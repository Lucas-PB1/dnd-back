import { Entity, Column, PrimaryColumn } from 'typeorm';

export type InventoryLocation = 'equipped' | 'backpack';
export type EquipmentSlot =
  | 'armor'
  | 'main_hand'
  | 'off_hand'
  | 'shield'
  | 'worn'
  | 'carried';

export const EXCLUSIVE_EQUIPMENT_SLOTS: ReadonlySet<EquipmentSlot> = new Set([
  'armor',
  'main_hand',
  'off_hand',
  'shield',
]);

@Entity({ schema: 'rpg', name: 'player_character_item' })
export class PlayerCharacterItem {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'item_slug', type: 'text' })
  itemSlug!: string;

  @Column({ type: 'int', default: 1 })
  quantity!: number;

  @Column({ type: 'text', default: 'backpack' })
  location!: InventoryLocation;

  @Column({ name: 'equipment_slot', type: 'text', nullable: true })
  equipmentSlot!: EquipmentSlot | null;

  @Column({ type: 'boolean', default: false })
  attuned!: boolean;

  @Column({ name: 'is_pact_weapon', type: 'boolean', default: false })
  isPactWeapon!: boolean;

  @Column({ name: 'attached_charm_slug', type: 'text', nullable: true })
  attachedCharmSlug!: string | null;

  @Column({ name: 'attached_coverage_slug', type: 'text', nullable: true })
  attachedCoverageSlug!: string | null;

  @Column({ name: 'attached_coverage_bonus', type: 'smallint', nullable: true })
  attachedCoverageBonus!: number | null;

  @Column({ name: 'attached_coverage_attuned', type: 'boolean', default: false })
  attachedCoverageAttuned!: boolean;

  @Column({ name: 'attached_coverage_spell_slug', type: 'text', nullable: true })
  attachedCoverageSpellSlug!: string | null;

  @Column({ name: 'bound_spell_slug', type: 'text', nullable: true })
  boundSpellSlug!: string | null;

  @Column({ name: 'instance_properties', type: 'jsonb', nullable: true })
  instanceProperties!: Record<string, unknown> | null;

  @Column({ name: 'contained_in_item_slug', type: 'text', nullable: true })
  containedInItemSlug!: string | null;
}
