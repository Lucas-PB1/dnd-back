/** Barrel estável — imports de `./rogue-features` continuam válidos. */
export {
  type RogueSubclassSlug,
  type CunningStrikeEffectSlug,
  type CunningStrikeEffect,
} from './rogue/types';
export {
  isRogueClass,
  sneakAttackDiceCount,
  sneakAttackDieFaces,
  sneakAttackDiceExpression,
  hasSlipperyMind,
  soulknifePsiDiceSchedule,
} from './rogue/sneak-attack';
export {
  cunningStrikeSaveDc,
  findCunningStrikeEffect,
  availableCunningStrikeEffects,
  validateCunningStrikeSelection,
} from './rogue/cunning-strike';
export { rogueCombatNotes } from './rogue/combat-notes';
