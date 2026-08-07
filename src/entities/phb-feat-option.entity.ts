import { Entity, Column, PrimaryColumn } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from './phb-option.entity';

// Re-export base classes
export { PhbOptionDef, PhbOptionValue };

// Lote C: backward-compatible class aliases that ARE proper classes
// (for TypeORM and type annotations)
@Entity({ schema: 'rpg', name: 'phb_option_def' })
export class PhbFeatOptionDef extends PhbOptionDef {}

@Entity({ schema: 'rpg', name: 'phb_option_value' })
export class PhbFeatOptionValue extends PhbOptionValue {}

@Entity({ schema: 'rpg', name: 'phb_feat' })
export class PhbFeatRef {
  @PrimaryColumn({ type: 'bigint' })
  id!: string;

  @Column({ unique: true })
  slug!: string;
}
