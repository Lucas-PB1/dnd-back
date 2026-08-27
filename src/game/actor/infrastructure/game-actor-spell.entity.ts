import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

export type InnateSpellUsage = 'at_will' | 'per_day' | 'recharge' | 'slot';

@Entity({ schema: 'rpg', name: 'game_actor_spell' })
export class GameActorSpell {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'actor_id', type: 'uuid' })
  actorId!: string;

  @Column({ name: 'spell_slug', type: 'text' })
  spellSlug!: string;

  @Column({ name: 'usage_kind', type: 'text' })
  usageKind!: InnateSpellUsage;

  @Column({ name: 'uses_per_day', type: 'int', nullable: true })
  usesPerDay!: number | null;

  @Column({ name: 'slot_level', type: 'int', nullable: true })
  slotLevel!: number | null;

  @Column({ name: 'recharge_dice', type: 'text', nullable: true })
  rechargeDice!: string | null;

  @Column({ name: 'sort_order', type: 'int', default: 0 })
  sortOrder!: number;
}
