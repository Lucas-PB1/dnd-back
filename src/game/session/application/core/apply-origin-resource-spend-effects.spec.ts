import { applyOriginResourceSpendEffects } from './apply-origin-resource-spend-effects';
import { proficiencyBonusForLevel } from '@game/session/domain/proficiency-bonus-for-level';
import { asDep } from '@common/testing/as-dep';
import type { CatalogEffect } from '@game/effects';

function spendEffect(input: {
  kind: 'temp_hp' | 'heal';
  resourceSlug: string;
  amountFormula: NonNullable<CatalogEffect['numeric']>['amountFormula'];
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
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: input.resourceSlug,
    label: input.label,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: { amountFormula: input.amountFormula, flat: null },
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
  };
}

describe('applyOriginResourceSpendEffects', () => {
  const stateResponse = {
    classResources: [],
    tempHp: 0,
    hitPointsCurrent: 8,
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
