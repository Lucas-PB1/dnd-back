import {
  bloodSymphonyHealAmount,
  canBloodSymphonyHeal,
  canTakeLowerBloodCost,
} from '@game/combat/domain/fighter';
import {
  rollStrikeSelfCost,
  type StrikeOption,
  type StrikeSelfCostRoll,
} from '@game/combat/domain/strike-option';
import type { Rng } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export type SpendStrikeSelfCostResult = {
  costTotal: number;
  expression: string;
  heal: number;
  hitPointsAfter: number;
  optionLabel: string;
  cost: StrikeSelfCostRoll;
};

export type SpendStrikeSelfCostPorts = {
  useClassResource: (slug: string, amount: number) => Promise<void>;
  applyCurrentHitPoints: (hitPointsCurrent: number) => Promise<void>;
};

export type SpendStrikeSelfCostNoteStyle = 'table' | 'duel';

/**
 * Gasta 1 uso do `resource_slug` da strike option + custo em si.
 * Cura Sinfonia só se `applySymphonyHeal` e gate de produto (unlock do catálogo).
 */
export async function spendStrikeSelfCost(input: {
  character: PlayerCharacter;
  option: StrikeOption;
  takeLowerCost?: boolean;
  takeLowerMinLevel?: number;
  lowerCostUnlockLevel?: number | null;
  symphonyUnlockLevel?: number | null;
  ports: SpendStrikeSelfCostPorts;
  /** Override resource (default: option.resourceSlug — obrigatório no catálogo). */
  resourceSlug?: string;
  applySymphonyHeal?: boolean;
  rng?: Rng;
}): Promise<SpendStrikeSelfCostResult> {
  const { character, option, ports } = input;
  const costDice = option.costDice;
  if (!costDice) {
    throw new Error(`Strike option sem cost_dice: ${option.slug}`);
  }
  const resourceSlug = input.resourceSlug ?? option.resourceSlug;
  if (!resourceSlug) {
    throw new Error(`Strike option sem resource_slug: ${option.slug}`);
  }
  if (character.hitPointsCurrent == null || character.hitPointsMax == null) {
    throw new Error('Pontos de Vida do personagem não definidos');
  }
  const lowerUnlock =
    input.lowerCostUnlockLevel ?? input.takeLowerMinLevel ?? null;
  if (input.takeLowerCost && !canTakeLowerBloodCost(character.level, lowerUnlock)) {
    throw new Error(
      'Rerrolar o Custo de Sangue exige nível 10+ (Sangue da Criação)',
    );
  }

  await ports.useClassResource(resourceSlug, 1);

  const cost = rollStrikeSelfCost({
    costDice,
    takeLower: Boolean(input.takeLowerCost),
    takeLowerMinLevel: lowerUnlock ?? 10,
    level: character.level,
    rng: input.rng,
  });

  let hitPointsAfter = character.hitPointsCurrent - cost.costTotal;
  let heal = 0;
  const symphony =
    input.applySymphonyHeal !== false &&
    canBloodSymphonyHeal(character.level, input.symphonyUnlockLevel);
  if (symphony) {
    heal = bloodSymphonyHealAmount(
      abilityModifier(character.abilityScores.constituicao),
    );
    hitPointsAfter += heal;
  }
  hitPointsAfter = Math.max(0, hitPointsAfter);

  await ports.applyCurrentHitPoints(hitPointsAfter);

  return {
    costTotal: cost.costTotal,
    expression: cost.expression,
    heal,
    hitPointsAfter,
    optionLabel: option.name,
    cost,
  };
}

export function formatStrikeSelfCostNote(
  result: SpendStrikeSelfCostResult,
  style: SpendStrikeSelfCostNoteStyle,
): string {
  const notes: string[] = [];
  if (style === 'table') {
    notes.push(
      `${result.optionLabel}: Custo de Sangue ${result.expression} = ${result.costTotal} Necrótico (não reduzível). Aplique o efeito do golpe na mesa.`,
    );
    if (result.heal > 0) {
      notes.push(`Sinfonia de Sangue: +${result.heal} PV`);
    }
  } else {
    notes.push(
      `${result.optionLabel}: Custo ${result.expression} = ${result.costTotal} Necrótico`,
    );
    if (result.heal > 0) {
      notes.push(`Sinfonia +${result.heal} PV`);
    }
  }
  return notes.join(' · ');
}
