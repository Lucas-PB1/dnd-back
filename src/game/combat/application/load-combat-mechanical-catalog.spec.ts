import { asDep } from '@common/testing/as-dep';
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
    const optionValueRepo = emptyFindRepo();
    const subclassRepo = {
      findOne: jest.fn().mockResolvedValue(null),
    };
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([]),
    };

    const service = new LoadCombatMechanicalCatalog(
      asDep(gunslingerRepo),
      asDep(battleMasterRepo),
      asDep(cunningRepo),
      asDep(tableActionRepo),
      asDep(personaMaskRepo),
      asDep(beastborneRepo),
      asDep(slayerRepo),
      asDep(precautionRepo),
      asDep(economyRepo),
      asDep(panelRepo),
      asDep(optionValueRepo),
      asDep(subclassRepo),
      asDep(effectCatalog),
      asDep({ query: jest.fn().mockResolvedValue([]) }),
    );

    return {
      service,
      gunslingerRepo,
      economyRepo,
      panelRepo,
      effectCatalog,
    };
  }

  it('hits DB once for concurrent and sequential loads within TTL', async () => {
    const { service, gunslingerRepo, economyRepo, effectCatalog } =
      createService();

    const [a, b] = await Promise.all([service.load(), service.load()]);
    expect(a).toBe(b);
    expect(gunslingerRepo.find).toHaveBeenCalledTimes(1);
    expect(economyRepo.find).toHaveBeenCalledTimes(1);
    expect(effectCatalog.load).toHaveBeenCalledTimes(1);

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
