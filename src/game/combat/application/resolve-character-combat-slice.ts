import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/creature-size';
import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import { Repository } from 'typeorm';
import type { ResolveActivePermanentItemEffects } from '../../inventory/application/resolve-active-permanent-item-effects';
import { applyItemAbilityBonuses } from '../../inventory/domain/permanent-item-effects';

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
  /** Bônus de deslocamento de itens ativos (metros). */
  itemSpeedBonusMeters: number;
  /** Bônus de PV máximos de itens ativos. */
  itemHpBonus: number;
};

export async function resolveCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  proficiencyBonus: number;
  featSlugs: string[];
  fightingStyleSlugs: string[];
  masteredWeaponSlugs: string[];
  sizeCategory: SizeCategory;
  equippedArmorClass: ResolveEquippedArmorClass;
  equippedWeaponAttacks: ResolveEquippedWeaponAttacks;
  equipmentCompliance: ResolveEquipmentCompliance;
  inventoryItems: Repository<PlayerCharacterItem>;
  permanentItemEffects: ResolveActivePermanentItemEffects;
}): Promise<MappedCombatSlice> {
  const {
    characterId,
    abilityScores,
    classSlug,
    subclassSlug,
    level,
    proficiencyBonus,
    featSlugs,
    fightingStyleSlugs,
    masteredWeaponSlugs,
    sizeCategory,
    equippedArmorClass,
    equippedWeaponAttacks,
    equipmentCompliance,
    inventoryItems,
    permanentItemEffects,
  } = input;

  const itemEffects = await permanentItemEffects.resolve(characterId);
  const combatScores = applyItemAbilityBonuses(
    abilityScores,
    itemEffects.abilityBonuses,
    itemEffects.abilityScoreCaps,
  );

  const hasShield = await inventoryItems.exist({
    where: {
      characterId,
      location: 'equipped',
      equipmentSlot: 'shield',
    },
  });

  const armor = await equippedArmorClass.resolve(characterId, combatScores, {
    classSlug,
    subclassSlug,
    featSlugs,
    fightingStyleSlugs,
    itemAcBonus: itemEffects.acBonus,
    itemAcBonusNames: itemEffects.sourceNames,
  });
  const weaponAttacks = await equippedWeaponAttacks.resolve(
    characterId,
    combatScores,
    {
      classSlug,
      level,
      proficiencyBonus,
      featSlugs,
      fightingStyleSlugs,
      sizeCategory,
      hasShield,
      masteredWeaponSlugs,
      itemAttackBonus: itemEffects.attackBonus,
      itemDamageBonus: itemEffects.damageBonus,
    },
  );

  const compliance = await equipmentCompliance.resolve(characterId, {
    classSlug,
    strengthScore: combatScores.forca,
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
    itemSpeedBonusMeters: itemEffects.speedBonusMeters,
    itemHpBonus: itemEffects.hpBonus,
  };
}
