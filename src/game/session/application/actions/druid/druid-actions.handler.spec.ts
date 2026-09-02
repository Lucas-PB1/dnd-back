import { BadRequestException } from '@nestjs/common';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { DruidActionsHandler } from './druid-actions.handler';

describe('DruidActionsHandler', () => {
  const druid = createTestCharacter({
    id: 'druid-1',
    classSlug: 'druid',
    subclassSlug: 'stars',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 18,
      carisma: 10,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      starryFormActive: false,
      stellarConstellation: null,
    },
    defaultCharacter: druid,
  });
  let handler: DruidActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    handler = new DruidActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.mechanicalCatalog),
    );
  });

  it('spends 1 Wild Shape use for base Wild Shape', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-shape',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
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

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
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
    expect(ctx.state.setStarryForm).toHaveBeenCalledWith(
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
    ctx.state.buildResponse.mockResolvedValueOnce({
      ...ctx.stateResponse,
      starryFormActive: true,
      stellarConstellation: 'archer',
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'starry-form-archer',
    });

    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
    expect(result.note).toContain('ainda ativa');
  });

  it('resolves Moon Combat Wild Shape for Circle of the Moon', async () => {
    ctx.mockCharacterOnce({ ...druid, subclassSlug: 'moon' });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'moon-combat-wild-shape',
    });

    expect(result.total).toBe(15);
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { tempHp: 15 },
    );
    expect(result.state).toEqual(expect.objectContaining({ tempHp: 15 }));
    expect(result.note).toContain('Forma Selvagem de Combate');
  });

  it('resolves Land Aid for Circle of the Land', async () => {
    ctx.mockCharacterOnce({ ...druid, subclassSlug: 'land', level: 3 });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'land-aid',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(result.note).toContain('Auxílio da Terra');
    expect(result.expression).toMatch(/d6/);
  });

  it('resolves Natural Recovery slot for Circle of the Land', async () => {
    ctx.mockCharacterOnce({ ...druid, subclassSlug: 'land', level: 6 });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'natural-recovery-2',
    });

    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      2,
    );
    expect(result.note).toContain('Recuperação Natural');
  });

  it('rejects Druid actions for non-druid characters', async () => {
    ctx.mockCharacterOnce({ ...druid, classSlug: 'ranger' });

    await expect(
      handler.useTableAction('user-1', 'druid-1', {
        actionSlug: 'wild-shape',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
