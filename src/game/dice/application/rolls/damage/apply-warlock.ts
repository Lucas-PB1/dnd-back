import { BadRequestException } from '@nestjs/common';
import {
  canUseEldritchSmite,
  eldritchSmiteDice,
} from '@game/combat/domain/warlock/eldritch-smite';
import { addDamagePart } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

export const applyWarlockExtras: DamageEffect = async (ctx, acc) => {
  const { character, dto, resourceSpender } = ctx;
  if (!dto.eldritchSmite) return;

  if (
    !canUseEldritchSmite({
      classSlug: character.classSlug,
      level: character.level,
      invocationSlugs: ctx.eldritchInvocationSlugs,
    })
  ) {
    throw new BadRequestException(
      'Punição Mística exige Bruxo nv.5+ com a invocação Eldritch Smite',
    );
  }

  const slotLevel = dto.smiteSlotLevel ?? 1;
  await resourceSpender.consumeSpellSlotLevel(character, slotLevel);
  const dice = eldritchSmiteDice(slotLevel);
  addDamagePart(acc, dice, { critical: dto.critical });
  acc.notes.push(
    `Punição Mística: ${dice} Energético (espaço de ${slotLevel}º círculo); pode derrubar alvo ≤ Enorme.`,
  );
};
