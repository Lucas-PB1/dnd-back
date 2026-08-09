import { FIXTURE_SOULKNIFE_ACTIONS } from '@game/combat/domain/__fixtures__/mechanical-catalog.fixtures';
import { RogueActionsHandler } from './rogue-actions.handler';

describe('RogueActionsHandler', () => {
  const stateResponse = {
    classResources: [],
  };
  const access = {
    findAccessibleOrFail: jest.fn(),
  };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = {
    getProficiencyBonus: jest.fn().mockResolvedValue(3),
  };
  const mechanicalCatalog = {
    load: async () => ({
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      cunningStrikeEffects: [],
      tableActions: [...FIXTURE_SOULKNIFE_ACTIONS],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [],
      dungeoneerSlayerLabels: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };
  const handler = new RogueActionsHandler(
    access as never,
    state as never,
    domain as never,
    mechanicalCatalog as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.buildResponse.mockResolvedValue(stateResponse);
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'rogue-1',
      classSlug: 'rogue',
      subclassSlug: 'soulknife',
      level: 9,
      abilityScores: {
        forca: 8,
        destreza: 18,
        constituicao: 12,
        inteligencia: 12,
        sabedoria: 10,
        carisma: 10,
      },
    });
  });

  it('spends a Soulknife die only when Psi-Bolstered Knack succeeds', async () => {
    const success = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'psi-bolstered-knack',
      checkTotal: 10,
      dc: 11,
    });
    expect(success.resourceSpent).toBe(true);
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'rogue-1' }),
      'soulknife-psi-dice',
      1,
    );

    jest.clearAllMocks();
    const failure = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'psi-bolstered-knack',
      checkTotal: 1,
      dc: 100,
    });
    expect(failure.resourceSpent).toBe(false);
    expect(state.useClassResource).not.toHaveBeenCalled();
  });

  it('rolls both attack and damage for the Psychic Blade', async () => {
    const result = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'psychic-blade-main',
    });

    expect(result.expression).toMatch(/1d20\+7.*1d6\+4/);
    expect(result.note).toContain('Psíquico');
    expect(result.resourceSpent).toBe(false);
  });

  it('spends the free Psychic Whispers use before Psi dice', async () => {
    await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'psychic-whispers',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'rogue-1' }),
      'psychic-whispers',
      1,
    );
  });

  it('spends the Arachnoid web resource', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      id: 'rogue-1',
      classSlug: 'rogue',
      subclassSlug: 'arachnoid-stalker',
      level: 9,
      abilityScores: {
        forca: 8,
        destreza: 18,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    });

    const result = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'arachnoid-web',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'arachnoid-stalker' }),
      'arachnoid-web',
      1,
    );
    expect(result.saveDc).toBe(15);
  });
});
