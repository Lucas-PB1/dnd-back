import {
  FEATURE_SCHEDULE_KEYS,
  type FeatureScheduleBand,
} from './feature-schedule';

const k = FEATURE_SCHEDULE_KEYS;

function bands(
  ...rows: Array<[string, number, number]>
): FeatureScheduleBand[] {
  return rows.map(([featureKey, unlockLevel, valueNum]) => ({
    featureKey,
    unlockLevel,
    valueNum,
  }));
}

export const FEATURE_SCHEDULE_FIXTURES_BY_CLASS: ReadonlyMap<
  string,
  readonly FeatureScheduleBand[]
> = new Map([
  [
    'fighter',
    bands(
      [k.attacksPerAction, 1, 1],
      [k.attacksPerAction, 5, 2],
      [k.attacksPerAction, 11, 3],
      [k.attacksPerAction, 20, 4],
      [k.indomitableMaxUses, 9, 1],
      [k.indomitableMaxUses, 13, 2],
      [k.indomitableMaxUses, 17, 3],
    ),
  ],
  [
    'monk',
    bands(
      [k.attacksPerAction, 1, 1],
      [k.attacksPerAction, 5, 2],
      [k.martialArtsDieFaces, 1, 6],
      [k.martialArtsDieFaces, 5, 8],
      [k.martialArtsDieFaces, 11, 10],
      [k.martialArtsDieFaces, 17, 12],
      [k.unarmoredSpeedBonusM, 2, 3],
      [k.unarmoredSpeedBonusM, 6, 4.5],
      [k.unarmoredSpeedBonusM, 10, 6],
      [k.unarmoredSpeedBonusM, 14, 7.5],
      [k.unarmoredSpeedBonusM, 18, 9],
    ),
  ],
  [
    'cleric',
    bands(
      [k.divineStrikeDiceCount, 7, 1],
      [k.divineStrikeDiceCount, 14, 2],
      [k.divineSparkDiceCount, 2, 1],
      [k.divineSparkDiceCount, 7, 2],
      [k.divineSparkDiceCount, 13, 3],
      [k.divineSparkDiceCount, 18, 4],
    ),
  ],
  [
    'paladin',
    bands(
      [k.attacksPerAction, 1, 1],
      [k.attacksPerAction, 5, 2],
      [k.radiantStrikesDiceCount, 11, 1],
      [k.auraRangeM, 6, 3],
      [k.auraRangeM, 18, 9],
    ),
  ],
  [
    'ranger',
    bands([k.attacksPerAction, 1, 1], [k.attacksPerAction, 5, 2]),
  ],
  [
    'rogue',
    bands(
      [k.sneakAttackDiceCount, 1, 1],
      [k.sneakAttackDiceCount, 3, 2],
      [k.sneakAttackDiceCount, 5, 3],
      [k.sneakAttackDiceCount, 7, 4],
      [k.sneakAttackDiceCount, 9, 5],
      [k.sneakAttackDiceCount, 11, 6],
      [k.sneakAttackDiceCount, 13, 7],
      [k.sneakAttackDiceCount, 15, 8],
      [k.sneakAttackDiceCount, 17, 9],
      [k.sneakAttackDiceCount, 19, 10],
    ),
  ],
  [
    'bard',
    bands(
      [k.bardicInspirationDieFaces, 1, 6],
      [k.bardicInspirationDieFaces, 5, 8],
      [k.bardicInspirationDieFaces, 10, 10],
      [k.bardicInspirationDieFaces, 15, 12],
    ),
  ],
  [
    'barbarian',
    bands(
      [k.rageDamageBonus, 1, 2],
      [k.rageDamageBonus, 9, 3],
      [k.rageDamageBonus, 16, 4],
      [k.brutalStrikeDiceCount, 9, 1],
      [k.brutalStrikeDiceCount, 17, 2],
    ),
  ],
  [
    'warlock',
    bands(
      [k.warlockPactSlotLevel, 1, 1],
      [k.warlockPactSlotLevel, 3, 2],
      [k.warlockPactSlotLevel, 5, 3],
      [k.warlockPactSlotLevel, 7, 4],
      [k.warlockPactSlotLevel, 9, 5],
      [k.warlockPactSlotCount, 1, 1],
      [k.warlockPactSlotCount, 2, 2],
      [k.warlockPactSlotCount, 11, 3],
      [k.warlockPactSlotCount, 17, 4],
      [k.warlockInvocationLimit, 1, 1],
      [k.warlockInvocationLimit, 2, 3],
      [k.warlockInvocationLimit, 5, 5],
      [k.warlockInvocationLimit, 7, 6],
      [k.warlockInvocationLimit, 9, 7],
      [k.warlockInvocationLimit, 12, 8],
      [k.warlockInvocationLimit, 15, 9],
      [k.warlockInvocationLimit, 18, 10],
    ),
  ],
  [
    'sorcerer',
    bands(
      [k.sorcererMetamagicLimit, 2, 2],
      [k.sorcererMetamagicLimit, 10, 4],
      [k.sorcererMetamagicLimit, 17, 6],
    ),
  ],
  [
    'gunslinger',
    bands(
      [k.gunslingerCritThreshold, 2, 19],
      [k.gunslingerCritThreshold, 9, 18],
      [k.gunslingerCritThreshold, 17, 17],
    ),
  ],
]);

