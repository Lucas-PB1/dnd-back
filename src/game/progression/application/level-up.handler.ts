import { BadRequestException, Injectable } from '@nestjs/common';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { UpdateCharacterHandler } from '../../characters/application/update-character.handler';
import { LevelUpDto } from '../dto/level-up.dto';
import { CharacterResponseDto } from '../../characters/dto/character-response.dto';
import { UpdateCharacterDto } from '../../characters/dto/update-character.dto';

@Injectable()
export class LevelUpHandler {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly updateCharacter: UpdateCharacterHandler,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: LevelUpDto,
  ): Promise<CharacterResponseDto> {
    const character = await this.repository.findOwnedOrFail(userId, characterId);

    if (character.level >= 20) {
      throw new BadRequestException('Character is already at maximum level');
    }

    const patch: UpdateCharacterDto = {
      level: character.level + 1,
      subclassSlug: dto.subclassSlug,
      classSkillSlugs: dto.classSkillSlugs,
      speciesChoices: dto.speciesChoices,
      subclassOptions: dto.subclassOptions,
      featSlugs: dto.featSlugs,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };

    return this.updateCharacter.execute(userId, characterId, patch);
  }
}
