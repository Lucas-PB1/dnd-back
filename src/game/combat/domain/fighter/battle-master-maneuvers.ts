
export type BattleMasterMesaRollKind =
  | 'parry_reduce_damage'
  | 'rally_temp_hp'
  | 'precision_add_attack'
  | 'superiority_die';

export type BattleMasterManeuver = {
  slug: string;
  name: string;
  description: string;
  timing: 'on_hit' | 'on_miss' | 'reaction' | 'bonus_action' | 'other';
  mesaRollKind: BattleMasterMesaRollKind;
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
