import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_spell' })
export class VPhbSpell {
  @ViewColumn({ name: 'slug' })
  slug!: string;

  @ViewColumn({ name: 'name' })
  name!: string;

  @ViewColumn({ name: 'level' })
  level!: number;

  @ViewColumn({ name: 'level_label' })
  levelLabel!: string;

  @ViewColumn({ name: 'school_slug' })
  schoolSlug!: string;

  @ViewColumn({ name: 'school_name' })
  schoolName!: string;

  @ViewColumn({ name: 'casting_time' })
  castingTime!: string;

  @ViewColumn({ name: 'range' })
  range!: string;

  @ViewColumn({ name: 'has_verbal' })
  hasVerbal!: boolean;

  @ViewColumn({ name: 'has_somatic' })
  hasSomatic!: boolean;

  @ViewColumn({ name: 'has_material' })
  hasMaterial!: boolean;

  @ViewColumn({ name: 'material_description' })
  materialDescription!: string | null;

  @ViewColumn({ name: 'components_label' })
  componentsLabel!: string | null;

  @ViewColumn({ name: 'duration' })
  duration!: string;

  @ViewColumn({ name: 'concentration' })
  concentration!: boolean;

  @ViewColumn({ name: 'ritual' })
  ritual!: boolean;

  @ViewColumn({ name: 'description' })
  description!: string;

  @ViewColumn({ name: 'higher_levels' })
  higherLevels!: string | null;

  @ViewColumn({ name: 'source_chapter' })
  sourceChapter!: number | null;

  @ViewColumn({ name: 'edition_slug' })
  editionSlug!: string | null;
}
