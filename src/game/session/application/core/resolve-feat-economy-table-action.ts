import { BadRequestException } from '@nestjs/common';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CharacterTransformationSnapshot } from '@game/session/infrastructure/queries/transformation-character.queries';

export type FeatEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export async function resolveFeatEconomyTableAction(
  deps: FeatEconomyTableActionDeps,
  character: PlayerCharacter,
  featSlug: string,
  actionSlug: string,
  transformation: CharacterTransformationSnapshot,
): Promise<TableActionResponseDto> {
  const catalog = await deps.mechanicalCatalog.load();
  const action = findFeatEconomyAction(
    catalog.economyActions,
    featSlug,
    actionSlug,
  );
  if (!action) {
    throw new BadRequestException(`Ação de mesa desconhecida: ${actionSlug}`);
  }

  if (transformation.stage < action.minLevel) {
    throw new BadRequestException(
      `${action.name} exige estágio de transformação ${action.minLevel}`,
    );
  }

  if (!actionMatchesTransformationChoices(action, transformation.choices)) {
    throw new BadRequestException(
      `${action.name} não está disponível com as escolhas atuais da transformação`,
    );
  }

  const spendAmount = resolveSpendAmount(action);
  const state =
    spendAmount > 0 && action.resourceSlug
      ? (
          await deps.state.useClassResource(
            character,
            action.resourceSlug,
            spendAmount,
          )
        ).state
      : await deps.state.buildResponse(character);

  const note =
    action.description?.trim() ||
    action.summary?.trim() ||
    `${action.name}: declare o efeito na mesa.`;

  return {
    state,
    actionName: action.name,
    resourceSpent: spendAmount > 0,
    note,
  };
}

function findFeatEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  featSlug: string,
  actionSlug: string,
): ClassEconomyActionRecord | undefined {
  return economyActions.find(
    (row) =>
      row.featSlug === featSlug &&
      row.tableAction === actionSlug &&
      row.classSlug == null &&
      row.speciesSlug == null &&
      row.itemSlug == null,
  );
}

function actionMatchesTransformationChoices(
  action: ClassEconomyActionRecord,
  choices: readonly { choiceKind: string; choiceSlug: string }[],
): boolean {
  const key = action.requiresOptionKey;
  const value = action.requiresOptionValue;
  if (!key || !value) return true;
  const picked = choices.find((c) => c.choiceKind === key)?.choiceSlug;
  return picked === value;
}

function resolveSpendAmount(action: ClassEconomyActionRecord): number {
  if (!action.resourceSlug || !action.alwaysSpendsResource) {
    return 0;
  }
  return action.spendAmount ?? 1;
}
