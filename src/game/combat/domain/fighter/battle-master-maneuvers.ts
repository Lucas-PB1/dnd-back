/**
 * Manobras do Mestre da Batalha — tipos e lookups.
 * Catálogo: `rpg.phb_battle_master_maneuver` / `v_phb_battle_master_maneuver`.
 */

export type BattleMasterManeuver = {
  slug: string;
  name: string;
  description: string;
  timing: 'on_hit' | 'on_miss' | 'reaction' | 'bonus_action' | 'other';
  addsToDamage: boolean;
  addsToAttack: boolean;
};

export function listBattleMasterManeuvers(
  catalog: readonly BattleMasterManeuver[],
): BattleMasterManeuver[] {
  return [...catalog];
}

export function findBattleMasterManeuver(
  catalog: readonly BattleMasterManeuver[],
  slug: string,
): BattleMasterManeuver | undefined {
  return catalog.find((item) => item.slug === slug);
}

/** CD de manobra: 8 + PB + FOR ou DES (o maior). */
export function battleMasterSaveDc(input: {
  proficiencyBonus: number;
  strengthMod: number;
  dexterityMod: number;
}): number {
  return (
    8 +
    input.proficiencyBonus +
    Math.max(input.strengthMod, input.dexterityMod)
  );
}
