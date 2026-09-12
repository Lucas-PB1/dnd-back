import { BadRequestException } from '@nestjs/common';
import { findDungeoneerPrecautionSpell } from '@game/combat/domain/fighter';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CatalogEffect } from '@game/effects';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';
import { resolveSpendPlan } from './resolve-spend-plan';
import { applyOneEffect } from './apply-one-effect';
import { buildEffectLoopContext } from './build-effect-loop-context';
import { applySpellSpiritFeatureTableAction } from '../kinds/caster/apply-spell-spirit-feature-table-action';

export async function runDeclaredEffectsLoop(input: {
  deps: DeclaredEconomyTableActionDeps;
  character: PlayerCharacter;
  action: ClassEconomyActionRecord;
  actionSlug: string;
  options: DeclaredEconomyTableActionOptions;
  applicable: CatalogEffect[];
  catalog: Awaited<ReturnType<DeclaredEconomyTableActionDeps['mechanicalCatalog']['load']>>;
}): Promise<TableActionResponseDto> {
  const { deps, character, action, actionSlug, options, applicable, catalog } =
    input;

  const spend = resolveSpendPlan(action, options);
  let state =
    spend.amount > 0 && spend.resourceSlug
      ? (
          await deps.state.useClassResource(
            character,
            spend.resourceSlug,
            spend.amount,
          )
        ).state
      : await deps.state.buildResponse(character);

  let note =
    action.description?.trim() ||
    action.summary?.trim() ||
    `${action.name}: declare o efeito na mesa.`;
  let total: number | undefined =
    options.amount != null ? options.amount : undefined;
  let expression: string | undefined;
  let roll: number | undefined;
  let saveDc: number | undefined;
  let resourceSpent = spend.amount > 0;
  let actionName = action.name;

  if (actionSlug === 'dungeon-precaution') {
    if (!options.spellSlug) {
      throw new BadRequestException('spellSlug é obrigatório');
    }
    const spell = findDungeoneerPrecautionSpell(
      catalog.precautionSpells,
      options.spellSlug,
    );
    if (!spell) {
      throw new BadRequestException(
        `Magia de precaução desconhecida: ${options.spellSlug}`,
      );
    }
    actionName = spell.name;
    note = `Precauções na Masmorra: conjure ${spell.name} sem gastar espaço de magia; escolha INT, SAB ou CAR como atributo de conjuração.`;
  }

  const {
    rageBonus,
    strMod,
    intMod,
    castingMod,
    scheduleDieFaces,
    scheduleCount,
    pactSlotLevel,
    pactSlotsRecoveryCount,
  } = buildEffectLoopContext(catalog, character);

  const toggleEffects = applicable.filter((e) => e.kind === 'toggle_combat_flag');
  const otherEffects = applicable.filter((e) => e.kind !== 'toggle_combat_flag');

  let toggleEntered: boolean | null = null;

  for (const effect of toggleEffects) {
    const applied = await applyOneEffect({
      deps,
      character,
      action,
      actionSlug,
      effect,
      state,
      note,
      total,
      expression,
      roll,
      saveDc,
      resourceSpent,
      options,
      rageBonus,
      strMod,
      intMod,
      castingMod,
      scheduleDieFaces,
      scheduleCount,
      pactSlotLevel,
      pactSlotsRecoveryCount,
      rageActive: Boolean(state.rageActive),
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
    roll = applied.roll;
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
      actionSlug,
      effect,
      state,
      note,
      total,
      expression,
      roll,
      saveDc,
      resourceSpent,
      options,
      rageBonus,
      strMod,
      intMod,
      castingMod,
      scheduleDieFaces,
      scheduleCount,
      pactSlotLevel,
      pactSlotsRecoveryCount,
      rageActive: Boolean(state.rageActive),
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
    roll = applied.roll;
    saveDc = applied.saveDc;
    resourceSpent = applied.resourceSpent;
  }

  if (
    (actionSlug === 'spectral-summon' ||
      actionSlug === 'fey-reinforcements') &&
    deps.syncSpellSpirit &&
    deps.dataSource &&
    options.userId
  ) {
    return applySpellSpiritFeatureTableAction({
      state: deps.state,
      dataSource: deps.dataSource,
      syncSpellSpirit: deps.syncSpellSpirit,
      userId: options.userId,
      character,
      actionSlug,
      actionName,
      resourceSpent,
      baseNote: note,
      currentState: state,
      spellSlug: options.spellSlug,
      spiritVariantKey: options.spiritVariantKey,
      slotLevel: options.slotLevel,
    });
  }

  if (
    actionSlug === 'spectral-summon' ||
    actionSlug === 'fey-reinforcements'
  ) {
    throw new BadRequestException(
      `${actionName}: sync de espírito indisponível neste contexto`,
    );
  }

  return {
    state,
    actionName,
    resourceSpent,
    note,
    ...(total != null ? { total } : {}),
    ...(expression != null ? { expression } : {}),
    ...(roll != null ? { roll } : {}),
    ...(saveDc != null ? { saveDc } : {}),
  };
}
