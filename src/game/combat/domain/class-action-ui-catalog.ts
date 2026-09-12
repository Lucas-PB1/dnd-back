export type ActionEconomyBucket = 'action' | 'bonus' | 'reaction' | 'free';

export type ClassEconomyActionRecord = {
  id: string;
  name: string;
  economy: ActionEconomyBucket;
  classSlug?: string | null;
  minLevel: number;
  subclassSlug?: string;
  speciesSlug?: string | null;
  featSlug?: string | null;
  itemSlug?: string | null;
  heritageTraitSlug?: string | null;
  threadSlug?: string | null;
  minTraitTakes?: number;
  requiresOptionKey?: string;
  requiresOptionValue?: string;
  resourceSlug?: string;
  freeResourceSlug?: string;
  alwaysSpendsResource?: boolean;
  summary?: string;
  description?: string;
  tableAction?: string;
  spendAmount?: number;
  spellSlug?: string;
};

export type PanelActionSection = 'base' | 'subclass' | 'metamagic' | 'channel';

export type ClassPanelActionRecord = {
  panelKey: string;
  classSlug: string;
  subclassSlug?: string;
  slug: string;
  name: string;
  title?: string;
  description?: string;
  minLevel: number;
  resourceSlug?: string;
  section: PanelActionSection;
  spendsFocus: boolean;
  sortOrder: number;
};
