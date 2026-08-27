import { Column, Entity, PrimaryColumn, UpdateDateColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'game_actor_state' })
export class GameActorState {
  @PrimaryColumn({ name: 'actor_id', type: 'uuid' })
  actorId!: string;

  @Column({ type: 'text', array: true, default: '{}' })
  conditions!: string[];

  @Column({ name: 'temp_hp', type: 'int', default: 0 })
  tempHp!: number;

  @Column({ name: 'concentrating_on', type: 'text', nullable: true })
  concentratingOn!: string | null;

  @Column({ name: 'innate_spell_uses', type: 'jsonb', default: {} })
  innateSpellUses!: Record<string, number>;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt!: Date;
}
