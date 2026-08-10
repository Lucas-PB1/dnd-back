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

  /** Slug da cobertura DMG presa a esta peça base (`kind=coverage`). */
  @Column({ name: 'attached_coverage_slug', type: 'text', nullable: true })
  attachedCoverageSlug!: string | null;

  /** Tier +1/+2/+3 quando a cobertura é `*-1-2-ou-3`. */
  @Column({ name: 'attached_coverage_bonus', type: 'smallint', nullable: true })
  attachedCoverageBonus!: number | null;

  /** Sintonia da cobertura anexada (conta no limite de 3). */
  @Column({ name: 'attached_coverage_attuned', type: 'boolean', default: false })
  attachedCoverageAttuned!: boolean;

  /** Magia vinculada (Arma Magificada / Enspelled). */
  @Column({ name: 'attached_coverage_spell_slug', type: 'text', nullable: true })
  attachedCoverageSpellSlug!: string | null;

  /** Magia vinculada em item único (ex.: Cajado Magificado). */
  @Column({ name: 'bound_spell_slug', type: 'text', nullable: true })
  boundSpellSlug!: string | null;
}
