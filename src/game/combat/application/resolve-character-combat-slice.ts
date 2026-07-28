import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/creature-size';
import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import { Repository } from 'typeorm';

export type MappedCombatSlice = {
  armorClass: number;
  armorClassNote: string;
  weaponAttacks: Awaited<ReturnType<ResolveEquippedWeaponAttacks['resolve']>>;
  equipmentWarnings: Awaited<
    ReturnType<ResolveEquipmentCompliance['resolve']>
  >['warnings'];
  cannotCastSpellsInArmor: boolean;
  speedPenaltyMeters: Awaited<
    ReturnType<ResolveEquipmentCompliance['resolve']>
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
  equippedArmorClass: ResolveEquippedArmorClass;
  equippedWeaponAttacks: ResolveEquippedWeaponAttacks;
  equipmentCompliance: ResolveEquipmentCompliance;
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
