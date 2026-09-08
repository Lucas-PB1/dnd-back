import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { choiceKindForOptionKey } from '@catalog/species/domain/species-option-keys';
import { VPhbHpBonusSource } from '@entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '@entities/views/v-phb-unarmored-defense.entity';
import { withDefaultSpeciesChoices } from '@game/effects';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { UnarmoredDefenseRow } from '../domain/equipment';

type HitPointsBonusRow = {
  label: string;
  flat?: number;
  perLevel?: number;
  fromLevel?: number;
};

type SpeciesChoice = { choiceKind: string; choiceSlug: string };

type HitPointsSourceInput = {
  speciesSlug?: string | null;
  subclassSlug?: string | null;
  featSlugs?: readonly string[];
  speciesChoices?: readonly SpeciesChoice[];
};

type UnarmoredDefenseInput = {
  classSlug?: string | null;
  subclassSlug?: string | null;
};

/** Catalogo de bonus de PV e Defesa sem Armadura (views + phb_effect). */
@Injectable()
export class CombatCatalogService {
  constructor(
    @InjectRepository(VPhbHpBonusSource)
    private readonly hpBonusRepo: Repository<VPhbHpBonusSource>,
    @InjectRepository(VPhbUnarmoredDefense)
    private readonly unarmoredRepo: Repository<VPhbUnarmoredDefense>,
  ) {}

  async loadHitPointsBonusSources(
    input: HitPointsSourceInput,
  ): Promise<HitPointsBonusRow[]> {
    const featSlugs = new Set(input.featSlugs ?? []);
    const choices = withDefaultSpeciesChoices(
      input.speciesSlug,
      input.speciesChoices ?? [],
    );
    const rows = await this.hpBonusRepo.find();
    return rows
      .filter((row) => this.matchesHitPointsSource(row, input, featSlugs, choices))
      .map((row) => ({
        label: row.label,
        flat: Number(row.flatBonus),
        perLevel: Number(row.perLevelBonus),
        fromLevel: Number(row.fromLevel),
      }));
  }

  async loadUnarmoredDefenses(
    input: UnarmoredDefenseInput,
  ): Promise<UnarmoredDefenseRow[]> {
    const where = unarmoredDefenseWhere(input);
    if (where.length === 0) return [];

    const rows = await this.unarmoredRepo.find({ where });

    return rows.map((row) => ({
      label: row.label,
      secondAbility: row.secondAbilitySlug as keyof AbilityScores,
      allowsShield: row.allowsShield,
    }));
  }

  private matchesHitPointsSource(
    row: VPhbHpBonusSource,
    input: HitPointsSourceInput,
    featSlugs: ReadonlySet<string>,
    choices: readonly SpeciesChoice[],
  ): boolean {
    if (row.sourceKind === 'species') {
      if (!input.speciesSlug || row.sourceSlug !== input.speciesSlug) {
        return false;
      }
      return matchesOptionGate(row, choices);
    }
    if (row.sourceKind === 'subclass') {
      return Boolean(input.subclassSlug) && row.sourceSlug === input.subclassSlug;
    }
    if (row.sourceKind === 'feat') {
      return featSlugs.has(row.sourceSlug);
    }
    return false;
  }
}

function matchesOptionGate(
  row: VPhbHpBonusSource,
  choices: readonly SpeciesChoice[],
): boolean {
  if (!row.requiresOptionKey) return true;
  const choiceKind = choiceKindForOptionKey(row.requiresOptionKey);
  return choices.some(
    (choice) =>
      choice.choiceKind === choiceKind &&
      choice.choiceSlug === row.requiresOptionValue,
  );
}

function unarmoredDefenseWhere(
  input: UnarmoredDefenseInput,
): Array<Pick<VPhbUnarmoredDefense, 'sourceKind' | 'sourceSlug'>> {
  const where: Array<Pick<VPhbUnarmoredDefense, 'sourceKind' | 'sourceSlug'>> =
    [];
  if (input.classSlug) {
    where.push({ sourceKind: 'class', sourceSlug: input.classSlug });
  }
  if (input.subclassSlug) {
    where.push({ sourceKind: 'subclass', sourceSlug: input.subclassSlug });
  }
  return where;
}
