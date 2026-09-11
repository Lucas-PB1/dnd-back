import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import {
  inferSpellDealsDamage,
  parseSpellRangeMeters,
  readEldritchInvocationCantripBindings,
  readEldritchInvocationOriginFeatBindings,
  readEldritchInvocationPicks,
  validateEldritchBlastCantripBindings,
  validateEldritchInvocationPicks,
  validateEldritchOriginFeatBindings,
  type EldritchCantripEligibility,
} from '@game/combat/domain/warlock';
import { isWarlockClass } from '@game/combat/domain/warlock';
import { loadMergedFeatureSchedules } from '@game/combat/infrastructure/feature-schedule.queries';
import {
  CharacterFeatDto,
  CharacterSpellDto,
} from '@game/sheet/dto/character-sheet.dto';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import {
  loadEldritchInvocationCatalog,
  loadOriginFeatSlugs,
} from '@game/sheet/infrastructure/queries/eldritch-invocation.queries';

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
    characterFeats: CharacterFeatDto[] | undefined = [],
  ): Promise<void> {
    const picks = readEldritchInvocationPicks(options);
    const bindings = readEldritchInvocationCantripBindings(options);
    const originBindings = readEldritchInvocationOriginFeatBindings(options);
    if (picks.length === 0) {
      if (bindings.length > 0 || originBindings.length > 0) {
        throw new BadRequestException(
          'Vínculos de invocação sem picks de invocação',
        );
      }
      return;
    }

    if (!isWarlockClass(ctx.classSlug)) {
      throw new BadRequestException(
        'Eldritch invocations are only available for Warlock',
      );
    }

    const [catalog, featureSchedules] = await Promise.all([
      loadEldritchInvocationCatalog(this.dataSource),
      loadMergedFeatureSchedules(
        this.dataSource,
        ctx.classSlug,
        ctx.subclassSlug,
      ),
    ]);
    const errors = validateEldritchInvocationPicks({
      level: ctx.level,
      picks,
      catalog,
      featureSchedules,
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

    const originFeatSlugs = await loadOriginFeatSlugs(
      this.dataSource,
      originBindings.map((binding) => binding.featSlug),
    );
    const lessonsFeatSlugs = new Set(
      originBindings.map((binding) => binding.featSlug),
    );
    const occupiedFeatSlugs = new Set(
      (characterFeats ?? [])
        .map((feat) => feat.featSlug)
        .filter((slug) => !lessonsFeatSlugs.has(slug)),
    );
    errors.push(
      ...validateEldritchOriginFeatBindings({
        picks,
        bindings: originBindings,
        originFeatSlugs,
        occupiedFeatSlugs,
      }),
    );

    if (errors.length > 0) {
      throw new BadRequestException(errors.join('; '));
    }
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
