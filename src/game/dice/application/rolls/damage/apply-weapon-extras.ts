import { rollDamageParts } from '../../../domain/dice';
import { addDamagePart, type DamageAccumulator } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Exagero, Mira e Tiro na cabeça. */
export const applyWeaponMasteryExtras: DamageEffect = (ctx, acc) => {
  const { attack, dto, character } = ctx;

  if (attack.overkillExtraDice) {
    addDamagePart(acc, attack.overkillExtraDice, { critical: dto.critical });
  }

  if (
    dto.sightedReroll &&
    attack.masteryActive &&
    attack.masterySlug === 'sighted' &&
    acc.rolls.length > 0
  ) {
    const idx = acc.rolls.indexOf(Math.min(...acc.rolls));
    const reroll = rollDamageParts(
      `1d${attack.damageDice.replace(/^\d+d/i, '').replace(/[+-].*$/, '') || '8'}`,
      0,
    );
    const newFace = reroll.dice[0]?.rolls[0] ?? acc.rolls[idx];
    acc.total = acc.total - acc.rolls[idx] + newFace;
    acc.rolls[idx] = newFace;
    acc.notes.push('Mira: dado rerrolado');
  }

  if (
    dto.headShot &&
    dto.critical &&
    character.classSlug === 'gunslinger' &&
    character.level >= 20
  ) {
    addDamagePart(acc, '10d10', { critical: false });
    acc.notes.push('Tiro na cabeça: morte se <100 PV; senão +10d10');
  }
};

export function noteRageBonus(acc: DamageAccumulator, rageDamageBonus: number): void {
  if (rageDamageBonus > 0) {
    acc.notes.push(`Fúria +${rageDamageBonus}`);
  }
}
