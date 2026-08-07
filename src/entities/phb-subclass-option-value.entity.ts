import { Entity, Column, PrimaryColumn } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from './phb-option.entity';

// Re-export base classes
export { PhbOptionDef, PhbOptionValue };

// Lote C: backward-compatible class aliases that ARE proper classes
// (for TypeORM and type annotations)
@Entity({ schema: 'rpg', name: 'phb_option_def' })
export class PhbSubclassOptionDef extends PhbOptionDef {}

@Entity({ schema: 'rpg', name: 'phb_option_value' })
export class PhbSubclassOptionValue extends PhbOptionValue {}

@Entity({ schema: 'rpg', name: 'phb_subclass' })
export class PhbSubclassRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;

  @Column({ name: 'class_id', type: 'bigint' })
  classId!: string;
}
