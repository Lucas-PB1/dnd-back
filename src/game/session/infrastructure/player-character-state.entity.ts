import { Entity, Column, PrimaryColumn } from 'typeorm';

export type SpellSlotsUsed = Record<string, number>;

@Entity({ schema: 'rpg', name: 'player_character_state' })
export class PlayerCharacterState {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @Column({ name: 'spell_slots_used', type: 'jsonb', default: {} })
  spellSlotsUsed!: SpellSlotsUsed;

  @Column({ name: 'concentrating_on', type: 'text', nullable: true })
  concentratingOn!: string | null;

  @Column({ type: 'text', array: true, default: [] })
  conditions!: string[];

  @Column({ name: 'temp_hp', type: 'int', default: 0 })
  tempHp!: number;
}
