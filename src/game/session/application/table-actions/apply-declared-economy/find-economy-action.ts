import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';

export function findDeclaredEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  classSlug: string | null,
  actionSlug: string,
  subclassSlug?: string | null,
): ClassEconomyActionRecord | undefined {
  if (!classSlug) return undefined;
  const matches = economyActions.filter(
    (row) =>
      row.classSlug === classSlug &&
      row.tableAction === actionSlug &&
      row.itemSlug == null &&
      row.featSlug == null &&
      row.speciesSlug == null,
  );
  if (matches.length === 0) return undefined;
  const forSubclass = matches.find(
    (row) =>
      row.subclassSlug != null && row.subclassSlug === (subclassSlug ?? null),
  );
  if (forSubclass) return forSubclass;
  const classOnly = matches.find((row) => row.subclassSlug == null);
  return classOnly ?? matches[0];
}
