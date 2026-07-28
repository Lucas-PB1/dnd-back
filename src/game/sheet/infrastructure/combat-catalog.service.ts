import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbHpBonusSource } from '../../../entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '../../../entities/views/v-phb-unarmored-defense.entity';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { HitPointsBonusRow } from '../domain/stats/hit-points.calc';
import type { UnarmoredDefenseRow } from '../domain/combat/armor-class';

type HitPointsSourceInput = {
  speciesSlug?: string | null;
  subclassSlug?: string | null;
  featSlugs?: readonly string[];
};

type UnarmoredDefenseInput = {
  classSlug?: string | null;
  subclassSlug?: string | null;
};

/** Leitura do catálogo estruturado de bônus de PV e Defesa sem Armadura. */
@Injectable()
export class CombatCatalogService {
  constructor(
    @InjectRepository(VPhbHpBonusSource)
    private readonly hpBonusRepo: Repository<VPhbHpBonusSource>,
    @InjectRepository(VPhbUnarmoredDefense)
    private readonly unarmoredRepo: Repository<VPhbUnarmoredDefense>,
  ) {}

  /** Bônus permanentes de PV aplicáveis à espécie/subclasse/talentos dados. */
  async loadHitPointsBonusSources(
    input: HitPointsSourceInput,
  ): Promise<HitPointsBonusRow[]> {
    const featSlugs = new Set(input.featSlugs ?? []);
    const rows = await this.hpBonusRepo.find();

    return rows
      .filter((row) => this.matchesHitPointsSource(row, input, featSlugs))
      .map((row) => ({
        label: row.label,
        flat: Number(row.flatBonus),
        perLevel: Number(row.perLevelBonus),
        fromLevel: Number(row.fromLevel),
      }));
  }

  /** Defesas sem Armadura concedidas pela classe/subclasse dadas. */
  async loadUnarmoredDefenses(
    input: UnarmoredDefenseInput,
  ): Promise<UnarmoredDefenseRow[]> {
    const rows = await this.unarmoredRepo.find();

    return rows
      .filter((row) => this.matchesUnarmoredDefense(row, input))
      .map((row) => ({
        label: row.label,
        secondAbility: row.secondAbilitySlug as keyof AbilityScores,
        allowsShield: row.allowsShield,
      }));
  }

  private matchesHitPointsSource(
    row: VPhbHpBonusSource,
    input: HitPointsSourceInput,
    featSlugs: ReadonlySet<string>,
  ): boolean {
    if (row.sourceKind === 'species') {
      return Boolean(input.speciesSlug) && row.sourceSlug === input.speciesSlug;
    }
    if (row.sourceKind === 'subclass') {
      return Boolean(input.subclassSlug) && row.sourceSlug === input.subclassSlug;
    }
    if (row.sourceKind === 'feat') {
      return featSlugs.has(row.sourceSlug);
    }
    return false;
  }

  private matchesUnarmoredDefense(
    row: VPhbUnarmoredDefense,
    input: UnarmoredDefenseInput,
  ): boolean {
    if (row.sourceKind === 'class') {
      return Boolean(input.classSlug) && row.sourceSlug === input.classSlug;
    }
    if (row.sourceKind === 'subclass') {
      return Boolean(input.subclassSlug) && row.sourceSlug === input.subclassSlug;
    }
    return false;
  }
}
