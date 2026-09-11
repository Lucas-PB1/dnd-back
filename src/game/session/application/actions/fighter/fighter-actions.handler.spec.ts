import {
  FIXTURE_BATTLE_MASTER_MANEUVERS,
  FIXTURE_DUNGEONEER_PRECAUTION_SPELLS,
  FIXTURE_PSI_ACTIONS,
} from '@game/combat/domain/__fixtures__/mechanical-catalog';
import type { CharacterSheetData } from '@game/sheet/domain/character-sheet.types';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { FighterActionsHandler } from './fighter-actions.handler';

const FIGHTER_ECONOMY = [
  {
    id: 'fighter-second-wind',
    name: 'Recuperar Fôlego',
    economy: 'bonus' as const,
    classSlug: 'fighter',
    minLevel: 1,
    resourceSlug: 'secondWind',
    alwaysSpendsResource: true,
    tableAction: 'second-wind',
    itemSlug: null,
    featSlug: null,
    description: 'Cura 1d10 + nível.',
  },
  {
    id: 'fighter-action-surge',
    name: 'Surto de Ação',
    economy: 'action' as const,
    classSlug: 'fighter',
    minLevel: 2,
    resourceSlug: 'actionSurge',
    alwaysSpendsResource: true,
    tableAction: 'action-surge',
    itemSlug: null,
    featSlug: null,
    description: 'Ação adicional.',
  },
  {
    id: 'fighter-tactical-mind',
    name: 'Mente Tática',
    economy: 'free' as const,
    classSlug: 'fighter',
    minLevel: 2,
    resourceSlug: 'secondWind',
    alwaysSpendsResource: false,
    tableAction: 'tactical-mind',
    itemSlug: null,
    featSlug: null,
    description: 'Boost de teste.',
  },
  {
    id: 'fighter-use-maneuver',
    name: 'Usar Manobra',
    economy: 'free' as const,
    classSlug: 'fighter',
    subclassSlug: 'battle-master',
    minLevel: 3,
    resourceSlug: 'superiority-dice',
    alwaysSpendsResource: false,
    tableAction: 'use-maneuver',
    itemSlug: null,
    featSlug: null,
    description: 'Manobra BM.',
  },
  {
    id: 'fighter-dungeon-precautions',
    name: 'Precauções na Masmorra',
    economy: 'free' as const,
    classSlug: 'fighter',
    subclassSlug: 'dungeoneer',
    minLevel: 7,
    resourceSlug: 'dungeon-precautions',
    alwaysSpendsResource: true,
    tableAction: 'dungeon-precaution',
    itemSlug: null,
    featSlug: null,
    description: 'Precaução.',
  },
  {
    id: 'fighter-psi-protective-field',
    name: 'Campo Protetor',
    economy: 'reaction' as const,
    classSlug: 'fighter',
    subclassSlug: 'psi-warrior',
    minLevel: 3,
    resourceSlug: 'psi-energy-dice',
    alwaysSpendsResource: true,
    tableAction: 'psi:protective-field',
    itemSlug: null,
    featSlug: null,
    description: 'Campo protetor.',
  },
  {
    id: 'fighter-psi-mental-guard',
    name: 'Resguardo Mental',
    economy: 'free' as const,
    classSlug: 'fighter',
    subclassSlug: 'psi-warrior',
    minLevel: 10,
    resourceSlug: 'psi-energy-dice',
    alwaysSpendsResource: true,
    tableAction: 'psi:mental-guard',
    itemSlug: null,
    featSlug: null,
    description: 'Encerra Amedrontado/Enfeitiçado.',
  },
  {
    id: 'fighter-psi-telekinetic-movement',
    name: 'Movimento Telecinético',
    economy: 'action' as const,
    classSlug: 'fighter',
    subclassSlug: 'psi-warrior',
    minLevel: 3,
    resourceSlug: 'psi-energy-dice',
    freeResourceSlug: 'telekinetic-movement',
    alwaysSpendsResource: false,
    tableAction: 'psi:telekinetic-movement',
    itemSlug: null,
    featSlug: null,
    description: 'Movimento telecinético.',
  },
];

