import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_subclass_feature_gate' })
export class PhbSubclassFeatureGate {
  @PrimaryColumn({ name: 'subclass_id', type: 'bigint' })
  subclassId!: string;

  @PrimaryColumn({ name: 'gate_key', type: 'text' })
  gateKey!: string;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;
}
