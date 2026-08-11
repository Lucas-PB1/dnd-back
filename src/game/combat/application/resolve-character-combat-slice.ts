import { applyItemAbilityBonuses } from '@game/inventory/domain/permanent-item-effects';
import {
  applyAbilityPenalties,
  collectAbilityPenaltiesFromInventory,
} from '@game/inventory/domain/artifact/artifact-instance-ops';
import { aggregateClassCombatContributions } from '../domain/aggregate-class-combat';
import { featCombatNotes } from '../domain/feat/combat-notes';
import { itemCombatNotes } from '../domain/item/combat-notes';
import { speciesCombatNotes } from '../domain/species/combat-notes';
import { paladinSavingThrowAuraBonus } from '../domain/paladin';
import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { In, Repository } from 'typeorm';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/equipment';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { PhbItem } from '@entities/phb-item.entity';

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
  /**
   * Bônus de salvaguarda vindo de auras/features de classe (ex.: Aura de Proteção).
   * SSOT no domain da API — o front só exibe; não recalcula.
   */
  savingThrowAuraBonus: number;
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

  const inventoryRows = await inventoryItems.find({ where: { characterId } });
  const equippedItems = inventoryRows.filter((row) => row.location === 'equipped');
  const hasShield = equippedItems.some((row) => row.equipmentSlot === 'shield');

  const itemEffects = await permanentItemEffects.resolve(characterId, {
    inventoryRows,
  });
  const withItemBonuses = applyItemAbilityBonuses(
    abilityScores,
    itemEffects.abilityBonuses,
    itemEffects.abilityScoreCaps,
  );
  const combatScores = applyAbilityPenalties(
    withItemBonuses,
    collectAbilityPenaltiesFromInventory(inventoryRows),
  );

  const armor = await equippedArmorClass.resolve(characterId, combatScores, {
    classSlug,
    subclassSlug,
    featSlugs,
    fightingStyleSlugs,
    itemAcBonus: itemEffects.acBonus,
    itemAcBonusNames: itemEffects.sourceNames,
    equippedItems,
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
      equippedItems,
    },
  );

  const compliance = await equipmentCompliance.resolve(characterId, {
    classSlug,
    strengthScore: combatScores.forca,
    featSlugs,
    sizeCategory,
    hasShield,
    equippedItems,
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
    propertiesBySlug: await loadItemCombatNoteProperties(
      inventoryItems,
      activeItemSlugs ?? [],
    ),
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
    savingThrowAuraBonus: paladinSavingThrowAuraBonus({
      classSlug,
      level,
      charismaModifier: abilityModifier(combatScores.carisma),
    }),
  };
}

async function loadItemCombatNoteProperties(
  inventoryItems: Repository<PlayerCharacterItem>,
  itemSlugs: readonly string[],
): Promise<Map<string, Record<string, unknown> | null>> {
  const map = new Map<string, Record<string, unknown> | null>();
  if (itemSlugs.length === 0) return map;
  const rows = await inventoryItems.manager.getRepository(PhbItem).find({
    where: { slug: In([...itemSlugs]) },
    select: ['slug', 'properties'],
  });
  for (const row of rows) {
    map.set(row.slug, row.properties);
  }
  return map;
}
