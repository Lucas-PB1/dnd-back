import { Injectable } from '@nestjs/common';
import { PlayerCharacter } from './player-character.entity';
import { CharacterResponseDto } from '../dto/character-response.dto';

@Injectable()
export class CharacterMapper {
  toDto(row: PlayerCharacter): CharacterResponseDto {
    return {
      id: row.id,
      name: row.name,
      level: row.level,
      classSlug: row.classSlug,
      speciesSlug: row.speciesSlug,
      backgroundSlug: row.backgroundSlug,
      subclassSlug: row.subclassSlug,
      alignmentSlug: row.alignmentSlug,
      abilityScores: row.abilityScores,
      hitPointsMax: row.hitPointsMax,
      hitPointsCurrent: row.hitPointsCurrent,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
    };
  }

  toDtoList(rows: PlayerCharacter[]): CharacterResponseDto[] {
    return rows.map((row) => this.toDto(row));
  }
}
