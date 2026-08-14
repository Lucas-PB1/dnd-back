import { DataSource } from 'typeorm';
import {
  CharacterSheetData,
  EMPTY_SHEET_DATA,
  type GrantedSpellSheetSlice,
} from '@game/sheet/domain/character-sheet.types';
import type { ClassAbilityBoostRow } from '@game/sheet/domain/stats/class-ability-boost';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  ClassOptionDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '@game/sheet/dto/character-sheet.dto';

export type CharacterSheetLoadDeps = {
  dataSource: DataSource;
};

type SheetBundleBoostJson = {
  abilitySlug: string;
  label: string;
  bonus: number;
  scoreMax: number;
  fromLevel: number;
};

type SheetBundleJson = {
  classSkillSlugs?: string[] | null;
  speciesChoices?: SpeciesChoiceDto[] | null;
  subclassOptions?: SubclassOptionDto[] | null;
  classOptions?: ClassOptionDto[] | null;
  characterFeats?: CharacterFeatDto[] | null;
  featOptions?: FeatOptionDto[] | null;
  characterSpells?: CharacterSpellDto[] | null;
  equipment?: Array<{
    source: 'class' | 'background';
    packageSlug: string;
    itemSlug?: string | null;
    quantity: number;
    sortOrder: number;
  }> | null;
  languageSlugs?: string[] | null;
  backgroundSkillSlugs?: string[] | null;
  proficiencyBonus?: number | null;
  classAbilityBoosts?: SheetBundleBoostJson[] | null;
  speciesSize?: string | null;
};

export async function loadCharacterSheet(
  deps: CharacterSheetLoadDeps,
  characterId: string,
  backgroundSlug?: string,
): Promise<CharacterSheetData> {
  const rows = await deps.dataSource.query<{ bundle: SheetBundleJson }[]>(
    `SELECT rpg.get_character_sheet_bundle($1::uuid, $2::text) AS bundle`,
    [characterId, backgroundSlug ?? null],
  );
  return mapSheetBundle(rows[0]?.bundle);
}

/** Feats/options/species/spells + classOptions — para GET state. */
export async function loadGrantedSpellSheetSlice(
  deps: CharacterSheetLoadDeps,
  characterId: string,
): Promise<GrantedSpellSheetSlice> {
  const sheet = await loadCharacterSheet(deps, characterId);
  return {
    speciesChoices: sheet.speciesChoices,
    classOptions: sheet.classOptions,
    characterFeats: sheet.characterFeats,
    featOptions: sheet.featOptions,
    characterSpells: sheet.characterSpells,
  };
}

export async function loadManyCharacterSheets(
  deps: CharacterSheetLoadDeps,
  characterIds: string[],
  backgroundByCharacterId: Map<string, string>,
): Promise<Map<string, CharacterSheetData>> {
  const map = new Map<string, CharacterSheetData>();
  if (characterIds.length === 0) return map;

  await Promise.all(
    characterIds.map(async (id) => {
      map.set(
        id,
        await loadCharacterSheet(deps, id, backgroundByCharacterId.get(id)),
      );
    }),
  );
  return map;
}

export async function loadBackgroundSkillSlugs(
  deps: CharacterSheetLoadDeps,
  backgroundSlug: string,
): Promise<string[]> {
  const rows = await deps.dataSource.query<{ slug: string }[]>(
    `SELECT s.slug
     FROM rpg.phb_background_skill bs
     JOIN rpg.phb_background b ON b.id = bs.background_id
     JOIN rpg.phb_skill s ON s.id = bs.skill_id
     WHERE b.slug = $1
     ORDER BY s.slug`,
    [backgroundSlug],
  );
  return rows.map((row) => row.slug);
}

export function mergeSheetData(
  base: CharacterSheetData,
  abilityGenerationMethodSlug: string | null,
): CharacterSheetData {
  return {
    ...base,
    abilityGenerationMethodSlug,
  };
}

export function emptySheetData(): CharacterSheetData {
  return { ...EMPTY_SHEET_DATA };
}

function mapSheetBundle(bundle: SheetBundleJson | null | undefined): CharacterSheetData {
  if (!bundle) return emptySheetData();

  return {
    classSkillSlugs: asStringArray(bundle.classSkillSlugs),
    speciesChoices: bundle.speciesChoices ?? [],
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
