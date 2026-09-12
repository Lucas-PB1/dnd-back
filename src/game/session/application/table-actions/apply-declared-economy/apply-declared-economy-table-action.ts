import { BadRequestException } from '@nestjs/common';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { assertCharacterLevel } from '../primitives/table-action-guards';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
  DeclaredEconomyTableActionResult,
} from './types';
import { findDeclaredEconomyAction } from './find-economy-action';
import { isTableActionEffectApplicable } from './effect-applicability';
import { trySlugEarlyRoute } from './slug-early-routes';
import {
  findStructuredEffect,
  tryStructuredKindRoute,
} from './structured-kind-routes';
import { runDeclaredEffectsLoop } from './run-declared-effects-loop';

export async function applyDeclaredEconomyTableAction(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  actionSlug: string,
  options: DeclaredEconomyTableActionOptions = {},
): Promise<DeclaredEconomyTableActionResult> {
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

  await trySlugEarlyRoute(deps, character, action, actionSlug, options);

  const effects = deps.effectCatalog
    ? await deps.effectCatalog.load({
        actionSlug,
        triggers: ['on_table_action'],
      })
    : [];
  const applicable = effects.filter((e) =>
    isTableActionEffectApplicable(e, character),
  );

  const structured = findStructuredEffect(applicable);
  if (structured) {
    const structuredResult = await tryStructuredKindRoute(
      deps,
      character,
      action,
      actionSlug,
      options,
      structured,
      catalog,
    );
    if (structuredResult) return structuredResult;
  }

  return runDeclaredEffectsLoop({
    deps,
    character,
    action,
    actionSlug,
    options,
    applicable,
    catalog,
  });
}
