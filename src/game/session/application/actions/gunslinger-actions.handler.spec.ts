import { BadRequestException } from '@nestjs/common';
import { GunslingerActionsHandler } from './gunslinger-actions.handler';

describe('GunslingerActionsHandler', () => {
  const stateResponse = { classResources: [{ slug: 'risk', remaining: 3, max: 4 }] };
  const maneuverResult = {
    state: stateResponse,
    maneuverSlug: 'bite-the-bullet',
    maneuverName: 'Morda a Bala',
    effectKind: 'temp_hp',
    riskRoll: { expression: '1d8', value: 5 },
    tempHpGained: 12,
    note: '+12 PV Temporários',
  };
  const access = { findAccessibleOrFail: jest.fn() };
  const martial = {
    listManeuvers: jest.fn(),
    useManeuver: jest.fn().mockResolvedValue(maneuverResult),
    reloadFirearm: jest.fn().mockResolvedValue(stateResponse),
    fireChamber: jest.fn().mockResolvedValue(stateResponse),
  };
  const state = {
    martial,
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    recoverClassResource: jest
      .fn()
      .mockResolvedValue({ ...stateResponse, classResources: [{ slug: 'risk', remaining: 4, max: 4 }] }),
  };
  const handler = new GunslingerActionsHandler(
    access as never,
    state as never,
  );

  const gunslinger = {
    id: 'gs-1',
    classSlug: 'gunslinger',
    subclassSlug: 'pistolero',
    level: 15,
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(gunslinger);
    martial.useManeuver.mockResolvedValue(maneuverResult);
  });

  it('routes use-maneuver through table-action', async () => {
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'bite-the-bullet',
    });
    expect(martial.useManeuver).toHaveBeenCalledWith(
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
    expect(state.recoverClassResource).toHaveBeenCalledWith(
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
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...gunslinger,
      level: 14,
    });
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'recover-risk',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects gunslinger actions for non-gunslingers', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...gunslinger,
      classSlug: 'fighter',
    });
    await expect(
      handler.useTableAction('user-1', 'gs-1', {
        actionSlug: 'recover-risk',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('reloads firearm via table-action', async () => {
    const result = await handler.useTableAction('user-1', 'gs-1', {
      actionSlug: 'reload-firearm',
      itemSlug: 'revolver',
    });
    expect(martial.reloadFirearm).toHaveBeenCalledWith(
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
    expect(martial.fireChamber).toHaveBeenCalledWith(
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
