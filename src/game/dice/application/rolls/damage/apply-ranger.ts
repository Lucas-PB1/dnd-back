import { BadRequestException } from '@nestjs/common';
import {
  carnificinaDamageBonus,
  feyDreadfulStrikesDie,
  gloomDreadAmbusherDie,
  huntersMarkDie,
  isRangerClass,
} from '@game/combat/domain/ranger';
import { addDamagePart, addFlatDamage } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Marca do Predador, Carnificina, Assassino de Colossos, Golpes Terríveis e Golpe Terrível. */
export const applyRangerExtras: DamageEffect = async (ctx, acc) => {
  const { character, combatFlags, dto, resourceSpender } = ctx;

  if (isRangerClass(character.classSlug) && dto.huntersMark) {
    const die = huntersMarkDie(character.level);
    addDamagePart(acc, die, { critical: dto.critical });
    acc.notes.push(`Marca do Predador: +${die} Energético`);
  } else if (dto.huntersMark) {
    throw new BadRequestException("Hunter's Mark requires Ranger class");
  }

  const carnificina = carnificinaDamageBonus({
    subclassSlug: character.subclassSlug,
    characterLevel: character.level,
    bestialAspectLevel: combatFlags.bestialAspectLevel,
  });
  if (carnificina > 0) {
    addFlatDamage(
      acc,
      carnificina,
      `Carnificina: +${carnificina} (Aspecto ${combatFlags.bestialAspectLevel})`,
    );
  }

  if (dto.colossusSlayer) {
    if (character.subclassSlug !== 'hunter' || character.level < 3) {
      throw new BadRequestException(
        'Colossus Slayer requires Hunter subclass level 3',
      );
    }
    addDamagePart(acc, '1d8', { critical: dto.critical });
    acc.notes.push(
      'Assassino de Colossos: +1d8 (1×/turno vs alvo abaixo do máximo de PV)',
    );
  }

  if (dto.dreadfulStrikes) {
    if (character.subclassSlug !== 'fey-wanderer' || character.level < 3) {
      throw new BadRequestException(
        'Dreadful Strikes requires Fey Wanderer level 3',
      );
    }
    const die = feyDreadfulStrikesDie(character.level);
    addDamagePart(acc, die, { critical: dto.critical });
    acc.notes.push(`Golpes Terríveis: +${die} Psíquico (1×/turno)`);
  }

  if (dto.dreadAmbusher) {
    if (character.subclassSlug !== 'gloom-stalker' || character.level < 3) {
      throw new BadRequestException(
        'Dread Ambusher requires Gloom Stalker level 3',
      );
    }
    await resourceSpender.spendClassResource(character, 'dread-strike', 1);
    const die = gloomDreadAmbusherDie(character.level);
    addDamagePart(acc, die, { critical: dto.critical });
    acc.notes.push(
      `Golpe Terrível: +${die} Psíquico (1 uso de Emboscador gasto)`,
    );
  }
};
