import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_companion_command' })
export class PhbCompanionCommand {
  @PrimaryColumn({ type: 'text' })
  slug!: string;

  @Column({ name: 'label_pt', type: 'text' })
  labelPt!: string;

  @Column({ name: 'note_kind', type: 'text' })
  noteKind!: 'strike' | 'bonus_action';

  @Column({ name: 'sort_order', type: 'int' })
  sortOrder!: number;
}
