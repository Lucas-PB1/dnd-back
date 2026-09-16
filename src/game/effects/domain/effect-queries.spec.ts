import type { CatalogEffect } from './catalog-effect';
import {
  filterEffectsByActionSlug,
  filterEffectsByResourceSpend,
  resolveFeatCastEconomyFromEffects,
  speedBonusMetersFromEffects,
} from './queries';
import { executeCatalogEffect } from './execute-catalog-effect';

function baseEffect(
  overrides: Partial<CatalogEffect> & Pick<CatalogEffect, 'kind' | 'trigger'>,
): CatalogEffect {
  return Object.assign(
    {
      id: '1',
      ownerKind: 'feat' as const,
      ownerId: '10',
      ownerSlug: 'magic-initiate',
      unlockLevel: 1,
      sortOrder: 0,
      minTraitTakes: 1,
      actionSlug: null,
      resourceSlug: null,
      label: null,
      requiresOptionKey: null,
      requiresOptionValue: null,
      spell: null,
      castEconomy: null,
      numeric: null,
      note: null,
      resource: null,
      combatMod: null,
      proficiency: null as CatalogEffect['proficiency'],
      purchaseDiscount: null as CatalogEffect['purchaseDiscount'],
      damageDie: null as CatalogEffect['damageDie'],
      weapon: null as CatalogEffect['weapon'],
      feat: null,
      saveAdvantage: null,
      sense: null,
      damageType: null,
      language: null,
      checkAdvantage: null,
      reach: null,
      restQuirk: null,
      environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
    combatFlag: null,
    companion: null,
    },
    overrides,
    {
      proficiency: overrides.proficiency ?? null,
      purchaseDiscount: overrides.purchaseDiscount ?? null,
      damageDie: overrides.damageDie ?? null,
    },
  );
}

describe('effect queries (cast / filters)', () => {
  it('resolves cast economy from grant_spell satellite', () => {
    const effects = [
      baseEffect({
        kind: 'grant_spell',
        trigger: 'on_build',
        spell: {
          spellId: null,
          spellSlug: null,
          optionKey: 'firstLevelSpell',
          spellLevel: 1,
        },
        castEconomy: {
          economy: 'once_per_long_rest',
          usesFormula: 'fixed',
          fixedUses: 1,
        },
      }),
    ];
    expect(
      resolveFeatCastEconomyFromEffects({
        effects,
        featSlug: 'magic-initiate',
        optionKey: 'firstLevelSpell',
      }),
    ).toBe('once_per_long_rest');
    expect(
      resolveFeatCastEconomyFromEffects({
        effects,
        featSlug: 'magic-initiate',
        optionKey: 'cantrip1',
      }),
    ).toBeNull();
  });

  it('filters by resource spend and action slug', () => {
    const effects = [
      baseEffect({
        kind: 'temp_hp',
        trigger: 'on_resource_spend',
        ownerKind: 'species',
        ownerSlug: 'orc',
        resourceSlug: 'adrenalineSurge',
        numeric: { amountFormula: 'proficiency_bonus', flat: null },
      }),
      baseEffect({
        id: '2',
        kind: 'temp_hp',
        trigger: 'on_table_action',
        actionSlug: 'brittle-bone-armor',
        numeric: { amountFormula: 'level_times_2', flat: null },
      }),
    ];
    expect(
      filterEffectsByResourceSpend(effects, 'adrenalineSurge'),
    ).toHaveLength(1);
    expect(filterEffectsByActionSlug(effects, 'brittle-bone-armor')).toHaveLength(
      1,
    );
  });
});

