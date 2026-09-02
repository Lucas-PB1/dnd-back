import type { Cap6BoonCombatNote } from './types';
import * as batch_a from './batches/batch-a';
import * as batch_b from './batches/batch-b';
import * as batch_c from './batches/batch-c';
import * as batch_d from './batches/batch-d';
export { CAP6_ECONOMY_LABEL_PT } from './economy-labels';
export type { Cap6BoonCombatNote } from './types';

export const CAP6_BOON_COMBAT_NOTES: Record<string, Cap6BoonCombatNote> = {
  ...batch_a.NOTES_ABERRANT_HORROR,
  ...batch_a.NOTES_FEY,
  ...batch_a.NOTES_FIEND,
  ...batch_b.NOTES_HAG,
  ...batch_b.NOTES_LICH,
  ...batch_b.NOTES_LYCANTHROPE,
  ...batch_c.NOTES_OOZE,
  ...batch_c.NOTES_PRIMORDIAL,
  ...batch_c.NOTES_SERAPH,
  ...batch_d.NOTES_SHADOWSTEEL_GHOUL,
  ...batch_d.NOTES_SPECTER,
  ...batch_d.NOTES_VAMPIRE,
};
