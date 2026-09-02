import { DataSource } from 'typeorm';
import { manikinArmorPresetFromChoices } from '../../domain/species/manikin-armor';
import { ResolveEquippedArmorClass } from '../resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '../resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '../resolve-equipment-compliance';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../../domain/equipment';
import { sheetProfile } from '@common/perf/sheet-profile';
import { assembleMappedCombatSlice } from './assemble-slice';
import { loadCombatScoresAndEffects } from './load-scores-and-effects';
import type { MappedCombatSlice } from './types';

export type { MappedCombatSlice } from './types';

export async function resolveCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  speciesSlug?: string | null;
  heritageChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  speciesChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  classOptions?: readonly { optionKey: string; valueId: string }[];
  transformation?: {
    slug: string;
    stage: number;
    choices?: readonly { choiceKind: string; choiceSlug: string }[];
  } | null;
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
    transformation,
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

  const { bundle, equippedItems, hasShield, itemEffects, combatScores } =
    await loadCombatScoresAndEffects({
      characterId,
      abilityScores,
      classSlug,
      subclassSlug,
      dataSource,
      permanentItemEffects,
    });

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

  return assembleMappedCombatSlice({
    armor,
    weaponAttacks,
    compliance,
    itemEffects,
    classSlug,
    subclassSlug,
    level,
    speciesSlug,
    heritageChoices,
    speciesChoices,
    transformation,
    featSlugs,
    fightingStyleSlugs,
    combatScores,
    dataSource,
    bundle,
  });
}
