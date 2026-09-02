import { NOTES_BATCH_A } from './batches/batch-a';
import { NOTES_BATCH_B } from './batches/batch-b';
import type { SubclassCombatNoteEntry } from './types';

export type { SubclassCombatNoteEntry } from './types';
export { GH_CLASS_COMBAT_NOTES } from './class-notes';

export const GH_SUBCLASS_COMBAT_NOTES: Record<
  string,
  SubclassCombatNoteEntry[]
> = {
  ...NOTES_BATCH_A,
  ...NOTES_BATCH_B,
};
