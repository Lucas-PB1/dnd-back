import { DataSource } from 'typeorm';
import { readEldritchInvocationOriginFeatBindings } from '@game/combat/domain/warlock';
import {
  CharacterSheetData,
} from '@game/sheet/domain/character-sheet.types';
import { syncLessonsOriginCharacterFeats } from '@game/sheet/domain/origin/lessons-origin';
import {
  CharacterFeatDto,
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';
import { assertAndConsumeHighElfCantripSwap } from './assert-high-elf-cantrip-swap';
import { resolveEffectiveFeatOptions } from './update-sheet-input';

export type EffectiveUpdateSheet = {
  effectiveCharacterFeats: CharacterFeatDto[];
  effectiveFeatOptions: FeatOptionDto[];
  effectiveSpeciesChoices: SpeciesChoiceDto[];
  effectiveHeritageChoices: SpeciesChoiceDto[];
};

/** Resolve feats/options/choices efetivos e consome swap de cantrip High Elf se houver. */
export async function resolveEffectiveUpdateSheet(input: {
  dataSource: DataSource;
  characterId: string;
  dto: UpdateCharacterDto;
  sheetSnapshot: CharacterSheetData;
}): Promise<EffectiveUpdateSheet> {
  const { dataSource, characterId, dto, sheetSnapshot } = input;

  let effectiveCharacterFeats =
    dto.characterFeats !== undefined
      ? dto.characterFeats
      : sheetSnapshot.characterFeats;

  if (dto.classOptions !== undefined) {
    const previousLessons = new Set(
      readEldritchInvocationOriginFeatBindings(
        sheetSnapshot.classOptions,
      ).map((binding) => binding.featSlug),
    );
    const protectedFeatSlugs = new Set(
      effectiveCharacterFeats
        .map((feat) => feat.featSlug)
        .filter((slug) => !previousLessons.has(slug)),
    );
    effectiveCharacterFeats = syncLessonsOriginCharacterFeats({
      previousClassOptions: sheetSnapshot.classOptions,
      nextClassOptions: dto.classOptions,
      characterFeats: effectiveCharacterFeats,
      protectedFeatSlugs,
    });
  }

  const effectiveFeatOptions = resolveEffectiveFeatOptions(
    dto,
    sheetSnapshot,
    effectiveCharacterFeats,
  );
  const effectiveSpeciesChoices =
    dto.speciesChoices !== undefined
      ? dto.speciesChoices
      : sheetSnapshot.speciesChoices;
  const effectiveHeritageChoices =
    dto.heritageChoices !== undefined
      ? dto.heritageChoices
      : sheetSnapshot.heritageChoices;

  if (dto.speciesChoices !== undefined) {
    await assertAndConsumeHighElfCantripSwap(
      dataSource,
      characterId,
      sheetSnapshot.speciesChoices,
      dto.speciesChoices,
    );
  }

  return {
    effectiveCharacterFeats,
    effectiveFeatOptions,
    effectiveSpeciesChoices,
    effectiveHeritageChoices,
  };
}
