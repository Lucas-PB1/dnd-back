import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '../../../../../common/assert';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import {
  PhbSubclassRef,
  PhbOptionValue,
} from '../../../../../entities/phb-subclass-option-value.entity';
import { CharacterSheetInput, CharacterSheetContext } from '../../character-sheet.types';
import { isFightingStyleSubclassOptionKey } from './fighting-style-feat-options';

@Injectable()
export class CharacterSubclassOptionsValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRefRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValuesRepo: Repository<PhbOptionValue>,
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
    const rows = await this.dataSource.query<{ subclass_unlock_level: number }[]>(
      `SELECT subclass_unlock_level FROM rpg.phb_class WHERE slug = $1`,
      [classSlug],
    );
    return rows[0]?.subclass_unlock_level ?? 3;
  }

  async loadSubclassOptionKeysAtLevel(
    subclassSlug: string,
    level: number,
  ): Promise<string[]> {
    const subclass = await this.subclassRefRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) return [];

    // Lote C: query unified phb_option_def with scope='subclass'
    const rows = await this.dataSource.query<{ optionKey: string }[]>(
      `SELECT DISTINCT def.option_key AS "optionKey"
       FROM rpg.phb_option_def def
       WHERE def.scope = 'subclass'
         AND def.owner_id = $1
         AND def.unlock_level <= $2
       ORDER BY def.option_key ASC`,
      [subclass.id, level],
    );
    return rows.map((row) => row.optionKey);
  }

  async validateSubclassOptions(
    subclassSlug: string | null,
    options: CharacterSheetInput['subclassOptions'],
  ): Promise<void> {
    if (!options) return;

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
      // Lote C: query unified phb_option_value with scope='subclass'
      const valid = await this.optionValuesRepo.findOne({
        where: {
          scope: 'subclass',
          ownerId: subclass.id,
          optionKey: option.optionKey,
          valueId: option.valueId,
        },
      });
      if (!valid) {
        throw new BadRequestException(
          `Subclass option '${option.optionKey}/${option.valueId}' is invalid for '${subclassSlug}'`,
        );
      }

      if (isFightingStyleSubclassOptionKey(option.optionKey)) {
        const exists = await this.dataSource.query<{ ok: number }[]>(
          `SELECT 1 AS ok FROM rpg.phb_fighting_style WHERE slug = $1 LIMIT 1`,
          [option.valueId],
        );
        if (exists.length === 0) {
          throw new BadRequestException(
            `Subclass option '${option.optionKey}/${option.valueId}' is not a valid fighting style`,
          );
        }
      }
    }
  }
}
