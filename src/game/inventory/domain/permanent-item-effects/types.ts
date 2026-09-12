import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { STANDARD_ABILITY_SCORE_CAP } from '@game/sheet/domain/validation/feats/epic-boon-feat-options';

export type PermanentItemEffects = {
  acBonus: number;
  attackBonus: number;
  damageBonus: number;
  abilityBonuses: Partial<
    Record<
      | 'forca'
      | 'destreza'
      | 'constituicao'
      | 'inteligencia'
      | 'sabedoria'
      | 'carisma',
      number
    >
  >;
  savingThrowBonuses: Partial<
    Record<
      | 'forca'
      | 'destreza'
      | 'constituicao'
      | 'inteligencia'
      | 'sabedoria'
      | 'carisma',
      number
    >
  >;
  speedBonusMeters: number;
  hpBonus: number;

  abilityScoreMax: number;
};

export const EMPTY_PERMANENT_ITEM_EFFECTS: PermanentItemEffects = {
  acBonus: 0,
  attackBonus: 0,
  damageBonus: 0,
  abilityBonuses: {},
  savingThrowBonuses: {},
  speedBonusMeters: 0,
  hpBonus: 0,
  abilityScoreMax: STANDARD_ABILITY_SCORE_CAP,
};

export type InventoryItemForEffects = {
  location: 'equipped' | 'backpack';
  attuned: boolean;
  itemName?: string;
  properties: Record<string, unknown> | null | undefined;
};

export type AbilityScoreCaps = Partial<Record<keyof AbilityScores, number>>;

export type ResolvedPermanentItemEffects = Omit<
  PermanentItemEffects,
  'abilityScoreMax'
> & {
  abilityScoreCaps: AbilityScoreCaps;
  sourceNames: string[];
};
