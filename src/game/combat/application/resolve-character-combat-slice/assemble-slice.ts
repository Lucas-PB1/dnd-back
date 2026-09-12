import type { DataSource } from 'typeorm';
import type { CatalogEffect } from '@game/effects';
import {
  acBonusFromEffects,
  acBonusSourcesFromEffects,
  hasDamageDieExplode,
  hasDamageDieFlip,
  hasDamageDieFloor,
  hasImproveCritical,
  hasInspirationRefundOnFail,
  hasSlotElevate,
  hasSlotReduce,
  hasVersatileOneHandFullDamage,
  hasWieldTwoHandedOneHand,
  speedBonusMetersFromEffects,
} from '@game/effects';
import { aggregateClassCombatContributions } from '../../domain/aggregate-class-combat';
import { featCombatNotes } from '../../domain/feat/combat-notes';
import { itemCombatNotes } from '../../domain/item/combat-notes';
import { speciesCombatNotes } from '../../domain/species/combat-notes';
import {
  heritageCombatNotes,
  loadHeritageCombatNotes,
  loadHeritageHitPointsBonus,
} from '../../domain/heritage/heritage-combat-notes';
import { transformationCombatNotes } from '../../domain/notes/grim-hollow/transformation-combat-notes';
import { loadTransformationBoonCombatNotes } from '../../domain/notes/grim-hollow/load-transformation-boon-combat-notes';
import { loadTransformationHitPointsBonus } from '../../domain/notes/grim-hollow/load-transformation-hit-points-bonus';
import { loadTransformationChoiceRule } from '@game/sheet/domain/transformation/load-transformation-choice-rule';
import { paladinSavingThrowAuraBonus } from '../../domain/paladin';
import { CLASS_GATE } from '../../domain/feature-gates';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { sheetProfile } from '@common/perf/sheet-profile';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterCombatBundle } from '../../infrastructure/load-character-combat-bundle';
import type { LevelCombatNoteRow } from '../../infrastructure/level-combat-note.queries';
import type { MappedCombatSlice } from './types';

type ArmorResult = {
  armorClass: number;
  armorClassNote: string;
};

type ComplianceResult = {
  warnings: MappedCombatSlice['equipmentWarnings'];
  cannotCastSpells: boolean;
  speedPenaltyMeters: MappedCombatSlice['speedPenaltyMeters'];
};

type ItemEffectsSlice = {
  speedBonusMeters: number;
  hpBonus: number;
};

