import { BadRequestException } from '@nestjs/common';
import { executeCatalogEffect } from '@game/effects';
import type { ApplyCtx } from './types';
import { resolveFlatOverride } from './flat-override';
import type { ApplyOneEffectResult } from './apply-one-effect.types';
import { applyResourceEffect } from './apply-one-effect-resources';
import { applyTableEffect } from './apply-one-effect-table';
import { applyCompanionEffect } from './apply-one-effect-companion';

export type { ApplyOneEffectResult } from './apply-one-effect.types';

export async function applyOneEffect(ctx: ApplyCtx): Promise<ApplyOneEffectResult> {
  const {
    deps,
    character,
    action,
    actionSlug,
    effect,
    options,
    rageBonus,
    strMod,
    intMod,
    castingMod,
    scheduleDieFaces,
    scheduleCount,
    pactSlotLevel,
    pactSlotsRecoveryCount,
    rageActive,
  } = ctx;
  let { state, note, total, expression, roll, saveDc, resourceSpent } = ctx;

  if (
    effect.requiresOptionKey === 'equipped_persona_mask' &&
    effect.requiresOptionValue
  ) {
    state = await deps.state.buildResponse(character);
    const equipped = state.personaMasks ?? [];
    if (!equipped.includes(effect.requiresOptionValue)) {
      throw new BadRequestException(
        `Vista a máscara requerida (${effect.requiresOptionValue}) antes de usar este efeito`,
      );
    }
  }

  const flatOverrideResult = resolveFlatOverride({
    effect,
    character,
    actionSlug,
    strMod,
    intMod,
    castingMod,
    scheduleDieFaces,
  });

  const executed = executeCatalogEffect(effect, {
    level: character.level,
    rageBonus,
    rageActive,
    diceCount: options.diceCount,
    scheduleDieFaces,
    scheduleCount,
    pactSlotLevel,
    pactSlotsRecoveryCount,
    ...flatOverrideResult,
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
  } else {
    const resourceKinds = new Set([
      'heal',
      'survive_at_zero',
      'temp_hp',
      'recover_resource',
      'recover_resource_to_max',
      'spend_resource',
      'heal_from_dice_pool',
      'recover_spell_slot',
    ]);
    const tableKinds = new Set([
      'feature_dc',
      'table_roll',
      'table_note',
      'grant_inspiration',
      'start_concentration',
    ]);
    const companionKinds = new Set(['sync_companion', 'companion_command']);

    let patch: Partial<ApplyOneEffectResult> = {};

    if (resourceKinds.has(executed.kind) || effect.kind === 'heal') {
      patch = await applyResourceEffect(ctx, executed);
    } else if (tableKinds.has(executed.kind)) {
      patch = await applyTableEffect(ctx, executed);
    } else if (companionKinds.has(executed.kind)) {
      patch = await applyCompanionEffect(ctx, executed);
    }

    state = patch.state ?? state;
    note = patch.note ?? note;
    total = patch.total ?? total;
    expression = patch.expression ?? expression;
    roll = patch.roll ?? roll;
    saveDc = patch.saveDc ?? saveDc;
    resourceSpent = patch.resourceSpent ?? resourceSpent;
  }

  return {
    state,
    note,
    total,
    expression,
    roll,
    saveDc,
    resourceSpent,
    toggleEntered,
  };
}
