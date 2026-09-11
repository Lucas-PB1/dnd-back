import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  isSorcererClass,
  readMetamagicPicks,
  validateMetamagicPicks,
} from '@game/combat/domain/sorcerer';
import { loadMergedFeatureSchedules } from '@game/combat/infrastructure/feature-schedule.queries';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import { loadMetamagicCatalog } from '@game/sheet/infrastructure/queries/metamagic-catalog.queries';

@Injectable()
export class CharacterMetamagicValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateMetamagicOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    const picks = readMetamagicPicks(options);
    if (picks.length === 0) return;

    if (!isSorcererClass(ctx.classSlug)) {
      throw new BadRequestException(
        'Metamagia só está disponível para Feiticeiros',
      );
    }

    const [catalog, featureSchedules] = await Promise.all([
      loadMetamagicCatalog(this.dataSource),
      loadMergedFeatureSchedules(
        this.dataSource,
        ctx.classSlug,
        ctx.subclassSlug,
      ),
    ]);
    const errors = validateMetamagicPicks({
      level: ctx.level,
      picks,
      catalog,
      featureSchedules,
    });
    if (errors.length > 0) {
      throw new BadRequestException(errors.join('; '));
    }
  }
}
