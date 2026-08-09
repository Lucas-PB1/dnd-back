import { applyItemAbilityBonuses } from '@game/inventory/domain/permanent-item-effects';
import { aggregateClassCombatContributions } from '../domain/aggregate-class-combat';
import { featCombatNotes } from '../domain/feat/combat-notes';
import { itemCombatNotes } from '../domain/item/combat-notes';
import { speciesCombatNotes } from '../domain/species/combat-notes';
import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { Repository } from 'typeorm';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/creature-size';

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
  /** Notas de combate de classe + espécie + talento + item (Passivas). */
  classCombatNotes: string[];
  /** Ataques por Ação Atacar (Guerreiro Extra Attack). */
  attacksPerAction: number;
};

export async function resolveCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  speciesSlug: string;
  speciesChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  level: number;
  proficiencyBonus: number;
  featSlugs: string[];
  fightingStyleSlugs: string[];
  /** Itens ativos (equipado + sintonizado) e charms anexados. */
  activeItemSlugs?: string[];
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
    speciesSlug,
    speciesChoices,
    level,
    proficiencyBonus,
    featSlugs,
    fightingStyleSlugs,
    activeItemSlugs,
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
      subclassSlug,
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

  const classCombat = aggregateClassCombatContributions({
    classSlug,
    subclassSlug,
    level,
  });
  const speciesNotes = speciesCombatNotes({ speciesSlug, speciesChoices });
  const featNotes = featCombatNotes({
    featSlugs: [...featSlugs, ...fightingStyleSlugs],
  });
  const itemNotes = itemCombatNotes({
    itemSlugs: activeItemSlugs ?? [],
  });

  return {
    armorClass: armor.armorClass,
    armorClassNote: armor.armorClassNote,
    weaponAttacks,
    equipmentWarnings: compliance.warnings,
    cannotCastSpellsInArmor: compliance.cannotCastSpells,
    speedPenaltyMeters: compliance.speedPenaltyMeters,
    itemSpeedBonusMeters:
      itemEffects.speedBonusMeters + classCombat.speedBonusMeters,
    itemHpBonus: itemEffects.hpBonus,
    classCombatNotes: [
      ...speciesNotes,
      ...featNotes,
      ...itemNotes,
      ...classCombat.notes,
    ],
    attacksPerAction: classCombat.attacksPerAction,
  };
}
