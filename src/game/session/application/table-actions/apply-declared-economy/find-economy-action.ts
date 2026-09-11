import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';

export function findDeclaredEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  classSlug: string | null,
  actionSlug: string,
): ClassEconomyActionRecord | undefined {
  if (!classSlug) return undefined;
  return economyActions.find(
    (row) =>
      row.classSlug === classSlug &&
      row.tableAction === actionSlug &&
      row.itemSlug == null &&
      row.featSlug == null &&
      row.speciesSlug == null,
  );
}
