import { BadRequestException } from '@nestjs/common';
import { DEFAULT_ABILITY_SCORES, PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { CharacterFactory } from './character.factory';
import { UpdateCharacterDto } from '../../dto/update-character.dto';
import { BACKGROUND_BOOST_MODE_PLUS1X3, BACKGROUND_BOOST_MODE_PLUS2_PLUS1 } from '../origin/background-ability-boost';

const createDto = {
  name: 'Aldric',
  classSlug: 'fighter',
  speciesSlug: 'human',
  backgroundSlug: 'soldier',
};

function baseRow(): PlayerCharacter {
  return {
    id: '1',
    userId: 'u',
    name: 'Old',
    level: 3,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'soldier',
    subclassSlug: 'champion',
    alignmentSlug: null,
    abilityScores: DEFAULT_ABILITY_SCORES,
    hitPointsMax: 20,
    hitPointsCurrent: 15,
    abilityGenerationMethodSlug: 'standard-array',
    backgroundBoostMode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
    backgroundBoostPlus2AbilitySlug: 'forca',
    backgroundBoostPlus1AbilitySlug: 'destreza',
    backgroundBoostPlus1Slugs: null,
    backgroundToolItemSlug: null,
  } as PlayerCharacter;
}

describe('CharacterFactory', () => {
  describe('buildNew', () => {
    it('builds entity with defaults and explicit overrides', () => {
      expect(CharacterFactory.buildNew('user-1', createDto)).toMatchObject({
        userId: 'user-1',
        level: 1,
        subclassSlug: null,
        abilityScores: DEFAULT_ABILITY_SCORES,
        hitPointsCurrent: null,
      });
      expect(
        CharacterFactory.buildNew('user-1', {
          ...createDto,
          level: 5,
          subclassSlug: 'champion',
          hitPointsMax: 40,
          hitPointsCurrent: 35,
          backgroundToolItemSlug: 'thieves-tools',
        }),
      ).toMatchObject({ level: 5, hitPointsMax: 40, hitPointsCurrent: 35 });
    });

    it('maps plus1x3 background boost columns', () => {
      const result = CharacterFactory.buildNew('user-1', {
        ...createDto,
        backgroundAbilityBoostMode: BACKGROUND_BOOST_MODE_PLUS1X3,
        backgroundAbilityBoostPlus1Slugs: ['forca', 'destreza', 'constituicao'],
      });
      expect(result.backgroundBoostMode).toBe(BACKGROUND_BOOST_MODE_PLUS1X3);
      expect(result.backgroundBoostPlus1Slugs).toHaveLength(3);
      expect(result.backgroundBoostPlus2AbilitySlug).toBeNull();
    });
  });

  describe('assertLevel', () => {
    it.each([0, 21])('rejects level %i', (level) => {
      expect(() => CharacterFactory.assertLevel(level)).toThrow(BadRequestException);
    });

    it('accepts level in range', () => {
      expect(() => CharacterFactory.assertLevel(10)).not.toThrow();
    });
  });

  describe('withBackgroundBoostsApplied', () => {
    it('applies +2/+1 boosts to ability scores', () => {
      const entity = CharacterFactory.buildNew('u', createDto);
      const result = CharacterFactory.withBackgroundBoostsApplied(entity, {
        abilityScores: DEFAULT_ABILITY_SCORES,
        backgroundAbilityBoostMode: BACKGROUND_BOOST_MODE_PLUS2_PLUS1,
        backgroundAbilityBoostPlus2Slug: 'forca',
        backgroundAbilityBoostPlus1Slug: 'destreza',
      });
      expect(result.abilityScores).toEqual({ ...DEFAULT_ABILITY_SCORES, forca: 12, destreza: 11 });
    });
  });

  describe('withFeatAbilityBoostsApplied', () => {
    it('returns entity unchanged when abilityScores missing', () => {
      const entity = { userId: 'u', name: 'X' };
      expect(
        CharacterFactory.withFeatAbilityBoostsApplied(entity, [
          { featSlug: 'telekinetic', optionKey: 'abilityIncrease', valueId: 'inteligencia' },
        ]),
      ).toBe(entity);
    });

    it('applies feat ability increases', () => {
      const entity = { abilityScores: DEFAULT_ABILITY_SCORES };
      const result = CharacterFactory.withFeatAbilityBoostsApplied(entity, [
        { featSlug: 'telekinetic', optionKey: 'abilityIncrease', valueId: 'inteligencia' },
      ]);
      expect(result.abilityScores!.inteligencia).toBe(11);
    });
  });

  describe('applyUpdate', () => {
    it('updates scalar fields and coalesces null subclass', () => {
      const row = baseRow();
      CharacterFactory.applyUpdate(row, { name: 'New', level: 5, subclassSlug: null } as unknown as UpdateCharacterDto);
      expect(row).toMatchObject({ name: 'New', level: 5, subclassSlug: null });
    });

    it('merges partial background boost updates from row', () => {
      const row = baseRow();
      CharacterFactory.applyUpdate(row, { backgroundAbilityBoostPlus1Slug: 'constituicao' });
      expect(row.backgroundBoostPlus1AbilitySlug).toBe('constituicao');
      expect(row.backgroundBoostPlus2AbilitySlug).toBe('forca');
    });

    it('rejects invalid level on update', () => {
      expect(() => CharacterFactory.applyUpdate(baseRow(), { level: 99 })).toThrow(/Level must be between/i);
    });

    it('updates class/species/background fields and boost mode switch', () => {
      const row = baseRow();
      CharacterFactory.applyUpdate(row, {
        classSlug: 'wizard',
        speciesSlug: 'elf',
        backgroundSlug: 'sage',
        alignmentSlug: 'neutral',
        hitPointsMax: 30,
        hitPointsCurrent: 25,
        backgroundToolItemSlug: 'gaming-set',
        backgroundAbilityBoostMode: BACKGROUND_BOOST_MODE_PLUS1X3,
        backgroundAbilityBoostPlus1Slugs: ['forca', 'destreza', 'constituicao'],
      } as UpdateCharacterDto);
      expect(row).toMatchObject({
        classSlug: 'wizard',
        backgroundBoostMode: BACKGROUND_BOOST_MODE_PLUS1X3,
        backgroundBoostPlus1Slugs: ['forca', 'destreza', 'constituicao'],
        backgroundBoostPlus2AbilitySlug: null,
      });
    });
  });

  describe('boostModeOf / withBackgroundTool', () => {
    it.each([
      [BACKGROUND_BOOST_MODE_PLUS1X3, BACKGROUND_BOOST_MODE_PLUS1X3],
      [BACKGROUND_BOOST_MODE_PLUS2_PLUS1, BACKGROUND_BOOST_MODE_PLUS2_PLUS1],
    ])('boostModeOf(%s)', (mode, expected) => {
      expect(CharacterFactory.boostModeOf({ backgroundBoostMode: mode } as PlayerCharacter)).toBe(expected);
    });

    it('sets background tool slug', () => {
      expect(CharacterFactory.withBackgroundTool({ name: 'X' }, 'thieves-tools')).toEqual({
        name: 'X',
        backgroundToolItemSlug: 'thieves-tools',
      });
    });
  });
});
