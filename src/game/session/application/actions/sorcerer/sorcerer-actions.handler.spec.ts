import { BadRequestException } from '@nestjs/common';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { SorcererActionsHandler } from './sorcerer-actions.handler';

describe('SorcererActionsHandler', () => {
  const sorcerer = createTestCharacter({
    id: 'sorc-1',
    classSlug: 'sorcerer',
    subclassSlug: 'wild-magic',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 18,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      classResources: [
        {
          slug: 'innate-sorcery',
          remaining: 2,
          max: 2,
          used: 0,
          name: 'Feitiçaria Inata',
        },
        {
          slug: 'sorceryPoints',
          remaining: 5,
          max: 5,
          used: 0,
          name: 'Pontos de Feitiçaria',
        },
      ],
      tempHp: 0,
    },
    defaultCharacter: sorcerer,
  });
  const dataSource = {
    query: jest.fn().mockResolvedValue([{ value_id: 'subtle-spell' }]),
  };
  let handler: SorcererActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    dataSource.query.mockResolvedValue([{ value_id: 'subtle-spell' }]);
    handler = new SorcererActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(dataSource),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep({ load: jest.fn().mockResolvedValue([]) }),
    );
  });

  it('converts level 1 spell slot to 1 sorcery point', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-slot-1-to-points',
    });

    expect(ctx.state.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(ctx.state.recoverClassResource).toHaveBeenCalledWith(
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

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      2,
    );
    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
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

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
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

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'innate-sorcery',
      1,
    );
    expect(result.actionName).toBe('Feitiçaria Inata');
  });

  it('spends tides-of-chaos resource for Marés do Caos', async () => {
    ctx.state.buildResponse.mockResolvedValue({
      ...ctx.stateResponse,
      classResources: [
        {
          slug: 'tides-of-chaos',
          remaining: 1,
          max: 1,
          used: 0,
          name: 'Marés do Caos',
        },
        {
          slug: 'sorceryPoints',
          remaining: 5,
          max: 5,
          used: 0,
          name: 'Pontos de Feitiçaria',
        },
      ],
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'tides-of-chaos',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'tides-of-chaos',
      1,
    );
    expect(result.actionName).toBe('Marés do Caos');
  });

  it('spends variable sorcery points for Bastião da Lei', async () => {
    ctx.mockCharacter({ ...sorcerer, subclassSlug: 'clockwork', level: 6 });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'bastion-of-law',
      pointsSpent: 4,
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      4,
    );
    expect(result.note).toContain('4d8');
  });

  it('rejects bastion cost outside 1–5', async () => {
    ctx.mockCharacter({ ...sorcerer, subclassSlug: 'clockwork', level: 6 });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'bastion-of-law',
        pointsSpent: 6,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects Sorcerer actions for non-sorcerer characters', async () => {
    ctx.mockCharacterOnce({ ...sorcerer, classSlug: 'cleric' });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'convert-slot-1-to-points',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rolls and applies temporary HP for Heroic Soul', async () => {
    ctx.mockCharacterOnce({
      ...sorcerer,
      subclassSlug: 'heroic-sorcery',
      level: 5,
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'heroic-soul',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.expression).toMatch(/^1d6\+5$/);
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
    expect(result.note).toContain('aplicados na ficha');
  });
});
