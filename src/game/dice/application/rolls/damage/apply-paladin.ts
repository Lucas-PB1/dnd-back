import { BadRequestException } from '@nestjs/common';
import { divineSmiteDice } from '@game/combat/domain/paladin-features';
import { addDamagePart } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Destruição Divina e Golpes Radiantes (após o Golpe Mortal no pipeline). */
export const applyPaladinExtras: DamageEffect = async (ctx, acc) => {
  const { character, dto, resourceSpender } = ctx;

  if (character.classSlug === 'paladin' && dto.divineSmite) {
    if (dto.mode !== 'melee') {
      throw new BadRequestException('Divine Smite requires a melee attack');
    }
    const slotLevel = dto.smiteSlotLevel ?? 1;
    await resourceSpender.consumeSpellSlotLevel(character, slotLevel);
    const dice = divineSmiteDice({
      slotLevel,
      vsUndeadOrFiend: dto.smiteVsUndeadOrFiend,
    });
    addDamagePart(acc, dice, { critical: dto.critical });
    acc.notes.push(
      `Destruição Divina: ${dice} Radiante (espaço de ${slotLevel}º círculo gasto)`,
    );
  } else if (dto.divineSmite) {
    throw new BadRequestException('Divine Smite requires Paladin class');
  }

  if (
    character.classSlug === 'paladin' &&
    character.level >= 11 &&
    dto.mode === 'melee'
  ) {
    addDamagePart(acc, '1d8', { critical: dto.critical });
    acc.notes.push('Golpes Radiantes: +1d8 Radiante');
  }
};
