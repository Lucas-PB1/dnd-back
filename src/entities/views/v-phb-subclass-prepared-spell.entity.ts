import { ViewColumn, ViewEntity } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_subclass_prepared_spell' })
export class VPhbSubclassPreparedSpell {
  @ViewColumn({ name: 'subclass_slug' })
  subclassSlug!: string;

  @ViewColumn({ name: 'unlock_level' })
  unlockLevel!: number;

  @ViewColumn({ name: 'spell_slug' })
  spellSlug!: string;

  @ViewColumn({ name: 'spell_name' })
  spellName!: string;

  @ViewColumn({ name: 'terrain_slug' })
  terrainSlug!: string | null;

  @ViewColumn({ name: 'terrain_label' })
  terrainLabel!: string | null;
}
