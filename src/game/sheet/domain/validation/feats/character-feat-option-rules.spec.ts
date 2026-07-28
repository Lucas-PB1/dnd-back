import { BadRequestException } from '@nestjs/common';
import {
  validateAbilityScoreImprovement,
  validateLinkedCastingAbilityMatchesAsi,
  validateMagicInitiateSpellLists,
  validateRitualCasterSpells,
} from './character-feat-option-rules';
import {
  ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
  ASI_DISTRIBUTION_PLUS1PLUS1,
  ASI_DISTRIBUTION_PLUS2,
} from './ability-score-improvement-feat-options';
import { RITUAL_CASTER_FEAT_SLUG } from './ritual-caster-feat-options';
import type { CharacterFeatDto, FeatOptionDto } from '../../../dto/character-sheet.dto';

const asiFeat: CharacterFeatDto = {
  featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG,
  instanceIndex: 0,
};

describe('character-feat-option-rules', () => {
  describe('validateAbilityScoreImprovement', () => {
    it('rejects invalid distributionMode', () => {
      const options: FeatOptionDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'distributionMode', valueId: 'invalid' },
      ];
      expect(() => validateAbilityScoreImprovement([asiFeat], options)).toThrow(
        /Invalid distributionMode/i,
      );
    });

    it('rejects secondaryAbility when mode is +2', () => {
      const options: FeatOptionDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'distributionMode', valueId: ASI_DISTRIBUTION_PLUS2 },
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'secondaryAbility', valueId: 'destreza' },
      ];
      expect(() => validateAbilityScoreImprovement([asiFeat], options)).toThrow(
        /secondaryAbility is not used/i,
      );
    });

    it('rejects duplicate abilities for +1/+1', () => {
      const options: FeatOptionDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'distributionMode', valueId: ASI_DISTRIBUTION_PLUS1PLUS1 },
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'primaryAbility', valueId: 'forca' },
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'secondaryAbility', valueId: 'forca' },
      ];
      expect(() => validateAbilityScoreImprovement([asiFeat], options)).toThrow(
        /must be different abilities/i,
      );
    });

    it('accepts valid +2 distribution', () => {
      const options: FeatOptionDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'distributionMode', valueId: ASI_DISTRIBUTION_PLUS2 },
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'primaryAbility', valueId: 'forca' },
      ];
      expect(() => validateAbilityScoreImprovement([asiFeat], options)).not.toThrow();
    });

    it('accepts valid +1/+1 with distinct abilities', () => {
      const options: FeatOptionDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'distributionMode', valueId: ASI_DISTRIBUTION_PLUS1PLUS1 },
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'primaryAbility', valueId: 'forca' },
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, optionKey: 'secondaryAbility', valueId: 'destreza' },
      ];
      expect(() => validateAbilityScoreImprovement([asiFeat], options)).not.toThrow();
    });

    it('scopes options by instanceIndex', () => {
      const feats: CharacterFeatDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, instanceIndex: 1 },
      ];
      const options: FeatOptionDto[] = [
        { featSlug: ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG, instanceIndex: 0, optionKey: 'distributionMode', valueId: 'invalid' },
      ];
      expect(() => validateAbilityScoreImprovement(feats, options)).not.toThrow();
    });
  });

  describe('validateLinkedCastingAbilityMatchesAsi', () => {
    const telekinetic: CharacterFeatDto = { featSlug: 'telekinetic', instanceIndex: 0 };

    it('throws when casting ability differs from ASI', () => {
      const options: FeatOptionDto[] = [
        { featSlug: 'telekinetic', optionKey: 'abilityIncrease', valueId: 'inteligencia' },
        { featSlug: 'telekinetic', optionKey: 'castingAbility', valueId: 'carisma' },
      ];
      expect(() => validateLinkedCastingAbilityMatchesAsi([telekinetic], options)).toThrow(
        BadRequestException,
      );
    });

    it('skips when ASI or casting is missing', () => {
      expect(() =>
        validateLinkedCastingAbilityMatchesAsi([telekinetic], [
          { featSlug: 'telekinetic', optionKey: 'abilityIncrease', valueId: 'inteligencia' },
        ]),
      ).not.toThrow();
    });

    it('accepts matching abilities', () => {
      const options: FeatOptionDto[] = [
        { featSlug: 'telekinetic', optionKey: 'abilityIncrease', valueId: 'inteligencia' },
        { featSlug: 'telekinetic', optionKey: 'castingAbility', valueId: 'inteligencia' },
      ];
      expect(() => validateLinkedCastingAbilityMatchesAsi([telekinetic], options)).not.toThrow();
    });
  });

  describe('validateRitualCasterSpells', () => {
    const ritualFeat: CharacterFeatDto = { featSlug: RITUAL_CASTER_FEAT_SLUG, instanceIndex: 0 };

    it('rejects duplicate ritual spell choices', () => {
      const options: FeatOptionDto[] = [
        { featSlug: RITUAL_CASTER_FEAT_SLUG, optionKey: 'ritualSpell1', valueId: 'detect-magic' },
        { featSlug: RITUAL_CASTER_FEAT_SLUG, optionKey: 'ritualSpell2', valueId: 'detect-magic' },
      ];
      expect(() => validateRitualCasterSpells([ritualFeat], options, 2)).toThrow(/distinct/i);
    });

    it('rejects slots above proficiency bonus', () => {
      const options: FeatOptionDto[] = [
        { featSlug: RITUAL_CASTER_FEAT_SLUG, optionKey: 'ritualSpell3', valueId: 'identify' },
      ];
      expect(() => validateRitualCasterSpells([ritualFeat], options, 2)).toThrow(/allows 2 ritual/i);
    });

    it('skips incomplete ritual spell rows', () => {
      const options: FeatOptionDto[] = [
        { featSlug: RITUAL_CASTER_FEAT_SLUG, optionKey: 'ritualSpell1', valueId: '' },
      ];
      expect(() => validateRitualCasterSpells([ritualFeat], options, 2)).not.toThrow();
    });

    it('accepts valid ritual spell choices within proficiency bonus', () => {
      const options: FeatOptionDto[] = [
        { featSlug: RITUAL_CASTER_FEAT_SLUG, optionKey: 'ritualSpell1', valueId: 'detect-magic' },
        { featSlug: RITUAL_CASTER_FEAT_SLUG, optionKey: 'ritualSpell2', valueId: 'identify' },
      ];
      expect(() => validateRitualCasterSpells([ritualFeat], options, 2)).not.toThrow();
    });
  });

  describe('validateMagicInitiateSpellLists', () => {
    it('allows single instance without spell list check', () => {
      expect(() =>
        validateMagicInitiateSpellLists(
          [{ featSlug: 'magic-initiate', instanceIndex: 0 }],
          [],
        ),
      ).not.toThrow();
    });

    it('rejects duplicate spell lists across instances', () => {
      const feats: CharacterFeatDto[] = [
        { featSlug: 'magic-initiate', instanceIndex: 0 },
        { featSlug: 'magic-initiate', instanceIndex: 1 },
      ];
      const options: FeatOptionDto[] = [
        { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'spellList', valueId: 'cleric' },
        { featSlug: 'magic-initiate', instanceIndex: 1, optionKey: 'spellList', valueId: 'cleric' },
      ];
      expect(() => validateMagicInitiateSpellLists(feats, options)).toThrow(/different spell list/i);
    });

    it('skips when any instance lacks spellList', () => {
      const feats: CharacterFeatDto[] = [
        { featSlug: 'magic-initiate', instanceIndex: 0 },
        { featSlug: 'magic-initiate', instanceIndex: 1 },
      ];
      expect(() =>
        validateMagicInitiateSpellLists(feats, [
          { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'spellList', valueId: 'cleric' },
        ]),
      ).not.toThrow();
    });

    it('accepts distinct spell lists across instances', () => {
      const feats: CharacterFeatDto[] = [
        { featSlug: 'magic-initiate', instanceIndex: 0 },
        { featSlug: 'magic-initiate', instanceIndex: 1 },
      ];
      const options: FeatOptionDto[] = [
        { featSlug: 'magic-initiate', instanceIndex: 0, optionKey: 'spellList', valueId: 'cleric' },
        { featSlug: 'magic-initiate', instanceIndex: 1, optionKey: 'spellList', valueId: 'wizard' },
      ];
      expect(() => validateMagicInitiateSpellLists(feats, options)).not.toThrow();
    });
  });
});
