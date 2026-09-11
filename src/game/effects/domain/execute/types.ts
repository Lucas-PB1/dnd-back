import type { Rng } from '@game/dice/domain/dice';
import type { EffectKind } from '../catalog-effect';

export type EffectExecution =
  | {
      kind: 'temp_hp' | 'heal';
      amount: number;
      note: string | null;
      expression?: string;
      faces?: number;
    }
  | {
      kind: 'spend_resource' | 'recover_resource';
      resourceSlug: string;
      amount: number;
      note: string | null;
    }
  | {
      kind: 'recover_resource_to_max';
      resourceSlug: string;
      note: string | null;
    }
  | {
      kind: 'toggle_combat_flag';
      flag: 'rage' | 'reckless';
      spendOnEnter: boolean;
      forceEnter: boolean;
      note: string | null;
    }
  | {
      kind: 'sync_companion';
      restoreHp: boolean;
      note: string | null;
    }
  | {
      kind: 'companion_command';
      note: string | null;
    }
  | {
      kind: 'table_roll';
      amount: number;
      expression: string;
      note: string | null;
    }
  | {
      kind: 'feature_dc';
      saveDc: number;
      note: string | null;
    }
  | {
      kind: 'heal_from_dice_pool';
      resourceSlug: string;
      diceCount: number;
      die: string;
      amount: number;
      expression: string;
      note: string | null;
    }
  | {
      kind: 'table_note';
      note: string;
      amount?: number;
      expression?: string;
    }
  | {
      kind: 'grant_inspiration';
      note: string | null;
    }
  | {
      kind: 'check_boost';
      resourceSlug: string;
      note: string | null;
    }
  | {
      kind: 'catalog_maneuver';
      note: string | null;
    }
  | {
      kind: 'catalog_metamagic';
      note: string | null;
    }
  | {
      kind: 'convert_spell_points';
      note: string | null;
    }
  | {
      kind: 'firearm_reload';
      note: string | null;
    }
  | {
      kind: 'firearm_fire';
      note: string | null;
    }
  | {
      kind: 'wild_resurgence';
      note: string | null;
    }
  | {
      kind: 'set_starry_form';
      note: string | null;
    }
  | {
      kind: 'strike_self_cost';
      note: string | null;
    }
  | {
      kind: 'set_tracker';
      note: string | null;
    }
  | {
      kind: 'missile_mage_arm';
      note: string | null;
    }
  | {
      kind: 'resource_fallback_spend';
      note: string | null;
    }
  | {
      kind: 'moon_combat_wild_shape';
      note: string | null;
    }
  | {
      kind: 'restore_resource_from_slot';
      note: string | null;
    }
  | {
      kind: 'bind_pact_weapon';
      note: string | null;
    }
  | {
      kind: 'psychic_blade_attack';
      note: string | null;
    }
  | {
      kind: 'start_concentration';
      spellSlug: string;
      note: string | null;
    }
  | {
      kind: 'survive_at_zero';
      amount: number;
      note: string | null;
    }
  | {
      kind: 'recover_spell_slot';
      slotLevel: number;
      count: number;
      note: string | null;
    }
  | {
      kind: 'unsupported';
      effectKind: EffectKind;
    };

export type ExecuteCatalogEffectContext = {
  level: number;
  rng?: Rng;
  hitDieFaces?: number;
  scheduleDieFaces?: number;
  flatOverride?: number;
  rageBonus?: number;
  rageActive?: boolean;
  /** Contagem de dados (Campeão dos Deuses / Luz Medicinal). */
  diceCount?: number;
  pactSlotLevel?: number;
  pactSlotsRecoveryCount?: number;
};
