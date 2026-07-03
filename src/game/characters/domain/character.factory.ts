import { BadRequestException } from '@nestjs/common';
import {
  DEFAULT_ABILITY_SCORES,
  PlayerCharacter,
} from '../../shared/infrastructure/player-character.entity';
import { CreateCharacterDto } from '../dto/create-character.dto';
import { UpdateCharacterDto } from '../dto/update-character.dto';

const MIN_LEVEL = 1;
const MAX_LEVEL = 20;

export class CharacterFactory {
  static buildNew(userId: string, dto: CreateCharacterDto): Partial<PlayerCharacter> {
    return {
      userId,
      name: dto.name,
      level: MIN_LEVEL,
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug ?? null,
      alignmentSlug: dto.alignmentSlug ?? null,
      abilityScores: dto.abilityScores ?? DEFAULT_ABILITY_SCORES,
      hitPointsMax: dto.hitPointsMax ?? null,
      hitPointsCurrent: dto.hitPointsCurrent ?? dto.hitPointsMax ?? null,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug ?? null,
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
  }

  static assertLevel(level: number): void {
    if (level < MIN_LEVEL || level > MAX_LEVEL) {
      throw new BadRequestException(`Level must be between ${MIN_LEVEL} and ${MAX_LEVEL}`);
    }
  }
}
