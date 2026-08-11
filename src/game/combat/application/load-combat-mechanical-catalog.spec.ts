import { LoadCombatMechanicalCatalog } from './load-combat-mechanical-catalog';

function emptyFindRepo() {
  return { find: jest.fn().mockResolvedValue([]) };
}

describe('LoadCombatMechanicalCatalog cache', () => {
  function createService() {
    const gunslingerRepo = emptyFindRepo();
    const battleMasterRepo = emptyFindRepo();
    const cunningRepo = emptyFindRepo();
    const tableActionRepo = emptyFindRepo();
    const personaMaskRepo = emptyFindRepo();
    const beastborneRepo = emptyFindRepo();
    const slayerRepo = emptyFindRepo();
    const precautionRepo = emptyFindRepo();
    const economyRepo = emptyFindRepo();
    const panelRepo = emptyFindRepo();

    const service = new LoadCombatMechanicalCatalog(
      gunslingerRepo as never,
      battleMasterRepo as never,
      cunningRepo as never,
      tableActionRepo as never,
      personaMaskRepo as never,
      beastborneRepo as never,
      slayerRepo as never,
      precautionRepo as never,
      economyRepo as never,
      panelRepo as never,
    );

    return {
      service,
      gunslingerRepo,
      economyRepo,
      panelRepo,
    };
  }

  it('hits DB once for concurrent and sequential loads within TTL', async () => {
    const { service, gunslingerRepo, economyRepo } = createService();

    const [a, b] = await Promise.all([service.load(), service.load()]);
    expect(a).toBe(b);
    expect(gunslingerRepo.find).toHaveBeenCalledTimes(1);
    expect(economyRepo.find).toHaveBeenCalledTimes(1);

    await service.load();
    expect(gunslingerRepo.find).toHaveBeenCalledTimes(1);
  });

  it('clearCache forces a new DB load', async () => {
    const { service, gunslingerRepo } = createService();
    await service.load();
    service.clearCache();
    await service.load();
    expect(gunslingerRepo.find).toHaveBeenCalledTimes(2);
  });
});
