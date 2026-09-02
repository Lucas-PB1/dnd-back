import { DataSource } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VPhbClassProgression } from '@entities/views/v-phb-class-progression.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { maxSpellLevelFromSlots } from '@game/spellcasting/domain/max-spell-level';

export type SubclassSpellcastingInfo = {
  spellListClassSlug: string;
  spellcastingMode: 'prepared' | 'known' | 'wizard';
};

export type SpellProgressionLimits = {
  cantripsMax: number | null;
  preparedOrKnownMax: number | null;
};

async function loadSubclassSpellSlotsRow(
  dataSource: DataSource,
  subclassSlug: string,
  classLevel: number,
): Promise<VSubclassSpellSlots | null> {
  return dataSource.getRepository(VSubclassSpellSlots).findOne({
    where: { subclassSlug, classLevel },
  });
}

export async function loadSubclassSpellcasting(
  dataSource: DataSource,
  subclassSlug: string | null,
): Promise<SubclassSpellcastingInfo | null> {
  if (!subclassSlug) return null;
  const row = await dataSource.getRepository(VSubclassSpellSlots).findOne({
    where: { subclassSlug },
    select: ['spellListClassSlug'],
  });
  if (!row) return null;
  return {
    spellListClassSlug: row.spellListClassSlug,
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
    const subclassRow = await loadSubclassSpellSlotsRow(
      dataSource,
      subclassSlug,
      level,
    );
    if (subclassRow?.spellSlots) {
      return maxSpellLevelFromSlots(subclassRow.spellSlots);
    }
  }
  const classRow = await dataSource.getRepository(VClassSpellSlots).findOne({
    where: { classSlug, classLevel: level },
    select: ['spellSlots'],
  });
  return maxSpellLevelFromSlots(classRow?.spellSlots);
}

export async function loadSpellProgressionLimits(
  dataSource: DataSource,
  ctx: { classSlug: string; subclassSlug: string | null; level: number },
  subclassCasting: SubclassSpellcastingInfo | null,
): Promise<SpellProgressionLimits | null> {
  if (subclassCasting && ctx.subclassSlug) {
    const row = await loadSubclassSpellSlotsRow(
      dataSource,
      ctx.subclassSlug,
      ctx.level,
    );
    if (!row) return null;
    return {
      cantripsMax: row.cantrips,
      preparedOrKnownMax: row.preparedSpells,
    };
  }

  const row = await dataSource.getRepository(VPhbClassProgression).findOne({
    where: { classSlug: ctx.classSlug, level: ctx.level },
    select: ['cantrips', 'preparedSpells'],
  });
  if (!row) return null;
  return {
    cantripsMax: row.cantrips,
    preparedOrKnownMax: row.preparedSpells,
  };
}
