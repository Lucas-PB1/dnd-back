import { BadRequestException, Injectable } from '@nestjs/common';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { UpdateCharacterHandler } from '../../sheet/application/update-character.handler';
import { LevelUpDto } from '../dto/level-up.dto';
import { CharacterResponseDto } from '../../sheet/dto/character-response.dto';
import { UpdateCharacterDto } from '../../sheet/dto/update-character.dto';

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
      characterFeats: dto.characterFeats,
      featOptions: dto.featOptions,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };

    return this.updateCharacter.execute(userId, characterId, patch);
  }
}
