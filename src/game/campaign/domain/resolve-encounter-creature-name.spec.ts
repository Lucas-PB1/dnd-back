import { resolveEncounterCreatureName } from '../domain/resolve-encounter-creature-name';

describe('resolveEncounterCreatureName', () => {
  it('uses override for a single creature', () => {
    expect(
      resolveEncounterCreatureName({
        templateName: 'Goblin',
        index: 1,
        count: 1,
        nameOverride: 'Boss',
      }),
    ).toBe('Boss');
  });

  it('suffixes index when spawning multiples', () => {
    expect(
      resolveEncounterCreatureName({
        templateName: 'Goblin',
        index: 2,
        count: 3,
        nameOverride: null,
      }),
    ).toBe('Goblin #2');
  });
});
