import { DataSource } from 'typeorm';
import {
  armorPresetSlugFromChoices,
  findArmorPreset,
} from '../../domain/species/manikin-armor';
import {
  loadSpeciesArmorPresets,
  loadSpeciesOptionDamageTypes,
} from '../../infrastructure/species-catalog.queries';
import { ResolveEquippedArmorClass } from '../resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '../resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '../resolve-equipment-compliance';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../../domain/equipment';
import { sheetProfile } from '@common/perf/sheet-profile';
import { unarmedDamageDieFromEffects } from '@game/effects';
import { assembleMappedCombatSlice } from './assemble-slice';
import { loadCombatScoresAndEffects } from './load-scores-and-effects';
import type { MappedCombatSlice } from './types';
import type { CatalogEffect } from '@game/effects';

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
  featEffects?: readonly CatalogEffect[];
  speciesEffects?: readonly CatalogEffect[];
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
    featEffects,
    speciesEffects,
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

  const armorPresets = await loadSpeciesArmorPresets(dataSource, speciesSlug);
  const presetSlug = armorPresetSlugFromChoices(armorPresets, speciesChoices);
  const speciesArmorPreset = findArmorPreset(armorPresets, presetSlug);

  const armor = await sheetProfile('combat.armor', () =>
    equippedArmorClass.resolve(characterId, combatScores, {
      classSlug,
      subclassSlug,
      featSlugs,
      fightingStyleSlugs,
      featEffects,
      itemAcBonus: itemEffects.acBonus,
      itemAcBonusNames: itemEffects.sourceNames,
      equippedItems,
      armorCatalogRows: bundle.armor,
      unarmoredDefenses: bundle.unarmoredDefenses,
      speciesArmorPreset,
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
        unarmedDamageDie: unarmedDamageDieFromEffects(featEffects ?? []),
        featEffects,
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
    proficiencyBonus,
    speciesSlug,
    heritageChoices,
    speciesChoices,
    transformation,
    featSlugs,
    featEffects,
    speciesEffects,
    fightingStyleSlugs,
    combatScores,
    dataSource,
    bundle,
    optionDamageTypes: await loadSpeciesOptionDamageTypes(
      dataSource,
      speciesSlug,
    ),
  });
}
