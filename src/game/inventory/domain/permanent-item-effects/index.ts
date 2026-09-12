

export type {
  AbilityScoreCaps,
  InventoryItemForEffects,
  PermanentItemEffects,
  ResolvedPermanentItemEffects,
} from './types';
export { EMPTY_PERMANENT_ITEM_EFFECTS } from './types';

export { parsePermanentItemEffects } from './parse';
export {
  applyItemAbilityBonuses,
  resolveActivePermanentItemEffects,
} from './resolve';
