import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_class_feature_schedule' })
export class PhbClassFeatureSchedule {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'owner_kind', type: 'text' })
  ownerKind!: 'class' | 'subclass';

  @Column({ name: 'class_id', type: 'bigint', nullable: true })
  classId!: string | null;

  @Column({ name: 'subclass_id', type: 'bigint', nullable: true })
  subclassId!: string | null;

  @Column({ name: 'feature_key', type: 'text' })
  featureKey!: string;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;

  @Column({ name: 'value_num', type: 'double precision' })
  valueNum!: number;
}