export const FEATURE_SCHEDULE_FIXTURES_BY_SUBCLASS: ReadonlyMap<
  string,
  readonly FeatureScheduleBand[]
> = new Map([
  [
    'battle-master',
    bands(
      [k.superiorityDiceCount, 3, 4],
      [k.superiorityDiceCount, 7, 5],
      [k.superiorityDiceCount, 15, 6],
      [k.superiorityDieFaces, 3, 8],
      [k.superiorityDieFaces, 10, 10],
      [k.superiorityDieFaces, 18, 12],
    ),
  ],
  [
    'psi-warrior',
    bands(
      [k.psiEnergyDiceCount, 3, 4],
      [k.psiEnergyDiceCount, 5, 6],
      [k.psiEnergyDiceCount, 9, 8],
      [k.psiEnergyDiceCount, 11, 8],
      [k.psiEnergyDiceCount, 13, 10],
      [k.psiEnergyDiceCount, 17, 12],
      [k.psiEnergyDieFaces, 3, 6],
      [k.psiEnergyDieFaces, 5, 8],
      [k.psiEnergyDieFaces, 9, 8],
      [k.psiEnergyDieFaces, 11, 10],
      [k.psiEnergyDieFaces, 13, 10],
      [k.psiEnergyDieFaces, 17, 12],
    ),
  ],
  [
    'soulknife',
    bands(
      [k.psiEnergyDiceCount, 3, 4],
      [k.psiEnergyDiceCount, 5, 6],
      [k.psiEnergyDiceCount, 9, 8],
      [k.psiEnergyDiceCount, 11, 8],
      [k.psiEnergyDiceCount, 13, 10],
      [k.psiEnergyDiceCount, 17, 12],
      [k.psiEnergyDieFaces, 3, 6],
      [k.psiEnergyDieFaces, 5, 8],
      [k.psiEnergyDieFaces, 9, 8],
      [k.psiEnergyDieFaces, 11, 10],
      [k.psiEnergyDieFaces, 13, 10],
      [k.psiEnergyDieFaces, 17, 12],
    ),
  ],
  [
    'champion',
    bands(
      [k.championCritThreshold, 3, 19],
      [k.championCritThreshold, 15, 18],
    ),
  ],
  [
    'zealot',
    bands(
      [k.zealotHealingDiceCount, 3, 4],
      [k.zealotHealingDiceCount, 6, 5],
      [k.zealotHealingDiceCount, 12, 6],
      [k.zealotHealingDiceCount, 17, 7],
    ),
  ],
  [
    'college-of-masks',
    bands(
      [k.personaMasksEquipped, 3, 1],
      [k.personaMasksEquipped, 14, 2],
      [k.personaMasksKnown, 3, 3],
      [k.personaMasksKnown, 6, 4],
      [k.personaMasksKnown, 14, 5],
    ),
  ],
  [
    'diviner',
    bands(
      [k.portentD20Count, 2, 2],
      [k.portentD20Count, 14, 3],
    ),
  ],
]);

export function fixtureSchedulesFor(
  classSlug: string | null | undefined,
  subclassSlug?: string | null,
): FeatureScheduleBand[] {
  const out: FeatureScheduleBand[] = [];
  if (classSlug) {
    const classBands = FEATURE_SCHEDULE_FIXTURES_BY_CLASS.get(classSlug);
    if (classBands) out.push(...classBands);
  }
  if (subclassSlug) {
    const subBands = FEATURE_SCHEDULE_FIXTURES_BY_SUBCLASS.get(subclassSlug);
    if (subBands) out.push(...subBands);
  }
  return out;
}
