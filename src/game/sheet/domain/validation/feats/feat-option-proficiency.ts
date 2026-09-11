import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '@common/assert';
import { PhbOptionDef, PhbOptionValue } from '@entities/reference/phb-option.entity';
import { FeatOptionDto } from '@game/sheet/dto/character-sheet.dto';
import { isSkillOrToolSlug } from '@game/sheet/infrastructure/queries/feat-option.queries';

export async function validateFeatProficiencyOption(
  dataSource: DataSource,
  featOptionValueRepo: Repository<PhbOptionValue>,
  def: PhbOptionDef,
  option: FeatOptionDto,
  featOptions: FeatOptionDto[],
): Promise<void> {
  const allowed = await featOptionValueRepo.findOne({
    where: {
      scope: 'feat' as const,
      ownerId: def.ownerId,
      optionKey: def.optionKey,
      valueId: option.valueId,
    },
  });
  if (!allowed) {
    const hasWhitelist = await featOptionValueRepo.exists({
      where: { scope: 'feat' as const, ownerId: def.ownerId, optionKey: def.optionKey },
    });
    if (hasWhitelist) {
      throw new BadRequestException(
        `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
      );
    }
    const valid = await isSkillOrToolSlug(dataSource, option.valueId);
    if (!valid) {
      throw new BadRequestException(
        `Proficiency '${option.valueId}' is not a valid skill or tool`,
      );
    }
  }
  const skilledValues = featOptions
    .filter((o) => o.optionKey.startsWith('proficiency'))
    .map((o) => o.valueId);
  assertUnique(skilledValues, 'Skilled proficiencies must be distinct');
  const artisanTools = featOptions
    .filter((o) => o.optionKey.startsWith('artisanTool'))
    .map((o) => o.valueId);
  assertUnique(artisanTools, 'Artisan tool choices must be distinct');
  const instruments = featOptions
    .filter((o) => o.optionKey.startsWith('musicalInstrument'))
    .map((o) => o.valueId);
  assertUnique(instruments, 'Musical instrument choices must be distinct');
}
