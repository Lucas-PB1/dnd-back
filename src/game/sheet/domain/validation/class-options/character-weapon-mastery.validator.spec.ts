import { DataSource } from 'typeorm';
import { CharacterSheetContext } from '../../character-sheet.types';
import { CharacterWeaponMasteryValidator } from './character-weapon-mastery.validator';

describe('CharacterWeaponMasteryValidator', () => {
  let validator: CharacterWeaponMasteryValidator;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;

  const ctx: CharacterSheetContext = {
    classSlug: 'fighter',
    level: 4,
    backgroundSlug: 'soldier',
    speciesSlug: 'human',
    subclassSlug: null,
  };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterWeaponMasteryValidator(
      dataSource as unknown as DataSource,
    );
  });

  function mockFighterQueries(weaponRow?: Record<string, unknown>) {
    dataSource.query.mockImplementation((sql: string) => {
      if (sql.includes('phb_class_progression')) {
        return Promise.resolve([
          { level: 1, weaponMastery: 0 },
          { level: 4, weaponMastery: 1 },
        ]);
      }
      if (sql.includes('weapon_mastery_eligibility')) {
        return Promise.resolve([{ weapon_mastery_eligibility: 'any' }]);
      }
      if (sql.includes('phb_class_proficiency') && sql.includes('weapon')) {
        return Promise.resolve([
          { slug: 'armas-simples' },
          { slug: 'armas-marciais' },
        ]);
      }
      if (sql.includes('phb_weapon w')) {
        return Promise.resolve([
          weaponRow ?? {
            slug: 'longsword',
            name: 'Longsword',
            category: 'martial',
            damage: '1d8',
            damage_type: 'slashing',
            properties: { propertyIds: [] },
            mastery_slug: 'sap',
          },
        ]);
      }
      return Promise.resolve([]);
    });
  }

  it('rejects mastery options when class has none at level', async () => {
    dataSource.query.mockResolvedValue([]);

    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/no weapon mastery options/i);
  });

  it('accepts valid unlocked mastery choice', async () => {
    mockFighterQueries();

    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).resolves.toBeUndefined();
  });

  it('rejects option key not unlocked at level', async () => {
    mockFighterQueries();

    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon2', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/not unlocked/i);
  });

  it('rejects duplicate weapon mastery choices', async () => {
    dataSource.query.mockImplementation((sql: string) => {
      if (sql.includes('phb_class_progression')) {
        return Promise.resolve([
          { level: 1, weaponMastery: 0 },
          { level: 4, weaponMastery: 2 },
        ]);
      }
      if (sql.includes('weapon_mastery_eligibility')) {
        return Promise.resolve([{ weapon_mastery_eligibility: 'any' }]);
      }
      if (sql.includes('phb_class_proficiency') && sql.includes('weapon')) {
        return Promise.resolve([
          { slug: 'armas-simples' },
          { slug: 'armas-marciais' },
        ]);
      }
      if (sql.includes('phb_weapon w')) {
        return Promise.resolve([
          {
            slug: 'longsword',
            name: 'Longsword',
            category: 'martial',
            damage: '1d8',
            damage_type: 'slashing',
            properties: { propertyIds: [] },
            mastery_slug: 'sap',
          },
        ]);
      }
      return Promise.resolve([]);
    });

    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
        { optionKey: 'masteryWeapon2', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/must be distinct/i);
  });

  it('rejects weapon without mastery property', async () => {
    mockFighterQueries({
      slug: 'club',
      name: 'Club',
      category: 'simple',
      damage: '1d4',
      damage_type: 'bludgeoning',
      properties: { propertyIds: [] },
      mastery_slug: null,
    });

    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'club' },
      ]),
    ).rejects.toThrow(/has no mastery property/i);
  });

  it('rejects unknown weapon slug', async () => {
    dataSource.query.mockImplementation((sql: string) => {
      if (sql.includes('phb_class_progression')) {
        return Promise.resolve([{ level: 4, weaponMastery: 1 }]);
      }
      if (sql.includes('weapon_mastery_eligibility')) {
        return Promise.resolve([{ weapon_mastery_eligibility: 'any' }]);
      }
      if (sql.includes('phb_class_proficiency') && sql.includes('weapon')) {
        return Promise.resolve([{ slug: 'simple-weapons' }]);
      }
      if (sql.includes('phb_weapon w')) return Promise.resolve([]);
      return Promise.resolve([]);
    });

    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'fake-weapon' },
      ]),
    ).rejects.toThrow(/not a valid weapon/i);
  });
});
