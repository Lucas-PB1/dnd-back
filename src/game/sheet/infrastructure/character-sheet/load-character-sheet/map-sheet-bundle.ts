import {
  CharacterSheetData,
  EMPTY_SHEET_DATA,
} from '@game/sheet/domain/character-sheet.types';
import type { ClassAbilityBoostRow } from '@game/sheet/domain/stats/class-ability-boost';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type {
  CharacterEquipmentDto,
  CharacterSpellDto,
  CharacterTransformationDto,
} from '@game/sheet/dto/character-sheet.dto';
import { splitOriginChoices } from '@game/sheet/domain/heritage/origin-choices';
import type { SheetBundleBoostJson, SheetBundleJson } from './types';

export function emptySheetData(): CharacterSheetData {
  return { ...EMPTY_SHEET_DATA };
}

export function mapSheetBundle(
  bundle: SheetBundleJson | null | undefined,
): CharacterSheetData {
  if (!bundle) return emptySheetData();

  const rawSpeciesChoices = bundle.speciesChoices ?? [];
  const explicitHeritage = bundle.heritageChoices ?? [];
  const split =
    explicitHeritage.length > 0
      ? { speciesChoices: rawSpeciesChoices, heritageChoices: explicitHeritage }
      : splitOriginChoices(rawSpeciesChoices);

  return {
    classSkillSlugs: asStringArray(bundle.classSkillSlugs),
    speciesChoices: split.speciesChoices,
    heritageChoices: split.heritageChoices,
    transformation: mapTransformation(bundle.transformation),
    subclassOptions: bundle.subclassOptions ?? [],
    classOptions: bundle.classOptions ?? [],
    characterFeats: bundle.characterFeats ?? [],
    featOptions: bundle.featOptions ?? [],
    characterSpells: (bundle.characterSpells ?? []) as CharacterSpellDto[],
    equipment: mapEquipment(bundle.equipment),
    languageSlugs: asStringArray(bundle.languageSlugs),
    abilityGenerationMethodSlug: null,
    backgroundSkillSlugs: asStringArray(bundle.backgroundSkillSlugs),
    proficiencyBonus:
      bundle.proficiencyBonus == null ? null : Number(bundle.proficiencyBonus),
    classAbilityBoosts: mapClassAbilityBoosts(bundle.classAbilityBoosts),
    speciesSize: bundle.speciesSize ?? null,
  };
}

function mapTransformation(
  value: CharacterTransformationDto | null | undefined,
): CharacterTransformationDto | null {
  if (!value?.slug) return null;
  return {
    slug: value.slug,
    stage: Number(value.stage),
    choices: (value.choices ?? []).map((choice) => ({
      choiceKind: choice.choiceKind,
      choiceSlug: choice.choiceSlug,
    })),
  };
}

function mapClassAbilityBoosts(
  rows: SheetBundleBoostJson[] | null | undefined,
): ClassAbilityBoostRow[] {
  return (rows ?? []).map((row) => ({
    ability: row.abilitySlug as keyof AbilityScores,
    label: row.label,
    bonus: Number(row.bonus),
    scoreMax: Number(row.scoreMax),
    fromLevel: Number(row.fromLevel),
  }));
}

function mapEquipment(
  rows: SheetBundleJson['equipment'],
): CharacterEquipmentDto[] {
  return (rows ?? []).map((row) => ({
    source: row.source,
    packageSlug: row.packageSlug,
    itemSlug: row.itemSlug ?? undefined,
    quantity: Number(row.quantity),
    sortOrder: Number(row.sortOrder),
  }));
}

function asStringArray(value: string[] | null | undefined): string[] {
  return value ?? [];
}
