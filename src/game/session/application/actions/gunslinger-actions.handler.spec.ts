import { BadRequestException } from '@nestjs/common';
import type { CharacterSheetData } from '@game/sheet/domain/character-sheet.types';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestCharacter,
} from './testing/table-action-handler.harness';
import { GunslingerActionsHandler } from './gunslinger-actions.handler';

describe('GunslingerActionsHandler', () => {
  const gunslinger = createTestCharacter({
    id: 'gs-1',
    classSlug: 'gunslinger',
    subclassSlug: 'pistolero',
    level: 15,
  });
  const maneuverResult = {
    state: { classResources: [{ slug: 'risk', remaining: 3, max: 4 }] },
    maneuverSlug: 'bite-the-bullet',
    maneuverName: 'Morda a Bala',
    effectKind: 'temp_hp',
    riskRoll: { expression: '1d8', value: 5 },
    tempHpGained: 12,
    note: '+12 PV Temporários',
  };
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      classResources: [
        { slug: 'risk', remaining: 3, max: 4, name: 'Risco', used: 1 },
      ],
    },
    defaultCharacter: gunslinger,
  });
  let handler: GunslingerActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    ctx.sheet.load.mockResolvedValue({
      characterFeats: [
        { featSlug: 'blackpowder-pistol-expert', instanceIndex: 0 },
      ],
    } as CharacterSheetData);
    ctx.state.martial.useManeuver.mockResolvedValue(maneuverResult);
    ctx.state.recoverClassResource.mockResolvedValue({
      ...ctx.stateResponse,
      classResources: [
        { slug: 'risk', remaining: 4, max: 4, name: 'Risco', used: 0 },
      ],
    });
    handler = new GunslingerActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.sheet),
    );
  });

  it('routes use-maneuver through table-action', async () => {
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'bite-the-bullet',
    });
    expect(ctx.state.martial.useManeuver).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'gs-1' }),
      'bite-the-bullet',
    );
    expect(result).toMatchObject({
      maneuverName: 'Morda a Bala',
      note: '+12 PV Temporários',
    });
  });

  it('rejects use-maneuver without maneuverSlug', async () => {
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'use-maneuver',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('recovers one risk die on recover-risk at level 15+', async () => {
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'recover-risk',
    });
    expect(ctx.state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'gs-1' }),
      'risk',
      1,
    );
    expect(result).toMatchObject({
      actionName: 'Gambito Terrível',
      resourceSpent: false,
    });
    expect(result.note).toContain('Dado de Risco');
  });

  it('rejects recover-risk below level 15', async () => {
    ctx.mockCharacterOnce({ ...gunslinger, level: 14 });
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'recover-risk',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects gunslinger actions for non-gunslingers', async () => {
    ctx.mockCharacterOnce({ ...gunslinger, classSlug: 'fighter' });
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'recover-risk',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('allows reload-firearm for non-gunslinger with blackpowder-pistol-expert', async () => {
    ctx.mockCharacterOnce({ ...gunslinger, classSlug: 'fighter' });
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'reload-firearm',
      itemSlug: 'blackpowder-pistol',
    });
    expect(ctx.state.martial.reloadFirearm).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'gs-1' }),
      'blackpowder-pistol',
    );
    expect(result).toMatchObject({ actionName: 'Recarregar' });
  });

  it('rejects reload-firearm for non-gunslinger without feat', async () => {
    ctx.mockCharacterOnce({ ...gunslinger, classSlug: 'fighter' });
    ctx.sheet.load.mockResolvedValueOnce({
      characterFeats: [],
    } as unknown as CharacterSheetData);
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'reload-firearm',
        itemSlug: 'blackpowder-pistol',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects reload-firearm for feat holder with non-pistol firearm', async () => {
    ctx.mockCharacterOnce({ ...gunslinger, classSlug: 'fighter' });
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'reload-firearm',
        itemSlug: 'revolver',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('reloads firearm via table-action', async () => {
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'reload-firearm',
      itemSlug: 'revolver',
    });
    expect(ctx.state.martial.reloadFirearm).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'gs-1' }),
      'revolver',
    );
    expect(result).toMatchObject({
      actionName: 'Recarregar',
      note: 'Recarregou revolver.',
    });
  });

  it('fires chamber via table-action', async () => {
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'fire-chamber',
      itemSlug: 'revolver',
      shots: 2,
    });
    expect(ctx.state.martial.fireChamber).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'gs-1' }),
      'revolver',
      2,
    );
    expect(result).toMatchObject({
      actionName: 'Disparar',
      note: 'Gastou 2 tiro(s) de revolver.',
    });
  });

  it('rejects reload-firearm without itemSlug', async () => {
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'reload-firearm',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
