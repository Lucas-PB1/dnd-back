import { resolveSkirmishAttackBudget } from './skirmish-attack-budget';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

function catalogWithAttacks(classSlug: string, valueNum: number) {
  return {
    load: async () => ({
      featureSchedulesByClassSlug: new Map([
        [
          classSlug,
          [
            {
              featureKey: 'attacks_per_action',
              unlockLevel: 5,
              valueNum,
            },
          ],
        ],
      ]),
      featureSchedulesBySubclassSlug: new Map(),
    }),
  } as unknown as LoadCombatMechanicalCatalog;
}

function character(
  classSlug: string,
  level: number,
): PlayerCharacter {
  return { classSlug, subclassSlug: null, level } as PlayerCharacter;
}

describe('resolveSkirmishAttackBudget', () => {
  it('gives the fighter extra attack from the catalog schedule', async () => {
    const budget = await resolveSkirmishAttackBudget(
      catalogWithAttacks('fighter', 2),
      character('fighter', 5),
    );
    expect(budget).toBe(2);
  });

  it('never drops below one attack', async () => {
    const budget = await resolveSkirmishAttackBudget(
      catalogWithAttacks('wizard', 0),
      character('wizard', 1),
    );
    expect(budget).toBe(1);
  });
});
