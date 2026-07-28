jest.mock('./update-character/apply-background-and-identity-update', () => ({
  applyBackgroundAndIdentityUpdate: jest.fn(),
}));
jest.mock('./update-character/clear-stale-sheet-choices', () => ({
  clearStaleSheetChoices: jest.fn(),
}));
jest.mock('./update-character/merge-update-character-spells', () => ({
  mergeUpdateCharacterSpells: jest.fn(),
}));

import { UpdateCharacterHandler } from './update-character.handler';
import { applyBackgroundAndIdentityUpdate } from './update-character/apply-background-and-identity-update';
import { clearStaleSheetChoices } from './update-character/clear-stale-sheet-choices';
import { mergeUpdateCharacterSpells } from './update-character/merge-update-character-spells';
import { EMPTY_SHEET_DATA } from '../domain/character-sheet.types';
import { DEFAULT_ABILITY_SCORES, type PlayerCharacter } from '../../shared/infrastructure/player-character.entity';

const mockApplyBackground = applyBackgroundAndIdentityUpdate as jest.MockedFunction<typeof applyBackgroundAndIdentityUpdate>;
const mockClearStale = clearStaleSheetChoices as jest.MockedFunction<typeof clearStaleSheetChoices>;
const mockMergeSpells = mergeUpdateCharacterSpells as jest.MockedFunction<typeof mergeUpdateCharacterSpells>;

function character(overrides: Partial<PlayerCharacter> = {}): PlayerCharacter {
  return {
    id: 'ch1',
    userId: 'u1',
    name: 'Aragorn',
    level: 3,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'soldier',
    subclassSlug: 'champion',
    alignmentSlug: null,
    abilityScores: DEFAULT_ABILITY_SCORES,
    hitPointsMax: 28,
    hitPointsCurrent: 28,
    abilityGenerationMethodSlug: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  } as PlayerCharacter;
}

