import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { DamageCombatFlags, DamageWeaponAttack } from '../damage/damage-roll-context';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from '../roll-weapon-context';

import { asDep } from '@common/testing/as-dep';

export function asRollDep<T = never>(mock: object): T {
  return asDep<T>(mock);
}

export const IDLE_COMBAT_FLAGS: DamageCombatFlags = {
  rageActive: false,
  recklessActive: false,
  bestialAspectLevel: 0,
};

export function testScores(partial: Partial<AbilityScores> = {}): AbilityScores {
  return {
    forca: 16,
    destreza: 14,
    constituicao: 13,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
    ...partial,
  };
}

export type AttackInput = Partial<DamageWeaponAttack> &
  Pick<DamageWeaponAttack, 'itemName'>;

export function buildMockAttack(overrides: AttackInput): DamageWeaponAttack {
  return {
    grazeOnMissDamage: null,
    damageDice: '1d8',
    damageBonus: 3,
    greatWeaponFighting: false,
    rageDamageBonus: 0,
    overkillExtraDice: null,
    brutalStrikeDice: null,
    divineFuryDice: null,
    abilitySlug: 'forca',
    ...overrides,
  } as DamageWeaponAttack;
}

export function mockEquippedAttack(
  attack: AttackInput,
  combatFlags: DamageCombatFlags = IDLE_COMBAT_FLAGS,
): void {
  (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
    attack: buildMockAttack(attack),
    combatFlags,
  });
}

export function mockCharacter(
  character: Partial<PlayerCharacter> & Pick<PlayerCharacter, 'classSlug'>,
): void {
  (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
    id: 'c1',
    subclassSlug: null,
    level: 5,
    abilityScores: testScores(),
    ...character,
  });
}
