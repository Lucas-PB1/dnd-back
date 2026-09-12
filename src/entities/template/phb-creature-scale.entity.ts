import { Column, Entity, PrimaryColumn } from 'typeorm';

/** Escala por nível do personagem (companion BM/Primal). */
@Entity({ schema: 'rpg', name: 'phb_creature_scale_by_level' })
export class PhbCreatureScaleByLevel {
  @PrimaryColumn({ name: 'template_slug', type: 'text' })
  templateSlug!: string;

  @Column({ name: 'hp_base', type: 'int' })
  hpBase!: number;

  @Column({ name: 'hp_per_level', type: 'int' })
  hpPerLevel!: number;

  @Column({ name: 'ac_ability_slug', type: 'text', nullable: true })
  acAbilitySlug!: string | null;
}

/** Escala por círculo do slot (Summon / Find Steed). */
@Entity({ schema: 'rpg', name: 'phb_creature_scale_by_slot' })
export class PhbCreatureScaleBySlot {
  @PrimaryColumn({ name: 'template_slug', type: 'text' })
  templateSlug!: string;

  @Column({ name: 'scale_min_slot', type: 'int' })
  scaleMinSlot!: number;

  @Column({ name: 'ac_base', type: 'int' })
  acBase!: number;

  @Column({ name: 'ac_per_slot', type: 'int' })
  acPerSlot!: number;

  @Column({ name: 'hp_base', type: 'int' })
  hpBase!: number;

  @Column({ name: 'hp_per_slot', type: 'int' })
  hpPerSlot!: number;

  @Column({ name: 'hp_mode', type: 'text' })
  hpMode!: 'per_slot' | 'above_min';
}
