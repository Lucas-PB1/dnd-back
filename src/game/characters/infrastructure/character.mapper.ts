import { Injectable } from '@nestjs/common';
import { PlayerCharacter } from './player-character.entity';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterDomainService } from '../domain/character-domain.service';

@Injectable()
export class CharacterMapper {
  constructor(private readonly domain: CharacterDomainService) {}

  async toDto(row: PlayerCharacter): Promise<CharacterResponseDto> {
    const proficiencyBonus = await this.domain.getProficiencyBonus(row.level);
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
      proficiencyBonus,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
    };
  }

  async toDtoList(rows: PlayerCharacter[]): Promise<CharacterResponseDto[]> {
    return Promise.all(rows.map((row) => this.toDto(row)));
  }
}
