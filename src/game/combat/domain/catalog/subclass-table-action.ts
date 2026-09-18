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
