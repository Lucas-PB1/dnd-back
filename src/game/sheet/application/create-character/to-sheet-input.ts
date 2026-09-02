import { CreateCharacterDto } from '../../dto/create-character.dto';
import { CharacterFeatDto } from '../../dto/character-sheet.dto';
import { CharacterSheetInput } from '../../domain/character-sheet.types';

export function toCreateSheetInput(
  dto: CreateCharacterDto,
  characterFeats?: CharacterFeatDto[],
): CharacterSheetInput {
  return {
    classSkillSlugs: dto.classSkillSlugs,
    speciesChoices: dto.speciesChoices,
    heritageChoices: dto.heritageChoices,
    transformation: dto.transformation,
    subclassOptions: dto.subclassOptions,
    classOptions: dto.classOptions,
    characterFeats: characterFeats ?? dto.characterFeats,
    featOptions: dto.featOptions,
    characterSpells: dto.characterSpells,
    equipment: dto.equipment,
    languageSlugs: dto.languageSlugs,
    abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
  };
}
