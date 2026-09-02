import type { DataSource } from 'typeorm';
import { applyItemAbilityBonuses } from '@game/inventory/domain/permanent-item-effects';
import {
  applyAbilityPenalties,
  collectAbilityPenaltiesFromInventory,
} from '@game/inventory/domain/artifact/artifact-instance-ops';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { sheetProfile } from '@common/perf/sheet-profile';
import { loadCharacterCombatBundle } from '../../infrastructure/load-character-combat-bundle';

export async function loadCombatScoresAndEffects(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  dataSource: DataSource;
  permanentItemEffects: ResolveActivePermanentItemEffects;
}) {
  const bundle = await sheetProfile('combat.p031', () =>
    loadCharacterCombatBundle(
      input.dataSource,
      input.characterId,
      input.classSlug,
      input.subclassSlug,
    ),
  );
  const inventoryRows = bundle.inventory;
  const equippedItems = inventoryRows.filter(
    (row) => row.location === 'equipped',
  );
  const hasShield = equippedItems.some((row) => row.equipmentSlot === 'shield');

  const itemEffects = await sheetProfile('combat.itemEffects', () =>
    input.permanentItemEffects.resolve(input.characterId, {
      inventoryRows,
      catalogItems: bundle.items,
    }),
  );
  const withItemBonuses = applyItemAbilityBonuses(
    input.abilityScores,
    itemEffects.abilityBonuses,
    itemEffects.abilityScoreCaps,
  );
  const combatScores = applyAbilityPenalties(
    withItemBonuses,
    collectAbilityPenaltiesFromInventory(inventoryRows),
  );

  return { bundle, equippedItems, hasShield, itemEffects, combatScores };
}
