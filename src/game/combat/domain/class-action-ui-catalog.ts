export type ActionEconomyBucket = 'action' | 'bonus' | 'reaction' | 'free';

export type ClassEconomyActionRecord = {
  id: string;
  name: string;
  economy: ActionEconomyBucket;
  /** Classe dona; omitido/null em linhas de espécie. */
  classSlug?: string | null;
  minLevel: number;
  subclassSlug?: string;
  /** Espécie dona; omitido/null em linhas de classe/talento. */
  speciesSlug?: string | null;
  /** Talento dono; omitido/null em linhas de classe/espécie. */
  featSlug?: string | null;
  /** Item mágico dono; omitido/null em linhas de classe/espécie/talento. */
  itemSlug?: string | null;
  requiresOptionKey?: string;
  requiresOptionValue?: string;
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
