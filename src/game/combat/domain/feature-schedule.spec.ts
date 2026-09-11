import {
  FEATURE_SCHEDULE_KEYS,
  scheduleIntAtLevel,
  scheduleValueAtLevel,
  type FeatureScheduleBand,
} from './feature-schedule';

const FIGHTER_ATTACKS: FeatureScheduleBand[] = [
  { featureKey: FEATURE_SCHEDULE_KEYS.attacksPerAction, unlockLevel: 1, valueNum: 1 },
  { featureKey: FEATURE_SCHEDULE_KEYS.attacksPerAction, unlockLevel: 5, valueNum: 2 },
  { featureKey: FEATURE_SCHEDULE_KEYS.attacksPerAction, unlockLevel: 11, valueNum: 3 },
  { featureKey: FEATURE_SCHEDULE_KEYS.attacksPerAction, unlockLevel: 20, valueNum: 4 },
];

const MONK_SCHEDULE: FeatureScheduleBand[] = [
  { featureKey: FEATURE_SCHEDULE_KEYS.martialArtsDieFaces, unlockLevel: 1, valueNum: 6 },
  { featureKey: FEATURE_SCHEDULE_KEYS.martialArtsDieFaces, unlockLevel: 5, valueNum: 8 },
  { featureKey: FEATURE_SCHEDULE_KEYS.martialArtsDieFaces, unlockLevel: 11, valueNum: 10 },
  { featureKey: FEATURE_SCHEDULE_KEYS.martialArtsDieFaces, unlockLevel: 17, valueNum: 12 },
  { featureKey: FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM, unlockLevel: 2, valueNum: 3 },
  { featureKey: FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM, unlockLevel: 6, valueNum: 4.5 },
  { featureKey: FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM, unlockLevel: 10, valueNum: 6 },
  { featureKey: FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM, unlockLevel: 14, valueNum: 7.5 },
  { featureKey: FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM, unlockLevel: 18, valueNum: 9 },
];

describe('feature-schedule', () => {
  it('resolves fighter attacks_per_action bands', () => {
    expect(
      scheduleIntAtLevel(FIGHTER_ATTACKS, FEATURE_SCHEDULE_KEYS.attacksPerAction, 1, 1),
    ).toBe(1);
    expect(
      scheduleIntAtLevel(FIGHTER_ATTACKS, FEATURE_SCHEDULE_KEYS.attacksPerAction, 5, 1),
    ).toBe(2);
    expect(
      scheduleIntAtLevel(FIGHTER_ATTACKS, FEATURE_SCHEDULE_KEYS.attacksPerAction, 11, 1),
    ).toBe(3);
    expect(
      scheduleIntAtLevel(FIGHTER_ATTACKS, FEATURE_SCHEDULE_KEYS.attacksPerAction, 20, 1),
    ).toBe(4);
  });

  it('resolves monk martial arts and speed bands', () => {
    expect(
      scheduleIntAtLevel(
        MONK_SCHEDULE,
        FEATURE_SCHEDULE_KEYS.martialArtsDieFaces,
        5,
        6,
      ),
    ).toBe(8);
    expect(
      scheduleValueAtLevel(
        MONK_SCHEDULE,
        FEATURE_SCHEDULE_KEYS.unarmoredSpeedBonusM,
        10,
      ),
    ).toBe(6);
  });

  it('returns fallback when bands missing', () => {
    expect(
      scheduleIntAtLevel([], FEATURE_SCHEDULE_KEYS.attacksPerAction, 20, 1),
    ).toBe(1);
  });

  it('resolves sneak and rage bands', () => {
    const bands: FeatureScheduleBand[] = [
      { featureKey: FEATURE_SCHEDULE_KEYS.sneakAttackDiceCount, unlockLevel: 1, valueNum: 1 },
      { featureKey: FEATURE_SCHEDULE_KEYS.sneakAttackDiceCount, unlockLevel: 3, valueNum: 2 },
      { featureKey: FEATURE_SCHEDULE_KEYS.sneakAttackDiceCount, unlockLevel: 19, valueNum: 10 },
      { featureKey: FEATURE_SCHEDULE_KEYS.rageDamageBonus, unlockLevel: 1, valueNum: 2 },
      { featureKey: FEATURE_SCHEDULE_KEYS.rageDamageBonus, unlockLevel: 9, valueNum: 3 },
      { featureKey: FEATURE_SCHEDULE_KEYS.rageDamageBonus, unlockLevel: 16, valueNum: 4 },
    ];
    expect(
      scheduleIntAtLevel(bands, FEATURE_SCHEDULE_KEYS.sneakAttackDiceCount, 2, 0),
    ).toBe(1);
    expect(
      scheduleIntAtLevel(bands, FEATURE_SCHEDULE_KEYS.sneakAttackDiceCount, 20, 0),
    ).toBe(10);
    expect(
      scheduleIntAtLevel(bands, FEATURE_SCHEDULE_KEYS.rageDamageBonus, 16, 0),
    ).toBe(4);
  });

  it('resolves psi faces/count independently', () => {
    const bands: FeatureScheduleBand[] = [
      { featureKey: FEATURE_SCHEDULE_KEYS.psiEnergyDiceCount, unlockLevel: 3, valueNum: 4 },
      { featureKey: FEATURE_SCHEDULE_KEYS.psiEnergyDiceCount, unlockLevel: 5, valueNum: 6 },
      { featureKey: FEATURE_SCHEDULE_KEYS.psiEnergyDiceCount, unlockLevel: 9, valueNum: 8 },
      { featureKey: FEATURE_SCHEDULE_KEYS.psiEnergyDieFaces, unlockLevel: 3, valueNum: 6 },
      { featureKey: FEATURE_SCHEDULE_KEYS.psiEnergyDieFaces, unlockLevel: 5, valueNum: 8 },
      { featureKey: FEATURE_SCHEDULE_KEYS.psiEnergyDieFaces, unlockLevel: 11, valueNum: 10 },
    ];
    expect(
      scheduleIntAtLevel(bands, FEATURE_SCHEDULE_KEYS.psiEnergyDiceCount, 9, 0),
    ).toBe(8);
    expect(
      scheduleIntAtLevel(bands, FEATURE_SCHEDULE_KEYS.psiEnergyDieFaces, 9, 0),
    ).toBe(8);
    expect(
      scheduleIntAtLevel(bands, FEATURE_SCHEDULE_KEYS.psiEnergyDieFaces, 11, 0),
    ).toBe(10);
  });
});
