import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_feature_gate' })
export class PhbFeatureGate {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'owner_kind', type: 'text' })
  ownerKind!: 'class' | 'subclass';

  @Column({ name: 'class_id', type: 'bigint', nullable: true })
  classId!: string | null;

  @Column({ name: 'subclass_id', type: 'bigint', nullable: true })
  subclassId!: string | null;

  @Column({ name: 'gate_key', type: 'text' })
  gateKey!: string;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;
}
