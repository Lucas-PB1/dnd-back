import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { PhbSpecies } from '@entities/phb-species.entity';
import {
  CharacterResponseDto,
  CharacterSummaryResponseDto,
} from '../dto/character-response.dto';
import { CharacterDomainService } from '../domain/core/character-domain.service';
import { computeDerivedStats } from '../domain/stats/character-derived-stats';
import {
  applyClassAbilityBoosts,
  classHitPointsBonus,
} from '../domain/stats/class-ability-boost';
import { loadClassAbilityBoosts } from './load-class-ability-boosts';
import { CharacterSheetRepository } from './character-sheet.repository';
import { CharacterSheetData } from '../domain/character-sheet.types';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '@game/combat/application/resolve-equipment-compliance';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  resolveSizeCategory,
  sizeCategoryFromChoices,
} from '@game/combat/domain/equipment';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import { resolveCharacterCombatSlice } from '@game/combat/application/resolve-character-combat-slice';
import { resolveCharacterSpellcastingSlice } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { loadActiveItemSlugs } from '@game/session/infrastructure/character-state/resources/class-resources';
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
      characterFeats: loaded.characterFeats,
      classOptions: loaded.classOptions,
      subclassOptions: loaded.subclassOptions,
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
    const activeItemSlugs = await loadActiveItemSlugs(this.dataSource, row.id);
    const combat = await resolveCharacterCombatSlice({
      characterId: row.id,
      abilityScores: effectiveAbilityScores,
      classSlug: row.classSlug,
      subclassSlug: row.subclassSlug,
      speciesSlug: row.speciesSlug,
      speciesChoices: loaded.speciesChoices,
      classOptions: loaded.classOptions,
      level: row.level,
      proficiencyBonus,
      featSlugs,
      fightingStyleSlugs,
      activeItemSlugs,
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
      classCombatNotes: combat.classCombatNotes,
      attacksPerAction: combat.attacksPerAction,
      savingThrowAuraBonus: combat.savingThrowAuraBonus,
      spellcastingAbilitySlug: spellcasting.spellcastingAbilitySlug,
      spellSaveDc: spellcasting.spellSaveDc,
      spellAttackBonus: spellcasting.spellAttackBonus,
      campaigns: [],
      coins: {
        copper: row.coinCopper,
        silver: row.coinSilver,
        electrum: row.coinElectrum,
        gold: row.coinGold,
        platinum: row.coinPlatinum,
      },
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
    };
  }

  toSummaryDto(row: PlayerCharacter): CharacterSummaryResponseDto {
    return {
      id: row.id,
      name: row.name,
      level: row.level,
      classSlug: row.classSlug,
      className: row.classSlug,
      speciesSlug: row.speciesSlug,
      speciesName: row.speciesSlug,
      backgroundSlug: row.backgroundSlug,
      subclassSlug: row.subclassSlug,
      subclassName: row.subclassSlug,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
      campaigns: [],
    };
  }

  toSummaryList(rows: PlayerCharacter[]): CharacterSummaryResponseDto[] {
    return rows.map((row) => this.toSummaryDto(row));
  }
}
