import { BadRequestException } from '@nestjs/common';
import { InventoryActionsHandler } from './inventory-actions.handler';

describe('InventoryActionsHandler', () => {
  const weaponCharm = {
    attach: jest.fn(),
    detach: jest.fn(),
  };
  const coverage = {
    attach: jest.fn(),
    detach: jest.fn(),
  };
  const artifactRegen = {
    execute: jest.fn(),
  };
  const artifactPolish = {
    conflict: jest.fn(),
    reroll: jest.fn(),
  };

  const handler = new InventoryActionsHandler(
    weaponCharm as never,
    coverage as never,
    artifactRegen as never,
    artifactPolish as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('dispatches attach-weapon-charm', async () => {
    weaponCharm.attach.mockResolvedValue({ itemSlug: 'longsword' });
    await handler.execute('u', 'c', {
      actionSlug: 'attach-weapon-charm',
      weaponSlug: 'longsword',
      charmSlug: 'weapon-charm-blade-1',
    });
    expect(weaponCharm.attach).toHaveBeenCalledWith('u', 'c', {
      weaponSlug: 'longsword',
      charmSlug: 'weapon-charm-blade-1',
    });
  });

  it('dispatches artifact-regen', async () => {
    artifactRegen.execute.mockResolvedValue({ note: 'ok' });
    await handler.execute('u', 'c', {
      actionSlug: 'artifact-regen',
      itemSlug: 'olho-de-vecna',
    });
    expect(artifactRegen.execute).toHaveBeenCalledWith(
      'u',
      'c',
      'olho-de-vecna',
    );
  });

  it('dispatches sentient-conflict and artifact-reroll', async () => {
    artifactPolish.conflict.mockResolvedValue({ saveDc: 16 });
    artifactPolish.reroll.mockResolvedValue({ itemSlug: 'onda' });
    await handler.execute('u', 'c', {
      actionSlug: 'sentient-conflict',
      itemSlug: 'onda',
    });
    await handler.execute('u', 'c', {
      actionSlug: 'artifact-reroll',
      itemSlug: 'onda',
    });
    expect(artifactPolish.conflict).toHaveBeenCalledWith('u', 'c', 'onda');
    expect(artifactPolish.reroll).toHaveBeenCalledWith('u', 'c', 'onda');
  });

  it('rejects missing fields', async () => {
    await expect(
      handler.execute('u', 'c', { actionSlug: 'detach-coverage' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
