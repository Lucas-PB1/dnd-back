import type { CatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { FeatureScheduleBand } from '@game/combat/domain/feature-schedule';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';
import {
  handleStructuredKind,
  type StructuredKindRouteResult,
} from './structured-kind-handlers';

export type { StructuredKindRouteResult };

const STRUCTURED_KINDS = [
  'check_boost',
  'catalog_maneuver',
  'catalog_metamagic',
  'convert_spell_points',
  'firearm_reload',
  'firearm_fire',
  'wild_resurgence',
  'set_starry_form',
  'strike_self_cost',
  'set_tracker',
  'missile_mage_arm',
  'resource_fallback_spend',
  'moon_combat_wild_shape',
  'restore_resource_from_slot',
  'bind_pact_weapon',
  'psychic_blade_attack',
] as const;

export function findStructuredEffect(
  applicable: CatalogEffect[],
): CatalogEffect | undefined {
  return applicable.find((e) =>
    (STRUCTURED_KINDS as readonly string[]).includes(e.kind),
  );
}

/**
 * Effect-kind-based structured routes.
 * Returns response or null to continue to generic effect loop.
 */
export async function tryStructuredKindRoute(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  action: ClassEconomyActionRecord,
  actionSlug: string,
  options: DeclaredEconomyTableActionOptions,
  structured: CatalogEffect,
  catalog: {
    featureSchedulesByClassSlug?: ReadonlyMap<string, readonly FeatureScheduleBand[]>;
    featureSchedulesBySubclassSlug?: ReadonlyMap<string, readonly FeatureScheduleBand[]>;
  },
): Promise<StructuredKindRouteResult> {
  return handleStructuredKind({
    deps,
    character,
    action,
    actionSlug,
    options,
    structured,
    catalog,
  });
}
