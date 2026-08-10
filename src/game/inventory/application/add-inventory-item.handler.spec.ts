import { BadRequestException } from '@nestjs/common';
import { AddInventoryItemHandler } from './add-inventory-item.handler';

describe('AddInventoryItemHandler', () => {
  const character = {
    abilityScores: { forca: 12 },
    coinCopper: 0,
    coinSilver: 0,
    coinElectrum: 0,
    coinGold: 20,
    coinPlatinum: 0,
  };

  let access: { findAccessibleOrFail: jest.Mock };
  let campaignAccess: { resolveInventoryPaymentContext: jest.Mock };
  let catalogLookup: { assertItemInCatalog: jest.Mock };
  let inventory: { add: jest.Mock };
  let handler: AddInventoryItemHandler;

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue(character),
    };
    campaignAccess = {
      resolveInventoryPaymentContext: jest.fn(),
    };
    catalogLookup = {
      assertItemInCatalog: jest.fn().mockResolvedValue({
        slug: 'longsword',
        cost: { text: '15 PO' },
      }),
    };
    inventory = {
      add: jest.fn().mockResolvedValue({ itemSlug: 'longsword' }),
    };
    handler = new AddInventoryItemHandler(
      access as never,
      campaignAccess as never,
      catalogLookup as never,
      inventory as never,
    );
  });

  it('adds free when solo', async () => {
    campaignAccess.resolveInventoryPaymentContext.mockResolvedValue({
      inCampaign: false,
      viewerIsDmOrAssistant: false,
      allowPlayerSkipPayment: false,
    });

    await handler.execute('u1', 'ch1', { itemSlug: 'longsword' });

    expect(inventory.add).toHaveBeenCalledWith('ch1', { itemSlug: 'longsword' }, 12, {
      debit: null,
    });
  });

  it('adds free when DM gifts', async () => {
    campaignAccess.resolveInventoryPaymentContext.mockResolvedValue({
      inCampaign: true,
      viewerIsDmOrAssistant: true,
      allowPlayerSkipPayment: false,
    });

    await handler.execute('u1', 'ch1', { itemSlug: 'longsword' });

    expect(inventory.add).toHaveBeenCalledWith(
      'ch1',
      { itemSlug: 'longsword' },
      12,
      { debit: null },
    );
  });

  it('debits coins when player must pay', async () => {
    campaignAccess.resolveInventoryPaymentContext.mockResolvedValue({
      inCampaign: true,
      viewerIsDmOrAssistant: false,
      allowPlayerSkipPayment: false,
    });

    await handler.execute('u1', 'ch1', {
      itemSlug: 'longsword',
      quantity: 1,
    });

    expect(inventory.add).toHaveBeenCalledWith(
      'ch1',
      { itemSlug: 'longsword', quantity: 1 },
      12,
      {
        debit: {
          copper: 0,
          silver: 0,
          electrum: 0,
          gold: 15,
          platinum: 0,
        },
      },
    );
  });

  it('skips payment when allowed and pay=false', async () => {
    campaignAccess.resolveInventoryPaymentContext.mockResolvedValue({
      inCampaign: true,
      viewerIsDmOrAssistant: false,
      allowPlayerSkipPayment: true,
    });

    await handler.execute('u1', 'ch1', {
      itemSlug: 'longsword',
      pay: false,
    });

    expect(inventory.add).toHaveBeenCalledWith(
      'ch1',
      { itemSlug: 'longsword', pay: false },
      12,
      { debit: null },
    );
  });

  it('rejects magical items without catalog cost when paying', async () => {
    campaignAccess.resolveInventoryPaymentContext.mockResolvedValue({
      inCampaign: true,
      viewerIsDmOrAssistant: false,
      allowPlayerSkipPayment: false,
    });
    catalogLookup.assertItemInCatalog.mockResolvedValue({
      slug: 'bag-of-holding',
      cost: null,
    });

    await expect(
      handler.execute('u1', 'ch1', { itemSlug: 'bag-of-holding' }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(inventory.add).not.toHaveBeenCalled();
  });

  it('rejects insufficient balance', async () => {
    campaignAccess.resolveInventoryPaymentContext.mockResolvedValue({
      inCampaign: true,
      viewerIsDmOrAssistant: false,
      allowPlayerSkipPayment: false,
    });
    access.findAccessibleOrFail.mockResolvedValue({
      ...character,
      coinGold: 1,
    });

    await expect(
      handler.execute('u1', 'ch1', { itemSlug: 'longsword' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
