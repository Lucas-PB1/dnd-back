export type WeaponCombatFlags = {
  rageActive: boolean;
  recklessActive: boolean;
  bestialAspectLevel: number;
  sacredWeaponActive: boolean;
};

export const IDLE_WEAPON_COMBAT_FLAGS: WeaponCombatFlags = {
  rageActive: false,
  recklessActive: false,
  bestialAspectLevel: 0,
  sacredWeaponActive: false,
};

export async function loadWeaponCombatFlags(
  dataSource: import('typeorm').DataSource | undefined,
  characterId: string,
): Promise<WeaponCombatFlags> {
  if (!dataSource || !characterId) return IDLE_WEAPON_COMBAT_FLAGS;
  const { PlayerCharacterState } = await import(
    '../player-character-state.entity'
  );
  const state = await dataSource.getRepository(PlayerCharacterState).findOne({
    where: { characterId },
    select: [
      'rageActive',
      'recklessActive',
      'bestialAspectLevel',
      'sacredWeaponActive',
    ],
  });
  if (!state) return IDLE_WEAPON_COMBAT_FLAGS;
  return {
    rageActive: state.rageActive,
    recklessActive: state.recklessActive,
    bestialAspectLevel: state.bestialAspectLevel,
    sacredWeaponActive: Boolean(state.sacredWeaponActive),
  };
}
