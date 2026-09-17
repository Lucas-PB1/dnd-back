import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { aggregateClassCombatContributions } from '@game/combat/domain/aggregate-class-combat';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export async function resolveSkirmishAttackBudget(
  catalog: LoadCombatMechanicalCatalog,
  character: PlayerCharacter,
): Promise<number> {
  const mechanical = await catalog.load();
  const contribution = aggregateClassCombatContributions({
    classSlug: character.classSlug,
    subclassSlug: character.subclassSlug,
    level: character.level,
    featureSchedules: featureSchedulesFromCatalog(
      mechanical,
      character.classSlug,
      character.subclassSlug,
    ),
  });
  return Math.max(1, contribution.attacksPerAction);
}
