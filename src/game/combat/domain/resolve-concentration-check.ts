import { rollD20Check } from '@game/dice/domain/dice';
import type { AdvantageMode } from '@game/dice/domain/dice';

/** CD = max(10, metade do dano tomado), PHB. */
export function concentrationSaveDc(damageTaken: number): number {
  const damage = Math.max(0, Math.floor(damageTaken));
  return Math.max(10, Math.floor(damage / 2));
}

export type ConcentrationCheckResult = {
  attempted: boolean;
  broken: boolean;
  dc: number;
  total: number;
  spellSlug: string | null;
};

export function resolveConcentrationCheck(input: {
  damageTaken: number;
  constitutionModifier: number;
  concentratingOn: string | null | undefined;
  advantage?: AdvantageMode;
}): ConcentrationCheckResult {
  const spellSlug = input.concentratingOn?.trim() || null;
  if (!spellSlug || input.damageTaken <= 0) {
    return {
      attempted: false,
      broken: false,
      dc: 10,
      total: 0,
      spellSlug,
    };
  }

  const dc = concentrationSaveDc(input.damageTaken);
  const roll = rollD20Check(
    input.constitutionModifier,
    input.advantage ?? 'normal',
  );
  return {
    attempted: true,
    broken: roll.total < dc,
    dc,
    total: roll.total,
    spellSlug,
  };
}
