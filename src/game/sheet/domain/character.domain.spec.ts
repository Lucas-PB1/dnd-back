import {
  calculateHitPointsMax,
  hitPointsBonus,
  parseHitDieLabel,
} from './hit-points.calc';
import { abilityModifier } from './ability-modifier';

describe('Character domain (PHB)', () => {
  describe('abilityModifier', () => {
    it('returns 0 for score 10', () => {
      expect(abilityModifier(10)).toBe(0);
    });

    it('returns +2 for score 14', () => {
      expect(abilityModifier(14)).toBe(2);
    });
  });

  describe('calculateHitPointsMax', () => {
    const fighterProfile = { hpLevel1DieValue: 10, hpFixedPerLevel: 6 };
    const wizardProfile = { hpLevel1DieValue: 6, hpFixedPerLevel: 4 };

    it('fighter level 1 with CON 10 has 10 HP (d10)', () => {
      expect(calculateHitPointsMax(1, fighterProfile, 10)).toBe(10);
    });

    it('wizard level 1 with CON 10 has 6 HP (d6)', () => {
      expect(calculateHitPointsMax(1, wizardProfile, 10)).toBe(6);
    });

    it('fighter level 5 with CON 14 has 44 HP', () => {
      expect(calculateHitPointsMax(5, fighterProfile, 14)).toBe(44);
    });

    it('wizard level 3 with CON 12 has 17 HP', () => {
      expect(calculateHitPointsMax(3, wizardProfile, 12)).toBe(17);
    });

    it('enforces minimum 1 HP gain per level with negative CON mod', () => {
      expect(calculateHitPointsMax(2, fighterProfile, 6)).toBe(12);
    });
  });

  describe('hitPointsBonus', () => {
    it('is zero without permanent sources', () => {
      expect(hitPointsBonus(5, { speciesSlug: 'elf', featSlugs: ['alert'] })).toBe(0);
    });

    it('dwarf gains +1 per character level', () => {
      expect(hitPointsBonus(1, { speciesSlug: 'dwarf' })).toBe(1);
      expect(hitPointsBonus(7, { speciesSlug: 'dwarf' })).toBe(7);
    });

    it('draconic resilience only applies from sorcerer level 3', () => {
      expect(hitPointsBonus(2, { subclassSlug: 'draconic' })).toBe(0);
      expect(hitPointsBonus(3, { subclassSlug: 'draconic' })).toBe(3);
      expect(hitPointsBonus(10, { subclassSlug: 'draconic' })).toBe(10);
    });

    it('tough feat gains +2 per character level', () => {
      expect(hitPointsBonus(4, { featSlugs: ['tough'] })).toBe(8);
    });

    it('boon of fortitude adds a flat +40', () => {
      expect(hitPointsBonus(19, { featSlugs: ['boon-of-fortitude'] })).toBe(40);
    });

    it('stacks species, subclass and feats', () => {
      expect(
        hitPointsBonus(20, {
          speciesSlug: 'dwarf',
          subclassSlug: 'draconic',
          featSlugs: ['tough', 'boon-of-fortitude'],
        }),
      ).toBe(20 + 20 + 40 + 40);
    });

    it('counts a repeated feat slug only once', () => {
      expect(hitPointsBonus(4, { featSlugs: ['tough', 'tough'] })).toBe(8);
    });
  });

  describe('calculateHitPointsMax with permanent bonuses', () => {
    const fighterProfile = { hpLevel1DieValue: 10, hpFixedPerLevel: 6 };

    it('adds the dwarf tenacity to the class base', () => {
      expect(
        calculateHitPointsMax(5, fighterProfile, 14, { speciesSlug: 'dwarf' }),
      ).toBe(44 + 5);
    });

    it('adds the tough feat at level 1', () => {
      expect(
        calculateHitPointsMax(1, fighterProfile, 10, { featSlugs: ['tough'] }),
      ).toBe(12);
    });
  });

  describe('parseHitDieLabel', () => {
    it('parses D10', () => {
      expect(parseHitDieLabel('D10')).toBe(10);
    });

    it('parses d6', () => {
      expect(parseHitDieLabel('d6')).toBe(6);
    });
  });
});