describe('UpdateCharacterHandler', () => {
  let catalogLookup: { validateCharacterCatalogRefs: jest.Mock };
  let sheetValidator: {
    validateLevelRules: jest.Mock;
    validateSheetInput: jest.Mock;
    validateFeatOptions: jest.Mock;
    validateFightingStyleSelections: jest.Mock;
  };
  let domain: { refreshHitPointsAfterChange: jest.Mock };
  let repository: { findAccessibleOrFail: jest.Mock; save: jest.Mock };
  let sheetRepository: { load: jest.Mock; sync: jest.Mock };
  let mapper: { toDto: jest.Mock };
  let seedStartingInventory: { execute: jest.Mock };
  let grantedSpellCatalog: Record<string, never>;
  let handler: UpdateCharacterHandler;

  beforeEach(() => {
    catalogLookup = { validateCharacterCatalogRefs: jest.fn() };
    sheetValidator = {
      validateLevelRules: jest.fn(),
      validateSheetInput: jest.fn(),
      validateFeatOptions: jest.fn(),
      validateFightingStyleSelections: jest.fn(),
    };
    domain = { refreshHitPointsAfterChange: jest.fn() };
    repository = {
      findAccessibleOrFail: jest.fn(),
      save: jest.fn(async (row) => row),
    };
    sheetRepository = {
      load: jest.fn().mockResolvedValue(EMPTY_SHEET_DATA),
      sync: jest.fn(),
    };
    mapper = { toDto: jest.fn((row) => ({ id: row.id, name: row.name, level: row.level })) };
    seedStartingInventory = { execute: jest.fn() };
    grantedSpellCatalog = {};
    mockApplyBackground.mockImplementation(async ({ row, dto }) => {
      if (dto.name !== undefined) row.name = dto.name;
    });
    mockClearStale.mockResolvedValue(undefined);
    mockMergeSpells.mockResolvedValue(undefined);
    handler = new UpdateCharacterHandler(
      catalogLookup as never,
      sheetValidator as never,
      domain as never,
      repository as never,
      sheetRepository as never,
      mapper as never,
      seedStartingInventory as never,
      grantedSpellCatalog as never,
    );
  });

  it('applies identity patch, syncs sheet and returns dto', async () => {
    const row = character();
    repository.findAccessibleOrFail.mockResolvedValue(row);

    const result = await handler.execute('u1', 'ch1', { name: 'Strider' });

    expect(repository.findAccessibleOrFail).toHaveBeenCalledWith('u1', 'ch1', 'write');
    expect(sheetValidator.validateLevelRules).toHaveBeenCalled();
    expect(sheetValidator.validateSheetInput).toHaveBeenCalled();
    expect(mockClearStale).toHaveBeenCalled();
    expect(mockApplyBackground).toHaveBeenCalled();
    expect(domain.refreshHitPointsAfterChange).toHaveBeenCalled();
    expect(repository.save).toHaveBeenCalledWith(row);
    expect(sheetRepository.sync).toHaveBeenCalledWith('ch1', expect.any(Object));
    expect(mockMergeSpells).not.toHaveBeenCalled();
    expect(result).toMatchObject({ id: 'ch1', name: 'Strider' });
  });

  it('resyncs spells and seeds inventory on level/equipment changes', async () => {
    const row = character();
    repository.findAccessibleOrFail.mockResolvedValue(row);

    await handler.execute('u1', 'ch1', {
      level: 4,
      classSlug: 'wizard',
      speciesSlug: 'elf',
      subclassSlug: 'evoker',
      equipment: [{ itemSlug: 'dagger', quantity: 1, source: 'background', packageSlug: 'a' }],
    });

    expect(catalogLookup.validateCharacterCatalogRefs).toHaveBeenCalled();
    expect(mockMergeSpells).toHaveBeenCalledWith(
      expect.objectContaining({ grantedSpellCatalog }),
    );
    expect(seedStartingInventory.execute).toHaveBeenCalledWith('ch1', [
      { itemSlug: 'dagger', quantity: 1, source: 'background', packageSlug: 'a' },
    ]);
  });

  it.each([
    ['alignment-only', { alignmentSlug: 'chaotic-neutral' }, true],
    ['identity-only', { name: 'Only Name' }, false],
  ])('%s catalog validation', async (_label, dto, shouldValidate) => {
    repository.findAccessibleOrFail.mockResolvedValue(
      character({ alignmentSlug: 'lawful-good' }),
    );
    await handler.execute('u1', 'ch1', dto);
    if (shouldValidate) {
      expect(catalogLookup.validateCharacterCatalogRefs).toHaveBeenCalled();
    } else {
      expect(catalogLookup.validateCharacterCatalogRefs).not.toHaveBeenCalled();
    }
  });

  it('validates feat options and resyncs spells on feat changes', async () => {
    repository.findAccessibleOrFail.mockResolvedValue(character());
    await handler.execute('u1', 'ch1', {
      characterFeats: [{ featSlug: 'great-weapon-master', instanceIndex: 0 }],
      featOptions: [{ featSlug: 'alert', optionKey: 'x', valueId: 'y' }],
      subclassOptions: [{ optionKey: 'fighting-style', valueId: 'defense' }],
    });
    expect(sheetValidator.validateFeatOptions).toHaveBeenCalled();
    expect(sheetValidator.validateFightingStyleSelections).toHaveBeenCalled();
    expect(mockMergeSpells).toHaveBeenCalled();
  });

  it('injects snapshot featOptions into validation after spell resync', async () => {
    const snapshotOptions = [{ featSlug: 'alert', optionKey: 'a', valueId: 'b' }];
    sheetRepository.load.mockResolvedValue({
      ...EMPTY_SHEET_DATA,
      featOptions: snapshotOptions,
    });
    repository.findAccessibleOrFail.mockResolvedValue(character());
    await handler.execute('u1', 'ch1', {
      level: 4,
      characterFeats: [{ featSlug: 'alert', instanceIndex: 0 }],
    });
    expect(sheetValidator.validateSheetInput).toHaveBeenCalledWith(
      expect.objectContaining({ featOptions: snapshotOptions }),
      expect.any(Object),
    );
  });

  it('reports ability and feat changes to domain HP refresh', async () => {
    const row = character();
    repository.findAccessibleOrFail.mockResolvedValue(row);
    await handler.execute('u1', 'ch1', {
      abilityScores: { ...row.abilityScores, forca: 18 },
      characterFeats: [{ featSlug: 'tough', instanceIndex: 0 }],
    });
    expect(domain.refreshHitPointsAfterChange).toHaveBeenCalledWith(
      row,
      expect.any(Object),
      expect.objectContaining({ abilityScores: true, characterFeats: true }),
      ['tough'],
    );
  });
});
