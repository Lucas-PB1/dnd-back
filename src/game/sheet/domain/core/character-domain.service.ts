import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '@entities/views/v-phb-class.entity';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { AbilityScores, PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CombatCatalogService } from '@game/combat/infrastructure/combat-catalog.service';
import {
  calculateHitPointsMax,
  ClassHpProfile,
  parseHitDieLabel,
} from '../stats/hit-points.calc';

type HitPointsSources = {
  speciesSlug?: string | null;
  subclassSlug?: string | null;
  featSlugs?: readonly string[];
};

function hitPointsSourcesOf(
  entity: PlayerCharacter,
  featSlugs?: readonly string[],
): HitPointsSources {
  return {
    speciesSlug: entity.speciesSlug,
    subclassSlug: entity.subclassSlug,
    featSlugs,
  };
}

@Injectable()
export class CharacterDomainService {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly combatCatalog: CombatCatalogService,
    @InjectRepository(PhbCharacterLevel)
    private readonly characterLevelsRepo: Repository<PhbCharacterLevel>,
  ) {}

  async getProficiencyBonus(level: number): Promise<number> {
    const row = await this.characterLevelsRepo.findOne({ where: { level } });
    if (!row) {
      throw new BadRequestException(`Character level '${level}' not found in catalog`);
    }
    return row.proficiencyBonus;
  }

  classHpProfile(phbClass: VPhbClass): ClassHpProfile {
    const dieValue = phbClass.hpLevel1DieValue ?? parseHitDieLabel(phbClass.hitDie);
    const fixedPerLevel =
      phbClass.hpFixedPerLevel ?? Math.ceil(dieValue / 2) + 1;

    return {
      hpLevel1DieValue: dieValue,
      hpFixedPerLevel: fixedPerLevel,
    };
  }

  async calculateHitPointsMaxForCharacter(input: {
    level: number;
    classSlug: string;
    abilityScores: AbilityScores;
    hitPointsSources?: HitPointsSources;
  }): Promise<number> {
    const phbClass = await this.catalogLookup.findClassOrFail(input.classSlug);
    const bonusSources = await this.combatCatalog.loadHitPointsBonusSources(
      input.hitPointsSources ?? {},
    );
    return calculateHitPointsMax(
      input.level,
      this.classHpProfile(phbClass),
      input.abilityScores.constituicao,
      bonusSources,
    );
  }

  async applyDerivedHitPoints(
    entity: PlayerCharacter,
    overrides?: { hitPointsMax?: number | null; hitPointsCurrent?: number | null },
    featSlugs?: readonly string[],
  ): Promise<void> {
    if (overrides?.hitPointsMax !== undefined && overrides.hitPointsMax !== null) {
      entity.hitPointsMax = overrides.hitPointsMax;
    } else if (entity.hitPointsMax === null) {
      entity.hitPointsMax = await this.calculateHitPointsMaxForCharacter({
        level: entity.level,
        classSlug: entity.classSlug,
        abilityScores: entity.abilityScores,
        hitPointsSources: hitPointsSourcesOf(entity, featSlugs),
      });
    }

    if (overrides?.hitPointsCurrent !== undefined) {
      entity.hitPointsCurrent = overrides.hitPointsCurrent ?? null;
    } else if (entity.hitPointsCurrent === null && entity.hitPointsMax !== null) {
      entity.hitPointsCurrent = entity.hitPointsMax;
    }
  }

  async refreshHitPointsAfterChange(
    entity: PlayerCharacter,
    dto: { hitPointsMax?: number; hitPointsCurrent?: number },
    changed: {
      level?: boolean;
      classSlug?: boolean;
      abilityScores?: boolean;
      speciesSlug?: boolean;
      subclassSlug?: boolean;
      characterFeats?: boolean;
    },
    featSlugs?: readonly string[],
  ): Promise<void> {
    const shouldRecalculateMax =
      dto.hitPointsMax === undefined &&
      Object.values(changed).some(Boolean);

    if (shouldRecalculateMax) {
      entity.hitPointsMax = await this.calculateHitPointsMaxForCharacter({
        level: entity.level,
        classSlug: entity.classSlug,
        abilityScores: entity.abilityScores,
        hitPointsSources: hitPointsSourcesOf(entity, featSlugs),
      });
    }

    if (dto.hitPointsCurrent === undefined && dto.hitPointsMax === undefined && shouldRecalculateMax) {
      entity.hitPointsCurrent = entity.hitPointsMax;
    }
  }
}
