import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import {
  findSpellQuotaViolation,
  spellQuotaViolationMessage,
} from '@game/spellcasting/domain/spell-quota';
import { extraCantripsFromClassOrder } from '../class-options/class-order-effects';
import { collectSubclassSpellbookBonusSlugs } from '../class-options/subclass-option-effects';
import { usesWizardPlusSangromancyList } from '@game/spellcasting/domain/sangromancy/sangromancy-spells';
import { loadSangromancySpellLevelsUpTo } from '@game/spellcasting/domain/sangromancy/load-sangromancy-spell-slugs';
import {
  loadSpellProgressionLimits,
  SubclassSpellcastingInfo,
} from './spell-progression-queries';

export async function assertSpellQuotas(
  dataSource: DataSource,
  classSpellsRepo: Repository<VSpellByClass>,
  spells: NonNullable<CharacterSheetInput['characterSpells']>,
  ctx: CharacterSheetContext,
  subclassCasting: SubclassSpellcastingInfo | null,
  classOptions?: CharacterSheetInput['classOptions'],
  subclassOptions?: CharacterSheetInput['subclassOptions'],
): Promise<void> {
  const limits = await loadSpellProgressionLimits(dataSource, ctx, subclassCasting);
  if (!limits) return;
  const extraCantrips = extraCantripsFromClassOrder(classOptions);
  const spellbookBonus = collectSubclassSpellbookBonusSlugs(subclassOptions);

  const catalogClassSlug =
    subclassCasting?.spellListClassSlug ?? ctx.classSlug;
  const mode = subclassCasting?.spellcastingMode;

  const catalogRows = await classSpellsRepo.find({
    where: { classSlug: catalogClassSlug },
  });
  let catalog = catalogRows.map((item) => ({
    slug: item.spellSlug,
    level: item.spellLevel,
  }));
  if (usesWizardPlusSangromancyList(ctx.classSlug, ctx.subclassSlug)) {
    const sangromancyRows = await loadSangromancySpellLevelsUpTo(
      dataSource,
      9,
    );
    const bySlug = new Map(catalog.map((row) => [row.slug, row]));
    for (const row of sangromancyRows) {
      if (!bySlug.has(row.slug)) {
        bySlug.set(row.slug, { slug: row.slug, level: row.level });
      }
    }
    catalog = [...bySlug.values()];
  }
  const quotaSpells = spells.filter(
    (spell) => !spellbookBonus.has(spell.spellSlug),
  );
  const violation = findSpellQuotaViolation({
    classSlug: catalogClassSlug,
    level: ctx.level,
    characterSpells: quotaSpells,
    catalog,
    cantripsMax:
      limits.cantripsMax == null
        ? null
        : limits.cantripsMax + extraCantrips,
    preparedOrKnownMax: limits.preparedOrKnownMax,
    mode,
  });
  if (violation) {
    throw new BadRequestException(
      spellQuotaViolationMessage(catalogClassSlug, violation),
    );
  }
}
