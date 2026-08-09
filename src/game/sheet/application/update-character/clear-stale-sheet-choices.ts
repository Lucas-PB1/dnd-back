import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';

/** Limpa escolhas de ficha obsoletas quando classe/espécie/subclasse muda sem novo payload. */
export async function clearStaleSheetChoices(
  sheetRepository: CharacterSheetRepository,
  characterId: string,
  dto: UpdateCharacterDto,
  changes: {
    classChanged: boolean;
    speciesChanged: boolean;
    subclassChanged: boolean;
  },
): Promise<void> {
  if (changes.classChanged && dto.classSkillSlugs === undefined) {
    await sheetRepository.clearClassSkills(characterId);
  }
  if (changes.classChanged && dto.classOptions === undefined) {
    await sheetRepository.clearClassOptions(characterId);
  }
  if (changes.speciesChanged && dto.speciesChoices === undefined) {
    await sheetRepository.clearSpeciesChoices(characterId);
  }
  if (changes.subclassChanged && dto.subclassOptions === undefined) {
    await sheetRepository.clearSubclassOptions(characterId);
  }
}
