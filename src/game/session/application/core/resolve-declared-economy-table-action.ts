import { BadRequestException } from '@nestjs/common';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { LoadEffectCatalog } from '@game/effects';
import { executeCatalogEffect } from '@game/effects';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyTemporaryHitPoints } from './apply-temporary-hit-points';
import { assertCharacterLevel } from './table-action-guards';

export type DeclaredEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog?: LoadEffectCatalog;
};

/**
 * Handler mínimo para ações cujo SSOT é `phb_class_economy_action.table_action`:
 * valida nível/subclasse do catálogo, gasta recurso se `alwaysSpendsResource`,
 * devolve nota da descrição; PV temp. via `phb_effect` quando seedado.
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
  let total: number | undefined;

  const effects = deps.effectCatalog
    ? await deps.effectCatalog.load({
        actionSlug,
        triggers: ['on_table_action'],
      })
    : [];
  const effect = effects.find(
    (row) => row.kind === 'temp_hp' || row.kind === 'heal' || row.kind === 'table_note',
  );

  if (effect) {
    const executed = executeCatalogEffect(effect, { level: character.level });
    if (executed.kind === 'temp_hp') {
      state = await applyTemporaryHitPoints(
        deps.state,
        character,
        executed.amount,
      );
      note = `${note} PV temporários aplicados: ${executed.amount}.`;
      total = executed.amount;
    } else if (executed.kind === 'table_note' && executed.note) {
      note = `${note} ${executed.note}`;
    }
  } else if (actionSlug === 'brittle-bone-armor') {
    const tempHp = 2 * character.level;
    state = await applyTemporaryHitPoints(deps.state, character, tempHp);
    note = `${note} PV temporários aplicados: ${tempHp} (2× nível de Mago).`;
    total = tempHp;
  } else if (actionSlug === 'marauders-reprisal') {
    const tempHp = Math.floor(character.level / 2);
    state = await applyTemporaryHitPoints(deps.state, character, tempHp);
    note = `${note} PV temporários aplicados: ${tempHp} (metade do nível).`;
    total = tempHp;
  }

  if (actionSlug === 'red-renewal') {
    const dice = Math.max(1, Math.floor(character.level / 2));
    state = await deps.state.recoverClassResource(
      character,
      'sangromancy-dice',
      dice,
    );
    note = `${note} Recuperados ${dice} Dado(s) de Sangromancia. Recupere também ${dice} Dado(s) de Vida gastos.`;
    total = dice;
  }

  return {
    state,
    actionName: action.name,
    resourceSpent: spendAmount > 0,
    note,
    ...(total != null ? { total } : {}),
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
