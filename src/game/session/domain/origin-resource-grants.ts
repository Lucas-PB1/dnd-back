import { rollDamageParts, type Rng } from '@game/dice/domain/dice';
import type { ResourceDieRollDto } from '@game/session/dto/core/session-commands.dto';
import { proficiencyBonusForLevel } from './proficiency-bonus-for-level';

export const ADRENALINE_SURGE_RESOURCE = 'adrenalineSurge';
export const HEALING_HANDS_RESOURCE = 'healingHands';
export const WEREKIN_SHIFT_ASPECT_RESOURCE = 'werekin-shift-aspect';
export const GH_FOCUSED_EDGE_RESOURCE = 'gh-focused-edge';
export const ENDURING_WYRD_RESOURCE = 'enduring-wyrd';

export type OriginResourceGrant =
  | {
      kind: 'temp_hp';
      amount: number;
      note: string;
      roll?: ResourceDieRollDto;
    }
  | {
      kind: 'heal';
      amount: number;
      note: string;
      roll: ResourceDieRollDto;
    };

type OriginCharacter = {
  level: number;
  speciesSlug: string | null;
};

export function resolveOriginResourceGrant(
  resourceSlug: string,
  character: OriginCharacter,
  rng: Rng = Math.random,
): OriginResourceGrant | null {
  const pb = proficiencyBonusForLevel(character.level);

  if (resourceSlug === ADRENALINE_SURGE_RESOURCE) {
    if (character.speciesSlug !== 'orc') return null;
    return {
      kind: 'temp_hp',
      amount: pb,
      note: `Pico de Adrenalina: ${pb} PV temp. (PB) aplicados na ficha.`,
    };
  }

  if (resourceSlug === WEREKIN_SHIFT_ASPECT_RESOURCE) {
    if (character.speciesSlug !== 'werekin') return null;
    const amount = 2 * pb;
    return {
      kind: 'temp_hp',
      amount,
      note: `Mudar Aspecto — Força Bestial: ${amount} PV temp. (2× PB) aplicados. Selvageria Primal / Caçador Veloz: declare na mesa e ignore estes PV temp. se não for Força Bestial.`,
    };
  }

  if (resourceSlug === HEALING_HANDS_RESOURCE) {
    if (character.speciesSlug !== 'aasimar') return null;
    const rolled = rollDamageParts(`${pb}d4`, 0, { rng });
    return {
      kind: 'heal',
      amount: rolled.total,
      note: `Mãos Curativas: ${rolled.total} PV curados (${rolled.expression}). Toque aplicado na sua ficha; se o alvo for outro, ajuste PV manualmente.`,
      roll: toResourceDieRoll(resourceSlug, rolled),
    };
  }

  if (resourceSlug === GH_FOCUSED_EDGE_RESOURCE) {
    const rolled = rollDamageParts(`${pb}d6`, 0, { rng });
    return {
      kind: 'temp_hp',
      amount: rolled.total,
      note: `Fio Concentrado: ${rolled.total} PV temp. (${rolled.expression}) aplicados na ficha.`,
      roll: toResourceDieRoll(resourceSlug, rolled),
    };
  }

  if (resourceSlug === ENDURING_WYRD_RESOURCE) {
    return {
      kind: 'temp_hp',
      amount: pb,
      note: `Wyrd Duradouro: ${pb} PV temp. (PB) aplicados na ficha.`,
    };
  }

  return null;
}

function toResourceDieRoll(
  resourceSlug: string,
  rolled: ReturnType<typeof rollDamageParts>,
): ResourceDieRollDto {
  return {
    resourceSlug,
    faces: rolled.dice[0]?.sides ?? 0,
    value: rolled.total,
    expression: rolled.expression,
  };
}
