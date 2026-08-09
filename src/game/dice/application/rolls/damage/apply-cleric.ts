import { BadRequestException } from '@nestjs/common';
import {
  divineStrikeDice,
  isClericClass,
} from '@game/combat/domain/cleric';
import { addDamagePart } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Golpe Divino, opção de Golpes Abençoados usada com ataque de arma. */
export const applyClericExtras: DamageEffect = (ctx, acc) => {
  if (!ctx.dto.divineStrike) return;

  if (!isClericClass(ctx.character.classSlug) || ctx.character.level < 7) {
    throw new BadRequestException('Divine Strike requires Cleric level 7');
  }

  const dice = divineStrikeDice(ctx.character.level);
  if (!dice) return;

  addDamagePart(acc, dice, { critical: ctx.dto.critical });
  acc.notes.push(
    `Golpe Divino: +${dice} Necrótico ou Radiante (1× por turno; opção de Golpes Abençoados)`,
  );
};
