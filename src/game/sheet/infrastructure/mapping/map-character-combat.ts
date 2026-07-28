import type { AbilityScores } from '../../../shared/infrastructure/player-character.entity';
import type { CharacterSheetData } from '../../domain/character-sheet.types';
import type { SizeCategory } from '../../domain/combat/creature-size';
import { collectFightingStyleSlugsFromSubclassOptions } from '../../domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '../../domain/validation/class-options/class-weapon-mastery-slots';
import { EquippedArmorClassService } from '../equipped-armor-class.service';
import { EquippedWeaponAttacksService } from '../equipped-weapon-attacks.service';
import { EquippedEquipmentComplianceService } from '../equipped-equipment-compliance.service';
import { PlayerCharacterItem } from '../../../inventory/infrastructure/player-character-item.entity';
import { Repository } from 'typeorm';

export type MappedCombatSlice = {
  armorClass: number;
  armorClassNote: string;
  weaponAttacks: Awaited<ReturnType<EquippedWeaponAttacksService['resolve']>>;
  equipmentWarnings: Awaited<
    ReturnType<EquippedEquipmentComplianceService['resolve']>
  >['warnings'];
  cannotCastSpellsInArmor: boolean;
  speedPenaltyMeters: Awaited<
    ReturnType<EquippedEquipmentComplianceService['resolve']>
  >['speedPenaltyMeters'];
};

export async function mapCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  proficiencyBonus: number;
  featSlugs: string[];
  sizeCategory: SizeCategory;
  sheet: CharacterSheetData;
  equippedArmorClass: EquippedArmorClassService;
  equippedWeaponAttacks: EquippedWeaponAttacksService;
  equipmentCompliance: EquippedEquipmentComplianceService;
  inventoryItems: Repository<PlayerCharacterItem>;
}): Promise<MappedCombatSlice> {
  const {
    characterId,
    abilityScores,
    classSlug,
    subclassSlug,
    proficiencyBonus,
    featSlugs,
    sizeCategory,
    sheet,
    equippedArmorClass,
    equippedWeaponAttacks,
    equipmentCompliance,
    inventoryItems,
  } = input;

  const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
    sheet.subclassOptions,
  );

  const hasShield = await inventoryItems.exist({
    where: {
      characterId,
      location: 'equipped',
      equipmentSlot: 'shield',
    },
  });

  const armor = await equippedArmorClass.resolve(characterId, abilityScores, {
    classSlug,
    subclassSlug,
    featSlugs,
    fightingStyleSlugs,
  });
  const weaponAttacks = await equippedWeaponAttacks.resolve(
    characterId,
    abilityScores,
    {
      classSlug,
      proficiencyBonus,
      featSlugs,
      fightingStyleSlugs,
      sizeCategory,
      hasShield,
      masteredWeaponSlugs: collectMasteredWeaponSlugs({
        classOptions: sheet.classOptions,
        featOptions: sheet.featOptions,
      }),
    },
  );

  const compliance = await equipmentCompliance.resolve(characterId, {
    classSlug,
    strengthScore: abilityScores.forca,
    featSlugs,
    sizeCategory,
    hasShield,
  });

  return {
    armorClass: armor.armorClass,
    armorClassNote: armor.armorClassNote,
    weaponAttacks,
    equipmentWarnings: compliance.warnings,
    cannotCastSpellsInArmor: compliance.cannotCastSpells,
    speedPenaltyMeters: compliance.speedPenaltyMeters,
  };
}
