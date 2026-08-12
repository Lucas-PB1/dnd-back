import { BadRequestException } from '@nestjs/common';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyTemporaryHitPoints } from './apply-temporary-hit-points';
import { assertCharacterLevel } from './table-action-guards';

export type DeclaredEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

/**
 * Handler mínimo para ações cujo SSOT é `phb_class_economy_action.table_action`:
 * valida nível/subclasse do catálogo, gasta recurso se `alwaysSpendsResource`,
 * devolve nota da descrição; PV temp. quando a feature concede valor fixo calculável.
 */
export async function resolveDeclaredEconomyTableAction(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  actionSlug: string,
): Promise<TableActionResponseDto> {
  const catalog = await deps.mechanicalCatalog.load();
  const action = findDeclaredEconomyAction(
    catalog.economyActions,
    character.classSlug,
    actionSlug,
  );
  if (!action) {
    throw new BadRequestException(`Ação de mesa desconhecida: ${actionSlug}`);
  }

  assertCharacterLevel(
    character,
    action.minLevel,
    character.classSlug ?? 'classe',
    action.name,
  );
  if (
    action.subclassSlug != null &&
    character.subclassSlug !== action.subclassSlug
  ) {
    throw new BadRequestException(
      `${action.name} exige a subclasse correta`,
    );
  }

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

  if (actionSlug === 'brittle-bone-armor') {
    const tempHp = 2 * character.level;
    state = await applyTemporaryHitPoints(deps.state, character, tempHp);
    note = `${note} PV temporários aplicados: ${tempHp} (2× nível de Mago).`;
  }

  return {
    state,
    actionName: action.name,
    resourceSpent: spendAmount > 0,
    note,
    ...(spendAmount > 0 && actionSlug === 'brittle-bone-armor'
      ? { total: 2 * character.level }
      : {}),
  };
}

function findDeclaredEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  classSlug: string | null,
  actionSlug: string,
): ClassEconomyActionRecord | undefined {
  if (!classSlug) return undefined;
  return economyActions.find(
    (row) =>
      row.classSlug === classSlug &&
      row.tableAction === actionSlug &&
      row.itemSlug == null &&
      row.featSlug == null &&
      row.speciesSlug == null,
  );
}

function resolveSpendAmount(action: ClassEconomyActionRecord): number {
  if (!action.resourceSlug || !action.alwaysSpendsResource) {
    return 0;
  }
  return action.spendAmount ?? 1;
}
