import { Column, Entity, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_creature_template_damage_affinity' })
export class PhbCreatureTemplateDamageAffinity {
  @PrimaryColumn({ name: 'template_slug', type: 'text' })
  templateSlug!: string;

  @PrimaryColumn({ name: 'damage_type_slug', type: 'text' })
  damageTypeSlug!: string;

  @PrimaryColumn({ type: 'text' })
  kind!: 'resistance' | 'vulnerability' | 'immunity';
}
