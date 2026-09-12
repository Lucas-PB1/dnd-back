import { Column, Entity, PrimaryColumn, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_spell_spirit' })
export class PhbSpellSpirit {
  @PrimaryColumn({ name: 'spell_slug', type: 'text' })
  spellSlug!: string;

  @Column({ name: 'actor_kind', type: 'text' })
  actorKind!: 'mount' | 'companion';

  @Column({ name: 'replace_policy', type: 'text', default: 'replace_same_spell' })
  replacePolicy!: 'replace_same_spell';

  @Column({ name: 'fly_speed_min_slot', type: 'int', nullable: true })
  flySpeedMinSlot!: number | null;
}

@Entity({ schema: 'rpg', name: 'phb_spell_spirit_variant' })
export class PhbSpellSpiritVariant {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id!: string;

  @Column({ name: 'spell_slug', type: 'text' })
  spellSlug!: string;

  @Column({ name: 'variant_key', type: 'text' })
  variantKey!: string;

  @Column({ name: 'template_slug', type: 'text' })
  templateSlug!: string;

  @Column({ type: 'text' })
  label!: string;

  /** Orçamento do cast (Animar Objetos: 1/2/3). Summons ficam em 1. */
  @Column({ name: 'budget_cost', type: 'int', default: 1 })
  budgetCost!: number;
}
