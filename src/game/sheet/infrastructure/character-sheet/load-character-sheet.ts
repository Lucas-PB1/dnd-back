import { DataSource, Repository } from 'typeorm';
import {
  CharacterSheetData,
  EMPTY_SHEET_DATA,
  type GrantedSpellSheetSlice,
} from '../../domain/character-sheet.types';
import { PlayerCharacterSkill } from '../player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterOption,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
} from '../player-sheet.entities';

export type CharacterSheetLoadDeps = {
  dataSource: DataSource;
  skills: Repository<PlayerCharacterSkill>;
  speciesChoices: Repository<PlayerCharacterSpeciesChoice>;
  options: Repository<PlayerCharacterOption>;
  feats: Repository<PlayerCharacterFeat>;
  spells: Repository<PlayerCharacterSpell>;
  equipment: Repository<PlayerCharacterEquipment>;
  languages: Repository<PlayerCharacterLanguage>;
};

export async function loadCharacterSheet(
  deps: CharacterSheetLoadDeps,
  characterId: string,
  backgroundSlug?: string,
): Promise<CharacterSheetData> {
  const [
    skillRows,
    speciesRows,
    subclassRows,
    classOptionRows,
    featRows,
    featOptionRows,
    spellRows,
    equipmentRows,
    languageRows,
  ] = await Promise.all([
    deps.skills.find({ where: { characterId }, order: { skillSlug: 'ASC' } }),
    deps.speciesChoices.find({
      where: { characterId },
      order: { choiceKind: 'ASC' },
    }),
    deps.options.find({
      where: { characterId, scope: 'subclass' },
      order: { optionKey: 'ASC' },
    }),
    deps.options.find({
      where: { characterId, scope: 'class' },
      order: { optionKey: 'ASC' },
    }),
    deps.feats.find({
      where: { characterId },
      order: { featSlug: 'ASC', instanceIndex: 'ASC' },
    }),
    deps.options.find({
      where: { characterId, scope: 'feat' },
      order: { ownerSlug: 'ASC', instanceIndex: 'ASC', optionKey: 'ASC' },
    }),
    deps.spells.find({ where: { characterId }, order: { spellSlug: 'ASC' } }),
    deps.equipment.find({
      where: { characterId },
      order: { sortOrder: 'ASC' },
    }),
    deps.languages.find({
      where: { characterId },
      order: { languageSlug: 'ASC' },
    }),
  ]);

  const backgroundSkillSlugs = backgroundSlug
    ? await loadBackgroundSkillSlugs(deps, backgroundSlug)
    : [];

  return {
    classSkillSlugs: skillRows.map((row) => row.skillSlug),
    speciesChoices: speciesRows.map((row) => ({
      choiceKind: row.choiceKind,
      choiceSlug: row.choiceSlug,
    })),
    subclassOptions: subclassRows.map((row) => ({
      optionKey: row.optionKey,
      valueId: row.valueId,
    })),
    classOptions: classOptionRows.map((row) => ({
      optionKey: row.optionKey,
      valueId: row.valueId,
    })),
    characterFeats: featRows.map((row) => ({
      featSlug: row.featSlug,
      instanceIndex: row.instanceIndex,
    })),
    featOptions: featOptionRows.map((row) => ({
      featSlug: row.ownerSlug,
      instanceIndex: row.instanceIndex,
      optionKey: row.optionKey,
      valueId: row.valueId,
    })),
    characterSpells: spellRows.map((row) => ({
      spellSlug: row.spellSlug,
      listType: row.listType as 'known' | 'prepared' | 'always_prepared',
    })),
    equipment: equipmentRows.map((row) => ({
      source: row.source as 'class' | 'background',
      packageSlug: row.packageSlug,
      itemSlug: row.itemSlug ?? undefined,
      quantity: row.quantity,
      sortOrder: row.sortOrder,
    })),
    languageSlugs: languageRows.map((row) => row.languageSlug),
    abilityGenerationMethodSlug: null,
    backgroundSkillSlugs,
  };
}

/** Só feats/options/species choices/spells — para GET state (granted casts). */
export async function loadGrantedSpellSheetSlice(
  deps: Pick<
    CharacterSheetLoadDeps,
    'speciesChoices' | 'options' | 'feats' | 'spells'
  >,
  characterId: string,
): Promise<GrantedSpellSheetSlice> {
  const [speciesRows, featRows, featOptionRows, spellRows] = await Promise.all([
    deps.speciesChoices.find({
      where: { characterId },
      order: { choiceKind: 'ASC' },
    }),
    deps.feats.find({
      where: { characterId },
      order: { featSlug: 'ASC', instanceIndex: 'ASC' },
    }),
    deps.options.find({
      where: { characterId, scope: 'feat' },
      order: { ownerSlug: 'ASC', instanceIndex: 'ASC', optionKey: 'ASC' },
    }),
    deps.spells.find({ where: { characterId }, order: { spellSlug: 'ASC' } }),
  ]);

  return {
    speciesChoices: speciesRows.map((row) => ({
      choiceKind: row.choiceKind,
      choiceSlug: row.choiceSlug,
    })),
    characterFeats: featRows.map((row) => ({
      featSlug: row.featSlug,
      instanceIndex: row.instanceIndex,
    })),
    featOptions: featOptionRows.map((row) => ({
      featSlug: row.ownerSlug,
      instanceIndex: row.instanceIndex,
      optionKey: row.optionKey,
      valueId: row.valueId,
    })),
    characterSpells: spellRows.map((row) => ({
      spellSlug: row.spellSlug,
      listType: row.listType as 'known' | 'prepared' | 'always_prepared',
    })),
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
      map.set(id, await loadCharacterSheet(deps, id, backgroundByCharacterId.get(id)));
    }),
  );
  return map;
}

export async function loadBackgroundSkillSlugs(
  deps: Pick<CharacterSheetLoadDeps, 'dataSource'>,
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
