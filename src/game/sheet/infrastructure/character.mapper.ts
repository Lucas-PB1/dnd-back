import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { PhbSpecies } from '../../../entities/phb-species.entity';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterDomainService } from '../domain/character-domain.service';
import { computeDerivedStats } from '../domain/character-derived-stats';
import { spellcastingDerivedStats } from '../domain/spellcasting-stats';
import type { AbilityKey } from '../../build/domain/ability-generation';
import { CharacterSheetRepository } from './character-sheet.repository';
import { CharacterSheetData } from '../domain/character-sheet.types';
import { EquippedArmorClassService } from './equipped-armor-class.service';
import { EquippedWeaponAttacksService } from './equipped-weapon-attacks.service';
import { EquippedEquipmentComplianceService } from './equipped-equipment-compliance.service';
import { collectFightingStyleSlugsFromSubclassOptions } from '../domain/fighting-style-feat-options';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '../domain/granted-spells';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { GrantedSpellCatalogService } from './granted-spell-catalog.service';
import {
  resolveSizeCategory,
  sizeCategoryFromChoices,
} from '../domain/creature-size';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';

const ABILITY_SLUGS = new Set<AbilityKey>([
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
]);

@Injectable()
export class CharacterMapper {
  constructor(
    private readonly dataSource: DataSource,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly equippedArmorClass: EquippedArmorClassService,
    private readonly equippedWeaponAttacks: EquippedWeaponAttacksService,
    private readonly equipmentCompliance: EquippedEquipmentComplianceService,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    private readonly grantedSpellCatalog: GrantedSpellCatalogService,
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
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
    const featSlugs = loaded.characterFeats.map((feat) => feat.featSlug);
    const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
      loaded.subclassOptions,
    );

    const species = await this.speciesRepo.findOne({
      where: { slug: row.speciesSlug },
    });
    const sizeCategory = resolveSizeCategory(
      species?.size,
      sizeCategoryFromChoices(loaded.speciesChoices),
    );

    const hasShield = await this.inventoryItems.exist({
      where: {
        characterId: row.id,
        location: 'equipped',
        equipmentSlot: 'shield',
      },
    });

    const armor = await this.equippedArmorClass.resolve(row.id, row.abilityScores, {
      classSlug: row.classSlug,
      subclassSlug: row.subclassSlug,
      featSlugs,
      fightingStyleSlugs,
    });
    const weaponAttacks = await this.equippedWeaponAttacks.resolve(
      row.id,
      row.abilityScores,
      {
        classSlug: row.classSlug,
        proficiencyBonus,
        featSlugs,
        fightingStyleSlugs,
        sizeCategory,
        hasShield,
      },
    );

    const compliance = await this.equipmentCompliance.resolve(row.id, {
      classSlug: row.classSlug,
      strengthScore: row.abilityScores.forca,
      featSlugs,
      sizeCategory,
      hasShield,
    });

    const spellcastingAbilitySlug = await this.loadSpellcastingAbilitySlug(
      row.classSlug,
    );
    const spellcasting = spellcastingDerivedStats({
      spellcastingAbilitySlug,
      proficiencyBonus,
      abilityModifiers: derived.abilityModifiers,
    });

    const { speciesCatalog, featFixedSpells } =
      await this.grantedSpellCatalog.loadMergeCatalog({
        speciesSlugs: [row.speciesSlug],
        featSlugs,
      });
    const featGrantedSlugs = collectFeatGrantedSpellSlugs(
      loaded.featOptions,
      loaded.characterFeats,
      featFixedSpells,
    );
    const speciesGrantedSlugs = collectSpeciesGrantedSpellSlugs(
      row.speciesSlug,
      loaded.speciesChoices,
      row.level,
      speciesCatalog,
    );
    const subclassSpellSlugs = await this.loadSubclassSpellSlugs(row.subclassSlug);
    const characterSpells = annotateCharacterSpellSources(loaded.characterSpells, {
      featGrantedSlugs,
      speciesGrantedSlugs,
      subclassSpellSlugs,
    });

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
      characterSpells,
      equipment: loaded.equipment,
      languageSlugs: loaded.languageSlugs,
      abilityGenerationMethodSlug: loaded.abilityGenerationMethodSlug,
      backgroundSkillSlugs: loaded.backgroundSkillSlugs,
      backgroundAbilityBoostMode:
        row.backgroundBoostMode === 'plus1x3' ? 'plus1x3' : 'plus2plus1',
      backgroundAbilityBoostPlus2Slug: row.backgroundBoostPlus2AbilitySlug,
      backgroundAbilityBoostPlus1Slug: row.backgroundBoostPlus1AbilitySlug,
      backgroundAbilityBoostPlus1Slugs: row.backgroundBoostPlus1Slugs,
      backgroundToolItemSlug: row.backgroundToolItemSlug,
      abilityModifiers: derived.abilityModifiers,
      passivePerception: derived.passivePerception,
      armorClass: armor.armorClass,
      armorClassNote: armor.armorClassNote,
      weaponAttacks,
      equipmentWarnings: compliance.warnings,
      cannotCastSpellsInArmor: compliance.cannotCastSpells,
      speedPenaltyMeters: compliance.speedPenaltyMeters,
      spellcastingAbilitySlug: spellcasting.spellcastingAbilitySlug,
      spellSaveDc: spellcasting.spellSaveDc,
      spellAttackBonus: spellcasting.spellAttackBonus,
      campaigns: [],
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
    };
  }

  private async loadSpellcastingAbilitySlug(
    classSlug: string,
  ): Promise<AbilityKey | null> {
    const rows = await this.dataSource.query<{ ability_slug: string }[]>(
      `SELECT a.slug AS ability_slug
       FROM rpg.phb_class_spellcasting cs
       JOIN rpg.phb_class c ON c.id = cs.class_id
       JOIN rpg.phb_ability a ON a.id = cs.ability_id
       WHERE c.slug = $1
       LIMIT 1`,
      [classSlug],
    );
    const slug = rows[0]?.ability_slug;
    if (!slug || !ABILITY_SLUGS.has(slug as AbilityKey)) return null;
    return slug as AbilityKey;
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

  private async loadSubclassSpellSlugs(
    subclassSlug: string | null,
  ): Promise<Set<string>> {
    if (!subclassSlug) return new Set();
    const rows = await this.subclassSpellsRepo.find({
      where: { subclassSlug },
      select: ['spellSlug'],
    });
    return new Set(rows.map((row) => row.spellSlug));
  }
}
