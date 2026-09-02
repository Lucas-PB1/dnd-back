import { CharacterSheetValidator } from '@game/sheet/domain/validation/character-sheet.validator';
import {
  CharacterSheetData,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import {
  CharacterFeatDto,
  FeatOptionDto,
} from '@game/sheet/dto/character-sheet.dto';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';

type EffectiveIdentity = {
  level: number;
  classSlug: string;
  speciesSlug: string | null;
  heritageSlug: string | null;
  backgroundSlug: string;
  subclassSlug: string | null;
};

/** Valida sheet input, feat options e fighting styles do patch de update. */
export async function validateUpdateCharacterSheet(input: {
  sheetValidator: CharacterSheetValidator;
  dto: UpdateCharacterDto;
  validationInput: CharacterSheetInput;
  effective: EffectiveIdentity;
  sheetSnapshot: CharacterSheetData;
  effectiveCharacterFeats: CharacterFeatDto[];
  effectiveFeatOptions: FeatOptionDto[];
  rowLevel: number;
  rowClassSlug: string;
}): Promise<void> {
  const {
    sheetValidator,
    dto,
    validationInput,
    effective,
    sheetSnapshot,
    effectiveCharacterFeats,
    effectiveFeatOptions,
    rowLevel,
    rowClassSlug,
  } = input;

  await sheetValidator.validateSheetInput(validationInput, {
    ...effective,
    characterFeats: effectiveCharacterFeats,
  });

  if (dto.characterFeats !== undefined || dto.featOptions !== undefined) {
    await sheetValidator.validateFeatOptions(
      effectiveCharacterFeats,
      effectiveFeatOptions,
      dto.level ?? rowLevel,
      dto.classSlug ?? rowClassSlug,
    );
  }

  const effectiveSubclassOptions =
    dto.subclassOptions !== undefined
      ? dto.subclassOptions
      : sheetSnapshot.subclassOptions;
  if (dto.characterFeats !== undefined || dto.subclassOptions !== undefined) {
    await sheetValidator.validateFightingStyleSelections(
      dto.classSlug ?? rowClassSlug,
      effectiveCharacterFeats,
      effectiveSubclassOptions,
      dto.level ?? rowLevel,
    );
  }
}
