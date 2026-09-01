import { BadRequestException } from '@nestjs/common';
import { addDamagePart } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Golpe Rápido (Determinação do Sindicato) — toggle no dano do ataque. */
export const applyGrimHollowFeatExtras: DamageEffect = async (ctx, acc) => {
  const { dto, attack } = ctx;
  if (!dto.quickStrike) return;
  if (!attack.quickStrikeDice) {
    throw new BadRequestException(
      'Golpe Rápido requires the resolutionofthe-syndicate origin feat',
    );
  }
  addDamagePart(acc, attack.quickStrikeDice, { critical: dto.critical });
  acc.notes.push(
    'Golpe Rápido: 1º dano após Iniciativa neste combate (marque após usar)',
  );
};
