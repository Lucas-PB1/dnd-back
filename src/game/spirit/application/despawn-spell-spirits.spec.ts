import { despawnSpiritsOnConcentrationChange } from './despawn-spell-spirits';

describe('despawnSpiritsOnConcentrationChange', () => {
  it('não faz nada se não havia concentração prévia', async () => {
    const dataSource = { getRepository: jest.fn() } as never;
    await expect(
      despawnSpiritsOnConcentrationChange(dataSource, 'c1', null, 'bless'),
    ).resolves.toBe(0);
  });

  it('não faz nada se a magia não mudou', async () => {
    const dataSource = { getRepository: jest.fn() } as never;
    await expect(
      despawnSpiritsOnConcentrationChange(
        dataSource,
        'c1',
        'invocar-fera',
        'invocar-fera',
      ),
    ).resolves.toBe(0);
  });
});
