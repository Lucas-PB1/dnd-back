import type { CatalogEffect } from '../catalog-effect';
import type { EffectExecution, ExecuteCatalogEffectContext } from './types';
import { EXECUTABLE_KINDS } from './executable-kinds';
import { tableNoteFromEffect } from './table-note';
import { executeStructuredEffect } from './execute-structured';
import { executeResourceEffect } from './execute-resource';
import { executeTableEffect } from './execute-table';

const TABLE_KINDS = new Set(['feature_dc', 'table_roll', 'heal', 'temp_hp']);

export function executeCatalogEffect(
  effect: CatalogEffect,
  context: ExecuteCatalogEffectContext,
): EffectExecution {
  if (!EXECUTABLE_KINDS.has(effect.kind)) {
    return tableNoteFromEffect(effect, context);
  }

  const structured = executeStructuredEffect(effect, context);
  if (structured) return structured;

  const resource = executeResourceEffect(effect, context);
  if (resource) return resource;

  if (TABLE_KINDS.has(effect.kind)) {
    return executeTableEffect(effect, context);
  }

  return tableNoteFromEffect(effect, context);
}
