import { Entity, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';
import { PhbSpellRef } from './phb-spell-ref.entity';
import { PhbSubclassRef } from './phb-subclass-ref.entity';

@Entity({ schema: 'rpg', name: 'phb_subclass_precaution_spell' })
export class PhbSubclassPrecautionSpell {
  @PrimaryColumn({ name: 'subclass_id', type: 'bigint' })
  subclassId!: string;

  @PrimaryColumn({ name: 'spell_id', type: 'bigint' })
  spellId!: string;

  @ManyToOne(() => PhbSubclassRef, { nullable: false })
  @JoinColumn({ name: 'subclass_id' })
  subclass!: PhbSubclassRef;

  @ManyToOne(() => PhbSpellRef, { nullable: false })
  @JoinColumn({ name: 'spell_id' })
  spell!: PhbSpellRef;
}
