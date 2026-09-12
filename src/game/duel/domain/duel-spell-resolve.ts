import { BadRequestException } from '@nestjs/common';
import { rollDie, rollD20Check } from '@game/dice/domain/dice';
import type { AdvantageMode } from '@game/dice/domain/dice';
import { MAGICAL_DARKNESS_SPELL_SLUG } from './arena-effects';

export type DuelSpellResolution =
  | { kind: 'arena_darkness' }
  | { kind: 'auto_damage'; damage: number; label: string }
  | {
      kind: 'spell_attack';
      damage: number;
      label: string;
      attackTotal: number;
      hit: boolean;
      critical: boolean;
    }
  | { kind: 'slot_only'; note: string };

export function resolveDuelSpellEffect(input: {
  spellSlug: string;
  slotLevel: number;
  characterLevel: number;
  spellAttackBonus: number;
  targetAc: number;
  advantage: AdvantageMode;
  castNote?: string;
}): DuelSpellResolution {
  const slug = input.spellSlug;

  if (slug === MAGICAL_DARKNESS_SPELL_SLUG) {
    return { kind: 'arena_darkness' };
  }

  if (slug === 'misseis-magicos') {
    const darts = 3 + Math.max(0, input.slotLevel - 1);
    let damage = 0;
    for (let i = 0; i < darts; i += 1) {
      damage += rollDie(4) + 1;
    }
    return {
      kind: 'auto_damage',
      damage,
      label: `Mísseis Mágicos (${darts} dardos)`,
    };
  }

  if (slug === 'raio-de-fogo') {
    const cantripDice =
      input.characterLevel >= 17 ? 4 : input.characterLevel >= 11 ? 3 : input.characterLevel >= 5 ? 2 : 1;
    const attack = rollD20Check(input.spellAttackBonus, input.advantage);
    const kept = attack.d20.kept[0] ?? 0;
    const critical = kept === 20;
    const hit = attack.total >= input.targetAc;
    let damage = 0;
    if (hit) {
      const diceCount = critical ? cantripDice * 2 : cantripDice;
      for (let i = 0; i < diceCount; i += 1) {
        damage += rollDie(10);
      }
    }
    return {
      kind: 'spell_attack',
      damage,
      label: `Raio de Fogo`,
      attackTotal: attack.total,
      hit,
      critical,
    };
  }

  return {
    kind: 'slot_only',
    note:
      input.castNote?.trim() ||
      'Magia conjurada (efeito tipado de combate ainda não modelado neste duelo).',
  };
}

export function mergeConditions(input: {
  current: readonly string[];
  action: 'add' | 'remove';
  condition: string;
}): string[] {
  const set = new Set(input.current);
  if (input.action === 'add') {
    set.add(input.condition);
  } else {
    set.delete(input.condition);
  }
  return [...set].sort();
}

export function assertValidDuelConditionSlug(slug: string): void {
  const allowed = new Set([
    'blinded',
    'charmed',
    'deafened',
    'frightened',
    'grappled',
    'incapacitated',
    'invisible',
    'paralyzed',
    'petrified',
    'poisoned',
    'prone',
    'restrained',
    'stunned',
    'unconscious',
  ]);
  if (!allowed.has(slug)) {
    throw new BadRequestException(`Unsupported condition '${slug}'`);
  }
}
