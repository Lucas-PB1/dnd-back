import { DataSource } from 'typeorm';
import { PlayerCharacterState } from '../player-character-state.entity';

export type WeaponCombatFlags = {
  rageActive: boolean;
  recklessActive: boolean;
  bestialAspectLevel: number;
};

export const IDLE_WEAPON_COMBAT_FLAGS: WeaponCombatFlags = {
  rageActive: false,
  recklessActive: false,
  bestialAspectLevel: 0,
};

export async function loadWeaponCombatFlags(
  dataSource: DataSource | undefined,
  characterId: string,
): Promise<WeaponCombatFlags> {
  if (!dataSource || !characterId) return IDLE_WEAPON_COMBAT_FLAGS;
  const state = await dataSource.getRepository(PlayerCharacterState).findOne({
    where: { characterId },
    select: ['rageActive', 'recklessActive', 'bestialAspectLevel'],
  });
  if (!state) return IDLE_WEAPON_COMBAT_FLAGS;
  return {
    rageActive: state.rageActive,
    recklessActive: state.recklessActive,
    bestialAspectLevel: state.bestialAspectLevel,
  };
}
