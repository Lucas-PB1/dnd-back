import { BadRequestException } from '@nestjs/common';
import {
  formatStrikeSelfCostNote,
  spendStrikeSelfCost,
} from '@game/combat/application/strike/spend-strike-self-cost';
import {
  BLOOD_GATE_LOWER_COST,
  BLOOD_GATE_SYMPHONY,
  BLOOD_STRIKE_TABLE_ACTION,
} from '@game/combat/domain/fighter';
import { findStrikeOptionForTableAction } from '@game/combat/domain/strike-option';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '@game/sheet/domain/validation/class-options/subclass-option-effects';
import { applyCurrentHitPoints } from '@game/session/application/core/apply-current-hit-points';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
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
      row.tableAction === BLOOD_STRIKE_TABLE_ACTION &&
      row.itemSlug == null &&
      row.featSlug == null,
  );
  if (!economy || character.subclassSlug !== economy.subclassSlug) {
    throw new BadRequestException('Golpe de Sangue não disponível');
  }

  const option = findStrikeOptionForTableAction(
    catalog.strikeOptions,
    dto.optionSlug,
    BLOOD_STRIKE_TABLE_ACTION,
  );
  if (!option?.costDice) {
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

  let state: Awaited<ReturnType<typeof applyCurrentHitPoints>> | undefined;
  let spent;
  try {
    const gates =
      catalog.featureGatesBySubclassSlug.get(character.subclassSlug ?? '') ??
      new Map();
    spent = await spendStrikeSelfCost({
      character,
      option,
      takeLowerCost: dto.takeLowerBloodCost,
      lowerCostUnlockLevel: gates.get(BLOOD_GATE_LOWER_COST) ?? null,
      symphonyUnlockLevel: gates.get(BLOOD_GATE_SYMPHONY) ?? null,
      ports: {
        useClassResource: async (slug, amount) => {
          await deps.state.useClassResource(character, slug, amount);
        },
        applyCurrentHitPoints: async (hitPointsCurrent) => {
          character.hitPointsCurrent = hitPointsCurrent;
          state = await applyCurrentHitPoints(
            deps.state,
            character,
            hitPointsCurrent,
          );
        },
      },
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Golpe de Sangue inválido',
    );
  }

  return {
    state: state!,
    actionName: option.name,
    expression: spent.expression,
    roll: spent.costTotal,
    total: spent.costTotal,
    resourceSpent: true,
    note: formatStrikeSelfCostNote(spent, 'table'),
  };
}
