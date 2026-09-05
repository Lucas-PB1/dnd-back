import { BadRequestException } from '@nestjs/common';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { LoadEffectCatalog } from '@game/effects';
import type { CatalogEffect } from '@game/effects';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CharacterTransformationSnapshot } from '@game/session/infrastructure/queries/transformation-character.queries';
import { applyFeatEconomyExecutedEffect } from './apply-feat-economy-executed-effect';

export type FeatEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog?: LoadEffectCatalog;
  /** Faces do DV da classe; se omitido, usa 8. */
  hitDieFaces?: number;
};

export async function resolveFeatEconomyTableAction(
  deps: FeatEconomyTableActionDeps,
  character: PlayerCharacter,
  featSlug: string,
  actionSlug: string,
  transformation?: CharacterTransformationSnapshot | null,
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
  assertTransformationAllows(action, transformation);

  const spendAmount = resolveSpendAmount(action);
  let state =
    spendAmount > 0 && action.resourceSlug
      ? (
          await deps.state.useClassResource(
            character,
            action.resourceSlug,
            spendAmount,
          )
        ).state
      : await deps.state.buildResponse(character);

  let note =
    action.description?.trim() ||
    action.summary?.trim() ||
    `${action.name}: declare o efeito na mesa.`;
  let total: number | undefined;
  let expression: string | undefined;

  const effect = await loadFeatTableActionEffect(deps.effectCatalog, {
    featSlug,
    tableAction: action.tableAction ?? actionSlug,
    actionId: action.id,
  });
  if (effect) {
    const applied = await applyFeatEconomyExecutedEffect({
      state: deps.state,
      character,
      effect,
      baseNote: note,
      hitDieFaces: deps.hitDieFaces ?? 8,
      currentState: state,
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
  }

  return {
    state,
    actionName: action.name,
    resourceSpent: spendAmount > 0,
    note,
    ...(total != null ? { total } : {}),
    ...(expression ? { expression } : {}),
  };
}

function assertTransformationAllows(
  action: ClassEconomyActionRecord,
  transformation?: CharacterTransformationSnapshot | null,
): void {
  if (!transformation) return;
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
}

async function loadFeatTableActionEffect(
  effectCatalog: LoadEffectCatalog | undefined,
  input: { featSlug: string; tableAction: string; actionId: string },
): Promise<CatalogEffect | undefined> {
  if (!effectCatalog) return undefined;
  const base = {
    triggers: ['on_table_action' as const],
    ownerKind: 'feat' as const,
    ownerSlugs: [input.featSlug],
  };
  const primary = await effectCatalog.load({
    ...base,
    actionSlug: input.tableAction,
  });
  if (primary[0]) return primary[0];
  if (input.actionId === input.tableAction) return undefined;
  const byId = await effectCatalog.load({
    ...base,
    actionSlug: input.actionId,
  });
  return byId[0];
}

function findFeatEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  featSlug: string,
  actionSlug: string,
): ClassEconomyActionRecord | undefined {
  return economyActions.find(
    (row) =>
      row.featSlug === featSlug &&
      (row.tableAction === actionSlug || row.id === actionSlug) &&
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
