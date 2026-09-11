import type { CatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { UseManeuverResponseDto } from '@game/session/dto/core/session-commands.dto';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { FeatureScheduleBand } from '@game/combat/domain/feature-schedule';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';
import { handleStructuredEarlyKind } from './structured-kind-early-handlers';
import { handleStructuredCatalogKind } from './structured-kind-catalog-handlers';

export type StructuredKindRouteResult =
  | TableActionResponseDto
  | UseManeuverResponseDto
  | null;

type StructuredRouteContext = {
  deps: DeclaredEconomyTableActionDeps;
  character: PlayerCharacter;
  action: ClassEconomyActionRecord;
  actionSlug: string;
  options: DeclaredEconomyTableActionOptions;
  structured: CatalogEffect;
  catalog: {
    featureSchedulesByClassSlug?: ReadonlyMap<string, readonly FeatureScheduleBand[]>;
    featureSchedulesBySubclassSlug?: ReadonlyMap<string, readonly FeatureScheduleBand[]>;
  };
};

export async function handleStructuredKind(
  ctx: StructuredRouteContext,
): Promise<StructuredKindRouteResult> {
  const early = await handleStructuredEarlyKind(
    ctx.deps,
    ctx.character,
    ctx.actionSlug,
    ctx.options,
    ctx.structured,
  );
  if (early) return early;

  return handleStructuredCatalogKind(
    ctx.deps,
    ctx.character,
    ctx.action,
    ctx.actionSlug,
    ctx.options,
    ctx.structured,
    ctx.catalog,
  );
}
