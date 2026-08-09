import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  isSorcererClass,
  readMetamagicPicks,
  validateMetamagicPicks,
  type MetamagicCatalogRow,
} from '@game/combat/domain/sorcerer';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';

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

    const catalog = await this.loadCatalog();
    const errors = validateMetamagicPicks({
      level: ctx.level,
      picks,
      catalog,
    });
    if (errors.length > 0) {
      throw new BadRequestException(errors.join('; '));
    }
  }

  private async loadCatalog(): Promise<MetamagicCatalogRow[]> {
    const rows = await this.dataSource.query<
      {
        slug: string;
        name: string;
        description: string;
        cost: number;
        stacks_with_other: boolean;
      }[]
    >(
      `SELECT slug, name, description, cost, stacks_with_other
       FROM rpg.phb_metamagic`,
    );
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      description: row.description,
      cost: Number(row.cost),
      stacksWithOther: row.stacks_with_other,
    }));
  }
}
