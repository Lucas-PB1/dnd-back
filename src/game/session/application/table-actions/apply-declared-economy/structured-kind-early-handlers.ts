import { BadRequestException } from '@nestjs/common';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyConvertSpellPointsTableAction } from '../kinds/caster/apply-convert-spell-points-table-action';
import { applyCatalogMetamagicTableAction } from '../kinds/caster/apply-catalog-metamagic-table-action';
import {
  applyGunslingerManeuverTableAction,
  applyReloadFirearmTableAction,
  applyFireChamberTableAction,
} from '../kinds/martial/apply-gunslinger-maneuver-table-action';
import { applyWildResurgenceTableAction } from '../kinds/form-state/apply-wild-resurgence-table-action';
import { applySetStarryFormTableAction } from '../kinds/form-state/apply-set-starry-form-table-action';
import type { CatalogEffect } from '@game/effects';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';
import type { StructuredKindRouteResult } from './structured-kind-handlers';
import { requireItemSlug } from './resolve-spend-plan';

export async function handleStructuredEarlyKind(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  actionSlug: string,
  options: DeclaredEconomyTableActionOptions,
  structured: CatalogEffect,
): Promise<StructuredKindRouteResult> {
  if (structured.kind === 'convert_spell_points') {
    return applyConvertSpellPointsTableAction({
      state: deps.state,
      character,
      actionSlug,
    });
  }

  if (structured.kind === 'catalog_metamagic') {
    if (!deps.dataSource) {
      throw new BadRequestException('Metamagia indisponível');
    }
    return applyCatalogMetamagicTableAction({
      state: deps.state,
      dataSource: deps.dataSource,
      character,
      metamagicSlug: options.metamagicSlug ?? '',
    });
  }

  if (structured.kind === 'firearm_reload') {
    const itemSlug = requireItemSlug(options.itemSlug);
    return applyReloadFirearmTableAction({
      state: deps.state,
      character,
      itemSlug,
    });
  }

  if (structured.kind === 'firearm_fire') {
    const itemSlug = requireItemSlug(options.itemSlug);
    return applyFireChamberTableAction({
      state: deps.state,
      character,
      itemSlug,
      shots: options.shots ?? 1,
    });
  }

  if (structured.kind === 'wild_resurgence') {
    return applyWildResurgenceTableAction({
      state: deps.state,
      character,
      actionSlug,
    });
  }

  if (structured.kind === 'set_starry_form') {
    return applySetStarryFormTableAction({
      state: deps.state,
      character,
      actionSlug,
    });
  }

  if (structured.kind === 'catalog_maneuver' && character.classSlug === 'gunslinger') {
    return applyGunslingerManeuverTableAction({
      state: deps.state,
      character,
      maneuverSlug: options.maneuverSlug ?? '',
    });
  }

  return null;
}
