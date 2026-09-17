import type { ConcentrationCheckResult } from '@game/combat/domain/resolve-concentration-check';
import type { Skirmish } from '../infrastructure/skirmish.entity';
import {
  clearMagicalDarkness,
  MAGICAL_DARKNESS_SPELL_SLUG,
} from '@game/duel/domain/arena-effects';

/** Limpa arena ligada à magia e devolve nota de log (ou null). */
export function noteSkirmishConcentrationBreak(input: {
  skirmish: Skirmish;
  damagedCharacterId: string | null;
  concentration: ConcentrationCheckResult;
}): string | null {
  if (!input.concentration.broken || !input.concentration.spellSlug) {
    return null;
  }

  const slug = input.concentration.spellSlug;
  const detail = `CD ${input.concentration.dc}, save ${input.concentration.total}`;

  if (slug === MAGICAL_DARKNESS_SPELL_SLUG) {
    if (
      input.damagedCharacterId != null &&
      input.skirmish.arenaEffectSourceCharacterId === input.damagedCharacterId
    ) {
      input.skirmish.arenaEffects = clearMagicalDarkness(
        input.skirmish.arenaEffects,
      );
      input.skirmish.arenaEffectSourceCharacterId = null;
      return `Concentração em Escuridão quebrada (${detail}) — arena sem escuridão mágica.`;
    }
    return `Concentração em Escuridão quebrada (${detail}).`;
  }

  return `Concentração em ${slug} quebrada (${detail}).`;
}
