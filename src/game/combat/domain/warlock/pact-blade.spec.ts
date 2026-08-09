import {
  isMeleeWeaponFromPropertyIds,
  propertyIdsFromItemProperties,
} from './pact-blade';

describe('pact-blade melee heuristic', () => {
  it('treats ammunition without thrown as ranged-only', () => {
    expect(
      isMeleeWeaponFromPropertyIds(['ammunition', 'two-handed']),
    ).toBe(false);
  });

  it('allows thrown ammunition weapons as melee-eligible', () => {
    expect(
      isMeleeWeaponFromPropertyIds(['ammunition', 'thrown']),
    ).toBe(true);
  });

  it('allows plain melee weapons', () => {
    expect(isMeleeWeaponFromPropertyIds(['versatile', 'finesse'])).toBe(true);
    expect(isMeleeWeaponFromPropertyIds([])).toBe(true);
  });

  it('reads propertyIds from item properties', () => {
    expect(
      propertyIdsFromItemProperties({ propertyIds: ['finesse', 1, 'light'] }),
    ).toEqual(['finesse', 'light']);
    expect(propertyIdsFromItemProperties(null)).toEqual([]);
  });
});
