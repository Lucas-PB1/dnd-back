import { Entity, Column, PrimaryColumn } from 'typeorm';

export type InventoryLocation = 'equipped' | 'backpack';
export type EquipmentSlot =
  | 'armor'
  | 'main_hand'
  | 'off_hand'
  | 'shield'
  | 'worn'
  | 'carried';

/** Slots com no máximo um item; worn/carried permitem vários. */
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

  /** Bruxo · Pacto da Lâmina: arma vinculada (no máximo uma por personagem). */
  @Column({ name: 'is_pact_weapon', type: 'boolean', default: false })
  isPactWeapon!: boolean;

  /** Slug do encanto de arma preso a este item (`weapon-charm-*`). */
  @Column({ name: 'attached_charm_slug', type: 'text', nullable: true })
  attachedCharmSlug!: string | null;
}
