import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { PlayerCharacterSkill } from './player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
  PlayerCharacterSubclassOption,
} from './player-sheet.entities';
import {
  CharacterSheetData,
  CharacterSheetInput,
  EMPTY_SHEET_DATA,
} from '../domain/character-sheet.types';

@Injectable()
export class CharacterSheetRepository {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(PlayerCharacterSkill)
    private readonly skills: Repository<PlayerCharacterSkill>,
    @InjectRepository(PlayerCharacterSpeciesChoice)
    private readonly speciesChoices: Repository<PlayerCharacterSpeciesChoice>,
    @InjectRepository(PlayerCharacterSubclassOption)
    private readonly subclassOptions: Repository<PlayerCharacterSubclassOption>,
    @InjectRepository(PlayerCharacterFeat)
    private readonly feats: Repository<PlayerCharacterFeat>,
    @InjectRepository(PlayerCharacterSpell)
    private readonly spells: Repository<PlayerCharacterSpell>,
    @InjectRepository(PlayerCharacterEquipment)
    private readonly equipment: Repository<PlayerCharacterEquipment>,
    @InjectRepository(PlayerCharacterLanguage)
    private readonly languages: Repository<PlayerCharacterLanguage>,
  ) {}

  async load(characterId: string, backgroundSlug?: string): Promise<CharacterSheetData> {
    const [
      skillRows,
      speciesRows,
      subclassRows,
      featRows,
      spellRows,
      equipmentRows,
      languageRows,
    ] = await Promise.all([
      this.skills.find({ where: { characterId }, order: { skillSlug: 'ASC' } }),
      this.speciesChoices.find({ where: { characterId }, order: { choiceKind: 'ASC' } }),
      this.subclassOptions.find({ where: { characterId }, order: { optionKey: 'ASC' } }),
      this.feats.find({ where: { characterId }, order: { featSlug: 'ASC' } }),
      this.spells.find({ where: { characterId }, order: { spellSlug: 'ASC' } }),
      this.equipment.find({ where: { characterId }, order: { sortOrder: 'ASC' } }),
      this.languages.find({ where: { characterId }, order: { languageSlug: 'ASC' } }),
    ]);

    const backgroundSkillSlugs = backgroundSlug
      ? await this.loadBackgroundSkillSlugs(backgroundSlug)
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
      featSlugs: featRows.map((row) => row.featSlug),
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

  async loadMany(
    characterIds: string[],
    backgroundByCharacterId: Map<string, string>,
  ): Promise<Map<string, CharacterSheetData>> {
    const map = new Map<string, CharacterSheetData>();
    if (characterIds.length === 0) return map;

    await Promise.all(
      characterIds.map(async (id) => {
        map.set(id, await this.load(id, backgroundByCharacterId.get(id)));
      }),
    );
    return map;
  }

  async loadBackgroundSkillSlugs(backgroundSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
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

  async sync(characterId: string, input: CharacterSheetInput): Promise<void> {
    if (input.classSkillSlugs !== undefined) {
      await this.skills.delete({ characterId });
      if (input.classSkillSlugs.length > 0) {
        await this.skills.insert(
          input.classSkillSlugs.map((skillSlug) => ({ characterId, skillSlug })),
        );
      }
    }

    if (input.speciesChoices !== undefined) {
      await this.speciesChoices.delete({ characterId });
      if (input.speciesChoices.length > 0) {
        await this.speciesChoices.insert(
          input.speciesChoices.map((choice) => ({
            characterId,
            choiceKind: choice.choiceKind,
            choiceSlug: choice.choiceSlug,
          })),
        );
      }
    }

    if (input.subclassOptions !== undefined) {
      await this.subclassOptions.delete({ characterId });
      if (input.subclassOptions.length > 0) {
        await this.subclassOptions.insert(
          input.subclassOptions.map((option) => ({
            characterId,
            optionKey: option.optionKey,
            valueId: option.valueId,
          })),
        );
      }
    }

    if (input.featSlugs !== undefined) {
      await this.feats.delete({ characterId });
      if (input.featSlugs.length > 0) {
        await this.feats.insert(
          input.featSlugs.map((featSlug) => ({ characterId, featSlug })),
        );
      }
    }

    if (input.characterSpells !== undefined) {
      await this.spells.delete({ characterId });
      if (input.characterSpells.length > 0) {
        await this.spells.insert(
          input.characterSpells.map((spell) => ({
            characterId,
            spellSlug: spell.spellSlug,
            listType: spell.listType,
          })),
        );
      }
    }

    if (input.equipment !== undefined) {
      await this.equipment.delete({ characterId });
      if (input.equipment.length > 0) {
        await this.equipment.insert(
          input.equipment.map((item, index) => ({
            characterId,
            source: item.source,
            packageSlug: item.packageSlug,
            itemSlug: item.itemSlug ?? null,
            quantity: item.quantity ?? 1,
            sortOrder: item.sortOrder ?? index,
          })),
        );
      }
    }

    if (input.languageSlugs !== undefined) {
      await this.languages.delete({ characterId });
      if (input.languageSlugs.length > 0) {
        await this.languages.insert(
          input.languageSlugs.map((languageSlug) => ({ characterId, languageSlug })),
        );
      }
    }
  }

  async clearSubclassOptions(characterId: string): Promise<void> {
    await this.subclassOptions.delete({ characterId });
  }

  async clearClassSkills(characterId: string): Promise<void> {
    await this.skills.delete({ characterId });
  }

  async clearSpeciesChoices(characterId: string): Promise<void> {
    await this.speciesChoices.delete({ characterId });
  }

  mergeSheetData(
    base: CharacterSheetData,
    abilityGenerationMethodSlug: string | null,
  ): CharacterSheetData {
    return {
      ...base,
      abilityGenerationMethodSlug,
    };
  }

  empty(): CharacterSheetData {
    return { ...EMPTY_SHEET_DATA };
  }
}
