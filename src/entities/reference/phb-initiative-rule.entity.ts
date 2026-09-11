import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_initiative_rule' })
export class PhbInitiativeRule {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'owner_kind', type: 'text' })
  ownerKind!: 'class' | 'subclass';

  @Column({ name: 'class_id', type: 'bigint', nullable: true })
  classId!: string | null;

  @Column({ name: 'subclass_id', type: 'bigint', nullable: true })
  subclassId!: string | null;

  @Column({ name: 'unlock_level', type: 'int' })
  unlockLevel!: number;

  @Column({ name: 'rule_kind', type: 'text' })
  ruleKind!: 'ability_bonus' | 'advantage';

  @Column({ name: 'ability_slug', type: 'text', nullable: true })
  abilitySlug!: string | null;

  @Column({ type: 'text' })
  label!: string;
}
