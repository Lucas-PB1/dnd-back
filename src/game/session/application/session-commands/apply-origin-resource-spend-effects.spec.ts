import { applyOriginResourceSpendEffects } from './apply-origin-resource-spend-effects';
import { proficiencyBonusForLevel } from '@game/session/domain/proficiency-bonus-for-level';
import { asDep } from '@common/testing/as-dep';
import type { CatalogEffect } from '@game/effects';

function spendEffect(input: {
  kind: 'temp_hp' | 'heal' | 'survive_at_zero';
  resourceSlug: string;
  amountFormula?: NonNullable<CatalogEffect['numeric']>['amountFormula'];
  flat?: number | null;
  minTraitTakes?: number;
  note: string;
  label: string;
}): CatalogEffect {
  return {
    id: input.resourceSlug,
    kind: input.kind,
    ownerKind: 'species',
    ownerId: '1',
    ownerSlug: 'test',
    trigger: 'on_resource_spend',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: input.minTraitTakes ?? 1,
    actionSlug: null,
    resourceSlug: input.resourceSlug,
    label: input.label,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: input.amountFormula
      ? { amountFormula: input.amountFormula, flat: input.flat ?? null }
      : null,
    note: { note: input.note },
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
    combatFlag: null,
    companion: null,
  };
}

