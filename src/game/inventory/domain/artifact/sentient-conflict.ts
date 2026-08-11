import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { parseInstanceProperties } from './roll-artifact-instance';

const CONFLICT_BASE_DC = 12;

export type SentientConflictResolution = {
  itemSlug: string;
  saveDc: number;
  itemCharisma: number;
  itemCharismaMod: number;
  note: string;
};

/** Conflito senciente: CD = 12 + mod. Carisma do item (Treasure). */
export function resolveSentientConflict(input: {
  itemSlug: string;
  instanceProperties: unknown;
}): SentientConflictResolution {
  const instance = parseInstanceProperties(input.instanceProperties);
  const sentience = instance?.sentience;
  const itemCharisma =
    sentience && typeof sentience.carisma === 'number'
      ? sentience.carisma
      : null;
  if (itemCharisma == null || !Number.isFinite(itemCharisma)) {
    throw new Error(
      `Item '${input.itemSlug}' has no sentience.carisma for conflict`,
    );
  }
  const itemCharismaMod = abilityModifier(itemCharisma);
  const saveDc = CONFLICT_BASE_DC + itemCharismaMod;
  return {
    itemSlug: input.itemSlug,
    saveDc,
    itemCharisma,
    itemCharismaMod,
    note: `Conflito senciente: salvaguarda de Carisma CD ${saveDc} (12 + mod. CAR do item ${itemCharismaMod}). Falha → Charm 1d12 h / suprime poderes / impede sintonia (mesa).`,
  };
}
