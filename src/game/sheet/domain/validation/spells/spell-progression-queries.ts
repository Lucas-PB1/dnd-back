import { DataSource } from 'typeorm';
import { maxSpellLevelFromSlots } from '@game/spellcasting/domain/max-spell-level';

export type SubclassSpellcastingInfo = {
  spellListClassSlug: string;
  spellcastingMode: 'prepared' | 'known' | 'wizard';
};

export type SpellProgressionLimits = {
  cantripsMax: number | null;
  preparedOrKnownMax: number | null;
};

export async function loadSubclassSpellcasting(
  dataSource: DataSource,
  subclassSlug: string | null,
): Promise<SubclassSpellcastingInfo | null> {
  if (!subclassSlug) return null;
  const rows = await dataSource.query<{ spell_list_class_slug: string }[]>(
    `SELECT list_c.slug AS spell_list_class_slug
     FROM rpg.phb_subclass_spellcasting ssc
     JOIN rpg.phb_subclass sc ON sc.id = ssc.subclass_id
     JOIN rpg.phb_class list_c ON list_c.id = ssc.spell_list_class_id
     WHERE sc.slug = $1
     LIMIT 1`,
    [subclassSlug],
  );
  const row = rows[0];
  if (!row) return null;
  return {
    spellListClassSlug: row.spell_list_class_slug,
    spellcastingMode: 'prepared',
  };
}

export async function maxSpellLevelForCharacter(
  dataSource: DataSource,
  classSlug: string,
  level: number,
  subclassSlug: string | null,
): Promise<number> {
  if (subclassSlug) {
    const subclassRows = await dataSource.query<
      { spell_slots: Record<string, number> | null }[]
    >(
      `SELECT spell_slots
       FROM rpg.v_subclass_spell_slots
       WHERE subclass_slug = $1 AND class_level = $2
       LIMIT 1`,
      [subclassSlug, level],
    );
    if (subclassRows[0]?.spell_slots) {
      return maxSpellLevelFromSlots(subclassRows[0].spell_slots);
    }
  }
  return maxSpellLevelForClass(dataSource, classSlug, level);
}

async function maxSpellLevelForClass(
  dataSource: DataSource,
  classSlug: string,
  level: number,
): Promise<number> {
  const rows = await dataSource.query<
    { spell_slots: Record<string, number> | null }[]
  >(
    `SELECT spell_slots
     FROM rpg.v_class_spell_slots
     WHERE class_slug = $1 AND class_level = $2
     LIMIT 1`,
    [classSlug, level],
  );
  return maxSpellLevelFromSlots(rows[0]?.spell_slots);
}

export async function loadSpellProgressionLimits(
  dataSource: DataSource,
  ctx: { classSlug: string; subclassSlug: string | null; level: number },
  subclassCasting: SubclassSpellcastingInfo | null,
): Promise<SpellProgressionLimits | null> {
  if (subclassCasting) {
    const subclassProg = await dataSource.query<
      { cantrips: number | null; prepared_spells: number | null }[]
    >(
      `SELECT sp.cantrips, sp.prepared_spells
       FROM rpg.phb_subclass_progression sp
       JOIN rpg.phb_subclass sc ON sc.id = sp.subclass_id
       WHERE sc.slug = $1 AND sp.level = $2
       LIMIT 1`,
      [ctx.subclassSlug, ctx.level],
    );
    const row = subclassProg[0];
    if (!row) return null;
    return {
      cantripsMax: row.cantrips,
      preparedOrKnownMax: row.prepared_spells,
    };
  }

  const progression = await dataSource.query<
    { cantrips: number | null; prepared_spells: number | null }[]
  >(
    `SELECT cantrips, prepared_spells
     FROM rpg.v_phb_class_progression
     WHERE class_slug = $1 AND level = $2
     LIMIT 1`,
    [ctx.classSlug, ctx.level],
  );
  const row = progression[0];
  if (!row) return null;
  return {
    cantripsMax: row.cantrips,
    preparedOrKnownMax: row.prepared_spells,
  };
}
