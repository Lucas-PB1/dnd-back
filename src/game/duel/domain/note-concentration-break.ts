import type { ConcentrationCheckResult } from '@game/combat/domain/resolve-concentration-check';
import type { Duel } from '../infrastructure/duel.entity';
import {
  clearMagicalDarkness,
  MAGICAL_DARKNESS_SPELL_SLUG,
} from './arena-effects';

/** Limpa arena ligada à magia e devolve nota de log (ou null). */
export function noteConcentrationBreak(input: {
  duel: Duel;
  damagedCharacterId: string;
  concentration: ConcentrationCheckResult;
}): string | null {
  if (!input.concentration.broken || !input.concentration.spellSlug) {
    return null;
  }

  const slug = input.concentration.spellSlug;
  const detail = `CD ${input.concentration.dc}, save ${input.concentration.total}`;

  if (slug === MAGICAL_DARKNESS_SPELL_SLUG) {
    if (input.duel.arenaEffectSourceCharacterId === input.damagedCharacterId) {
      input.duel.arenaEffects = clearMagicalDarkness(input.duel.arenaEffects);
      input.duel.arenaEffectSourceCharacterId = null;
      return `Concentração em Escuridão quebrada (${detail}) — arena sem escuridão mágica.`;
    }
    return `Concentração em Escuridão quebrada (${detail}).`;
  }

  return `Concentração em ${slug} quebrada (${detail}).`;
}
