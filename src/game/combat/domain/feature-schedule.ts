export const FEATURE_SCHEDULE_KEYS = {
  attacksPerAction: 'attacks_per_action',
  martialArtsDieFaces: 'martial_arts_die_faces',
  unarmoredSpeedBonusM: 'unarmored_speed_bonus_m',
  sneakAttackDiceCount: 'sneak_attack_dice_count',
  bardicInspirationDieFaces: 'bardic_inspiration_die_faces',
  rageDamageBonus: 'rage_damage_bonus',
  brutalStrikeDiceCount: 'brutal_strike_dice_count',
  indomitableMaxUses: 'indomitable_max_uses',
  superiorityDiceCount: 'superiority_dice_count',
  superiorityDieFaces: 'superiority_die_faces',
  psiEnergyDiceCount: 'psi_energy_dice_count',
  psiEnergyDieFaces: 'psi_energy_die_faces',
  championCritThreshold: 'champion_crit_threshold',
  zealotHealingDiceCount: 'zealot_healing_dice_count',
  gunslingerCritThreshold: 'gunslinger_crit_threshold',
  warlockPactSlotLevel: 'warlock_pact_slot_level',
  warlockPactSlotCount: 'warlock_pact_slot_count',
  warlockInvocationLimit: 'warlock_invocation_limit',
  sorcererMetamagicLimit: 'sorcerer_metamagic_limit',
  divineStrikeDiceCount: 'divine_strike_dice_count',
  divineSparkDiceCount: 'divine_spark_dice_count',
  radiantStrikesDiceCount: 'radiant_strikes_dice_count',
  auraRangeM: 'aura_range_m',
  personaMasksEquipped: 'persona_masks_equipped',
  personaMasksKnown: 'persona_masks_known',
  portentD20Count: 'portent_d20_count',
} as const;

export type FeatureScheduleKey =
  (typeof FEATURE_SCHEDULE_KEYS)[keyof typeof FEATURE_SCHEDULE_KEYS];

export type FeatureScheduleBand = {
  featureKey: string;
  unlockLevel: number;
  valueNum: number;
};


export function scheduleValueAtLevel(
  bands: readonly FeatureScheduleBand[],
  featureKey: string,
  level: number,
): number | null {
  if (!bands.length) return null;
  let best: number | null = null;
  let bestUnlock = -1;
  for (const band of bands) {
    if (band.featureKey !== featureKey) continue;
    if (band.unlockLevel > level) continue;
    if (band.unlockLevel >= bestUnlock) {
      bestUnlock = band.unlockLevel;
      best = band.valueNum;
    }
  }
  return best;
}

export function scheduleIntAtLevel(
  bands: readonly FeatureScheduleBand[],
  featureKey: string,
  level: number,
  fallback: number,
): number {
  const raw = scheduleValueAtLevel(bands, featureKey, level);
  return raw == null ? fallback : Math.trunc(raw);
}

export function scheduleIntOrNullAtLevel(
  bands: readonly FeatureScheduleBand[],
  featureKey: string,
  level: number,
): number | null {
  const raw = scheduleValueAtLevel(bands, featureKey, level);
  return raw == null ? null : Math.trunc(raw);
}

export function bandsForFeature(
  bands: readonly FeatureScheduleBand[],
  featureKey: string,
): FeatureScheduleBand[] {
  return bands.filter((b) => b.featureKey === featureKey);
}

export function mergeFeatureSchedules(
  ...lists: Array<readonly FeatureScheduleBand[] | undefined>
): FeatureScheduleBand[] {
  const out: FeatureScheduleBand[] = [];
  for (const list of lists) {
    if (list?.length) out.push(...list);
  }
  return out;
}

export function featureSchedulesFromCatalog(
  catalog: {
    featureSchedulesByClassSlug: ReadonlyMap<
      string,
      readonly FeatureScheduleBand[]
    >;
    featureSchedulesBySubclassSlug: ReadonlyMap<
      string,
      readonly FeatureScheduleBand[]
    >;
  },
  classSlug: string | null | undefined,
  subclassSlug?: string | null,
): FeatureScheduleBand[] {
  return mergeFeatureSchedules(
    classSlug
      ? catalog.featureSchedulesByClassSlug.get(classSlug)
      : undefined,
    subclassSlug
      ? catalog.featureSchedulesBySubclassSlug.get(subclassSlug)
      : undefined,
  );
}
