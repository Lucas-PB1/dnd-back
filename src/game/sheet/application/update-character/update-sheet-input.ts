import { UpdateCharacterDto } from '../../dto/update-character.dto';
import { CharacterFeatDto, FeatOptionDto } from '../../dto/character-sheet.dto';
import {
  CharacterSheetData,
  CharacterSheetInput,
} from '../../domain/character-sheet.types';

export function featSlugsOf(feats: readonly CharacterFeatDto[]): string[] {
  return feats.map((feat) => feat.featSlug).sort();
}

export function toSheetInput(dto: UpdateCharacterDto): CharacterSheetInput {
  return {
    classSkillSlugs: dto.classSkillSlugs,
    speciesChoices: dto.speciesChoices,
    subclassOptions: dto.subclassOptions,
    classOptions: dto.classOptions,
    characterFeats: dto.characterFeats,
    featOptions: dto.featOptions,
    characterSpells: dto.characterSpells,
    equipment: dto.equipment,
    languageSlugs: dto.languageSlugs,
    abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
  };
}

export function resolveEffectiveFeatOptions(
  dto: UpdateCharacterDto,
  sheetSnapshot: CharacterSheetData,
  effectiveCharacterFeats: CharacterFeatDto[],
): FeatOptionDto[] {
  if (dto.featOptions !== undefined) return dto.featOptions;
  if (dto.characterFeats !== undefined) {
    return sheetSnapshot.featOptions.filter((option) =>
      effectiveCharacterFeats.some(
        (feat) =>
          feat.featSlug === option.featSlug &&
          feat.instanceIndex === (option.instanceIndex ?? 0),
      ),
    );
  }
  return sheetSnapshot.featOptions;
}

export function shouldResyncCharacterSpells(
  dto: UpdateCharacterDto,
  levelChanged: boolean,
  speciesChanged: boolean,
  subclassChanged: boolean,
): boolean {
  return (
    dto.characterSpells !== undefined ||
    dto.featOptions !== undefined ||
    dto.characterFeats !== undefined ||
    dto.speciesChoices !== undefined ||
    speciesChanged ||
    subclassChanged ||
    levelChanged
  );
}
