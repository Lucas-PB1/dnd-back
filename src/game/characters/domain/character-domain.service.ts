import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../../entities/views/v-phb-class.entity';
import { PhbCharacterLevel } from '../../../entities/phb-character-level.entity';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { AbilityScores, PlayerCharacter } from '../infrastructure/player-character.entity';
import {
  calculateHitPointsMax,
  ClassHpProfile,
  parseHitDieLabel,
} from './hit-points.calc';

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
  }): Promise<number> {
    const phbClass = await this.catalogLookup.findClassOrFail(input.classSlug);
    return calculateHitPointsMax(
      input.level,
      this.classHpProfile(phbClass),
      input.abilityScores.constituicao,
    );
  }

  async applyDerivedHitPoints(
    entity: PlayerCharacter,
    overrides?: { hitPointsMax?: number | null; hitPointsCurrent?: number | null },
  ): Promise<void> {
    if (overrides?.hitPointsMax !== undefined && overrides.hitPointsMax !== null) {
      entity.hitPointsMax = overrides.hitPointsMax;
    } else if (entity.hitPointsMax === null) {
      entity.hitPointsMax = await this.calculateHitPointsMaxForCharacter({
        level: entity.level,
        classSlug: entity.classSlug,
        abilityScores: entity.abilityScores,
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
    changed: { level?: boolean; classSlug?: boolean; abilityScores?: boolean },
  ): Promise<void> {
    const shouldRecalculateMax =
      dto.hitPointsMax === undefined &&
      (changed.level || changed.classSlug || changed.abilityScores);

    if (shouldRecalculateMax) {
      entity.hitPointsMax = await this.calculateHitPointsMaxForCharacter({
        level: entity.level,
        classSlug: entity.classSlug,
        abilityScores: entity.abilityScores,
      });
    }

    if (dto.hitPointsCurrent === undefined && dto.hitPointsMax === undefined && shouldRecalculateMax) {
      entity.hitPointsCurrent = entity.hitPointsMax;
    }
  }
}
