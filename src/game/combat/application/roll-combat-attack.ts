import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { rollD20Check } from '@game/dice/domain/dice';
import type { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';
import { resolveAttackVsArmorClass } from '../domain/attack-vs-armor-class';
import {
  pickActorAttackAction,
  pickEquippedWeaponItemSlug,
  rollActorCombatDamage,
} from './combat-attack-weapons';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';

export type CombatAttackRoll = {
  hit: boolean;
  critical: boolean;
  attackTotal: number;
  attackExpression: string;
  attackRolls: number[];
  naturalD20: number;
  damageTotal: number | null;
  damageExpression: string | null;
  damageRolls: number[];
  note: string | null;
};

export type CombatAttackCommand = {
  advantage?: 'normal' | 'advantage' | 'disadvantage';
  itemSlug?: string;
  mode?: 'melee' | 'ranged';
  actionId?: string;
  spentInspiration?: boolean;
  automatic?: boolean;
  studiedAttack?: boolean;
  doorKick?: boolean;
  steadyAim?: boolean;
  strokeOfLuck?: boolean;
  assassinate?: boolean;
  preciseHunter?: boolean;
  brutalStrike?: boolean;
  targetCover?: 'none' | 'half' | 'three_quarters' | 'full';
  longRange?: boolean;
  meleeWithRanged?: boolean;
  graze?: boolean;
  sneakAttack?: boolean;
  cunningStrikeEffects?: string[];
  divineSmite?: boolean;
  smiteSlotLevel?: number;
  smiteVsUndeadOrFiend?: boolean;
  eldritchSmite?: boolean;
  gunslingerRiskDamageBonus?: number;
  huntersMark?: boolean;
  colossusSlayer?: boolean;
  dreadfulStrikes?: boolean;
  dreadAmbusher?: boolean;
  divineStrike?: boolean;
  savageAttacker?: boolean;
  chargerStrike?: boolean;
  haftBonusAttack?: boolean;
  poisonousSneak?: boolean;
  assassinSurprise?: boolean;
  psiStrike?: boolean;
  monsterSlayer?: boolean;
  divineFury?: boolean;
  quickStrike?: boolean;
};

export async function rollPcCombatAttack(input: {
  rolls: CharacterRollsService;
  inventoryItems: Repository<PlayerCharacterItem>;
  userId: string;
  characterId: string;
  dto: CombatAttackCommand;
  targetAc: number;
}): Promise<CombatAttackRoll> {
  const itemSlug = await pickEquippedWeaponItemSlug(
    input.inventoryItems,
    input.characterId,
    input.dto.itemSlug,
  );
  const modes: Array<'melee' | 'ranged'> = input.dto.mode
    ? [input.dto.mode]
    : ['melee', 'ranged'];
  let usedMode = modes[0];
  let attack;
  try {
    attack = await input.rolls.rollAttack(input.userId, input.characterId, {
      itemSlug,
      mode: usedMode,
      advantage: input.dto.advantage,
      automatic: input.dto.automatic,
      studiedAttack: input.dto.studiedAttack,
      doorKick: input.dto.doorKick,
      steadyAim: input.dto.steadyAim,
      strokeOfLuck: input.dto.strokeOfLuck,
      assassinate: input.dto.assassinate,
      preciseHunter: input.dto.preciseHunter,
      brutalStrike: input.dto.brutalStrike,
      targetCover: input.dto.targetCover,
      longRange: input.dto.longRange,
      meleeWithRanged: input.dto.meleeWithRanged,
      spentInspiration: input.dto.spentInspiration,
    });
  } catch (error) {
    if (!(error instanceof BadRequestException) || !modes[1]) throw error;
    usedMode = modes[1];
    attack = await input.rolls.rollAttack(input.userId, input.characterId, {
      itemSlug,
      mode: usedMode,
      advantage: input.dto.advantage,
      automatic: input.dto.automatic,
      studiedAttack: input.dto.studiedAttack,
      doorKick: input.dto.doorKick,
      steadyAim: input.dto.steadyAim,
      strokeOfLuck: input.dto.strokeOfLuck,
      assassinate: input.dto.assassinate,
      preciseHunter: input.dto.preciseHunter,
      brutalStrike: input.dto.brutalStrike,
      targetCover: input.dto.targetCover,
      longRange: input.dto.longRange,
      meleeWithRanged: input.dto.meleeWithRanged,
      spentInspiration: input.dto.spentInspiration,
    });
  }
  const natural = attack.kept?.[0] ?? 0;
  const vsAc = resolveAttackVsArmorClass({
    attackTotal: attack.total,
    targetAc: input.targetAc,
    naturalD20: natural,
    critThreshold: attack.critical ? natural : undefined,
  });
  const notes = [attack.note].filter((row): row is string => Boolean(row));
  if (!vsAc.hit) {
    notes.push('Erro');
    if (input.dto.graze) {
      const graze = await input.rolls.rollDamage(
        input.userId,
        input.characterId,
        { itemSlug, mode: usedMode, grazeMiss: true },
      );
      notes.push(graze.note ?? 'Resvalar');
      return {
        hit: false,
        critical: false,
        attackTotal: attack.total,
        attackExpression: attack.expression,
        attackRolls: attack.rolls,
        naturalD20: natural,
        damageTotal: graze.total,
        damageExpression: graze.expression,
        damageRolls: graze.rolls ?? [],
        note: notes.join(' · ') || null,
      };
    }
    return {
      hit: false,
      critical: false,
      attackTotal: attack.total,
      attackExpression: attack.expression,
      attackRolls: attack.rolls,
      naturalD20: natural,
      damageTotal: null,
      damageExpression: null,
      damageRolls: [],
      note: notes.join(' · ') || null,
    };
  }
  const damage = await input.rolls.rollDamage(input.userId, input.characterId, {
    itemSlug,
    mode: usedMode,
    critical: vsAc.critical,
    sneakAttack: input.dto.sneakAttack,
    cunningStrikeEffects: input.dto.cunningStrikeEffects,
    divineSmite: input.dto.divineSmite,
    smiteSlotLevel: input.dto.smiteSlotLevel,
    smiteVsUndeadOrFiend: input.dto.smiteVsUndeadOrFiend,
    eldritchSmite: input.dto.eldritchSmite,
    gunslingerRiskDamageBonus: input.dto.gunslingerRiskDamageBonus,
    huntersMark: input.dto.huntersMark,
    colossusSlayer: input.dto.colossusSlayer,
    dreadfulStrikes: input.dto.dreadfulStrikes,
    dreadAmbusher: input.dto.dreadAmbusher,
    divineStrike: input.dto.divineStrike,
    savageAttacker: input.dto.savageAttacker,
    chargerStrike: input.dto.chargerStrike,
    haftBonusAttack: input.dto.haftBonusAttack,
    poisonousSneak: input.dto.poisonousSneak,
    assassinSurprise: input.dto.assassinSurprise,
    psiStrike: input.dto.psiStrike,
    monsterSlayer: input.dto.monsterSlayer,
    divineFury: input.dto.divineFury,
    quickStrike: input.dto.quickStrike,
    brutalStrike: input.dto.brutalStrike,
  });
  if (vsAc.critical) notes.push('Crítico');
  else notes.push('Acerto');
  if (damage.note) notes.push(damage.note);
  return {
    hit: true,
    critical: vsAc.critical,
    attackTotal: attack.total,
    attackExpression: attack.expression,
    attackRolls: attack.rolls,
    naturalD20: natural,
    damageTotal: damage.total,
    damageExpression: damage.expression,
    damageRolls: damage.rolls ?? [],
    note: notes.join(' · ') || null,
  };
}

export async function rollActorCombatAttack(input: {
  actorActions: Repository<GameActorAction>;
  actorId: string;
  dto: CombatAttackCommand;
  targetAc: number;
}): Promise<CombatAttackRoll> {
  const action = await pickActorAttackAction(
    input.actorActions,
    input.actorId,
    input.dto.actionId,
  );
  const roll = rollD20Check(
    action.attackBonus ?? 0,
    input.dto.advantage ?? 'normal',
  );
  const natural = roll.d20.kept[0] ?? 0;
  const vsAc = resolveAttackVsArmorClass({
    attackTotal: roll.total,
    targetAc: input.targetAc,
    naturalD20: natural,
  });
  const notes = [`${action.name}`];
  if (!vsAc.hit) {
    notes.push('Erro');
    return {
      hit: false,
      critical: false,
      attackTotal: roll.total,
      attackExpression: roll.expression,
      attackRolls: roll.d20.rolls,
      naturalD20: natural,
      damageTotal: null,
      damageExpression: null,
      damageRolls: [],
      note: notes.join(' · '),
    };
  }
  const damage = rollActorCombatDamage(
    action.damageExpression,
    vsAc.critical,
  );
  notes.push(vsAc.critical ? 'Crítico' : 'Acerto');
  return {
    hit: true,
    critical: vsAc.critical,
    attackTotal: roll.total,
    attackExpression: roll.expression,
    attackRolls: roll.d20.rolls,
    naturalD20: natural,
    damageTotal: damage?.total ?? 0,
    damageExpression: damage?.expression ?? null,
    damageRolls: damage?.dice.flatMap((die) => die.kept) ?? [],
    note: notes.join(' · '),
  };
}
