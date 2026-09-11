import { BadRequestException } from '@nestjs/common';
import {
  formatStrikeSelfCostNote,
  spendStrikeSelfCost,
} from '@game/combat/application/strike/spend-strike-self-cost';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import {
  BLOOD_GATE_LOWER_COST,
  BLOOD_GATE_SYMPHONY,
  BLOOD_STRIKE_TABLE_ACTION,
} from '@game/combat/domain/fighter';
import { findStrikeOptionForTableAction } from '@game/combat/domain/strike-option';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '@game/sheet/domain/validation/class-options/subclass-option-effects';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyCurrentHitPoints } from '../../primitives/apply-current-hit-points';
import { assertCharacterLevel } from '../../primitives/table-action-guards';

export async function applyStrikeSelfCostTableAction(input: {
  state: CharacterStateRepository;
  sheet: CharacterSheetRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  character: PlayerCharacter;
  optionSlug: string;
  takeLowerBloodCost?: boolean;
}): Promise<TableActionResponseDto> {
  const { character } = input;
  assertCharacterLevel(character, 3, 'Guerreiro', 'Golpe de Sangue');
  if (!input.optionSlug) {
    throw new BadRequestException(
      'optionSlug é obrigatório (opção de Golpe de Sangue)',
    );
  }

  const catalog = await input.mechanicalCatalog.load();
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
    input.optionSlug,
    BLOOD_STRIKE_TABLE_ACTION,
  );
  if (!option?.costDice) {
    throw new BadRequestException(
      `Opção de Golpe de Sangue desconhecida: ${input.optionSlug}`,
    );
  }

  const sheet = await input.sheet.load(character.id);
  const known = (sheet.subclassOptions ?? []).some(
    (opt) =>
      BLOOD_STRIKE_OPTION_KEY_RE.test(opt.optionKey) &&
      opt.valueId === input.optionSlug,
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
      takeLowerCost: input.takeLowerBloodCost,
      lowerCostUnlockLevel: gates.get(BLOOD_GATE_LOWER_COST) ?? null,
      symphonyUnlockLevel: gates.get(BLOOD_GATE_SYMPHONY) ?? null,
      ports: {
        useClassResource: async (slug, amount) => {
          await input.state.useClassResource(character, slug, amount);
        },
        applyCurrentHitPoints: async (hitPointsCurrent) => {
          character.hitPointsCurrent = hitPointsCurrent;
          state = await applyCurrentHitPoints(
            input.state,
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
