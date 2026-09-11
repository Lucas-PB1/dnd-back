import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';
import { PhbClassRef } from './phb-class-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_class_progression' })
export class PhbClassProgression {
  @PrimaryColumn({ name: 'class_id', type: 'bigint' })
  classId!: string;

  @PrimaryColumn({ type: 'int' })
  level!: number;

  @ManyToOne(() => PhbClassRef, { nullable: false })
  @JoinColumn({ name: 'class_id' })
  klass!: PhbClassRef;

  @Column({ name: 'proficiency_bonus', type: 'int' })
  proficiencyBonus!: number;

  @Column({ type: 'int', nullable: true })
  cantrips!: number | null;

  @Column({ name: 'prepared_spells', type: 'int', nullable: true })
  preparedSpells!: number | null;

  @Column({ name: 'channel_divinity', type: 'int', nullable: true })
  channelDivinity!: number | null;

  @Column({ name: 'weapon_mastery', type: 'int', nullable: true })
  weaponMastery!: number | null;

  @Column({ name: 'asi_or_feat', type: 'boolean', default: false })
  asiOrFeat!: boolean;
}
