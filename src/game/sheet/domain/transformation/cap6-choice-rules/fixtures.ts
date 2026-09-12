/**
 * Fixtures de teste — SSOT de produção é SQL
 * (`phb_transformation_*` + scripts/generate/cap6-choice-rules-seed.mjs).
 */
import * as batch_a from './batches/batch-a';
import * as batch_b from './batches/batch-b';
import * as batch_c from './batches/batch-c';
import type { Cap6TransformationRule } from './types';

export const CAP6_CHOICE_RULES: Record<string, Cap6TransformationRule> = {
  'gh-transformation-aberrant-horror': batch_a.RULE_ABERRANT_HORROR,
  'gh-transformation-fey': batch_a.RULE_FEY,
  'gh-transformation-fiend': batch_a.RULE_FIEND,
  'gh-transformation-hag': batch_a.RULE_HAG,
  'gh-transformation-lich': batch_b.RULE_LICH,
  'gh-transformation-lycanthrope': batch_b.RULE_LYCANTHROPE,
  'gh-transformation-ooze': batch_b.RULE_OOZE,
  'gh-transformation-primordial': batch_b.RULE_PRIMORDIAL,
  'gh-transformation-seraph': batch_c.RULE_SERAPH,
  'gh-transformation-shadowsteel-ghoul': batch_c.RULE_SHADOWSTEEL_GHOUL,
  'gh-transformation-specter': batch_c.RULE_SPECTER,
  'gh-transformation-vampire': batch_c.RULE_VAMPIRE,
};
