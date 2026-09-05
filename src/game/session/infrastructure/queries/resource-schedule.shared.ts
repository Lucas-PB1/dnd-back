import { DataSource } from 'typeorm';
import type { ClassResourceScheduleRow } from '@game/session/domain/class-resources';

export type ClassResourceDbRow = {
  resource_slug: string;
  resource_name: string;
  unlock_level: number;
  max_formula: string;
  fixed_max: number | null;
  recover_one_on_short: boolean;
  recover_all_on_short: boolean;
  recover_all_on_long: boolean;
  recover_on_long_dice: string | null;
};

export function mapResourceScheduleRow(
  row: ClassResourceDbRow,
): ClassResourceScheduleRow {
  return {
    resourceSlug: row.resource_slug,
    resourceName: row.resource_name,
    unlockLevel: row.unlock_level,
    maxFormula: row.max_formula,
    fixedMax: row.fixed_max,
    recoverOneOnShort: row.recover_one_on_short,
    recoverAllOnShort: row.recover_all_on_short,
    recoverAllOnLong: row.recover_all_on_long,
    recoverOnLongDice: row.recover_on_long_dice ?? null,
  };
}
