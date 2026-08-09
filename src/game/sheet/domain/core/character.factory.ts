import { BadRequestException } from '@nestjs/common';
import {
  DEFAULT_ABILITY_SCORES,
  PlayerCharacter,
} from '@game/shared/infrastructure/player-character.entity';
import { CreateCharacterDto } from '@game/sheet/dto/create-character.dto';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';
import {
  applyBackgroundAbilityBoosts,
  BACKGROUND_BOOST_MODE_PLUS1X3,
  BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
  resolveBackgroundAbilityBoostInput,
  type BackgroundBoostMode,
} from '../origin/background-ability-boost';
import { applyFeatAbilityIncreases } from '../validation/feats/feat-ability-boost';
import type { FeatOptionDto } from '@game/sheet/dto/character-sheet.dto';

const MIN_LEVEL = 1;
const MAX_LEVEL = 20;

function boostColumnsFromDto(dto: {
  backgroundAbilityBoostMode?: string | null;
  backgroundAbilityBoostPlus2Slug?: string | null;
  backgroundAbilityBoostPlus1Slug?: string | null;
  backgroundAbilityBoostPlus1Slugs?: string[] | null;
}): Pick<
  PlayerCharacter,
  | 'backgroundBoostMode'
  | 'backgroundBoostPlus2AbilitySlug'
  | 'backgroundBoostPlus1AbilitySlug'
  | 'backgroundBoostPlus1Slugs'
> {
  const input = resolveBackgroundAbilityBoostInput({
    mode: dto.backgroundAbilityBoostMode,
    plus2Slug: dto.backgroundAbilityBoostPlus2Slug,
    plus1Slug: dto.backgroundAbilityBoostPlus1Slug,
    plus1Slugs: dto.backgroundAbilityBoostPlus1Slugs,
  });

  if (input.mode === BACKGROUND_BOOST_MODE_PLUS1X3) {
    return {
      backgroundBoostMode: BACKGROUND_BOOST_MODE_PLUS1X3,
      backgroundBoostPlus2AbilitySlug: null,
      backgroundBoostPlus1AbilitySlug: null,
      backgroundBoostPlus1Slugs: input.plus1Slugs,
    };
  }

  return {
    backgroundBoostMode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
    backgroundBoostPlus2AbilitySlug: input.plus2Slug,
    backgroundBoostPlus1AbilitySlug: input.plus1Slug,
    backgroundBoostPlus1Slugs: null,
  };
}

export class CharacterFactory {
  static buildNew(userId: string, dto: CreateCharacterDto): Partial<PlayerCharacter> {
    const level = dto.level ?? MIN_LEVEL;
    CharacterFactory.assertLevel(level);

    return {
      userId,
      name: dto.name,
      level,
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug ?? null,
      alignmentSlug: dto.alignmentSlug ?? null,
      abilityScores: dto.abilityScores ?? DEFAULT_ABILITY_SCORES,
      hitPointsMax: dto.hitPointsMax ?? null,
      hitPointsCurrent: dto.hitPointsCurrent ?? dto.hitPointsMax ?? null,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug ?? null,
      ...boostColumnsFromDto(dto),
      backgroundToolItemSlug: dto.backgroundToolItemSlug ?? null,
    };
  }

  static withBackgroundTool(
    entity: Partial<PlayerCharacter>,
    toolItemSlug: string | null,
  ): Partial<PlayerCharacter> {
    return { ...entity, backgroundToolItemSlug: toolItemSlug };
  }

  /** Aplica bônus do antecedente sobre scores base (criação). */
  static withBackgroundBoostsApplied(
    entity: Partial<PlayerCharacter>,
    dto: Pick<
      CreateCharacterDto,
      | 'abilityScores'
      | 'backgroundAbilityBoostMode'
      | 'backgroundAbilityBoostPlus2Slug'
      | 'backgroundAbilityBoostPlus1Slug'
      | 'backgroundAbilityBoostPlus1Slugs'
    >,
  ): Partial<PlayerCharacter> {
    const base = dto.abilityScores ?? DEFAULT_ABILITY_SCORES;
    const boostInput = resolveBackgroundAbilityBoostInput({
      mode: dto.backgroundAbilityBoostMode,
      plus2Slug: dto.backgroundAbilityBoostPlus2Slug,
      plus1Slug: dto.backgroundAbilityBoostPlus1Slug,
      plus1Slugs: dto.backgroundAbilityBoostPlus1Slugs,
    });
    return {
      ...entity,
      abilityScores: applyBackgroundAbilityBoosts(base, boostInput),
      ...boostColumnsFromDto(dto),
    };
  }

