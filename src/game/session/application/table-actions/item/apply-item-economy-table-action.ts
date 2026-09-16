import { BadRequestException } from '@nestjs/common';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { LoadEffectCatalog } from '@game/effects';
import type { CatalogEffect } from '@game/effects';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { DataSource, Repository } from 'typeorm';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { loadActiveItemSlugs } from '@game/session/infrastructure/queries/class-resource-character.queries';
import { applyFeatEconomyExecutedEffect } from '../feat/apply-feat-economy-executed-effect';
import { consumeInventoryQuantity } from '../primitives/consume-inventory-quantity';

export type ItemEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog?: LoadEffectCatalog;
  items?: Repository<PlayerCharacterItem>;
  dataSource?: DataSource;
};

export async function applyItemEconomyTableAction(
  deps: ItemEconomyTableActionDeps,
  character: PlayerCharacter,
  itemSlug: string,
  actionSlug: string,
): Promise<TableActionResponseDto> {
  const catalog = await deps.mechanicalCatalog.load();
  const action = findItemEconomyAction(
    catalog.economyActions,
    itemSlug,
    actionSlug,
  );
  if (!action) {
    throw new BadRequestException(`Ação de mesa desconhecida: ${actionSlug}`);
  }

  await assertItemUsable(deps, character, itemSlug, action);

  const spendAmount = resolveSpendAmount(action);
  const effects = await loadItemTableActionEffects(deps.effectCatalog, {
    itemSlug,
    actionId: action.id,
    tableAction: action.tableAction ?? null,
  });
  const spendFromAction = spendAmount > 0 && !!action.resourceSlug;
  let state =
    spendFromAction && action.resourceSlug
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
  let resourceSpent = spendFromAction;
  let appliedSheetEffect = false;

  for (const effect of effects) {
    const applied = await applyFeatEconomyExecutedEffect({
      state: deps.state,
      character,
      effect,
      baseNote: note,
      hitDieFaces: 8,
      currentState: state,
    });
    state = applied.state;
    note = applied.note;
    if (applied.total != null) total = applied.total;
    if (applied.expression) expression = applied.expression;
    resourceSpent = resourceSpent || applied.resourceSpent === true;
    appliedSheetEffect = true;
  }

  if (appliedSheetEffect && !action.resourceSlug) {
    if (!deps.items) {
      throw new BadRequestException('Inventário indisponível para consumir o item');
    }
    await consumeInventoryQuantity(deps.items, character.id, itemSlug);
  }

  return {
    state,
    actionName: action.name,
    resourceSpent,
    note,
    ...(total != null ? { total } : {}),
    ...(expression ? { expression } : {}),
  };
}

function findItemEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  itemSlug: string,
  actionSlug: string,
): ClassEconomyActionRecord | undefined {
  return economyActions.find(
    (row) =>
      row.itemSlug === itemSlug &&
      (row.tableAction === actionSlug || row.id === actionSlug),
  );
}

function resolveSpendAmount(action: ClassEconomyActionRecord): number {
  if (!action.resourceSlug || !action.alwaysSpendsResource) {
    return 0;
  }
  return action.spendAmount ?? 1;
}

async function assertItemUsable(
  deps: ItemEconomyTableActionDeps,
  character: PlayerCharacter,
  itemSlug: string,
  action: ClassEconomyActionRecord,
): Promise<void> {
  if (action.resourceSlug) {
    if (!deps.dataSource) {
      throw new BadRequestException('Catálogo indisponível para item com cargas');
    }
    const active = await loadActiveItemSlugs(deps.dataSource, character.id);
    if (!active.includes(itemSlug)) {
      throw new BadRequestException(
        `Item '${itemSlug}' não está ativo (equipado e sintonizado, se exigir)`,
      );
    }
    return;
  }

  if (!deps.items) {
    throw new BadRequestException('Inventário indisponível para usar o item');
  }
  const row = await deps.items.findOne({
    where: { characterId: character.id, itemSlug },
  });
  if (!row || row.quantity < 1) {
    throw new BadRequestException(`Personagem não possui o item '${itemSlug}'`);
  }
}

async function loadItemTableActionEffects(
  effectCatalog: LoadEffectCatalog | undefined,
  input: { itemSlug: string; actionId: string; tableAction: string | null },
): Promise<CatalogEffect[]> {
  if (!effectCatalog) return [];
  const base = {
    triggers: ['on_table_action' as const],
    ownerKind: 'item' as const,
    ownerSlugs: [input.itemSlug],
  };
  const byId = await effectCatalog.load({
    ...base,
    actionSlug: input.actionId,
  });
  if (byId.length > 0) return byId;
  if (!input.tableAction || input.tableAction === input.actionId) return [];
  return effectCatalog.load({
    ...base,
    actionSlug: input.tableAction,
  });
}
