import { BadRequestException } from '@nestjs/common';
import { FIXTURE_PERSONA_MASK_SLUGS } from '@game/combat/domain/__fixtures__/mechanical-catalog.fixtures';
import { BardActionsHandler } from './bard-actions.handler';

describe('BardActionsHandler', () => {
  const stateResponse = { classResources: [], tempHp: 0, personaMasks: [] as string[] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
    martial: {
      setPersonaMasks: jest.fn().mockResolvedValue(stateResponse),
    },
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const mechanicalCatalog = {
    load: async () => ({
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      cunningStrikeEffects: [],
      tableActions: [],
      personaMasks: FIXTURE_PERSONA_MASK_SLUGS.map((slug) => ({
        slug,
        name: slug,
      })),
      personaMaskSlugs: [...FIXTURE_PERSONA_MASK_SLUGS],
      beastborneAspectBenefits: [],
      dungeoneerSlayerLabels: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };
  const handler = new BardActionsHandler(
    access as never,
    state as never,
    domain as never,
    mechanicalCatalog as never,
  );
  const bard = {
    id: 'bard-1',
    classSlug: 'bard',
    subclassSlug: 'lore',
    level: 5,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 12,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 16,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(bard);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('spends Bardic Inspiration and returns correct die for level 5', async () => {
    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'grant-inspiration',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
    expect(result.expression).toBe('1d8');
    expect(result.note).toContain('Inspiração de Bardo (1d8)');
  });

  it('resolves Cutting Words for Lore Bard', async () => {
    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'cutting-words',
    });

    expect(result.expression).toBe('1d8');
    expect(result.note).toContain('Palavras de Interrupção');
  });

  it('resolves Peerless Skill for Lore Bard at level 14+', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'lore',
      level: 14,
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'peerless-skill',
    });

    expect(result.expression).toBe('1d10');
    expect(result.note).toContain('Perícia Inigualável');
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('resolves Mantle of Inspiration for Glamour Bard (PHB 2024)', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'glamour',
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'mantle-of-inspiration',
    });

    expect(result.expression).toBe('2d8');
    expect(result.note).toContain('Manto de Inspiração');
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('resolves Mantle of Majesty spending resource for Glamour Bard at level 6+', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'glamour',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'mantle-of-majesty',
    });

    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Comando');
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'mantle-of-majesty',
      1,
    );
  });

  it('resolves Unarmed Dance with Dexterity for Dance Bard', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'dance',
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'unarmed-dance',
    });

    expect(result.note).toContain('Destreza');
    expect(result.resourceSpent).toBe(false);
    expect(result.expression).toMatch(/^1d8\+/);
  });

  it('resolves Coordinated Movement for Dance Bard at level 6+', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'dance',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'coordinated-movement',
    });

    expect(result.note).toContain('Movimento Coordenado');
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('rejects persona mask action without equipped mask', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'college-of-masks',
      level: 3,
    });
    state.buildResponse.mockResolvedValue({
      ...stateResponse,
      personaMasks: [],
    });

    await expect(
      handler.useTableAction('user-1', 'bard-1', {
        actionSlug: 'persona-angel',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('resolves persona angel when mask is equipped', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'college-of-masks',
      level: 3,
    });
    state.buildResponse.mockResolvedValue({
      ...stateResponse,
      personaMasks: ['persona-mask-angel'],
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'persona-angel',
    });

    expect(result.note).toContain('Anjo');
    expect(result.expression).toBe('1d6');
  });

  it('recovers 1 inspiration for Superior Inspiration (level 18)', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      level: 18,
    });

    await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'superior-inspiration',
    });

    expect(state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('rejects Bard actions for non-bard characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      classSlug: 'fighter',
    });

    await expect(
      handler.useTableAction('user-1', 'bard-1', {
        actionSlug: 'grant-inspiration',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
