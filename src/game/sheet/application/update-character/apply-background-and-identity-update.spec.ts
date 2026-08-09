import { applyBackgroundAndIdentityUpdate } from './apply-background-and-identity-update';
import { DEFAULT_ABILITY_SCORES, PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  BACKGROUND_BOOST_MODE_PLUS1X3,
  BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
} from '@game/sheet/domain/origin/background-ability-boost';
import type { CatalogLookupService } from '@catalog/catalog-lookup.service';
import type { CharacterSheetValidator } from '@game/sheet/domain/validation/character-sheet.validator';

function row(): PlayerCharacter {
  return {
    id: '1',
    userId: 'u',
    name: 'Hero',
    level: 1,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'soldier',
    subclassSlug: null,
    alignmentSlug: null,
    abilityScores: DEFAULT_ABILITY_SCORES,
    hitPointsMax: 10,
    hitPointsCurrent: 10,
    abilityGenerationMethodSlug: null,
    backgroundBoostMode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
    backgroundBoostPlus2AbilitySlug: 'forca',
    backgroundBoostPlus1AbilitySlug: 'destreza',
    backgroundBoostPlus1Slugs: null,
    backgroundToolItemSlug: 'gaming-set',
  } as PlayerCharacter;
}

describe('applyBackgroundAndIdentityUpdate', () => {
  let catalogLookup: { findBackgroundOrFail: jest.Mock };
  let sheetValidator: {
    validateBackgroundToolChoice: jest.Mock;
    validateBackgroundAbilityBoosts: jest.Mock;
  };

  beforeEach(() => {
    catalogLookup = {
      findBackgroundOrFail: jest.fn().mockResolvedValue({
        toolProficiencyKind: 'choice',
        toolItemSlug: null,
      }),
    };
    sheetValidator = {
      validateBackgroundToolChoice: jest.fn().mockResolvedValue(undefined),
      validateBackgroundAbilityBoosts: jest.fn().mockResolvedValue(undefined),
    };
  });

  it('resets boost columns when background changes without boost patch', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: { backgroundSlug: 'sage' },
      effective: { backgroundSlug: 'sage' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: true,
    });
    expect(entity.backgroundBoostMode).toBe('plus2plus1');
    expect(entity.backgroundBoostPlus2AbilitySlug).toBeNull();
    expect(entity.backgroundBoostPlus1Slugs).toBeNull();
  });

  it('clears background tool when background changes and dto omits tool', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: { backgroundSlug: 'sage' },
      effective: { backgroundSlug: 'sage' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: true,
    });
    expect(entity.backgroundToolItemSlug).toBeNull();
  });

  it('validates and applies background tool choice', async () => {
    const entity = row();
    catalogLookup.findBackgroundOrFail.mockResolvedValue({
      toolProficiencyKind: 'fixed',
      toolItemSlug: 'thieves-tools',
    });
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: { backgroundToolItemSlug: 'ignored' },
      effective: { backgroundSlug: 'soldier' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: false,
    });
    expect(sheetValidator.validateBackgroundToolChoice).toHaveBeenCalledWith(
      expect.any(Object),
      'thieves-tools',
    );
    expect(entity.backgroundToolItemSlug).toBe('thieves-tools');
  });

  it('validates boosts and applies base scores when boost patch includes abilityScores', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: {
        backgroundAbilityBoostMode: BACKGROUND_BOOST_MODE_PLUS1X3,
        backgroundAbilityBoostPlus1Slugs: ['forca', 'destreza', 'constituicao'],
        abilityScores: DEFAULT_ABILITY_SCORES,
      },
      effective: { backgroundSlug: 'soldier' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: false,
    });
    expect(sheetValidator.validateBackgroundAbilityBoosts).toHaveBeenCalled();
    expect(entity.abilityScores).toEqual({
      ...DEFAULT_ABILITY_SCORES,
      forca: 11,
      destreza: 11,
      constituicao: 11,
    });
  });

  it('applies dto fields without recomputing scores when boost patch lacks abilityScores', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: {
        name: 'Renamed',
        backgroundAbilityBoostPlus1Slug: 'constituicao',
      },
      effective: { backgroundSlug: 'soldier' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: false,
    });
    expect(entity.name).toBe('Renamed');
    expect(entity.backgroundBoostPlus1AbilitySlug).toBe('constituicao');
    expect(sheetValidator.validateBackgroundAbilityBoosts).toHaveBeenCalled();
    expect(entity.abilityScores).toEqual(DEFAULT_ABILITY_SCORES);
  });

  it('preserves boost columns when background unchanged without boost patch', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: { name: 'Same' },
      effective: { backgroundSlug: 'soldier' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: false,
    });
    expect(entity.backgroundBoostPlus2AbilitySlug).toBe('forca');
    expect(entity.backgroundToolItemSlug).toBe('gaming-set');
  });

  it('keeps tool slug when background changes but dto includes tool', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: { backgroundToolItemSlug: 'thieves-tools' },
      effective: { backgroundSlug: 'criminal' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: true,
    });
    expect(entity.backgroundToolItemSlug).toBe('thieves-tools');
    expect(sheetValidator.validateBackgroundToolChoice).toHaveBeenCalled();
  });

  it('skips boost validation when dto has no boost fields', async () => {
    const entity = row();
    await applyBackgroundAndIdentityUpdate({
      row: entity,
      dto: { name: 'Renamed' },
      effective: { backgroundSlug: 'soldier' },
      catalogLookup: catalogLookup as unknown as CatalogLookupService,
      sheetValidator: sheetValidator as unknown as CharacterSheetValidator,
      backgroundChanged: false,
    });
    expect(sheetValidator.validateBackgroundAbilityBoosts).not.toHaveBeenCalled();
  });
});
