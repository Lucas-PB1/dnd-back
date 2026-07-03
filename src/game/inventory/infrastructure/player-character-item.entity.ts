import { Entity, Column, PrimaryColumn } from 'typeorm';

export type InventoryLocation = 'equipped' | 'backpack';
export type EquipmentSlot = 'armor' | 'main_hand' | 'off_hand' | 'shield';

@Entity({ schema: 'rpg', name: 'player_character_item' })
export class PlayerCharacterItem {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'item_slug' })
  itemSlug!: string;

  @Column({ type: 'int', default: 1 })
  quantity!: number;

  @Column({ default: 'backpack' })
  location!: InventoryLocation;

  @Column({ name: 'equipment_slot', type: 'text', nullable: true })
  equipmentSlot!: EquipmentSlot | null;
}
