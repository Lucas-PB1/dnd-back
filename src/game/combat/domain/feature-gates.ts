/**
 * Gates booleanos nível→unlock (SSOT: phb_class_feature_gate /
 * phb_subclass_feature_gate). Predicados puros recebem unlock do catálogo.
 */

export const CLASS_GATE = {
  studiedAttacks: 'studied_attacks',
  tacticalMaster: 'tactical_master',
  tacticalShift: 'tactical_shift',
  tacticalMind: 'tactical_mind',
  indomitable: 'indomitable',
  slipperyMind: 'slippery_mind',
  evasion: 'evasion',
  diamondSoul: 'diamond_soul',
  auraOfProtection: 'aura_of_protection',
  preciseHunter: 'precise_hunter',
  relentlessHunter: 'relentless_hunter',
} as const;

export const SUBCLASS_GATE = {
  doorKick: 'door_kick',
  assassinMobileAim: 'assassin_mobile_aim',
  divineFury: 'divine_fury',
  psychicBlades: 'psychic_blades',
  bloodArmament: 'blood-armament',
  bloodExplosion: 'blood-explosion',
  bloodLowerCost: 'blood-lower-cost',
  bloodSymphony: 'blood-symphony',
} as const;

export type FeatureGatesByOwnerSlug = ReadonlyMap<
  string,
  ReadonlyMap<string, number>
>;

export function meetsFeatureGate(
  level: number,
  unlockLevel: number | null | undefined,
): boolean {
  return unlockLevel != null && level >= unlockLevel;
}

export function unlockFromGates(
  gatesByOwner: FeatureGatesByOwnerSlug | undefined,
  ownerSlug: string | null | undefined,
  gateKey: string,
): number | null {
  if (!ownerSlug || !gatesByOwner) return null;
  const unlock = gatesByOwner.get(ownerSlug)?.get(gateKey);
  return unlock == null ? null : unlock;
}
