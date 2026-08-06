/** Ação de mesa tipada (Psi Warrior, Soulknife, …) — SSOT no banco. */

export type SubclassTableAction = {
  subclassSlug: string;
  slug: string;
  name: string;
  unlockLevel: number;
  freeResourceSlug?: string;
  alwaysSpendsPool: boolean;
  rollsPoolDie: boolean;
  spendsOnlyOnSuccess: boolean;
  alwaysPoolCost?: number;
  repeatPoolCost?: number;
};

export function findSubclassTableAction(
  catalog: readonly SubclassTableAction[],
  subclassSlug: string,
  actionSlug: string,
): SubclassTableAction | undefined {
  return catalog.find(
    (row) => row.subclassSlug === subclassSlug && row.slug === actionSlug,
  );
}

export function listSubclassTableActions(
  catalog: readonly SubclassTableAction[],
  subclassSlug: string,
): SubclassTableAction[] {
  return catalog.filter((row) => row.subclassSlug === subclassSlug);
}
