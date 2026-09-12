import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_class_feature_gate' })
export class PhbClassFeatureGate {
  @PrimaryColumn({ name: 'class_id', type: 'bigint' })
  classId!: string;

  @PrimaryColumn({ name: 'gate_key', type: 'text' })
  gateKey!: string;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;
}
