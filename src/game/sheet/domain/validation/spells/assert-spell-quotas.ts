import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { CharacterSheetContext } from '../../character-sheet.types';
import { CharacterSheetInput } from '../../character-sheet.types';
import {
  findSpellQuotaViolation,
  spellQuotaViolationMessage,
} from '../../spellcasting/spell-quota';
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
): Promise<void> {
  const limits = await loadSpellProgressionLimits(dataSource, ctx, subclassCasting);
  if (!limits) return;

  const catalogClassSlug =
    subclassCasting?.spellListClassSlug ?? ctx.classSlug;
  const mode = subclassCasting?.spellcastingMode;

  const catalogRows = await classSpellsRepo.find({
    where: { classSlug: catalogClassSlug },
  });
  const violation = findSpellQuotaViolation({
    classSlug: catalogClassSlug,
    level: ctx.level,
    characterSpells: spells,
    catalog: catalogRows.map((item) => ({
      slug: item.spellSlug,
      level: item.spellLevel,
    })),
    cantripsMax: limits.cantripsMax,
    preparedOrKnownMax: limits.preparedOrKnownMax,
    mode,
  });
  if (violation) {
    throw new BadRequestException(
      spellQuotaViolationMessage(catalogClassSlug, violation),
    );
  }
}
