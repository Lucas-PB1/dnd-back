import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacterSkill } from './player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterOption,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
} from './player-sheet.entities';
import {
  CharacterSheetData,
  CharacterSheetInput,
} from '../domain/character-sheet.types';
import {
  emptySheetData,
  loadBackgroundSkillSlugs,
  loadCharacterSheet,
  loadGrantedSpellSheetSlice,
  loadManyCharacterSheets,
  mergeSheetData as mergeAbilityGeneration,
} from './character-sheet/load-character-sheet';
import type { GrantedSpellSheetSlice } from '../domain/character-sheet.types';
import {
  clearClassOptions,
  clearClassSkills,
  clearSpeciesChoices,
  clearSubclassOptions,
  syncCharacterSheet,
} from './character-sheet/sync-character-sheet';

@Injectable()
export class CharacterSheetRepository {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(PlayerCharacterSkill)
    private readonly skills: Repository<PlayerCharacterSkill>,
    @InjectRepository(PlayerCharacterSpeciesChoice)
    private readonly speciesChoices: Repository<PlayerCharacterSpeciesChoice>,
    @InjectRepository(PlayerCharacterOption)
    private readonly options: Repository<PlayerCharacterOption>,
    @InjectRepository(PlayerCharacterFeat)
    private readonly feats: Repository<PlayerCharacterFeat>,
    @InjectRepository(PlayerCharacterSpell)
    private readonly spells: Repository<PlayerCharacterSpell>,
    @InjectRepository(PlayerCharacterEquipment)
    private readonly equipment: Repository<PlayerCharacterEquipment>,
    @InjectRepository(PlayerCharacterLanguage)
    private readonly languages: Repository<PlayerCharacterLanguage>,
  ) {}

  private loadDeps() {
    return { dataSource: this.dataSource };
  }

  private syncDeps() {
    return {
      skills: this.skills,
      speciesChoices: this.speciesChoices,
      options: this.options,
      feats: this.feats,
      spells: this.spells,
      equipment: this.equipment,
      languages: this.languages,
      dataSource: this.dataSource,
    };
  }

  async load(
    characterId: string,
    backgroundSlug?: string,
  ): Promise<CharacterSheetData> {
    return loadCharacterSheet(this.loadDeps(), characterId, backgroundSlug);
  }

  async loadGrantedSpellSlice(
    characterId: string,
  ): Promise<GrantedSpellSheetSlice> {
    return loadGrantedSpellSheetSlice(this.loadDeps(), characterId);
  }

  async loadMany(
    characterIds: string[],
    backgroundByCharacterId: Map<string, string>,
  ): Promise<Map<string, CharacterSheetData>> {
    return loadManyCharacterSheets(
      this.loadDeps(),
      characterIds,
      backgroundByCharacterId,
    );
  }

  async loadBackgroundSkillSlugs(backgroundSlug: string): Promise<string[]> {
    return loadBackgroundSkillSlugs(this.loadDeps(), backgroundSlug);
  }

  async sync(characterId: string, input: CharacterSheetInput): Promise<void> {
    return syncCharacterSheet(this.syncDeps(), characterId, input);
  }

  async clearSubclassOptions(characterId: string): Promise<void> {
    return clearSubclassOptions(this.syncDeps(), characterId);
  }

  async clearClassOptions(characterId: string): Promise<void> {
    return clearClassOptions(this.syncDeps(), characterId);
  }

  async clearClassSkills(characterId: string): Promise<void> {
    return clearClassSkills(this.syncDeps(), characterId);
  }

  async clearSpeciesChoices(characterId: string): Promise<void> {
    return clearSpeciesChoices(this.syncDeps(), characterId);
  }

  mergeSheetData(
    base: CharacterSheetData,
    abilityGenerationMethodSlug: string | null,
  ): CharacterSheetData {
    return mergeAbilityGeneration(base, abilityGenerationMethodSlug);
  }

  empty(): CharacterSheetData {
    return emptySheetData();
  }
}
