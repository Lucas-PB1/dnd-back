import { DataSource } from 'typeorm';
import { applyItemAbilityBonuses } from '@game/inventory/domain/permanent-item-effects';
import {
  applyAbilityPenalties,
  collectAbilityPenaltiesFromInventory,
} from '@game/inventory/domain/artifact/artifact-instance-ops';
import { aggregateClassCombatContributions } from '../domain/aggregate-class-combat';
import { featCombatNotes } from '../domain/feat/combat-notes';
import { itemCombatNotes } from '../domain/item/combat-notes';
import { speciesCombatNotes } from '../domain/species/combat-notes';
import {
  heritageCombatNotes,
  loadHeritageHitPointsBonus,
} from '../domain/heritage/heritage-combat-notes';
import { manikinArmorPresetFromChoices } from '../domain/species/manikin-armor';
import { paladinSavingThrowAuraBonus } from '../domain/paladin';
import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/equipment';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { sheetProfile } from '@common/perf/sheet-profile';
import { loadCharacterCombatBundle } from '../infrastructure/load-character-combat-bundle';

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
  itemSpeedBonusMeters: number;
  itemHpBonus: number;
  heritageHpBonus: number;
  classCombatNotes: string[];
  attacksPerAction: number;
  savingThrowAuraBonus: number;
};

export async function resolveCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  speciesSlug?: string | null;
  heritageChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  speciesChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  classOptions?: readonly { optionKey: string; valueId: string }[];
  level: number;
  proficiencyBonus: number;
  featSlugs: string[];
  fightingStyleSlugs: string[];
  masteredWeaponSlugs: string[];
  sizeCategory: SizeCategory;
  dataSource: DataSource;
  equippedArmorClass: ResolveEquippedArmorClass;
  equippedWeaponAttacks: ResolveEquippedWeaponAttacks;
  equipmentCompliance: ResolveEquipmentCompliance;
  permanentItemEffects: ResolveActivePermanentItemEffects;
}): Promise<MappedCombatSlice> {
  const {
    characterId,
    abilityScores,
    classSlug,
    subclassSlug,
    speciesSlug,
    heritageChoices,
    speciesChoices,
    classOptions,
    level,
    proficiencyBonus,
    featSlugs,
    fightingStyleSlugs,
    masteredWeaponSlugs,
    sizeCategory,
    dataSource,
    equippedArmorClass,
    equippedWeaponAttacks,
    equipmentCompliance,
    permanentItemEffects,
  } = input;

  const bundle = await sheetProfile('combat.p031', () =>
    loadCharacterCombatBundle(
      dataSource,
      characterId,
      classSlug,
      subclassSlug,
    ),
  );
  const inventoryRows = bundle.inventory;
  const equippedItems = inventoryRows.filter((row) => row.location === 'equipped');
  const hasShield = equippedItems.some((row) => row.equipmentSlot === 'shield');

  const itemEffects = await sheetProfile('combat.itemEffects', () =>
    permanentItemEffects.resolve(characterId, {
      inventoryRows,
      catalogItems: bundle.items,
    }),
  );
  const withItemBonuses = applyItemAbilityBonuses(
    abilityScores,
    itemEffects.abilityBonuses,
    itemEffects.abilityScoreCaps,
  );
  const combatScores = applyAbilityPenalties(
    withItemBonuses,
    collectAbilityPenaltiesFromInventory(inventoryRows),
  );

  const armor = await sheetProfile('combat.armor', () =>
    equippedArmorClass.resolve(characterId, combatScores, {
      classSlug,
      subclassSlug,
      featSlugs,
      fightingStyleSlugs,
      itemAcBonus: itemEffects.acBonus,
      itemAcBonusNames: itemEffects.sourceNames,
      equippedItems,
      armorCatalogRows: bundle.armor,
      unarmoredDefenses: bundle.unarmoredDefenses,
      manikinArmorPresetSlug: manikinArmorPresetFromChoices(
        speciesSlug,
        speciesChoices,
      ),
    }),
  );
  const [weaponAttacks, compliance] = await Promise.all([
    sheetProfile('combat.weapons', () =>
      equippedWeaponAttacks.resolve(characterId, combatScores, {
        classSlug,
        subclassSlug,
        level,
        proficiencyBonus,
        featSlugs,
        fightingStyleSlugs,
        classOptions,
        sizeCategory,
        hasShield,
        masteredWeaponSlugs,
        itemAttackBonus: itemEffects.attackBonus,
        itemDamageBonus: itemEffects.damageBonus,
        equippedItems,
      }),
    ),
    sheetProfile('combat.compliance', () =>
      equipmentCompliance.resolve(characterId, {
        classSlug,
        strengthScore: combatScores.forca,
        featSlugs,
        classOptions,
        sizeCategory,
        hasShield,
        equippedItems,
        armorCatalogRows: bundle.armor,
      }),
    ),
  ]);

  const classCombat = aggregateClassCombatContributions({
    classSlug,
    subclassSlug,
    level,
  });
  const speciesNotes = speciesCombatNotes({ speciesSlug, speciesChoices });
  const heritageNotes = heritageCombatNotes({ heritageChoices });
  const heritageHpBonus = await sheetProfile('combat.heritageHp', () =>
    loadHeritageHitPointsBonus(
      dataSource,
      heritageChoices ?? [],
      level,
    ),
  );
  const featNotes = featCombatNotes({
    featSlugs: [...featSlugs, ...fightingStyleSlugs],
  });
  const propertiesBySlug = new Map(
    bundle.items.map((item) => [item.slug, item.properties] as const),
  );
  const itemNotes = itemCombatNotes({
    itemSlugs: bundle.activeItemSlugs,
    propertiesBySlug,
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
    heritageHpBonus,
    classCombatNotes: [
      ...speciesNotes,
      ...heritageNotes,
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
