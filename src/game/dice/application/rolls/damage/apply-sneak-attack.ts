import { BadRequestException } from '@nestjs/common';
import {
  cunningStrikeSaveDc,
  sneakAttackDieFaces,
  validateCunningStrikeSelection,
} from '../../../../combat/domain/rogue-features';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import { rollDamageParts } from '../../../domain/dice';
import {
  addDamagePart,
  addFlatDamage,
  multiplyDamageTotal,
} from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Ataque Furtivo, Golpe Astuto e opções de Assassino (inclui dobra do Golpe Mortal). */
export const applySneakAttack: DamageEffect = async (ctx, acc) => {
  const { attack, dto, character, domain } = ctx;
  const cunningStrikeEffects = dto.cunningStrikeEffects ?? [];

  if (
    (dto.sneakAttack ||
      cunningStrikeEffects.length > 0 ||
      dto.poisonousSneak ||
      dto.assassinSurprise ||
      dto.assassinDeathStrike ||
      dto.assassinPoisonFailedSave) &&
    character.classSlug !== 'rogue'
  ) {
    throw new BadRequestException('Rogue damage options require Rogue class');
  }
  if (cunningStrikeEffects.length > 0 && !dto.sneakAttack) {
    throw new BadRequestException('Cunning Strike requires Sneak Attack');
  }
  if (
    (dto.poisonousSneak ||
      dto.assassinSurprise ||
      dto.assassinDeathStrike ||
      dto.assassinPoisonFailedSave) &&
    !dto.sneakAttack
  ) {
    throw new BadRequestException(
      'This subclass damage option requires Sneak Attack',
    );
  }

  if (!dto.sneakAttack) {
    return;
  }

  if (!attack.sneakAttackEligible) {
    throw new BadRequestException(
      'Sneak Attack requires a Finesse weapon or a ranged attack',
    );
  }

  let selection: ReturnType<typeof validateCunningStrikeSelection>;
  try {
    selection = validateCunningStrikeSelection({
      level: character.level,
      subclassSlug: character.subclassSlug,
      effectSlugs: cunningStrikeEffects,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid Cunning Strike',
    );
  }

  if (
    dto.poisonousSneak &&
    character.subclassSlug !== 'arachnoid-stalker'
  ) {
    throw new BadRequestException(
      'Poisonous Strike requires Arachnoid Stalker',
    );
  }
  if (
    selection.effects.some((effect) => effect.slug === 'paralyze') &&
    !dto.poisonousSneak
  ) {
    throw new BadRequestException('Paralyze requires Poisonous Strike damage');
  }

  const dieFaces = sneakAttackDieFaces(
    character.subclassSlug,
    dto.poisonousSneak,
  );
  if (selection.remainingSneakAttackDice > 0) {
    addDamagePart(
      acc,
      `${selection.remainingSneakAttackDice}d${dieFaces}`,
      { critical: dto.critical },
    );
  }

  const pb = await domain.getProficiencyBonus(character.level);
  const saveDc = cunningStrikeSaveDc({
    dexterityModifier: abilityModifier(character.abilityScores.destreza),
    proficiencyBonus: pb,
  });
  acc.notes.push(
    `Ataque Furtivo: ${selection.remainingSneakAttackDice}d${dieFaces}${dto.critical ? ' dobrado no crítico' : ''}`,
  );
  for (const effect of selection.effects) {
    acc.notes.push(
      `${effect.name} (custo ${effect.cost}d): ${effect.note}${
        effect.saveAbility ? ` CD ${saveDc}` : ''
      }`,
    );
  }

  if (dto.assassinSurprise) {
    if (character.subclassSlug !== 'assassin' || character.level < 3) {
      throw new BadRequestException(
        'Surprising Strikes requires Assassin level 3',
      );
    }
    addFlatDamage(
      acc,
      character.level,
      `Golpe Surpreendente: +${character.level} de dano da arma na primeira rodada`,
    );
  }

  if (dto.assassinPoisonFailedSave) {
    if (
      character.subclassSlug !== 'assassin' ||
      character.level < 13 ||
      !selection.effects.some((effect) => effect.slug === 'poison')
    ) {
      throw new BadRequestException(
        'Poison Weapons requires Assassin level 13 and Poison Cunning Strike',
      );
    }
    const poison = rollDamageParts('2d6', 0);
    acc.total += poison.total;
    acc.expression = `${acc.expression}+${poison.expression}`;
    acc.rolls.push(...(poison.dice[0]?.rolls ?? []));
    acc.notes.push(
      'Armas Venenosas: +2d6 Venenoso; ignora Resistência a Venenoso',
    );
  }

  if (dto.assassinDeathStrike) {
    if (character.subclassSlug !== 'assassin' || character.level < 17) {
      throw new BadRequestException('Death Strike requires Assassin level 17');
    }
    multiplyDamageTotal(
      acc,
      2,
      `Golpe Mortal: dano dobrado após falha em Constituição CD ${saveDc}`,
    );
  }
};
