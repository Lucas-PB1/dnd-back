import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { rageDamageBonus } from '@game/combat/domain/barbarian';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import type { LoadEffectCatalog } from '@game/effects';
import { executeCatalogEffect, type CatalogEffect } from '@game/effects';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  applyCompanionCommand,
  applyCompanionSummon,
  type CompanionTableActionDeps,
} from '../actions/shared/companion-table-actions';
import { applyTemporaryHitPoints } from './apply-temporary-hit-points';
import { assertCharacterLevel } from './table-action-guards';

export type DeclaredEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog?: LoadEffectCatalog;
  companion?: {
    dataSource: DataSource;
    syncCompanion: SyncCharacterCompanionHandler;
  };
};

export type DeclaredEconomyTableActionOptions = {
  userId?: string;
  diceCount?: number;
  companionCommand?: string;
};

/**
 * SSOT mesa: `phb_class_economy_action` (botão/gasto) + `phb_effect` on_table_action (apply).
 */
export async function applyDeclaredEconomyTableAction(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  actionSlug: string,
  options: DeclaredEconomyTableActionOptions = {},
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
    throw new BadRequestException(`${action.name} exige a subclasse correta`);
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
  let expression: string | undefined;
  let saveDc: number | undefined;
  let resourceSpent = spendAmount > 0;

  const effects = deps.effectCatalog
    ? await deps.effectCatalog.load({
        actionSlug,
        triggers: ['on_table_action'],
      })
    : [];

  const bands = featureSchedulesFromCatalog(
    {
      featureSchedulesByClassSlug:
        catalog.featureSchedulesByClassSlug ?? new Map(),
      featureSchedulesBySubclassSlug:
        catalog.featureSchedulesBySubclassSlug ?? new Map(),
    },
    character.classSlug,
    character.subclassSlug,
  );
  const rageBonus = rageDamageBonus(character.level, bands);
  const strMod = abilityModifier(character.abilityScores?.forca ?? 10);

  const toggleEffects = effects.filter((e) => e.kind === 'toggle_combat_flag');
  const otherEffects = effects.filter((e) => e.kind !== 'toggle_combat_flag');

  let toggleEntered: boolean | null = null;

  for (const effect of toggleEffects) {
    const applied = await applyOneEffect({
      deps,
      character,
      action,
      effect,
      state,
      note,
      total,
      expression,
      saveDc,
      resourceSpent,
      options,
      rageBonus,
      strMod,
      rageActive: Boolean(state.rageActive),
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
    saveDc = applied.saveDc;
    resourceSpent = applied.resourceSpent;
    if (applied.toggleEntered != null) toggleEntered = applied.toggleEntered;
  }

  for (const effect of otherEffects) {
    if (
      toggleEntered === false &&
      (effect.kind === 'temp_hp' || effect.kind === 'table_note')
    ) {
      continue;
    }
    const applied = await applyOneEffect({
      deps,
      character,
      action,
      effect,
      state,
      note,
      total,
      expression,
      saveDc,
      resourceSpent,
      options,
      rageBonus,
      strMod,
      rageActive: Boolean(state.rageActive),
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
    saveDc = applied.saveDc;
    resourceSpent = applied.resourceSpent;
  }

  return {
    state,
    actionName: action.name,
    resourceSpent,
    note,
    ...(total != null ? { total } : {}),
    ...(expression != null ? { expression } : {}),
    ...(saveDc != null ? { saveDc } : {}),
  };
}

type ApplyCtx = {
  deps: DeclaredEconomyTableActionDeps;
  character: PlayerCharacter;
  action: ClassEconomyActionRecord;
  effect: CatalogEffect;
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
  saveDc?: number;
  resourceSpent: boolean;
  options: DeclaredEconomyTableActionOptions;
  rageBonus: number;
  strMod: number;
  rageActive: boolean;
};

async function applyOneEffect(ctx: ApplyCtx): Promise<{
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
  saveDc?: number;
  resourceSpent: boolean;
  toggleEntered?: boolean | null;
}> {
  const {
    deps,
    character,
    action,
    effect,
    options,
    rageBonus,
    strMod,
    rageActive,
  } = ctx;
  let { state, note, total, expression, saveDc, resourceSpent } = ctx;

  const needsStrFlat =
    effect.kind === 'feature_dc' ||
    effect.numeric?.amountFormula === 'ability_mod' ||
    effect.numeric?.amountFormula === 'eight_plus_mod_plus_pb';

  const executed = executeCatalogEffect(effect, {
    level: character.level,
    rageBonus,
    rageActive,
    diceCount: options.diceCount,
    ...(needsStrFlat ? { flatOverride: strMod } : {}),
  });

  let toggleEntered: boolean | null | undefined;

  if (executed.kind === 'toggle_combat_flag') {
    const before = state;
    if (executed.flag === 'rage') {
      const entering = executed.forceEnter ? true : !before.rageActive;
      state = await deps.state.martial.toggleRage(
        character,
        entering,
        entering ? executed.spendOnEnter : false,
      );
      toggleEntered = entering;
      resourceSpent = resourceSpent || (entering && executed.spendOnEnter);
      if (!entering) {
        note = executed.note?.trim() || 'Fúria encerrada.';
      } else {
        note =
          executed.note?.trim() ||
          `Fúria ativa (+${rageBonus} dano FOR; Resistência Contundente/Cortante/Perfurante).${executed.spendOnEnter ? ' Gasta 1 uso.' : ''}`;
        if (character.subclassSlug === 'wild-heart' && character.level >= 3) {
          note +=
            ' Coração Selvagem: escolha Águia, Lobo ou Urso nesta ativação (mesa).';
        }
        if (character.subclassSlug === 'wild-heart' && character.level >= 14) {
          note += ' Também escolha Carneiro, Falcão ou Leão.';
        }
        if (character.level >= 7) {
          note += ' Bote Instintivo: mova até metade do Deslocamento.';
        }
      }
    } else {
      const next = !before.recklessActive;
      state = await deps.state.martial.toggleReckless(character, next);
      toggleEntered = next;
      note =
        executed.note?.trim() ||
        (next
          ? 'Ataque Imprudente ativo: Vantagem em ataques com Força; ataques contra você têm Vantagem.'
          : 'Ataque Imprudente encerrado.');
    }
  } else if (executed.kind === 'temp_hp') {
    state = await applyTemporaryHitPoints(
      deps.state,
      character,
      executed.amount,
    );
    total = executed.amount;
    expression = executed.expression;
    note = `${note} PV temporários aplicados: ${executed.amount}.`;
  } else if (executed.kind === 'recover_resource' && executed.resourceSlug) {
    state = await deps.state.recoverClassResource(
      character,
      executed.resourceSlug,
      executed.amount,
    );
    total = executed.amount;
    note = executed.note?.trim()
      ? `${note} ${executed.note.trim()}`
      : `${note} Recuperados ${executed.amount} uso(s) de ${executed.resourceSlug}.`;
  } else if (
    executed.kind === 'recover_resource_to_max' &&
    executed.resourceSlug
  ) {
    if (executed.resourceSlug === 'rage') {
      state = await deps.state.martial.recoverAllRage(character);
    } else {
      const pool = state.classResources?.find(
        (r) => r.slug === executed.resourceSlug,
      );
      const missing = pool ? Math.max(0, pool.max - pool.remaining) : 0;
      if (missing > 0) {
        state = await deps.state.recoverClassResource(
          character,
          executed.resourceSlug,
          missing,
        );
      } else {
        state = await deps.state.buildResponse(character);
      }
    }
    note =
      executed.note?.trim() ||
      `Recuperou todos os usos de ${executed.resourceSlug}.`;
  } else if (executed.kind === 'feature_dc') {
    saveDc = executed.saveDc;
    if (executed.note?.trim()) note = `${note} ${executed.note.trim()}`;
    else note = `${note} CD ${executed.saveDc}.`;
  } else if (executed.kind === 'table_roll') {
    total = executed.amount;
    expression = executed.expression;
    if (executed.note?.trim()) {
      note = executed.note
        .replace(/\{total\}/g, String(executed.amount))
        .replace(/\{expression\}/g, executed.expression);
    }
  } else if (executed.kind === 'heal_from_dice_pool') {
    if (!executed.resourceSlug) {
      throw new BadRequestException('heal_from_dice_pool exige resource_slug');
    }
    state = (
      await deps.state.useClassResource(
        character,
        executed.resourceSlug,
        executed.diceCount,
      )
    ).state;
    resourceSpent = true;
    total = executed.amount;
    expression = executed.expression;
    note =
      executed.note?.trim() ||
      `Campeão dos Deuses: Ação Bônus — recupere ${executed.amount} PV (${executed.expression}). Aplique na ficha.`;
    note = note
      .replace(/\{total\}/g, String(executed.amount))
      .replace(/\{expression\}/g, executed.expression);
  } else if (executed.kind === 'sync_companion') {
    if (!deps.companion || !options.userId) {
      throw new BadRequestException('Companheiro indisponível nesta ação');
    }
    if (!character.subclassSlug) {
      throw new BadRequestException('Companheiro exige subclasse');
    }
    const companionDeps: CompanionTableActionDeps = {
      state: deps.state,
      dataSource: deps.companion.dataSource,
      syncCompanion: deps.companion.syncCompanion,
    };
    const result = await applyCompanionSummon(
      companionDeps,
      options.userId,
      character,
      character.subclassSlug,
      character.subclassSlug,
      action.name,
      executed.restoreHp,
    );
    state = result.state;
    note = result.note;
  } else if (executed.kind === 'companion_command') {
    if (!deps.companion) {
      throw new BadRequestException('Companheiro indisponível nesta ação');
    }
    if (!character.subclassSlug) {
      throw new BadRequestException('Companheiro exige subclasse');
    }
    const companionDeps: CompanionTableActionDeps = {
      state: deps.state,
      dataSource: deps.companion.dataSource,
      syncCompanion: deps.companion.syncCompanion,
    };
    const result = await applyCompanionCommand(
      companionDeps,
      character,
      character.subclassSlug,
      character.subclassSlug,
      action.name,
      options.companionCommand,
    );
    state = result.state;
    note = result.note;
  } else if (executed.kind === 'table_note' && executed.note) {
    note = `${note} ${executed.note}`;
    if (executed.amount != null) {
      total = executed.amount;
      expression = executed.expression;
    }
  } else if (executed.kind === 'grant_inspiration') {
    state = await deps.state.patch(character, { inspiration: true });
    if (executed.note) note = `${note} ${executed.note}`;
  }

  return {
    state,
    note,
    total,
    expression,
    saveDc,
    resourceSpent,
    toggleEntered,
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
