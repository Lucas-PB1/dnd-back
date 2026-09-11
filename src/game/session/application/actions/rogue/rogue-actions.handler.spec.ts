import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { RogueActionsHandler } from './rogue-actions.handler';

const ROGUE_ECONOMY = [
  {
    id: 'rogue-psi-bolstered',
    name: 'Aptidão Reforçada Psiquicamente',
    economy: 'free' as const,
    classSlug: 'rogue',
    subclassSlug: 'soulknife',
    minLevel: 3,
    resourceSlug: 'soulknife-psi-dice',
    alwaysSpendsResource: false,
    tableAction: 'psi-bolstered-knack',
    itemSlug: null,
    featSlug: null,
    description: 'Psi knack',
  },
  {
    id: 'rogue-psychic-whispers',
    name: 'Sussurros Psíquicos',
    economy: 'action' as const,
    classSlug: 'rogue',
    subclassSlug: 'soulknife',
    minLevel: 3,
    resourceSlug: 'soulknife-psi-dice',
    freeResourceSlug: 'psychic-whispers',
    alwaysSpendsResource: false,
    tableAction: 'psychic-whispers',
    itemSlug: null,
    featSlug: null,
    description: 'Whispers',
  },
  {
    id: 'rogue-arachnoid-web',
    name: 'Correia / Teia',
    economy: 'bonus' as const,
    classSlug: 'rogue',
    subclassSlug: 'arachnoid-stalker',
    minLevel: 3,
    resourceSlug: 'arachnoid-web',
    alwaysSpendsResource: true,
    tableAction: 'arachnoid-web',
    itemSlug: null,
    featSlug: null,
    description: 'Web',
  },
  {
    id: 'rogue-psychic-blade-main',
    name: 'Lâmina Psíquica',
    economy: 'action' as const,
    classSlug: 'rogue',
    subclassSlug: 'soulknife',
    minLevel: 3,
    alwaysSpendsResource: false,
    tableAction: 'psychic-blade-main',
    itemSlug: null,
    featSlug: null,
    description: 'Blade',
  },
];

const ROGUE_EFFECTS: CatalogEffect[] = [
  {
    kind: 'check_boost',
    resourceSlug: 'soulknife-psi-dice',
    ownerKind: 'subclass',
    ownerSlug: 'soulknife',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'psi-bolstered-knack',
    note: { note: 'Psi knack' },
  } as CatalogEffect,
  {
    kind: 'table_roll',
    ownerKind: 'subclass',
    ownerSlug: 'soulknife',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'psychic-whispers',
    numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
  } as CatalogEffect,
  {
    kind: 'feature_dc',
    ownerKind: 'subclass',
    ownerSlug: 'arachnoid-stalker',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'arachnoid-web',
    numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
  } as CatalogEffect,
  {
    kind: 'table_note',
    ownerKind: 'subclass',
    ownerSlug: 'arachnoid-stalker',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'arachnoid-web',
    note: { note: 'Correia CD {saveDc}' },
  } as CatalogEffect,
  {
    kind: 'psychic_blade_attack',
    ownerKind: 'subclass',
    ownerSlug: 'soulknife',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'psychic-blade-main',
    note: { note: 'Lâmina Psíquica' },
  } as CatalogEffect,
];

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
    mechanicalCatalogLoad: { economyActions: ROGUE_ECONOMY },
  });
  const effectCatalog = { load: jest.fn().mockResolvedValue(ROGUE_EFFECTS) };
  let handler: RogueActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockImplementation(({ actionSlug }: { actionSlug?: string }) =>
      Promise.resolve(
        ROGUE_EFFECTS.filter((effect) => effect.actionSlug === actionSlug),
      ),
    );
    handler = new RogueActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
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
    effectCatalog.load.mockImplementation(({ actionSlug }: { actionSlug?: string }) =>
      Promise.resolve(
        ROGUE_EFFECTS.filter((effect) => effect.actionSlug === actionSlug),
      ),
    );
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
      level: 5,
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
