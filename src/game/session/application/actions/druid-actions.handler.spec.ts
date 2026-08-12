import { BadRequestException } from '@nestjs/common';
import { DruidActionsHandler } from './druid-actions.handler';

describe('DruidActionsHandler', () => {
  const stateResponse = {
    classResources: [],
    starryFormActive: false,
    stellarConstellation: null,
  };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    setStarryForm: jest.fn().mockImplementation(async (_character, input) => ({
      ...stateResponse,
      starryFormActive: input.active,
      stellarConstellation: input.constellation ?? null,
    })),
    patch: jest.fn().mockImplementation(async (_character, patch) => ({
      ...stateResponse,
      ...patch,
    })),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new DruidActionsHandler(
    access as never,
    state as never,
    domain as never,
  );
  const druid = {
    id: 'druid-1',
    classSlug: 'druid',
    subclassSlug: 'stars',
    level: 5,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 18,
      carisma: 10,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(druid);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('spends 1 Wild Shape use for base Wild Shape', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-shape',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(result.note).toContain('Forma Selvagem');
  });

  it('converts 1 Wild Shape use into 1st level spell slot', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-resurgence-slot',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      1,
    );
    expect(result.note).toContain('Ressurgimento Selvagem');
  });

  it('resolves Starry Form Archer for Circle of Stars', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'starry-form-archer',
    });

    expect(result.expression).toBe('1d8+4');
    expect(result.note).toContain('Forma Estelar (Arqueiro)');
    expect(state.setStarryForm).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { active: true, constellation: 'archer' },
    );
    expect(result.state).toEqual(
      expect.objectContaining({
        starryFormActive: true,
        stellarConstellation: 'archer',
      }),
    );
  });

  it('re-uses Starry Form Archer without spending Wild Shape again', async () => {
    state.buildResponse.mockResolvedValueOnce({
      ...stateResponse,
      starryFormActive: true,
      stellarConstellation: 'archer',
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'starry-form-archer',
    });

    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(result.note).toContain('ainda ativa');
  });

  it('resolves Moon Combat Wild Shape for Circle of the Moon', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...druid,
      subclassSlug: 'moon',
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'moon-combat-wild-shape',
    });

    expect(result.total).toBe(15);
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { tempHp: 15 },
    );
    expect(result.state).toEqual(expect.objectContaining({ tempHp: 15 }));
    expect(result.note).toContain('Forma Selvagem de Combate');
  });

  it('resolves Land Aid for Circle of the Land', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...druid,
      subclassSlug: 'land',
      level: 3,
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'land-aid',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(result.note).toContain('Auxílio da Terra');
    expect(result.expression).toMatch(/d6/);
  });

  it('resolves Natural Recovery slot for Circle of the Land', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...druid,
      subclassSlug: 'land',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'natural-recovery-2',
    });

    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      2,
    );
    expect(result.note).toContain('Recuperação Natural');
  });

  it('rejects Druid actions for non-druid characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...druid,
      classSlug: 'ranger',
    });

    await expect(
      handler.useTableAction('user-1', 'druid-1', {
        actionSlug: 'wild-shape',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
