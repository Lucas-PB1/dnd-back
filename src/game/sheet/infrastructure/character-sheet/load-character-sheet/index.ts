import {
  CharacterSheetData,
  type GrantedSpellSheetSlice,
} from '@game/sheet/domain/character-sheet.types';
import { mapSheetBundle } from './map-sheet-bundle';
import type { CharacterSheetLoadDeps, SheetBundleJson } from './types';

export type { CharacterSheetLoadDeps } from './types';
export { emptySheetData, mapSheetBundle } from './map-sheet-bundle';

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
    heritageChoices: sheet.heritageChoices,
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
