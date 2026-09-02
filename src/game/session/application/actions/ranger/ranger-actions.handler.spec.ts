import { BadRequestException } from '@nestjs/common';
import { FIXTURE_BESTIAL_ASPECT_BENEFITS } from '@game/combat/domain/__fixtures__/mechanical-catalog';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { RangerActionsHandler } from './ranger-actions.handler';

describe('RangerActionsHandler', () => {
  const ranger = createTestCharacter({
    id: 'ranger-1',
    classSlug: 'ranger',
    subclassSlug: 'hunter',
    level: 10,
    abilityScores: createTestAbilityScores({
      forca: 12,
      destreza: 16,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 16,
      carisma: 8,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      concentratingOn: 'marca-do-predador',
      tempHp: 0,
    },
    defaultCharacter: ranger,
    mechanicalCatalogLoad: {
      beastborneAspectBenefits: [...FIXTURE_BESTIAL_ASPECT_BENEFITS],
    },
  });
  const syncCompanion = { execute: jest.fn() };
  const dataSource = {};
  let handler: RangerActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    handler = new RangerActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(syncCompanion),
      asHandlerDep(dataSource),
    );
  });

  it('spends Favored Enemy and concentrates on Hunter\'s Mark', async () => {
    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'hunters-mark-free',
    });
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      'favoredEnemy',
      1,
    );
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      { concentratingOn: 'marca-do-predador' },
    );
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls temporary HP for Tireless using WIS', async () => {
    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'tireless',
    });
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      'tireless',
      1,
    );
    expect(result.expression).toMatch(/1d8\+3/);
    expect(result.note).toContain('PV temporários');
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('rejects Nature\'s Veil below level 14', async () => {
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'natures-veil',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects subclass actions for the wrong subclass', async () => {
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'primal-companion',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('resolves Hunter Superior Defense note at level 15', async () => {
    ctx.mockCharacterOnce({
      ...ranger,
      subclassSlug: 'hunter',
      level: 15,
    });
    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'hunter-defense',
    });
    expect(result.resourceSpent).toBe(false);
    expect(result.note).toContain('Defesa do Caçador');
  });

  it('resolves Gloom Stalker Shadowy Dodge note at level 15', async () => {
    ctx.mockCharacterOnce({
      ...ranger,
      subclassSlug: 'gloom-stalker',
      level: 15,
    });
    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'gloom-stalker-dodge',
    });
    expect(result.note).toContain('Esquiva Sombria');
  });

  it('rejects ranger actions for non-rangers', async () => {
    ctx.mockCharacterOnce({ ...ranger, classSlug: 'fighter' });
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'hunters-mark-free',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
