import { asDep } from '@common/testing/as-dep';
jest.mock('@game/sheet/infrastructure/queries/class-meta.queries', () => ({
  loadWeaponMasteryProgression: jest.fn(),
  loadWeaponMasteryEligibility: jest.fn(),
}));
jest.mock('@game/sheet/infrastructure/queries/class-option.queries', () => ({
  loadWeaponMasteryPiece: jest.fn(),
}));

import { DataSource } from 'typeorm';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { ClassProficienciesQuery } from '@catalog/classes/queries/class-proficiencies.query';
import { CharacterWeaponMasteryValidator } from './character-weapon-mastery.validator';
import { mockClassProficienciesQuery } from '../testing/class-validation.spec.helpers';
import {
  loadWeaponMasteryEligibility,
  loadWeaponMasteryProgression,
} from '@game/sheet/infrastructure/queries/class-meta.queries';
import { loadWeaponMasteryPiece } from '@game/sheet/infrastructure/queries/class-option.queries';

describe('CharacterWeaponMasteryValidator', () => {
  let validator: CharacterWeaponMasteryValidator;
  let dataSource: DataSource;
  let proficiencies: ReturnType<typeof mockClassProficienciesQuery>;

  const ctx: CharacterSheetContext = {
    classSlug: 'fighter',
    level: 4,
    backgroundSlug: 'soldier',
    speciesSlug: 'human',
    subclassSlug: null,
  };

  beforeEach(() => {
    dataSource = {} as DataSource;
    proficiencies = mockClassProficienciesQuery();
    validator = new CharacterWeaponMasteryValidator(dataSource, proficiencies.query);
  });

  function mockFighterQueries(weaponRow?: Record<string, unknown>) {
    jest.mocked(loadWeaponMasteryProgression).mockResolvedValue([
      { level: 1, weaponMastery: 0 },
      { level: 4, weaponMastery: 1 },
    ]);
    jest.mocked(loadWeaponMasteryEligibility).mockResolvedValue('any');
    jest.mocked(loadWeaponMasteryPiece).mockResolvedValue(asDep({
      slug: 'longsword',
      name: 'Longsword',
      category: 'martial',
      damage: '1d8',
      damageType: 'slashing',
      properties: { propertyIds: [] },
      masterySlug: 'sap',
      ...weaponRow,
    }));
  }

  it('allows empty mastery options', async () => {
    mockFighterQueries();
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, []),
    ).resolves.toBeUndefined();
  });

  it('rejects mastery when class has no slots at level', async () => {
    jest.mocked(loadWeaponMasteryProgression).mockResolvedValue([
      { level: 1, weaponMastery: 0 },
    ]);
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/no weapon mastery options/i);
  });

  it('accepts proficient weapon with mastery property', async () => {
    mockFighterQueries();
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).resolves.toBeUndefined();
  });

  it('rejects duplicate mastery picks', async () => {
    mockFighterQueries();
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/Duplicate class option keys/i);
  });

  it('rejects unknown weapon slug', async () => {
    mockFighterQueries();
    jest.mocked(loadWeaponMasteryPiece).mockResolvedValue(null);
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'not-a-weapon' },
      ]),
    ).rejects.toThrow(/not a valid weapon/i);
  });

  it('rejects weapon without mastery property', async () => {
    mockFighterQueries({ masterySlug: null });
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/no mastery property/i);
  });

  it('rejects ranged-only weapon for melee-eligible class', async () => {
    jest.mocked(loadWeaponMasteryEligibility).mockResolvedValue('melee');
    jest.mocked(loadWeaponMasteryProgression).mockResolvedValue([
      { level: 1, weaponMastery: 0 },
      { level: 4, weaponMastery: 1 },
    ]);
    jest.mocked(loadWeaponMasteryPiece).mockResolvedValue({
      slug: 'longbow',
      name: 'Longbow',
      category: 'martial',
      damage: '1d8',
      damageType: 'piercing',
      properties: { propertyIds: ['ammunition'] },
      masterySlug: 'slow',
    });
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longbow' },
      ]),
    ).rejects.toThrow(/melee weapon/i);
  });

  it('rejects weapon without proficiency', async () => {
    mockFighterQueries({ category: 'martial' });
    proficiencies.forClassSlug.mockResolvedValue({
      savingThrowSlugs: [],
      savingThrowNames: [],
      armorTrainingSlugs: [],
      armorTrainingNames: [],
      weaponProficiencySlugs: ['armas-simples'],
      weaponProficiencyNames: [],
      fightingStyleSlugs: [],
      fightingStyleNames: [],
    });
    await expect(
      validator.validateClassWeaponMasteryOptions(ctx, [
        { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      ]),
    ).rejects.toThrow(/requires proficiency/i);
  });
});
