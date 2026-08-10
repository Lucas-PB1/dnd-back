import {
  applyCoinPatch,
  debitCoins,
  EMPTY_COIN_PURSE,
  parseCostText,
  resolveInventoryPayment,
  scaleCoinPurse,
} from './coin-purse';

describe('coin-purse', () => {
  it('parses single and multi coin cost texts', () => {
    expect(parseCostText('15 PO')).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 15,
    });
    expect(parseCostText('5 PP')).toEqual({
      ...EMPTY_COIN_PURSE,
      silver: 5,
    });
    expect(parseCostText('2 PO 5 PC')).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 2,
      copper: 5,
    });
    expect(parseCostText('1 PL')).toEqual({
      ...EMPTY_COIN_PURSE,
      platinum: 1,
    });
  });

  it('rejects missing or unparsable cost', () => {
    expect(() => parseCostText(null)).toThrow(/no catalog price/);
    expect(() => parseCostText('barato')).toThrow(/Cannot parse/);
  });

  it('debits without cross-coin exchange', () => {
    const balance = { ...EMPTY_COIN_PURSE, gold: 10, silver: 2 };
    expect(debitCoins(balance, { ...EMPTY_COIN_PURSE, gold: 3 })).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 7,
      silver: 2,
    });
    expect(() =>
      debitCoins(balance, { ...EMPTY_COIN_PURSE, gold: 11 }),
    ).toThrow(/Insufficient gold/);
  });

  it('scales cost by quantity', () => {
    expect(scaleCoinPurse({ ...EMPTY_COIN_PURSE, gold: 5 }, 3)).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 15,
    });
  });

  it('patches coin balances', () => {
    expect(
      applyCoinPatch({ ...EMPTY_COIN_PURSE, gold: 1 }, { copper: 4 }),
    ).toEqual({ ...EMPTY_COIN_PURSE, gold: 1, copper: 4 });
  });

  it('resolves payment rules', () => {
    expect(
      resolveInventoryPayment({
        inCampaign: false,
        viewerIsDmOrAssistant: false,
        allowPlayerSkipPayment: false,
        pay: true,
      }),
    ).toEqual({ mustPay: false, reason: 'solo' });

    expect(
      resolveInventoryPayment({
        inCampaign: true,
        viewerIsDmOrAssistant: true,
        allowPlayerSkipPayment: false,
        pay: true,
      }),
    ).toEqual({ mustPay: false, reason: 'gift' });

    expect(
      resolveInventoryPayment({
        inCampaign: true,
        viewerIsDmOrAssistant: false,
        allowPlayerSkipPayment: true,
        pay: false,
      }),
    ).toEqual({ mustPay: false, reason: 'skip' });

    expect(
      resolveInventoryPayment({
        inCampaign: true,
        viewerIsDmOrAssistant: false,
        allowPlayerSkipPayment: false,
        pay: false,
      }),
    ).toEqual({ mustPay: true });
  });
});
