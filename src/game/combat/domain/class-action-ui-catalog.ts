export type ActionEconomyBucket = 'action' | 'bonus' | 'reaction' | 'free';

export type ClassEconomyActionRecord = {
  id: string;
  name: string;
  economy: ActionEconomyBucket;
  classSlug: string;
  minLevel: number;
  subclassSlug?: string;
  resourceSlug?: string;
  freeResourceSlug?: string;
  alwaysSpendsResource?: boolean;
  summary?: string;
  description?: string;
  tableAction?: string;
  spendAmount?: number;
};

export type PanelActionSection = 'base' | 'subclass' | 'metamagic' | 'channel';

export type ClassPanelActionRecord = {
  panelKey: string;
  classSlug: string;
  subclassSlug?: string;
  slug: string;
  name: string;
  title?: string;
  minLevel: number;
  resourceSlug?: string;
  section: PanelActionSection;
  spendsFocus: boolean;
  sortOrder: number;
};
