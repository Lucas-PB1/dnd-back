import { BadRequestException } from '@nestjs/common';
import { CharacterDomainService } from './character-domain.service';
import { DEFAULT_ABILITY_SCORES, PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import type { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import type { CombatCatalogService } from '../../../combat/infrastructure/combat-catalog.service';

describe('CharacterDomainService', () => {
  let catalogLookup: { findClassOrFail: jest.Mock };
  let combatCatalog: { loadHitPointsBonusSources: jest.Mock };
  let characterLevelsRepo: { findOne: jest.Mock };
  let service: CharacterDomainService;

  beforeEach(() => {
    catalogLookup = {
      findClassOrFail: jest.fn().mockResolvedValue({
        hitDie: 'd10',
        hpLevel1DieValue: 10,
        hpFixedPerLevel: 6,
      }),
    };
    combatCatalog = { loadHitPointsBonusSources: jest.fn().mockResolvedValue([]) };
    characterLevelsRepo = {
      findOne: jest.fn().mockResolvedValue({ level: 3, proficiencyBonus: 2 }),
    };
    service = new CharacterDomainService(
      catalogLookup as unknown as CatalogLookupService,
      combatCatalog as unknown as CombatCatalogService,
      characterLevelsRepo as never,
    );
  });

  describe('getProficiencyBonus', () => {
    it('returns catalog proficiency bonus', async () => {
      await expect(service.getProficiencyBonus(3)).resolves.toBe(2);
    });

    it('throws when level row missing', async () => {
      characterLevelsRepo.findOne.mockResolvedValue(null);
      await expect(service.getProficiencyBonus(99)).rejects.toThrow(BadRequestException);
    });
  });

  describe('classHpProfile', () => {
    it('uses explicit hpLevel1DieValue when present', () => {
      const profile = service.classHpProfile({
        hitDie: 'd8',
        hpLevel1DieValue: 8,
        hpFixedPerLevel: 5,
      } as never);
      expect(profile).toEqual({ hpLevel1DieValue: 8, hpFixedPerLevel: 5 });
    });

    it('derives die and fixed gain from hitDie label', () => {
      const profile = service.classHpProfile({ hitDie: 'd12', hpLevel1DieValue: null, hpFixedPerLevel: null } as never);
      expect(profile).toEqual({ hpLevel1DieValue: 12, hpFixedPerLevel: 7 });
    });
  });

  describe('applyDerivedHitPoints', () => {
    function row(overrides: Partial<PlayerCharacter> = {}): PlayerCharacter {
      return {
        level: 3,
        classSlug: 'fighter',
        speciesSlug: 'human',
        subclassSlug: null,
        abilityScores: DEFAULT_ABILITY_SCORES,
        hitPointsMax: null,
        hitPointsCurrent: null,
        ...overrides,
      } as PlayerCharacter;
    }

    it('uses explicit hitPointsMax override', async () => {
      const entity = row();
      await service.applyDerivedHitPoints(entity, { hitPointsMax: 42 });
      expect(entity.hitPointsMax).toBe(42);
      expect(catalogLookup.findClassOrFail).not.toHaveBeenCalled();
    });

    it('calculates max HP when null and sets current to max', async () => {
      const entity = row();
      await service.applyDerivedHitPoints(entity);
      expect(entity.hitPointsMax).toBeGreaterThan(0);
      expect(entity.hitPointsCurrent).toBe(entity.hitPointsMax);
    });

    it('honors explicit hitPointsCurrent override', async () => {
      const entity = row({ hitPointsMax: 30 });
      await service.applyDerivedHitPoints(entity, { hitPointsCurrent: 12 });
      expect(entity.hitPointsCurrent).toBe(12);
    });

    it('sets current to null when override is null', async () => {
      const entity = row({ hitPointsMax: 30, hitPointsCurrent: 20 });
      await service.applyDerivedHitPoints(entity, { hitPointsCurrent: null });
      expect(entity.hitPointsCurrent).toBeNull();
    });
  });

  describe('refreshHitPointsAfterChange', () => {
    function row(): PlayerCharacter {
      return {
        level: 5,
        classSlug: 'fighter',
        speciesSlug: 'human',
        subclassSlug: null,
        abilityScores: DEFAULT_ABILITY_SCORES,
        hitPointsMax: 30,
        hitPointsCurrent: 20,
      } as PlayerCharacter;
    }

    it('recalculates max and current when relevant fields changed', async () => {
      const entity = row();
      await service.refreshHitPointsAfterChange(entity, {}, { level: true });
      expect(entity.hitPointsMax).toBeGreaterThan(0);
      expect(entity.hitPointsCurrent).toBe(entity.hitPointsMax);
    });

    it('skips recalculation when dto supplies hitPointsMax', async () => {
      const entity = row();
      await service.refreshHitPointsAfterChange(entity, { hitPointsMax: 99 }, { level: true });
      expect(entity.hitPointsMax).toBe(30);
    });

    it('preserves current HP when dto supplies hitPointsCurrent during recalc', async () => {
      const entity = row();
      await service.refreshHitPointsAfterChange(
        entity,
        { hitPointsCurrent: 15 },
        { level: true },
      );
      expect(entity.hitPointsCurrent).toBe(20);
    });

    it('skips when nothing changed and no dto HP fields', async () => {
      const entity = row();
      await service.refreshHitPointsAfterChange(entity, {}, {});
      expect(entity.hitPointsMax).toBe(30);
      expect(entity.hitPointsCurrent).toBe(20);
    });
  });
});
