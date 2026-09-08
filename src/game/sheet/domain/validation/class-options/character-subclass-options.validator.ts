import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '@common/assert';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbOptionValue } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { CharacterSheetInput, CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { isFightingStyleSubclassOptionKey } from './fighting-style-feat-options';
import { CharacterSubclassOptionValueValidator } from './character-subclass-option-value.validator';
import {
  loadSubclassOptionKeysAtLevel,
  subclassOptionValueType,
} from '@game/sheet/infrastructure/queries/class-option.queries';
import { resolveSubclassUnlockLevel } from '@game/sheet/infrastructure/queries/class-meta.queries';
import { fightingStyleExists } from '@game/sheet/infrastructure/queries/feat-option.queries';

@Injectable()
export class CharacterSubclassOptionsValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRefRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValuesRepo: Repository<PhbOptionValue>,
    private readonly optionValueValidator: CharacterSubclassOptionValueValidator,
  ) {}

  async validateLevelRules(ctx: CharacterSheetContext): Promise<void> {
    await this.catalogLookup.findClassOrFail(ctx.classSlug);
    const unlockLevel = await this.resolveSubclassUnlockLevel(ctx.classSlug);

    if (ctx.level >= unlockLevel && !ctx.subclassSlug) {
      throw new BadRequestException(
        `Subclass is required at level ${ctx.level} for class '${ctx.classSlug}'`,
      );
    }

    if (ctx.subclassSlug && ctx.level < unlockLevel) {
      throw new BadRequestException(
        `Subclass '${ctx.subclassSlug}' unlocks at level ${unlockLevel} for class '${ctx.classSlug}'`,
      );
    }
  }

  async resolveSubclassUnlockLevel(classSlug: string): Promise<number> {
    return resolveSubclassUnlockLevel(this.dataSource, classSlug);
  }

  async loadSubclassOptionKeysAtLevel(
    subclassSlug: string,
    level: number,
  ): Promise<string[]> {
    const subclass = await this.subclassRefRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) return [];

    return loadSubclassOptionKeysAtLevel(this.dataSource, subclass.id, level);
  }

  async validateSubclassOptions(
    subclassSlug: string | null,
    options: CharacterSheetInput['subclassOptions'],
    ctx?: Pick<CharacterSheetContext, 'classSlug' | 'level'>,
  ): Promise<void> {
    // `[]` é injetado no resync de level-up; não é escolha de opções.
    if (!options?.length) return;

    if (!subclassSlug) {
      throw new BadRequestException('Subclass must be set before choosing subclass options');
    }

    assertUnique(
      options.map((o) => o.optionKey),
      'Duplicate subclass option keys are not allowed',
    );

    const subclass = await this.subclassRefRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) {
      throw new BadRequestException(`Subclass '${subclassSlug}' not found in catalog`);
    }

    for (const option of options) {
      const valid = await this.optionValuesRepo.findOne({
        where: {
          scope: 'subclass',
          ownerId: subclass.id,
          optionKey: option.optionKey,
          valueId: option.valueId,
        },
      });
      const valueType = await subclassOptionValueType(
        this.dataSource,
        subclass.id,
        option.optionKey,
      );
      const needsCatalogValue =
        valueType === 'catalog' ||
        valueType === 'terrain' ||
        valueType === 'fighting_style';

      if (needsCatalogValue && !valid) {
        throw new BadRequestException(
          `Subclass option '${option.optionKey}/${option.valueId}' is invalid for '${subclassSlug}'`,
        );
      }

      if (isFightingStyleSubclassOptionKey(option.optionKey)) {
        if (!(await fightingStyleExists(this.dataSource, option.valueId))) {
          throw new BadRequestException(
            `Subclass option '${option.optionKey}/${option.valueId}' is not a valid fighting style`,
          );
        }
      }
    }

    if (ctx) {
      await this.optionValueValidator.validate(
        subclassSlug,
        ctx.classSlug,
        ctx.level,
        options,
      );
    }
  }
}
