import { applyActionSurgeAttackBudget } from './skirmish-table-action-budget';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

describe('applyActionSurgeAttackBudget (PVE-10a)', () => {
  it('adds the attack budget to remaining attacks', async () => {
    const mechanicalCatalog = {
      load: async () => ({
        featureSchedulesByClassSlug: new Map([
          [
            'fighter',
            [
              {
                featureKey: 'attacks_per_action',
                unlockLevel: 5,
                valueNum: 2,
              },
            ],
          ],
        ]),
        featureSchedulesBySubclassSlug: new Map(),
      }),
    } as unknown as LoadCombatMechanicalCatalog;

    const result = await applyActionSurgeAttackBudget({
      mechanicalCatalog,
      character: {
        classSlug: 'fighter',
        subclassSlug: null,
        level: 5,
      } as PlayerCharacter,
      turnAttacksRemaining: 1,
    });
    expect(result.extra).toBe(2);
    expect(result.turnAttacksRemaining).toBe(3);
  });
});
