import { BadRequestException } from '@nestjs/common';
import { SorcererActionsHandler } from './sorcerer-actions.handler';

describe('SorcererActionsHandler', () => {
  const stateResponse = {
    classResources: [
      { slug: 'innate-sorcery', remaining: 2, max: 2, used: 0, name: 'Feitiçaria Inata' },
      { slug: 'sorceryPoints', remaining: 5, max: 5, used: 0, name: 'Pontos de Feitiçaria' },
    ],
    tempHp: 0,
  };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const dataSource = {
    query: jest.fn().mockResolvedValue([{ value_id: 'subtle-spell' }]),
  };
  const mechanicalCatalog = {
    load: async () => ({
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      cunningStrikeEffects: [],
      tableActions: [],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [],
      dungeoneerSlayerLabels: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };
  const handler = new SorcererActionsHandler(
    access as never,
    state as never,
    domain as never,
    dataSource as never,
    mechanicalCatalog as never,
  );
  const sorcerer = {
    id: 'sorc-1',
    classSlug: 'sorcerer',
    subclassSlug: 'wild-magic',
    level: 5,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 18,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(sorcerer);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
    dataSource.query.mockResolvedValue([{ value_id: 'subtle-spell' }]);
  });

  it('converts level 1 spell slot to 1 sorcery point', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-slot-1-to-points',
    });

    expect(state.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.note).toContain('consumiu 1 Slot de 1º círculo');
  });

  it('converts sorcery points to level 1 spell slot (cost 2 points)', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-points-to-slot-1',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      2,
    );
    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(result.note).toContain('gastou 2 Pontos de Feitiçaria');
  });

  it('spends sorcery points for a known Metamagic option', async () => {
    dataSource.query
      .mockResolvedValueOnce([
        {
          slug: 'subtle-spell',
          name: 'Magia Sutil',
          description: 'Sem componentes V/S/M',
          cost: 1,
          stacks_with_other: false,
        },
      ])
      .mockResolvedValueOnce([{ value_id: 'subtle-spell' }]);

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'use-metamagic',
      metamagicSlug: 'subtle-spell',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.actionName).toBe('Magia Sutil');
  });

  it('activates Feitiçaria Inata spending one use', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'innate-sorcery',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'innate-sorcery',
      1,
    );
    expect(result.actionName).toBe('Feitiçaria Inata');
  });

  it('spends tides-of-chaos resource for Marés do Caos', async () => {
    state.buildResponse.mockResolvedValue({
      classResources: [
        { slug: 'tides-of-chaos', remaining: 1, max: 1, used: 0, name: 'Marés do Caos' },
        { slug: 'sorceryPoints', remaining: 5, max: 5, used: 0, name: 'Pontos de Feitiçaria' },
      ],
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'tides-of-chaos',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'tides-of-chaos',
      1,
    );
    expect(result.actionName).toBe('Marés do Caos');
  });

  it('spends variable sorcery points for Bastião da Lei', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      ...sorcerer,
      subclassSlug: 'clockwork',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'bastion-of-law',
      pointsSpent: 4,
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      4,
    );
    expect(result.note).toContain('4d8');
  });

  it('rejects bastion cost outside 1–5', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      ...sorcerer,
      subclassSlug: 'clockwork',
      level: 6,
    });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'bastion-of-law',
        pointsSpent: 6,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects Sorcerer actions for non-sorcerer characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...sorcerer,
      classSlug: 'cleric',
    });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'convert-slot-1-to-points',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rolls and applies temporary HP for Heroic Soul', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...sorcerer,
      subclassSlug: 'heroic-sorcery',
      level: 5,
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'heroic-soul',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.expression).toMatch(/^1d6\+5$/);
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
    expect(result.note).toContain('aplicados na ficha');
  });
});