  /** +1 de talentos com optionKey abilityIncrease (após antecedente). */
  static withFeatAbilityBoostsApplied(
    entity: Partial<PlayerCharacter>,
    featOptions: FeatOptionDto[] | undefined,
    epicBoonFeatSlugs?: ReadonlySet<string>,
  ): Partial<PlayerCharacter> {
    if (!entity.abilityScores) return entity;
    return {
      ...entity,
      abilityScores: applyFeatAbilityIncreases(
        entity.abilityScores,
        featOptions,
        { epicBoonFeatSlugs },
      ),
    };
  }

  static applyUpdate(row: PlayerCharacter, dto: UpdateCharacterDto): void {
    if (dto.level !== undefined) {
      CharacterFactory.assertLevel(dto.level);
      row.level = dto.level;
    }
    if (dto.name !== undefined) row.name = dto.name;
    if (dto.classSlug !== undefined) row.classSlug = dto.classSlug;
    if (dto.speciesSlug !== undefined) row.speciesSlug = dto.speciesSlug;
    if (dto.backgroundSlug !== undefined) row.backgroundSlug = dto.backgroundSlug;
    if (dto.subclassSlug !== undefined) row.subclassSlug = dto.subclassSlug ?? null;
    if (dto.alignmentSlug !== undefined) row.alignmentSlug = dto.alignmentSlug ?? null;
    if (dto.abilityScores !== undefined) row.abilityScores = dto.abilityScores;
    if (dto.hitPointsMax !== undefined) row.hitPointsMax = dto.hitPointsMax;
    if (dto.hitPointsCurrent !== undefined) row.hitPointsCurrent = dto.hitPointsCurrent;
    if (dto.abilityGenerationMethodSlug !== undefined) {
      row.abilityGenerationMethodSlug = dto.abilityGenerationMethodSlug ?? null;
    }

    const boostTouched =
      dto.backgroundAbilityBoostMode !== undefined ||
      dto.backgroundAbilityBoostPlus2Slug !== undefined ||
      dto.backgroundAbilityBoostPlus1Slug !== undefined ||
      dto.backgroundAbilityBoostPlus1Slugs !== undefined;

    if (boostTouched) {
      const columns = boostColumnsFromDto({
        backgroundAbilityBoostMode:
          dto.backgroundAbilityBoostMode ?? row.backgroundBoostMode,
        backgroundAbilityBoostPlus2Slug:
          dto.backgroundAbilityBoostPlus2Slug !== undefined
            ? dto.backgroundAbilityBoostPlus2Slug
            : row.backgroundBoostPlus2AbilitySlug,
        backgroundAbilityBoostPlus1Slug:
          dto.backgroundAbilityBoostPlus1Slug !== undefined
            ? dto.backgroundAbilityBoostPlus1Slug
            : row.backgroundBoostPlus1AbilitySlug,
        backgroundAbilityBoostPlus1Slugs:
          dto.backgroundAbilityBoostPlus1Slugs !== undefined
            ? dto.backgroundAbilityBoostPlus1Slugs
            : row.backgroundBoostPlus1Slugs,
      });
      row.backgroundBoostMode = columns.backgroundBoostMode;
      row.backgroundBoostPlus2AbilitySlug = columns.backgroundBoostPlus2AbilitySlug;
      row.backgroundBoostPlus1AbilitySlug = columns.backgroundBoostPlus1AbilitySlug;
      row.backgroundBoostPlus1Slugs = columns.backgroundBoostPlus1Slugs;
    }

    if (dto.backgroundToolItemSlug !== undefined) {
      row.backgroundToolItemSlug = dto.backgroundToolItemSlug ?? null;
    }
  }

  static assertLevel(level: number): void {
    if (level < MIN_LEVEL || level > MAX_LEVEL) {
      throw new BadRequestException(`Level must be between ${MIN_LEVEL} and ${MAX_LEVEL}`);
    }
  }

  static boostModeOf(row: PlayerCharacter): BackgroundBoostMode {
    return row.backgroundBoostMode === BACKGROUND_BOOST_MODE_PLUS1X3
      ? BACKGROUND_BOOST_MODE_PLUS1X3
      : BACKGROUND_BOOST_MODE_PLUS2_PLUS1;
  }
}
