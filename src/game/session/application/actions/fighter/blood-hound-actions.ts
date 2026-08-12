import { BadRequestException } from '@nestjs/common';
import {
  BLOOD_STRIKE_RESOURCE_SLUG,
  bloodStrikeCostDice,
  bloodStrikeLabel,
  bloodSymphonyHealAmount,
  canTakeLowerBloodCost,
} from '@game/combat/domain/fighter';
import { rollExpression } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '@game/sheet/domain/validation/class-options/subclass-option-effects';
import { applyCurrentHitPoints } from '@game/session/application/core/apply-current-hit-points';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type { TableActionResponseDto } from '@game/session/dto';
import type { FighterActionDeps } from './fighter-action-deps';

export type BloodStrikeDto = {
  optionSlug: string;
  /** Sangue da Criação (L10+): rerrola e fica com o menor custo. */
  takeLowerBloodCost?: boolean;
};

export async function useBloodStrikeAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
  dto: BloodStrikeDto,
): Promise<TableActionResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  assertCharacterLevel(character, 3, 'Guerreiro', 'Golpe de Sangue');

  const catalog = await deps.mechanicalCatalog.load();
  const economy = catalog.economyActions.find(
    (row) =>
      row.classSlug === character.classSlug &&
      row.tableAction === 'blood-strike' &&
      row.itemSlug == null &&
      row.featSlug == null,
  );
  if (!economy || character.subclassSlug !== economy.subclassSlug) {
    throw new BadRequestException('Golpe de Sangue não disponível');
  }

  const costDice = bloodStrikeCostDice(dto.optionSlug);
  if (!costDice) {
    throw new BadRequestException(
      `Opção de Golpe de Sangue desconhecida: ${dto.optionSlug}`,
    );
  }

  const sheet = await deps.sheet.load(character.id);
  const known = (sheet.subclassOptions ?? []).some(
    (opt) =>
      BLOOD_STRIKE_OPTION_KEY_RE.test(opt.optionKey) &&
      opt.valueId === dto.optionSlug,
  );
  if (!known) {
    throw new BadRequestException(
      'Personagem não conhece esta opção de Golpe de Sangue',
    );
  }

  if (
    character.hitPointsCurrent == null ||
    character.hitPointsMax == null
  ) {
    throw new BadRequestException('Pontos de Vida do personagem não definidos');
  }

  await deps.state.useClassResource(
    character,
    BLOOD_STRIKE_RESOURCE_SLUG,
    1,
  );

  const first = rollExpression(costDice);
  let costTotal = first.total;
  let expression = first.expression;

  if (dto.takeLowerBloodCost) {
    if (!canTakeLowerBloodCost(character.level)) {
      throw new BadRequestException(
        'Rerrolar o Custo de Sangue exige nível 10+ (Sangue da Criação)',
      );
    }
    const second = rollExpression(costDice);
    costTotal = Math.min(first.total, second.total);
    expression = `${costDice} (menor de ${first.total}/${second.total})`;
  }

  let hp = character.hitPointsCurrent - costTotal;
  const notes: string[] = [
    `${bloodStrikeLabel(dto.optionSlug)}: Custo de Sangue ${expression} = ${costTotal} Necrótico (não reduzível). Aplique o efeito do golpe na mesa.`,
  ];

  if (character.level >= 15) {
    const heal = bloodSymphonyHealAmount(
      abilityModifier(character.abilityScores.constituicao),
    );
    hp += heal;
    notes.push(`Sinfonia de Sangue: +${heal} PV`);
  }

  const state = await applyCurrentHitPoints(deps.state, character, hp);

  return {
    state,
    actionName: bloodStrikeLabel(dto.optionSlug),
    expression,
    roll: costTotal,
    total: costTotal,
    resourceSpent: true,
    note: notes.join(' · '),
  };
}
