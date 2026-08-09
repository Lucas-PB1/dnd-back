import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  readEldritchInvocationPicks,
  validateEldritchInvocationPicks,
  type EldritchInvocationCatalogRow,
} from '../../../../combat/domain/warlock-features';
import { isWarlockClass } from '../../../../combat/domain/warlock-features';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '../../character-sheet.types';

@Injectable()
export class CharacterEldritchInvocationsValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateEldritchInvocationOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    const picks = readEldritchInvocationPicks(options);
    if (picks.length === 0) return;

    if (!isWarlockClass(ctx.classSlug)) {
      throw new BadRequestException(
        'Eldritch invocations are only available for Warlock',
      );
    }

    const catalog = await this.loadCatalog();
    const errors = validateEldritchInvocationPicks({
      level: ctx.level,
      picks,
      catalog,
    });
    if (errors.length > 0) {
      throw new BadRequestException(errors.join('; '));
    }
  }

  private async loadCatalog(): Promise<EldritchInvocationCatalogRow[]> {
    const rows = await this.dataSource.query<
      {
        slug: string;
        name: string;
        min_level: number;
        requires_pact_slug: string | null;
        requires_invocation_slug: string | null;
        repeatable: boolean;
      }[]
    >(
      `SELECT slug, name, min_level, requires_pact_slug, requires_invocation_slug, repeatable
       FROM rpg.phb_eldritch_invocation`,
    );
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      minLevel: row.min_level,
      requiresPactSlug: row.requires_pact_slug,
      requiresInvocationSlug: row.requires_invocation_slug,
      repeatable: row.repeatable,
    }));
  }
}
