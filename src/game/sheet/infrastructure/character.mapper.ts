import { Injectable } from '@nestjs/common';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterDomainService } from '../domain/character-domain.service';
import { computeDerivedStats } from '../domain/character-derived-stats';
import { CharacterSheetRepository } from './character-sheet.repository';
import { CharacterSheetData } from '../domain/character-sheet.types';
import { EquippedArmorClassService } from './equipped-armor-class.service';

@Injectable()
export class CharacterMapper {
  constructor(
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly equippedArmorClass: EquippedArmorClassService,
  ) {}

  async toDto(
    row: PlayerCharacter,
    sheetData?: CharacterSheetData,
  ): Promise<CharacterResponseDto> {
    const loaded =
      sheetData ??
      this.sheet.mergeSheetData(
        await this.sheet.load(row.id, row.backgroundSlug),
        row.abilityGenerationMethodSlug,
      );

    const proficiencyBonus = await this.domain.getProficiencyBonus(row.level);
    const derived = computeDerivedStats({
      abilityScores: row.abilityScores,
      proficiencyBonus,
      classSkillSlugs: loaded.classSkillSlugs,
      backgroundSkillSlugs: loaded.backgroundSkillSlugs,
    });
    const armor = await this.equippedArmorClass.resolve(row.id, row.abilityScores);

    return {
      id: row.id,
      name: row.name,
      level: row.level,
      classSlug: row.classSlug,
      speciesSlug: row.speciesSlug,
      backgroundSlug: row.backgroundSlug,
      subclassSlug: row.subclassSlug,
      alignmentSlug: row.alignmentSlug,
      abilityScores: row.abilityScores,
      hitPointsMax: row.hitPointsMax,
      hitPointsCurrent: row.hitPointsCurrent,
      proficiencyBonus,
      classSkillSlugs: loaded.classSkillSlugs,
      speciesChoices: loaded.speciesChoices,
      subclassOptions: loaded.subclassOptions,
      characterFeats: loaded.characterFeats,
      featOptions: loaded.featOptions,
      characterSpells: loaded.characterSpells,
      equipment: loaded.equipment,
      languageSlugs: loaded.languageSlugs,
      abilityGenerationMethodSlug: loaded.abilityGenerationMethodSlug,
      backgroundSkillSlugs: loaded.backgroundSkillSlugs,
      backgroundAbilityBoostPlus2Slug: row.backgroundBoostPlus2AbilitySlug,
      backgroundAbilityBoostPlus1Slug: row.backgroundBoostPlus1AbilitySlug,
      backgroundToolItemSlug: row.backgroundToolItemSlug,
      abilityModifiers: derived.abilityModifiers,
      passivePerception: derived.passivePerception,
      armorClass: armor.armorClass,
      armorClassNote: armor.armorClassNote,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
    };
  }

  async toDtoList(rows: PlayerCharacter[]): Promise<CharacterResponseDto[]> {
    const sheetMap = await this.sheet.loadMany(
      rows.map((row) => row.id),
      new Map(rows.map((row) => [row.id, row.backgroundSlug])),
    );

    return Promise.all(
      rows.map((row) => {
        const base = sheetMap.get(row.id) ?? this.sheet.empty();
        return this.toDto(row, this.sheet.mergeSheetData(base, row.abilityGenerationMethodSlug));
      }),
    );
  }
}
