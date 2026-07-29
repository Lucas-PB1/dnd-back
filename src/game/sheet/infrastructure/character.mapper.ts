import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { PhbSpecies } from '../../../entities/phb-species.entity';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterDomainService } from '../domain/core/character-domain.service';
import { computeDerivedStats } from '../domain/stats/character-derived-stats';
import {
  applyClassAbilityBoosts,
  classHitPointsBonus,
} from '../domain/stats/class-ability-boost';
import { loadClassAbilityBoosts } from './load-class-ability-boosts';
import { CharacterSheetRepository } from './character-sheet.repository';
import { CharacterSheetData } from '../domain/character-sheet.types';
import { ResolveEquippedArmorClass } from '../../combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '../../combat/application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '../../combat/application/resolve-equipment-compliance';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '../../spellcasting/application/load-granted-spell-catalog';
import {
  resolveSizeCategory,
  sizeCategoryFromChoices,
} from '../../combat/domain/creature-size';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import { ResolveActivePermanentItemEffects } from '../../inventory/application/resolve-active-permanent-item-effects';
import { resolveCharacterCombatSlice } from '../../combat/application/resolve-character-combat-slice';
import { resolveCharacterSpellcastingSlice } from '../../spellcasting/application/resolve-character-spellcasting-slice';
import { collectFightingStyleSlugsFromSubclassOptions } from '../domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '../domain/validation/class-options/class-weapon-mastery-slots';

@Injectable()
export class CharacterMapper {
  constructor(
    private readonly dataSource: DataSource,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly equippedArmorClass: ResolveEquippedArmorClass,
    private readonly equippedWeaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly equipmentCompliance: ResolveEquipmentCompliance,
    private readonly permanentItemEffects: ResolveActivePermanentItemEffects,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
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
    const classBoosts = await loadClassAbilityBoosts(
      this.dataSource,
      row.classSlug,
    );
    const { scores: effectiveAbilityScores } = applyClassAbilityBoosts(
      row.abilityScores,
      row.level,
      classBoosts,
    );
    const classHpBonus = classHitPointsBonus(
      row.abilityScores.constituicao,
      effectiveAbilityScores.constituicao,
      row.level,
    );
    const derived = computeDerivedStats({
      abilityScores: effectiveAbilityScores,
      proficiencyBonus,
      classSkillSlugs: loaded.classSkillSlugs,
      backgroundSkillSlugs: loaded.backgroundSkillSlugs,
      speciesChoices: loaded.speciesChoices,
      featOptions: loaded.featOptions,
      classOptions: loaded.classOptions,
      classSlug: row.classSlug,
      level: row.level,
    });
    const featSlugs = loaded.characterFeats.map((feat) => feat.featSlug);

    const species = await this.speciesRepo.findOne({
      where: { slug: row.speciesSlug },
    });
    const sizeCategory = resolveSizeCategory(
      species?.size,
      sizeCategoryFromChoices(loaded.speciesChoices),
    );

    const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
      loaded.subclassOptions,
    );
    const combat = await resolveCharacterCombatSlice({
      characterId: row.id,
      abilityScores: effectiveAbilityScores,
      classSlug: row.classSlug,
      subclassSlug: row.subclassSlug,
      level: row.level,
      proficiencyBonus,
      featSlugs,
      fightingStyleSlugs,
      masteredWeaponSlugs: collectMasteredWeaponSlugs({
        classOptions: loaded.classOptions,
        featOptions: loaded.featOptions,
      }),
      sizeCategory,
      equippedArmorClass: this.equippedArmorClass,
      equippedWeaponAttacks: this.equippedWeaponAttacks,
      equipmentCompliance: this.equipmentCompliance,
      inventoryItems: this.inventoryItems,
      permanentItemEffects: this.permanentItemEffects,
    });

    const spellcasting = await resolveCharacterSpellcastingSlice({
      dataSource: this.dataSource,
      subclassSpellsRepo: this.subclassSpellsRepo,
      grantedSpellCatalog: this.grantedSpellCatalog,
      sheet: loaded,
      speciesSlug: row.speciesSlug,
      subclassSlug: row.subclassSlug,
      level: row.level,
      classSlug: row.classSlug,
      proficiencyBonus,
      abilityModifiers: derived.abilityModifiers,
      featSlugs,
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
      effectiveAbilityScores,
      hitPointsMax:
        row.hitPointsMax === null
          ? null
          : row.hitPointsMax + combat.itemHpBonus + classHpBonus,
      hitPointsCurrent: row.hitPointsCurrent,
      proficiencyBonus,
      classSkillSlugs: loaded.classSkillSlugs,
      speciesChoices: loaded.speciesChoices,
      subclassOptions: loaded.subclassOptions,
      classOptions: loaded.classOptions,
      characterFeats: loaded.characterFeats,
      featOptions: loaded.featOptions,
      characterSpells: spellcasting.characterSpells,
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
      armorClass: combat.armorClass,
      armorClassNote: combat.armorClassNote,
      weaponAttacks: combat.weaponAttacks,
      equipmentWarnings: combat.equipmentWarnings,
      cannotCastSpellsInArmor: combat.cannotCastSpellsInArmor,
      speedPenaltyMeters: combat.speedPenaltyMeters,
      itemSpeedBonusMeters: combat.itemSpeedBonusMeters,
      spellcastingAbilitySlug: spellcasting.spellcastingAbilitySlug,
      spellSaveDc: spellcasting.spellSaveDc,
      spellAttackBonus: spellcasting.spellAttackBonus,
      campaigns: [],
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
        return this.toDto(
          row,
          this.sheet.mergeSheetData(base, row.abilityGenerationMethodSlug),
        );
      }),
    );
  }
}
