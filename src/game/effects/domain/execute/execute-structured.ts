import type { CatalogEffect } from '../catalog-effect';
import type { EffectExecution, ExecuteCatalogEffectContext } from './types';

export function executeStructuredEffect(
  effect: CatalogEffect,
  _context: ExecuteCatalogEffectContext,
): EffectExecution | null {
  if (effect.kind === 'grant_inspiration') {
    return {
      kind: 'grant_inspiration',
      note:
        effect.note?.note?.trim() ||
        effect.label ||
        'Inspiração concedida (declare aliados na mesa).',
    };
  }

  if (effect.kind === 'check_boost') {
    return {
      kind: 'check_boost',
      resourceSlug: effect.resourceSlug ?? '',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'catalog_maneuver' || effect.kind === 'catalog_metamagic') {
    return {
      kind: effect.kind,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'strike_self_cost') {
    return {
      kind: 'strike_self_cost',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'set_tracker') {
    return {
      kind: 'set_tracker',
      note: effect.note?.note ?? null,
    };
  }

  if (
    effect.kind === 'missile_mage_arm' ||
    effect.kind === 'resource_fallback_spend' ||
    effect.kind === 'moon_combat_wild_shape' ||
    effect.kind === 'restore_resource_from_slot' ||
    effect.kind === 'bind_pact_weapon' ||
    effect.kind === 'psychic_blade_attack' ||
    effect.kind === 'convert_spell_points' ||
    effect.kind === 'firearm_reload' ||
    effect.kind === 'firearm_fire' ||
    effect.kind === 'wild_resurgence' ||
    effect.kind === 'set_starry_form'
  ) {
    return {
      kind: effect.kind,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'start_concentration') {
    return {
      kind: 'start_concentration',
      spellSlug: effect.spell?.spellSlug ?? '',
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'toggle_combat_flag') {
    const flag = effect.combatFlag?.flag ?? 'rage';
    return {
      kind: 'toggle_combat_flag',
      flag,
      spendOnEnter: effect.combatFlag?.spendOnEnter ?? true,
      forceEnter: effect.combatFlag?.forceEnter ?? false,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'sync_companion') {
    return {
      kind: 'sync_companion',
      restoreHp: effect.companion?.restoreHp ?? false,
      note: effect.note?.note ?? null,
    };
  }

  if (effect.kind === 'companion_command') {
    return {
      kind: 'companion_command',
      note: effect.note?.note ?? null,
    };
  }

  return null;
}
