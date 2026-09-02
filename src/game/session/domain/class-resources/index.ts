/**
 * Resolve máximos e recuperação de recursos de classe (PHB 2024).
 * Cotas vêm de `phb_resource_grant` + `phb_class_progression.channel_divinity`.
 * Tabelas nível→quantidade: [`resource-max-formulas.ts`](../resource-max-formulas.ts).
 */

export type {
  AbilityMods,
  ClassResourceMax,
  ClassResourceScheduleRow,
  LongRestResourceRecoveryResult,
  ResourceMaxFormula,
} from './types';

export { resolveClassResourceMaxima } from './resolve-maxima';
export {
  applyLongRestResourceRecovery,
  applyResourceRecover,
  applyResourceSpend,
  applyShortRestResourceRecovery,
  resourcesRemaining,
} from './spend-and-recover';
