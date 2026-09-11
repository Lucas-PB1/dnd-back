import { BadRequestException } from '@nestjs/common';
import type { EffectExecution } from '@game/effects';
import {
  applyCompanionCommand,
  applyCompanionSummon,
  type CompanionTableActionDeps,
} from '../../actions/shared/companion-table-actions';
import type { ApplyCtx } from './types';
import type { ApplyOneEffectResult } from './apply-one-effect.types';

export async function applyCompanionEffect(
  ctx: ApplyCtx,
  executed: EffectExecution,
): Promise<Partial<ApplyOneEffectResult>> {
  const { deps, character, action, options } = ctx;

  if (executed.kind === 'sync_companion') {
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
    return { state: result.state, note: result.note };
  }

  if (executed.kind === 'companion_command') {
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
    return { state: result.state, note: result.note };
  }

  return {};
}
