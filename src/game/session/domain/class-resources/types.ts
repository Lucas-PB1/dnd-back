

export type ResourceMaxFormula =
  | 'fixed'
  | 'proficiency_bonus'
  | 'charisma_mod'
  | 'wisdom_mod'
  | 'constitution_mod'
  | 'intelligence_mod'
  | 'level'
  | 'level_plus_one'
  | string;

export type ClassResourceScheduleRow = {
  resourceSlug: string;
  resourceName: string;
  unlockLevel: number;
  maxFormula: ResourceMaxFormula;
  fixedMax: number | null;
  recoverOneOnShort: boolean;
  recoverAllOnShort: boolean;
  recoverAllOnLong: boolean;
  recoverOnLongDice: string | null;
};

export type ClassResourceMax = {
  slug: string;
  name: string;
  max: number;
  recoverOneOnShort: boolean;
  recoverAllOnShort: boolean;
  recoverAllOnLong: boolean;
  recoverOnLongDice: string | null;
};

export type AbilityMods = {
  forca: number;
  destreza: number;
  constituicao: number;
  inteligencia: number;
  sabedoria: number;
  carisma: number;
};

export type LongRestResourceRecoveryResult = {
  used: Record<string, number>;
  notes: string[];
};