export async function assembleMappedCombatSlice(input: {
  armor: ArmorResult;
  weaponAttacks: MappedCombatSlice['weaponAttacks'];
  compliance: ComplianceResult;
  itemEffects: ItemEffectsSlice;
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  proficiencyBonus: number;
  speciesSlug?: string | null;
  heritageChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  speciesChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  transformation?: {
    slug: string;
    stage: number;
    choices?: readonly { choiceKind: string; choiceSlug: string }[];
  } | null;
  featSlugs: string[];
  featEffects?: readonly CatalogEffect[];
  speciesEffects?: readonly CatalogEffect[];
  fightingStyleSlugs: string[];
  combatScores: AbilityScores;
  dataSource: DataSource;
  bundle: Pick<CharacterCombatBundle, 'items' | 'activeItemSlugs'>;
  optionDamageTypes?: ReadonlyMap<string, string>;
  damageTypeLabels?: ReadonlyMap<string, string>;
  levelCombatNotes?: readonly LevelCombatNoteRow[];
  featureSchedules: readonly import('../../domain/feature-schedule').FeatureScheduleBand[];
  classFeatureGates?: ReadonlyMap<string, number>;
}): Promise<MappedCombatSlice> {
  const classCombat = aggregateClassCombatContributions({
    classSlug: input.classSlug,
    subclassSlug: input.subclassSlug,
    level: input.level,
    levelCombatNotes: input.levelCombatNotes,
    featureSchedules: input.featureSchedules,
  });
  const speciesNotes = speciesCombatNotes({
    speciesSlug: input.speciesSlug,
    speciesChoices: input.speciesChoices,
    speciesEffects: input.speciesEffects,
    optionDamageTypes: input.optionDamageTypes,
    damageTypeLabels: input.damageTypeLabels,
  });
  const heritageCatalogNotes = await sheetProfile('combat.heritageNotes', () =>
    loadHeritageCombatNotes(input.dataSource),
  );
  const heritageNotes = heritageCombatNotes({
    heritageChoices: input.heritageChoices,
    catalogNotes: heritageCatalogNotes,
  });
  const transformationBoonNotes = await sheetProfile(
    'combat.transformationBoonNotes',
    () => loadTransformationBoonCombatNotes(input.dataSource),
  );
  const transformationChoiceRules = input.transformation?.slug
    ? await sheetProfile('combat.transformationChoiceRules', () =>
        loadTransformationChoiceRule(
          input.dataSource,
          input.transformation!.slug,
        ),
      )
    : null;
  const transformationNotes = transformationCombatNotes(
    input.transformation ?? null,
    transformationBoonNotes,
    transformationChoiceRules,
  );
  const heritageHpBonus = await sheetProfile('combat.heritageHp', () =>
    loadHeritageHitPointsBonus(
      input.dataSource,
      input.heritageChoices ?? [],
      input.level,
    ),
  );
  const transformationHpBonus = await sheetProfile('combat.transformationHp', () =>
    loadTransformationHitPointsBonus(
      input.dataSource,
      input.transformation ?? null,
      input.level,
    ),
  );
  const featNotes = featCombatNotes({
    featSlugs: [...input.featSlugs, ...input.fightingStyleSlugs],
    featEffects: input.featEffects,
  });
  const propertiesBySlug = new Map(
    input.bundle.items.map(
      (item) => [item.slug, item.properties] as const,
    ),
  );
  const itemNotes = itemCombatNotes({
    itemSlugs: input.bundle.activeItemSlugs,
    propertiesBySlug,
  });

  const effects = input.featEffects ?? [];
  const featAcBonusSources = acBonusSourcesFromEffects(
    effects,
    input.featSlugs,
    input.proficiencyBonus,
  );
  const featAcBonus = acBonusFromEffects(
    effects,
    input.featSlugs,
    input.proficiencyBonus,
  );

  return {
    armorClass: input.armor.armorClass,
    armorClassNote: input.armor.armorClassNote,
    featAcBonus,
    featAcBonusSources,
    weaponAttacks: input.weaponAttacks,
    equipmentWarnings: input.compliance.warnings,
    cannotCastSpellsInArmor: input.compliance.cannotCastSpells,
    speedPenaltyMeters: input.compliance.speedPenaltyMeters,
    itemSpeedBonusMeters:
      input.itemEffects.speedBonusMeters +
      classCombat.speedBonusMeters +
      speedBonusMetersFromEffects(effects, input.featSlugs),
    itemHpBonus: input.itemEffects.hpBonus,
    heritageHpBonus,
    transformationHpBonus,
    classCombatNotes: [
      ...speciesNotes,
      ...heritageNotes,
      ...transformationNotes,
      ...featNotes,
      ...itemNotes,
      ...classCombat.notes,
    ],
    attacksPerAction: classCombat.attacksPerAction,
    savingThrowAuraBonus: paladinSavingThrowAuraBonus({
      classSlug: input.classSlug,
      level: input.level,
      charismaModifier: abilityModifier(input.combatScores.carisma),
      unlockLevel:
        input.classFeatureGates?.get(CLASS_GATE.auraOfProtection) ?? null,
    }),
    featEffectFlags: {
      inspirationRefundOnFail: hasInspirationRefundOnFail(
        effects,
        input.featSlugs,
      ),
      damageDieFloor: hasDamageDieFloor(effects, input.featSlugs),
      damageDieFlip: hasDamageDieFlip(effects, input.featSlugs),
      damageDieExplode: hasDamageDieExplode(effects, input.featSlugs),
      improveCritical: hasImproveCritical(effects, input.featSlugs),
      slotElevate: hasSlotElevate(effects, input.featSlugs),
      slotReduce: hasSlotReduce(effects, input.featSlugs),
      wieldTwoHandedOneHand: hasWieldTwoHandedOneHand(
        effects,
        input.featSlugs,
      ),
      versatileOneHandFullDamage: hasVersatileOneHandFullDamage(
        effects,
        input.featSlugs,
      ),
    },
  };
}
