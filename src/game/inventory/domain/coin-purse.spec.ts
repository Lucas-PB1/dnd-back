import {
  applyCoinPatch,
  copperToPurse,
  debitCoins,
  debitCoinsWithExchange,
  EMPTY_COIN_PURSE,
  halfCoinPurseValue,
  parseCostText,
  purseToCopper,
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

  it('parses Brazilian thousand separators', () => {
    expect(parseCostText('1.500 PO')).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 1500,
    });
    expect(parseCostText('1.000 PO')).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 1000,
    });
    expect(parseCostText('40.000 PO')).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 40000,
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

  it('converts purse to copper and back (greedy)', () => {
    expect(purseToCopper({ ...EMPTY_COIN_PURSE, gold: 1 })).toBe(100);
    expect(purseToCopper({ ...EMPTY_COIN_PURSE, platinum: 1 })).toBe(1000);
    expect(copperToPurse(1155)).toEqual({
      platinum: 1,
      gold: 1,
      electrum: 1,
      silver: 0,
      copper: 5,
    });
  });

  it('debits with exchange across denominations', () => {
    const balance = { ...EMPTY_COIN_PURSE, platinum: 2 };
    const cost = { ...EMPTY_COIN_PURSE, gold: 15 };
    expect(debitCoinsWithExchange(balance, cost)).toEqual({
      ...EMPTY_COIN_PURSE,
      platinum: 0,
      gold: 5,
    });
    expect(() =>
      debitCoinsWithExchange(
        { ...EMPTY_COIN_PURSE, silver: 5 },
        { ...EMPTY_COIN_PURSE, gold: 1 },
      ),
    ).toThrow(/Insufficient coins/);
  });

  it('halves catalog value for selling', () => {
    expect(halfCoinPurseValue({ ...EMPTY_COIN_PURSE, gold: 15 })).toEqual({
      ...EMPTY_COIN_PURSE,
      gold: 7,
      electrum: 1,
    });
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
