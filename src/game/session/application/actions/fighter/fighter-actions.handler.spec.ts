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
    mechanicalCatalogLoad: {
      battleMasterManeuvers: [...FIXTURE_BATTLE_MASTER_MANEUVERS],
      tableActions: [...FIXTURE_PSI_ACTIONS],
      precautionSpells: [...FIXTURE_DUNGEONEER_PRECAUTION_SPELLS],
    },
  });
  let handler: FighterActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    ctx.sheet.load.mockResolvedValue({
      subclassOptions: [{ optionKey: 'maneuver1', valueId: 'trip-attack' }],
    } as CharacterSheetData);
    handler = new FighterActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.sheet),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep({ load: jest.fn().mockResolvedValue([]) }),
    );
  });

  it('spends one Superiority Die for a selected maneuver', async () => {
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

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'psi:protective-field',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      psiWarrior,
      'psi-energy-dice',
      1,
    );
    expect(result.actionName).toBe('Campo Protetor');
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
});
