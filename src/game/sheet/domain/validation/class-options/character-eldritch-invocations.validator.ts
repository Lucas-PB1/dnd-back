import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import {
  inferSpellDealsDamage,
  parseSpellRangeMeters,
  readEldritchInvocationCantripBindings,
  readEldritchInvocationPicks,
  validateEldritchBlastCantripBindings,
  validateEldritchInvocationPicks,
  type EldritchCantripEligibility,
  type EldritchInvocationCatalogRow,
} from '@game/combat/domain/warlock-features';
import { isWarlockClass } from '@game/combat/domain/warlock-features';
import { CharacterSpellDto } from '@game/sheet/dto/character-sheet.dto';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';

@Injectable()
export class CharacterEldritchInvocationsValidator {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(VPhbSpell)
    private readonly spells: Repository<VPhbSpell>,
  ) {}

  async validateEldritchInvocationOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells: CharacterSpellDto[] | undefined,
  ): Promise<void> {
    const picks = readEldritchInvocationPicks(options);
    const bindings = readEldritchInvocationCantripBindings(options);
    if (picks.length === 0) {
      if (bindings.length > 0) {
        throw new BadRequestException(
          'Vínculos de truque de invocação sem picks de invocação',
        );
      }
      return;
    }

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

    const cantripsBySlug = await this.loadCantripEligibility(
      bindings,
      characterSpells ?? [],
    );
    errors.push(
      ...validateEldritchBlastCantripBindings({
        picks,
        bindings,
        cantripsBySlug,
      }),
    );

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

  private async loadCantripEligibility(
    bindings: ReturnType<typeof readEldritchInvocationCantripBindings>,
    characterSpells: CharacterSpellDto[],
  ): Promise<Map<string, EldritchCantripEligibility>> {
    const slugs = [...new Set(bindings.map((binding) => binding.cantripSlug))];
    if (slugs.length === 0) return new Map();

    const knownSlugs = new Set(characterSpells.map((spell) => spell.spellSlug));
    const rows = await this.spells.find({ where: { slug: In(slugs) } });
    const map = new Map<string, EldritchCantripEligibility>();
    for (const row of rows) {
      map.set(row.slug, {
        slug: row.slug,
        isWarlockCantrip: row.level === 0 && knownSlugs.has(row.slug),
        requiresAttackRoll: row.requiresAttackRoll,
        rangeMeters: parseSpellRangeMeters(row.range),
        dealsDamage: inferSpellDealsDamage({
          requiresAttackRoll: row.requiresAttackRoll,
          saveAbilitySlug: row.saveAbilitySlug,
          description: row.description,
        }),
      });
    }
    for (const slug of slugs) {
      if (map.has(slug)) continue;
      map.set(slug, {
        slug,
        isWarlockCantrip: false,
        requiresAttackRoll: false,
        rangeMeters: null,
        dealsDamage: false,
      });
    }
    return map;
  }
}
