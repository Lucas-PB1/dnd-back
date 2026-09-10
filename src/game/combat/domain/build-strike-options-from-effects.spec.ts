import type { CatalogEffect } from '@game/effects/domain/catalog-effect';
import { BLOOD_HOUND_STRIKE_OPTIONS } from './__fixtures__/mechanical-catalog/strike-options.fixtures';
import {
  STRIKE_OPTION_REQUIRES_KEY,
  buildStrikeOptionsFromEffects,
} from './build-strike-options-from-effects';
import { findStrikeOption } from './strike-option';

function base(
  overrides: Partial<CatalogEffect> &
    Pick<CatalogEffect, 'kind' | 'trigger' | 'requiresOptionValue'>,
): CatalogEffect {
  return {
    id: overrides.id ?? '1',
    kind: overrides.kind,
    ownerKind: 'subclass',
    ownerId: '99',
    ownerSlug: 'blood-hound',
    trigger: overrides.trigger,
    unlockLevel: 3,
    sortOrder: overrides.sortOrder ?? 0,
    minTraitTakes: 1,
    actionSlug: overrides.actionSlug ?? null,
    resourceSlug: overrides.resourceSlug ?? null,
    label: overrides.label ?? null,
    requiresOptionKey: STRIKE_OPTION_REQUIRES_KEY,
    requiresOptionValue: overrides.requiresOptionValue,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: overrides.note ?? null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: overrides.condition ?? null,
    save: overrides.save ?? null,
    forcedMovement: null,
    dice: overrides.dice ?? null,
  };
}

const LABELS = new Map(
  BLOOD_HOUND_STRIKE_OPTIONS.map((row) => [row.slug, row.name]),
);

