import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/creature-size';
import { EquippedArmorClassService } from '../infrastructure/equipped-armor-class.service';
import { EquippedWeaponAttacksService } from '../infrastructure/equipped-weapon-attacks.service';
import { EquippedEquipmentComplianceService } from '../infrastructure/equipped-equipment-compliance.service';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
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

export async function resolveCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  proficiencyBonus: number;
  featSlugs: string[];
  fightingStyleSlugs: string[];
  masteredWeaponSlugs: string[];
  sizeCategory: SizeCategory;
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
    fightingStyleSlugs,
    masteredWeaponSlugs,
    sizeCategory,
    equippedArmorClass,
    equippedWeaponAttacks,
    equipmentCompliance,
    inventoryItems,
  } = input;

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
      masteredWeaponSlugs,
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
