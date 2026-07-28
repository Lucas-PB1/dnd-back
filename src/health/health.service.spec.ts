import { DataSource } from 'typeorm';
import { HealthService } from './health.service';

describe('HealthService', () => {
  const dataSource = { query: jest.fn() } as unknown as DataSource;
  const service = new HealthService(dataSource);

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('returns ok when database responds', async () => {
    dataSource.query = jest.fn().mockResolvedValue([{ '?column?': 1 }]);

    await expect(service.check()).resolves.toEqual({
      status: 'ok',
      db: 'connected',
    });
    expect(dataSource.query).toHaveBeenCalledWith('SELECT 1');
  });

  it('returns degraded when database query fails', async () => {
    dataSource.query = jest
      .fn()
      .mockRejectedValue(new Error('connection refused'));

    await expect(service.check()).resolves.toEqual({
      status: 'degraded',
      db: 'disconnected',
    });
  });
});