describe('FighterActionsHandler tabletop actions', () => {
  const fighter = createTestCharacter({
    id: 'fighter-id',
    classSlug: 'fighter',
    subclassSlug: 'battle-master',
    level: 15,
    backgroundSlug: 'soldier',
    abilityScores: createTestAbilityScores({
      forca: 18,
      destreza: 14,
      constituicao: 14,
      inteligencia: 16,
      sabedoria: 10,
      carisma: 12,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    defaultCharacter: fighter,
    proficiencyBonus: 5,
    stateResponse: {
      classResources: [
        { slug: 'secondWind', remaining: 2, max: 2, name: 'Fôlego', used: 0 },
        {
          slug: 'actionSurge',
          remaining: 1,
          max: 1,
          name: 'Surto de Ação',
          used: 0,
        },
        {
          slug: 'superiority-dice',
          remaining: 4,
          max: 4,
          name: 'Dados de Superioridade',
          used: 0,
        },
        {
          slug: 'psi-energy-dice',
          remaining: 4,
          max: 4,
          name: 'Dados Psi',
          used: 0,
        },
        {
          slug: 'dungeon-precautions',
          remaining: 2,
          max: 2,
          name: 'Precauções',
          used: 0,
        },
        {
          slug: 'telekinetic-movement',
          remaining: 1,
          max: 1,
          name: 'Mov. Telecinético',
          used: 0,
        },
      ],
      tempHp: 0,
    },
    mechanicalCatalogLoad: {
      battleMasterManeuvers: [...FIXTURE_BATTLE_MASTER_MANEUVERS],
      tableActions: [...FIXTURE_PSI_ACTIONS],
      precautionSpells: [...FIXTURE_DUNGEONEER_PRECAUTION_SPELLS],
      economyActions: FIGHTER_ECONOMY,
    },
  });
  let handler: FighterActionsHandler;
  let effectLoad: jest.Mock;

  beforeEach(() => {
    ctx.resetMocks();
    effectLoad = jest.fn().mockResolvedValue([]);
    ctx.sheet.load.mockResolvedValue({
      subclassOptions: [{ optionKey: 'maneuver1', valueId: 'trip-attack' }],
    } as CharacterSheetData);
    handler = new FighterActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.sheet),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep({ load: effectLoad }),
    );
  });

  it('spends one Superiority Die for a selected maneuver', async () => {
    effectLoad.mockResolvedValue([
      {
        kind: 'catalog_maneuver',
        trigger: 'on_table_action',
        actionSlug: 'use-maneuver',
        unlockLevel: 3,
        ownerKind: 'subclass',
        ownerSlug: 'battle-master',
        note: null,
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'trip-attack',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      fighter,
      'superiority-dice',
      1,
    );
    expect(result.actionName).toBe('Ataque Derrubador');
    expect(result.saveDc).toBe(17);
    expect(result.resourceSpent).toBe(true);
  });

  it('uses Relentless without spending Superiority', async () => {
    effectLoad.mockResolvedValue([
      {
        kind: 'catalog_maneuver',
        trigger: 'on_table_action',
        actionSlug: 'use-maneuver',
        unlockLevel: 3,
        ownerKind: 'subclass',
        ownerSlug: 'battle-master',
        note: null,
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'trip-attack',
      useRelentless: true,
    });

    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
    expect(result.resourceSpent).toBe(false);
    expect(result.expression).toBe('1d8');
  });

  it('applies temporary HP for Rally on this PC', async () => {
    effectLoad.mockResolvedValue([
      {
        kind: 'catalog_maneuver',
        trigger: 'on_table_action',
        actionSlug: 'use-maneuver',
        unlockLevel: 3,
        ownerKind: 'subclass',
        ownerSlug: 'battle-master',
        note: null,
      },
    ]);
    ctx.sheet.load.mockResolvedValue({
      subclassOptions: [{ optionKey: 'maneuver1', valueId: 'rally' }],
    } as CharacterSheetData);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'rally',
    });

    expect(ctx.state.patch).toHaveBeenCalled();
    expect(result.actionName).toBe('Reunir');
    expect(result.note).toContain('PV temp. aplicados neste PC');
    expect(result.total).toBeGreaterThan(0);
  });

  it('spends Psi Energy for Protective Field', async () => {
    const psiWarrior = { ...fighter, subclassSlug: 'psi-warrior', level: 7 };
    ctx.mockCharacter({ ...fighter, subclassSlug: 'psi-warrior', level: 7 });
    effectLoad.mockResolvedValue([
      {
        kind: 'table_roll',
        trigger: 'on_table_action',
        actionSlug: 'psi:protective-field',
        unlockLevel: 3,
        ownerKind: 'subclass',
        ownerSlug: 'psi-warrior',
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Campo Protetor: reduza {total} do dano.' },
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'psi:protective-field',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      psiWarrior,
      'psi-energy-dice',
      1,
    );
    expect(result.actionName).toBe('Campo Protetor');
    expect(result.total).toBeGreaterThan(0);
  });

  it('uses free psi resource unless usePsiDie', async () => {
    ctx.mockCharacter({ ...fighter, subclassSlug: 'psi-warrior', level: 7 });
    effectLoad.mockResolvedValue([
      {
        kind: 'table_note',
        trigger: 'on_table_action',
        actionSlug: 'psi:telekinetic-movement',
        unlockLevel: 3,
        ownerKind: 'subclass',
        ownerSlug: 'psi-warrior',
        note: { note: 'Movimento Telecinético: mova objeto/criatura.' },
      },
    ]);

    await handler.useTableAction('user', fighter.id, {
      actionSlug: 'psi:telekinetic-movement',
    });
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'telekinetic-movement',
      1,
    );

    ctx.resetMocks();
    effectLoad.mockResolvedValue([
      {
        kind: 'table_note',
        trigger: 'on_table_action',
        actionSlug: 'psi:telekinetic-movement',
        unlockLevel: 3,
        ownerKind: 'subclass',
        ownerSlug: 'psi-warrior',
        note: { note: 'Movimento Telecinético: mova objeto/criatura.' },
      },
    ]);
    ctx.mockCharacter({ ...fighter, subclassSlug: 'psi-warrior', level: 7 });

    await handler.useTableAction('user', fighter.id, {
      actionSlug: 'psi:telekinetic-movement',
      usePsiDie: true,
    });
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'psi-energy-dice',
      1,
    );
  });

  it('spends one Dungeon Precaution for an allowed spell', async () => {
    ctx.mockCharacter({ ...fighter, subclassSlug: 'dungeoneer', level: 7 });

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'dungeon-precaution',
      spellSlug: 'detectar-magia',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      { ...fighter, subclassSlug: 'dungeoneer', level: 7 },
      'dungeon-precautions',
      1,
    );
    expect(result.note).toContain('Detectar Magia');
  });

  it('routes second-wind through economy heal', async () => {
    ctx.mockCharacter({
      ...fighter,
      hitPointsCurrent: 20,
      hitPointsMax: 50,
    });
    effectLoad.mockResolvedValue([
      {
        kind: 'heal',
        trigger: 'on_table_action',
        actionSlug: 'second-wind',
        unlockLevel: 1,
        ownerKind: 'class',
        numeric: { amountFormula: 'dice_1d10_plus_level', flat: null },
        note: null,
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'second-wind',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: fighter.id }),
      'secondWind',
      1,
    );
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
    expect(result.actionName).toBe('Recuperar Fôlego');
    expect(result.resourceSpent).toBe(true);
  });

  it('routes tactical-mind through check_boost', async () => {
    effectLoad.mockResolvedValue([
      {
        kind: 'check_boost',
        trigger: 'on_table_action',
        actionSlug: 'tactical-mind',
        unlockLevel: 2,
        ownerKind: 'class',
        resourceSlug: 'secondWind',
        note: { note: 'Mente Tática: sucesso' },
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'tactical-mind',
      checkTotal: 10,
      dc: 15,
    });

    expect(result.expression).toBe('1d10');
    expect(result.roll).toBeDefined();
  });

  it('routes action-surge through economy note', async () => {
    effectLoad.mockResolvedValue([
      {
        kind: 'table_note',
        trigger: 'on_table_action',
        actionSlug: 'action-surge',
        unlockLevel: 2,
        ownerKind: 'class',
        note: { note: 'Surto de Ação: execute uma ação adicional.' },
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'action-surge',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: fighter.id }),
      'actionSurge',
      1,
    );
    expect(result.actionName).toBe('Surto de Ação');
    expect(result.note).toContain('ação adicional');
  });

  it('routes psi:mental-guard through economy', async () => {
    ctx.mockCharacter({ ...fighter, subclassSlug: 'psi-warrior', level: 10 });
    effectLoad.mockResolvedValue([
      {
        kind: 'table_note',
        trigger: 'on_table_action',
        actionSlug: 'psi:mental-guard',
        unlockLevel: 10,
        ownerKind: 'subclass',
        ownerSlug: 'psi-warrior',
        note: { note: 'Resguardo Mental: encerre Amedrontado/Enfeitiçado.' },
      },
    ]);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'psi:mental-guard',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'psi-warrior' }),
      'psi-energy-dice',
      1,
    );
    expect(result.actionName).toBe('Resguardo Mental');
    expect(result.note).toContain('Amedrontado');
  });
});
