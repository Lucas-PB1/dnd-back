import { Entity, PrimaryColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_character_level' })
export class PhbCharacterLevel {
  @PrimaryColumn()
  level!: number;

  @Column({ name: 'proficiency_bonus' })
  proficiencyBonus!: number;

  @Column({ name: 'xp_threshold', type: 'int', nullable: true })
  xpThreshold!: number | null;
}
