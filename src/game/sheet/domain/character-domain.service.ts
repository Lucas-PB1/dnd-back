import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../../entities/views/v-phb-class.entity';
import { PhbCharacterLevel } from '../../../entities/phb-character-level.entity';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { AbilityScores, PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  calculateHitPointsMax,
  ClassHpProfile,
  HitPointsContext,
  parseHitDieLabel,
} from './hit-points.calc';

function hitPointsContextOf(
  entity: PlayerCharacter,
  featSlugs?: readonly string[],
): HitPointsContext {
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
    hitPointsContext?: HitPointsContext;
  }): Promise<number> {
    const phbClass = await this.catalogLookup.findClassOrFail(input.classSlug);
    return calculateHitPointsMax(
      input.level,
      this.classHpProfile(phbClass),
      input.abilityScores.constituicao,
      input.hitPointsContext,
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
        hitPointsContext: hitPointsContextOf(entity, featSlugs),
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
        hitPointsContext: hitPointsContextOf(entity, featSlugs),
      });
    }

    if (dto.hitPointsCurrent === undefined && dto.hitPointsMax === undefined && shouldRecalculateMax) {
      entity.hitPointsCurrent = entity.hitPointsMax;
    }
  }
}