describe('executeCatalogEffect', () => {
  it('executes temp_hp and table_note', () => {
    const temp = executeCatalogEffect(
      baseEffect({
        kind: 'temp_hp',
        trigger: 'on_resource_spend',
        resourceSlug: 'adrenalineSurge',
        numeric: { amountFormula: 'proficiency_bonus', flat: null },
        note: { note: 'PB temp' },
      }),
      { level: 5 },
    );
    expect(temp).toMatchObject({ kind: 'temp_hp', amount: 3, note: 'PB temp' });

    const note = executeCatalogEffect(
      baseEffect({
        kind: 'table_note',
        trigger: 'on_table_action',
        actionSlug: 'foo',
        note: { note: 'Declare' },
      }),
      { level: 1 },
    );
    expect(note).toEqual({ kind: 'table_note', note: 'Declare' });
  });

  it('soma dados extras de upcast em heal com dice', () => {
    const result = executeCatalogEffect(
      baseEffect({
        kind: 'heal',
        trigger: 'on_cast',
        dice: {
          die: '2d8',
          dieAtLevel: null,
          atLevel: null,
          damageTypeSlug: null,
        },
        numeric: { amountFormula: 'ability_mod', flat: null },
      }),
      { level: 5, diceCount: 2, flatOverride: 3, rng: () => 0.999 },
    );
    expect(result).toMatchObject({
      kind: 'heal',
      amount: 35,
      expression: '4d8+3',
    });
  });

  it('executes survive_at_zero as 1 HP without numeric', () => {
    const result = executeCatalogEffect(
      baseEffect({
        kind: 'survive_at_zero',
        trigger: 'on_resource_spend',
        resourceSlug: 'relentlessEndurance',
        note: { note: '1 PV' },
      }),
      { level: 5 },
    );
    expect(result).toEqual({
      kind: 'survive_at_zero',
      amount: 1,
      note: '1 PV',
    });
  });

  it('executes survive_at_zero as 1 plus half hit point max', () => {
    const result = executeCatalogEffect(
      baseEffect({
        kind: 'survive_at_zero',
        trigger: 'on_table_action',
        actionSlug: 'feat-boon-recovery-death',
        numeric: { amountFormula: 'one_plus_half_hp_max', flat: null },
        note: { note: 'Até a Morte.' },
      }),
      { level: 20, hitPointMax: 40 },
    );
    expect(result).toMatchObject({
      kind: 'survive_at_zero',
      amount: 21,
    });
  });

  it('executes apply_condition and clear_condition', () => {
    const applied = executeCatalogEffect(
      baseEffect({
        kind: 'apply_condition',
        trigger: 'on_table_action',
        actionSlug: 'natures-veil',
        condition: { conditionSlug: 'invisible', pendingKind: null },
        note: { note: 'Invisível.' },
      }),
      { level: 14 },
    );
    expect(applied).toEqual({
      kind: 'apply_condition',
      conditionSlug: 'invisible',
      note: 'Invisível.',
    });

    const cleared = executeCatalogEffect(
      baseEffect({
        kind: 'clear_condition',
        trigger: 'on_table_action',
        actionSlug: 'cure-poison',
        condition: { conditionSlug: 'poisoned', pendingKind: null },
        note: { note: 'Encerrar Envenenado.' },
      }),
      { level: 1 },
    );
    expect(cleared).toEqual({
      kind: 'clear_condition',
      conditionSlug: 'poisoned',
      note: 'Encerrar Envenenado.',
    });
  });

  it('executes grant_inspiration', () => {
    const result = executeCatalogEffect(
      baseEffect({
        kind: 'grant_inspiration',
        trigger: 'on_table_action',
        actionSlug: 'musician-song',
        note: { note: 'Canção' },
      }),
      { level: 3 },
    );
    expect(result).toEqual({ kind: 'grant_inspiration', note: 'Canção' });
  });

  it('executes recover_resource', () => {
    const result = executeCatalogEffect(
      baseEffect({
        kind: 'recover_resource',
        trigger: 'on_table_action',
        actionSlug: 'restore-intimidating-presence',
        resourceSlug: 'intimidating-presence',
        numeric: { amountFormula: 'fixed', flat: 1 },
        note: { note: 'Restaurou' },
      }),
      { level: 14 },
    );
    expect(result).toEqual({
      kind: 'recover_resource',
      resourceSlug: 'intimidating-presence',
      amount: 1,
      note: 'Restaurou',
    });
  });
});

describe('speedBonusMetersFromEffects', () => {
  it('converts fixed ft speed_bonus to meters (10 ft → 3 m)', () => {
    const effects = [
      baseEffect({
        kind: 'speed_bonus',
        trigger: 'passive',
        ownerSlug: 'speedy',
        numeric: { amountFormula: 'fixed', flat: 10 },
      }),
    ];
    expect(speedBonusMetersFromEffects(effects, ['speedy'])).toBe(3);
    expect(speedBonusMetersFromEffects(effects, ['other'])).toBe(0);
  });
});
