import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { FeatureScheduleBand } from '@game/combat/domain/feature-schedule';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import { psiEnergyDieFaces } from '@game/combat/domain/fighter';
import { applyCheckBoostTableAction } from '../kinds/martial/apply-check-boost-table-action';
import { applyCatalogManeuverTableAction } from '../kinds/martial/apply-catalog-maneuver-table-action';
import { applyStrikeSelfCostTableAction } from '../kinds/martial/apply-strike-self-cost-table-action';
import { applySetBestialAspectTableAction } from '../kinds/form-state/apply-set-bestial-aspect-table-action';
import { applySetPersonaMasksTableAction } from '../kinds/form-state/apply-set-persona-masks-table-action';
import {
  applyMissileMageArmTableAction,
  parseMissileMageArmAction,
} from '../kinds/caster/apply-missile-mage-arm-table-action';
import {
  applyInnateSorceryTableAction,
  applyDragonWingsTableAction,
} from '../kinds/caster/apply-sorcerer-fallback-table-action';
import {
  applyMoonCombatWildShapeTableAction,
  applyRestoreLunarStepTableAction,
} from '../kinds/form-state/apply-wild-resurgence-table-action';
import { applyInvokePactWeaponTableAction } from '../kinds/caster/apply-invoke-pact-weapon-table-action';
import { applyPsychicBladeTableAction } from '../kinds/attack/apply-psychic-blade-table-action';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';
import type { StructuredKindRouteResult } from './structured-kind-handlers';

export async function handleStructuredCatalogKind(
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
  if (structured.kind === 'check_boost') {
    if (
      (actionSlug === 'psi-bolstered-knack' || actionSlug === 'guided-strike') &&
      (options.checkTotal == null || options.dc == null)
    ) {
      throw new BadRequestException(
        `${action.name} requires checkTotal and dc`,
      );
    }
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
    const psiFaces = psiEnergyDieFaces(character.level, bands) ?? undefined;
    return applyCheckBoostTableAction({
      state: deps.state,
      character,
      resourceSlug: structured.resourceSlug || action.resourceSlug || '',
      actionName: action.name,
      checkTotal: options.checkTotal,
      dc: options.dc,
      note: structured.note?.note,
      dieFaces: psiFaces,
    });
  }

  if (structured.kind === 'catalog_maneuver') {
    if (!deps.sheet || !deps.getProficiencyBonus) {
      throw new BadRequestException('Catálogo de manobra indisponível');
    }
    return applyCatalogManeuverTableAction({
      state: deps.state,
      sheet: deps.sheet,
      mechanicalCatalog: deps.mechanicalCatalog,
      character,
      maneuverSlug: options.maneuverSlug ?? '',
      useRelentless: options.useRelentless,
      proficiencyBonus: await deps.getProficiencyBonus(character.level),
    });
  }

  if (structured.kind === 'strike_self_cost') {
    if (!deps.sheet) {
      throw new BadRequestException('Ficha indisponível para Golpe de Sangue');
    }
    return applyStrikeSelfCostTableAction({
      state: deps.state,
      sheet: deps.sheet,
      mechanicalCatalog: deps.mechanicalCatalog,
      character,
      optionSlug: options.optionSlug ?? '',
      takeLowerBloodCost: options.takeLowerBloodCost,
    });
  }

  if (structured.kind === 'set_tracker') {
    if (actionSlug === 'set-bestial-aspect') {
      return applySetBestialAspectTableAction({
        state: deps.state,
        mechanicalCatalog: deps.mechanicalCatalog,
        character,
        actionName: action.name,
        level: options.level,
      });
    }
    return applySetPersonaMasksTableAction({
      state: deps.state,
      mechanicalCatalog: deps.mechanicalCatalog,
      character,
      actionName: action.name,
      masks: options.masks ?? [],
    });
  }

  if (structured.kind === 'missile_mage_arm') {
    const missileArm = parseMissileMageArmAction(actionSlug);
    if (!missileArm) {
      throw new BadRequestException(
        `Ação de mísseis desconhecida: ${actionSlug}`,
      );
    }
    return applyMissileMageArmTableAction({
      state: deps.state,
      character,
      ...missileArm,
    });
  }

  if (structured.kind === 'resource_fallback_spend') {
    if (actionSlug === 'innate-sorcery') {
      return applyInnateSorceryTableAction({
        state: deps.state,
        character,
      });
    }
    if (actionSlug === 'dragon-wings') {
      return applyDragonWingsTableAction({
        state: deps.state,
        character,
      });
    }
    throw new BadRequestException(
      `Fallback de recurso desconhecido: ${actionSlug}`,
    );
  }

  if (structured.kind === 'moon_combat_wild_shape') {
    return applyMoonCombatWildShapeTableAction({
      state: deps.state,
      character,
    });
  }

  if (structured.kind === 'restore_resource_from_slot') {
    return applyRestoreLunarStepTableAction({
      state: deps.state,
      character,
      slotLevel: options.slotLevel,
    });
  }

  if (structured.kind === 'bind_pact_weapon') {
    if (!deps.inventory || !deps.assertCanBindPact) {
      throw new BadRequestException('Inventário indisponível para Arma de Pacto');
    }
    return applyInvokePactWeaponTableAction({
      state: deps.state,
      inventory: deps.inventory,
      assertCanBindPact: deps.assertCanBindPact,
      character,
      itemSlug: options.itemSlug,
    });
  }

  if (structured.kind === 'psychic_blade_attack') {
    if (!deps.getProficiencyBonus) {
      throw new BadRequestException(
        'Proficiência indisponível para Lâmina Psíquica',
      );
    }
    return applyPsychicBladeTableAction({
      state: deps.state,
      character,
      getProficiencyBonus: deps.getProficiencyBonus,
      bonusAttack: actionSlug === 'psychic-blade-bonus',
    });
  }

  return null;
}
