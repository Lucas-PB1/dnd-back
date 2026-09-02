import { FIXTURE_SOULKNIFE_ACTIONS } from '@game/combat/domain/__fixtures__/mechanical-catalog';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from './testing/table-action-handler.harness';
import { RogueActionsHandler } from './rogue-actions.handler';

describe('RogueActionsHandler', () => {
  const rogue = createTestCharacter({
    id: 'rogue-1',
    classSlug: 'rogue',
    subclassSlug: 'soulknife',
    level: 9,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 18,
      constituicao: 12,
      inteligencia: 12,
      sabedoria: 10,
      carisma: 10,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    defaultCharacter: rogue,
    mechanicalCatalogLoad: { tableActions: [...FIXTURE_SOULKNIFE_ACTIONS] },
  });
  let handler: RogueActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    handler = new RogueActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.mechanicalCatalog),
    );
  });

  it('spends a Soulknife die only when Psi-Bolstered Knack succeeds', async () => {
    const success = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'psi-bolstered-knack',
      checkTotal: 10,
      dc: 11,
    });
    expect(success.resourceSpent).toBe(true);
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'rogue-1' }),
      'soulknife-psi-dice',
      1,
    );

    jest.clearAllMocks();
    ctx.resetMocks();
    const failure = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'psi-bolstered-knack',
      checkTotal: 1,
      dc: 100,
    });
    expect(failure.resourceSpent).toBe(false);
    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
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
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'rogue-1' }),
      'psychic-whispers',
      1,
    );
  });

  it('spends the Arachnoid web resource', async () => {
    ctx.mockCharacterOnce({
      ...rogue,
      subclassSlug: 'arachnoid-stalker',
      abilityScores: createTestAbilityScores({
        forca: 8,
        destreza: 18,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      }),
    });

    const result = await handler.useTableAction('user-1', 'rogue-1', {
      actionSlug: 'arachnoid-web',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'arachnoid-stalker' }),
      'arachnoid-web',
      1,
    );
    expect(result.saveDc).toBe(15);
  });
});