/** Pacote mínimo espelhando seed para 4 golpes representativos. */
function sampleEffects(): CatalogEffect[] {
  return [
    // hunting
    base({
      id: 'h1',
      kind: 'self_damage',
      trigger: 'on_option_use',
      requiresOptionValue: 'hunting-strike',
      label: 'Golpe da Caça',
      resourceSlug: 'blood-strike',
      actionSlug: 'blood-strike',
      sortOrder: 10,
      dice: {
        die: '1d4',
        dieAtLevel: null,
        atLevel: null,
        damageTypeSlug: 'slashing',
      },
    }),
    base({
      id: 'h2',
      kind: 'extra_damage_dice',
      trigger: 'on_hit',
      requiresOptionValue: 'hunting-strike',
      label: 'Golpe da Caça',
      sortOrder: 20,
      dice: {
        die: '1d6',
        dieAtLevel: '3d6',
        atLevel: 18,
        damageTypeSlug: 'slashing',
      },
    }),
    base({
      id: 'h3',
      kind: 'ignore_target_armor',
      trigger: 'on_hit',
      requiresOptionValue: 'hunting-strike',
      label: 'Golpe da Caça',
      sortOrder: 30,
    }),
    // bloodshard
    base({
      id: 'b1',
      kind: 'self_damage',
      trigger: 'on_option_use',
      requiresOptionValue: 'bloodshard-strike',
      label: 'Golpe Estilhaço-Sangue',
      resourceSlug: 'blood-strike',
      actionSlug: 'blood-strike',
      sortOrder: 10,
      dice: {
        die: '1d8',
        dieAtLevel: null,
        atLevel: null,
        damageTypeSlug: 'piercing',
      },
    }),
    base({
      id: 'b2',
      kind: 'replace_attack_with_save',
      trigger: 'on_hit',
      requiresOptionValue: 'bloodshard-strike',
      label: 'Golpe Estilhaço-Sangue',
      sortOrder: 15,
    }),
    base({
      id: 'b3',
      kind: 'extra_damage_dice',
      trigger: 'on_hit',
      requiresOptionValue: 'bloodshard-strike',
      label: 'secondary',
      sortOrder: 21,
      dice: {
        die: '1d6',
        dieAtLevel: '3d6',
        atLevel: 18,
        damageTypeSlug: 'piercing',
      },
    }),
    // exiling
    base({
      id: 'e1',
      kind: 'self_damage',
      trigger: 'on_option_use',
      requiresOptionValue: 'exiling-strike',
      label: 'Golpe do Exílio',
      resourceSlug: 'blood-strike',
      actionSlug: 'blood-strike',
      sortOrder: 10,
      dice: {
        die: '1d10',
        dieAtLevel: null,
        atLevel: null,
        damageTypeSlug: 'radiant',
      },
    }),
    base({
      id: 'e2',
      kind: 'extra_damage_dice',
      trigger: 'on_hit',
      requiresOptionValue: 'exiling-strike',
      label: 'Golpe do Exílio',
      sortOrder: 20,
      dice: {
        die: '2d6',
        dieAtLevel: null,
        atLevel: 18,
        damageTypeSlug: 'radiant',
      },
    }),
    base({
      id: 'e3',
      kind: 'feature_save',
      trigger: 'on_hit',
      requiresOptionValue: 'exiling-strike',
      label: 'Golpe do Exílio',
      sortOrder: 30,
      save: {
        saveAbility: 'charisma',
        dcAbility: null,
        dcFormula: 'eight_plus_mod_plus_pb',
      },
    }),
    base({
      id: 'e4',
      kind: 'apply_condition',
      trigger: 'on_save_fail',
      requiresOptionValue: 'exiling-strike',
      label: 'Golpe do Exílio',
      sortOrder: 40,
      condition: {
        conditionSlug: 'incapacitated',
        pendingKind: 'blood-exile',
      },
    }),
    // bewitching
    base({
      id: 'w1',
      kind: 'self_damage',
      trigger: 'on_option_use',
      requiresOptionValue: 'bewitching-strike',
      label: 'Golpe Enfeitiçante',
      resourceSlug: 'blood-strike',
      actionSlug: 'blood-strike',
      sortOrder: 10,
      dice: {
        die: '1d8',
        dieAtLevel: null,
        atLevel: null,
        damageTypeSlug: 'psychic',
      },
    }),
    base({
      id: 'w2',
      kind: 'extra_damage_dice',
      trigger: 'on_hit',
      requiresOptionValue: 'bewitching-strike',
      label: 'Golpe Enfeitiçante',
      sortOrder: 20,
      dice: {
        die: '2d6',
        dieAtLevel: '4d6',
        atLevel: 18,
        damageTypeSlug: 'psychic',
      },
    }),
    base({
      id: 'w3',
      kind: 'feature_save',
      trigger: 'on_hit',
      requiresOptionValue: 'bewitching-strike',
      label: 'Golpe Enfeitiçante',
      sortOrder: 30,
      save: {
        saveAbility: 'wisdom',
        dcAbility: null,
        dcFormula: 'eight_plus_mod_plus_pb',
      },
    }),
    base({
      id: 'w4',
      kind: 'combat_note',
      trigger: 'on_hit',
      requiresOptionValue: 'bewitching-strike',
      label: 'Golpe Enfeitiçante',
      sortOrder: 40,
      note: { note: 'Efeito narrativo / mesa (note_only).' },
    }),
  ];
}

describe('buildStrikeOptionsFromEffects', () => {
  it('reconstrói StrikeOption a partir de pacotes de effect', () => {
    const built = buildStrikeOptionsFromEffects({
      effects: sampleEffects(),
      optionLabels: LABELS,
    });

    expect(findStrikeOption(built, 'hunting-strike')).toEqual(
      findStrikeOption(BLOOD_HOUND_STRIKE_OPTIONS, 'hunting-strike'),
    );
    expect(findStrikeOption(built, 'bloodshard-strike')).toEqual(
      findStrikeOption(BLOOD_HOUND_STRIKE_OPTIONS, 'bloodshard-strike'),
    );
    expect(findStrikeOption(built, 'exiling-strike')).toEqual(
      findStrikeOption(BLOOD_HOUND_STRIKE_OPTIONS, 'exiling-strike'),
    );
    expect(findStrikeOption(built, 'bewitching-strike')).toEqual(
      findStrikeOption(BLOOD_HOUND_STRIKE_OPTIONS, 'bewitching-strike'),
    );
  });
});
