import { BadRequestException } from '@nestjs/common';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { ClericActionsHandler } from './cleric-actions.handler';

describe('ClericActionsHandler', () => {
  const cleric = createTestCharacter({
    id: 'cleric-1',
    classSlug: 'cleric',
    subclassSlug: 'light',
    level: 7,
    abilityScores: createTestAbilityScores({
      forca: 10,
      destreza: 10,
      constituicao: 14,
      inteligencia: 12,
      sabedoria: 18,
      carisma: 8,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: { tempHp: 0 },
    defaultCharacter: cleric,
  });
  let handler: ClericActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    handler = new ClericActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.mechanicalCatalog),
    );
  });

  it('spends Channel Divinity and rolls the scaled Divine Spark', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'divine-spark-damage',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'channelDivinity',
      1,
    );
    expect(result.expression).toMatch(/^2d8\+4$/);
    expect(result.saveDc).toBe(15);
  });

  it('adds Sear Undead damage at level 5+', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'turn-undead',
    });

    expect(result.expression).toBe('4d8');
    expect(result.saveDc).toBe(15);
    expect(result.note).toContain('Fulminar');
  });

  it('rolls Radiance of Dawn for a Light Cleric', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'radiance-of-dawn',
    });

    expect(result.expression).toBe('2d10+7');
    expect(result.saveDc).toBe(15);
  });

  it('uses the Life Domain healing pool without rolling', async () => {
    ctx.mockCharacterOnce({ ...cleric, subclassSlug: 'life', level: 9 });

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'preserve-life',
    });

    expect(result.total).toBe(45);
    expect(result.note).toContain('metade dos PV máximos');
  });

  it('spends War Priest uses from the subclass resource', async () => {
    ctx.mockCharacterOnce({ ...cleric, subclassSlug: 'war' });

    await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'war-priest',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'war-priest',
      1,
    );
  });

  it('applies temporary HP for Improved Warding Flare', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'warding-flare',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'warding-flare',
      1,
    );
    expect(result.expression).toMatch(/^2d6\+4$/);
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
    expect(result.note).toContain('ajuste o contador');
  });

  it('rejects Cleric actions for another class', async () => {
    ctx.mockCharacterOnce({ ...cleric, classSlug: 'wizard' });

    await expect(
      handler.useTableAction('user-1', 'cleric-1', {
        actionSlug: 'divine-spark-heal',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Channel Divinity for Dragon Majesty with save DC', async () => {
    ctx.mockCharacterOnce({
      ...cleric,
      subclassSlug: 'dragon-domain',
      level: 5,
    });

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'dragon-majesty',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'channelDivinity',
      1,
    );
    expect(result.saveDc).toBe(15);
    expect(result.note).toContain('Enfeitiçado ou Amedrontado');
  });

  it('spends chromatic-affinity for Dragon Domain bonus damage', async () => {
    ctx.mockCharacterOnce({
      ...cleric,
      subclassSlug: 'dragon-domain',
      level: 8,
    });

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'chromatic-affinity',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'chromatic-affinity',
      1,
    );
    expect(result.total).toBe(8);
  });

  it('spends legendary-aspect for Rend at level 17+', async () => {
    ctx.mockCharacterOnce({
      ...cleric,
      subclassSlug: 'dragon-domain',
      level: 17,
    });

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'legendary-aspect-rend',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'legendary-aspect',
      1,
    );
    expect(result.note).toContain('Rasgar');
  });
});