describe('applyOriginResourceSpendEffects', () => {
  const stateResponse = {
    classResources: [],
    tempHp: 0,
    hitPointsCurrent: 8,
    conditions: [] as string[],
  };
  const state = {
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
    applyCurrentHitPoints: jest.fn().mockImplementation(async (_c, hp) => ({
      ...stateResponse,
      hitPointsCurrent: hp,
    })),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('computes proficiency by level band', () => {
    expect(proficiencyBonusForLevel(1)).toBe(2);
    expect(proficiencyBonusForLevel(5)).toBe(3);
    expect(proficiencyBonusForLevel(15)).toBe(5);
  });

  it('applies 2× PB temp HP for werekin shift aspect', async () => {
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({ id: 'pc-1', speciesSlug: 'werekin', level: 5 }),
      resourceSlug: 'werekin-shift-aspect',
      currentState: asDep(stateResponse),
      effects: [
        spendEffect({
          kind: 'temp_hp',
          resourceSlug: 'werekin-shift-aspect',
          amountFormula: 'proficiency_bonus_times_2',
          label: 'Mudar Aspecto — Força Bestial',
          note: 'Mudar Aspecto — Força Bestial: PV temp. (2× PB).',
        }),
      ],
    });
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 6 },
    );
    expect(result.note).toMatch(/Força Bestial/);
    expect(result.state.tempHp).toBe(6);
  });

  it('applies PB temp HP for orc adrenaline surge', async () => {
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({ id: 'pc-1', speciesSlug: 'orc', level: 5 }),
      resourceSlug: 'adrenalineSurge',
      currentState: asDep(stateResponse),
      effects: [
        spendEffect({
          kind: 'temp_hp',
          resourceSlug: 'adrenalineSurge',
          amountFormula: 'proficiency_bonus',
          label: 'Pico de Adrenalina',
          note: 'Pico de Adrenalina: PV temp. (PB) aplicados na ficha.',
        }),
      ],
    });
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 3 },
    );
    expect(result.note).toMatch(/Pico de Adrenalina/);
  });

  it('rolls PB d6 temp HP for focused edge', async () => {
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({ id: 'pc-1', speciesSlug: 'human', level: 5 }),
      resourceSlug: 'gh-focused-edge',
      currentState: asDep(stateResponse),
      rng: () => 0,
      effects: [
        spendEffect({
          kind: 'temp_hp',
          resourceSlug: 'gh-focused-edge',
          amountFormula: 'dice_pb_d6',
          label: 'Fio Concentrado',
          note: 'Fio Concentrado: PV temp. (PBd6) aplicados na ficha.',
        }),
      ],
    });
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 3 },
    );
    expect(result.roll).toEqual({
      resourceSlug: 'gh-focused-edge',
      faces: 6,
      value: 3,
      expression: '3d6',
    });
    expect(result.note).toMatch(/Fio Concentrado/);
  });

  it('applies PB d4 temp HP for stalwart edge', async () => {
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({ id: 'pc-1', speciesSlug: 'human', level: 5 }),
      resourceSlug: 'gh-stalwart-edge',
      currentState: asDep(stateResponse),
      rng: () => 0,
      effects: [
        spendEffect({
          kind: 'temp_hp',
          resourceSlug: 'gh-stalwart-edge',
          amountFormula: 'dice_pb_d4',
          label: 'Fio Inabalável',
          note: 'Fio Inabalável: PV temp. (PBd4) aplicados na ficha.',
        }),
      ],
    });
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 3 },
    );
    expect(result.roll).toEqual({
      resourceSlug: 'gh-stalwart-edge',
      faces: 4,
      value: 3,
      expression: '3d4',
    });
    expect(result.note).toMatch(/Fio Inabalável/);
  });

  it('rolls PB d4 heal for aasimar healing hands', async () => {
    const character = {
      id: 'pc-1',
      speciesSlug: 'aasimar',
      level: 1,
      hitPointsCurrent: 8,
      hitPointsMax: 20,
    };
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep(character),
      resourceSlug: 'healingHands',
      currentState: asDep(stateResponse),
      rng: () => 0,
      effects: [
        spendEffect({
          kind: 'heal',
          resourceSlug: 'healingHands',
          amountFormula: 'dice_pb_d4',
          label: 'Mãos Curativas',
          note: 'Mãos Curativas: PV curados (PBd4).',
        }),
      ],
    });
    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      10,
    );
    expect(result.roll?.expression).toBe('2d4');
    expect(result.note).toMatch(/Mãos Curativas/);
  });

  it('applies PB temp HP for enduring wyrd', async () => {
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({ id: 'pc-1', speciesSlug: 'human', level: 9 }),
      resourceSlug: 'enduring-wyrd',
      currentState: asDep(stateResponse),
      effects: [
        spendEffect({
          kind: 'temp_hp',
          resourceSlug: 'enduring-wyrd',
          amountFormula: 'proficiency_bonus',
          label: 'Wyrd Duradouro',
          note: 'Wyrd Duradouro: PV temp. (PB) aplicados na ficha.',
        }),
      ],
    });
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 4 },
    );
    expect(result.note).toMatch(/Wyrd Duradouro/);
  });

  it('sets 1 HP and clears death saves for orc relentless endurance', async () => {
    const currentState = {
      ...stateResponse,
      hitPointsCurrent: 0,
      conditions: ['unconscious'],
    };
    state.applyCurrentHitPoints.mockImplementation(async (_c, hp) => ({
      ...currentState,
      hitPointsCurrent: hp,
    }));

    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({
        id: 'pc-1',
        speciesSlug: 'orc',
        level: 5,
        hitPointsCurrent: 0,
        hitPointsMax: 40,
      }),
      resourceSlug: 'relentlessEndurance',
      currentState: asDep(currentState),
      effects: [
        spendEffect({
          kind: 'survive_at_zero',
          resourceSlug: 'relentlessEndurance',
          amountFormula: 'fixed',
          flat: 1,
          label: 'Vigor Implacável',
          note: 'Ao cair a 0 PV (sem morte imediata): fica com 1 PV (gasta 1 uso).',
        }),
      ],
    });

    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      {
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        conditions: [],
      },
    );
    expect(result.note).toMatch(/1 PV/);
  });

  it('sets 1 HP for unparalleled endurance at 1 take', async () => {
    const currentState = {
      ...stateResponse,
      hitPointsCurrent: 0,
      conditions: ['unconscious'],
    };
    state.applyCurrentHitPoints.mockImplementation(async (_c, hp) => ({
      ...currentState,
      hitPointsCurrent: hp,
    }));

    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({
        id: 'pc-1',
        heritageSlug: 'orc',
        level: 5,
        hitPointsCurrent: 0,
        hitPointsMax: 40,
      }),
      resourceSlug: 'gh-unparalleled-endurance',
      currentState: asDep(currentState),
      traitTakes: 1,
      effects: [
        spendEffect({
          kind: 'survive_at_zero',
          resourceSlug: 'gh-unparalleled-endurance',
          amountFormula: 'fixed',
          flat: 1,
          minTraitTakes: 1,
          label: 'Resistência Incomparável',
          note: 'Ao cair a 0 PV: fica com 1 PV (gasta 1 uso).',
        }),
        spendEffect({
          kind: 'survive_at_zero',
          resourceSlug: 'gh-unparalleled-endurance',
          amountFormula: 'dice_1d6_plus_pb',
          minTraitTakes: 2,
          label: 'Resistência Incomparável',
          note: 'Ao cair a 0 PV: 1d6 + PB PV.',
        }),
      ],
    });

    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      1,
    );
    expect(result.note).toMatch(/1 PV/);
  });

  it('rolls 1d6+PB HP for unparalleled endurance at 2 takes', async () => {
    const currentState = {
      ...stateResponse,
      hitPointsCurrent: 0,
      conditions: ['unconscious'],
    };
    state.applyCurrentHitPoints.mockImplementation(async (_c, hp) => ({
      ...currentState,
      hitPointsCurrent: hp,
    }));

    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({
        id: 'pc-1',
        heritageSlug: 'orc',
        level: 5,
        hitPointsCurrent: 0,
        hitPointsMax: 40,
      }),
      resourceSlug: 'gh-unparalleled-endurance',
      currentState: asDep(currentState),
      traitTakes: 2,
      rng: () => 0,
      effects: [
        spendEffect({
          kind: 'survive_at_zero',
          resourceSlug: 'gh-unparalleled-endurance',
          amountFormula: 'fixed',
          flat: 1,
          minTraitTakes: 1,
          label: 'Resistência Incomparável',
          note: 'Ao cair a 0 PV: fica com 1 PV (gasta 1 uso).',
        }),
        spendEffect({
          kind: 'survive_at_zero',
          resourceSlug: 'gh-unparalleled-endurance',
          amountFormula: 'dice_1d6_plus_pb',
          minTraitTakes: 2,
          label: 'Resistência Incomparável',
          note: 'Ao cair a 0 PV: {total} PV (1d6 + PB).',
        }),
      ],
    });

    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      4,
    );
    expect(result.roll).toEqual({
      resourceSlug: 'gh-unparalleled-endurance',
      faces: 6,
      value: 4,
      expression: '1d6+3',
    });
  });

  it('ignores other resources', async () => {
    const result = await applyOriginResourceSpendEffects({
      state: asDep(state),
      character: asDep({
        id: 'pc-1',
        speciesSlug: 'werekin',
        level: 5,
      }),
      resourceSlug: 'bearfolk-apex-predator',
      currentState: asDep(stateResponse),
      effects: [],
    });
    expect(state.patch).not.toHaveBeenCalled();
    expect(state.applyCurrentHitPoints).not.toHaveBeenCalled();
    expect(result.note).toBeNull();
  });
});
