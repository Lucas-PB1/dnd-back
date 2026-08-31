import { BadRequestException } from '@nestjs/common';
import { assertUnique } from '@common/assert';
import {
  HERITAGE_SIZE_KIND,
  HERITAGE_SPEED_TRADE_KIND,
  HERITAGE_TRAIT_SLOT_9,
  HERITAGE_TRAIT_SLOTS,
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  type HeritageTraitPick,
} from './aggregate-trait-takes';

export interface HeritageChoiceCatalogRow {
  choiceKind: string;
  traitSlug: string;
}

export interface HeritageTraitLimitRow {
  slug: string;
  maxTakes: number | null;
}

export interface HeritageChoiceRules {
  allowsSpeedTrade: boolean;
  allowsSizeChoice: boolean;
}

export interface ValidateHeritageChoicesInput {
  heritageSlug: string;
  choices: readonly HeritageTraitPick[];
  catalogRows: readonly HeritageChoiceCatalogRow[];
  traitLimits: readonly HeritageTraitLimitRow[];
  rules: HeritageChoiceRules;
}

export function validateHeritageChoices(input: ValidateHeritageChoicesInput): void {
  const { heritageSlug, choices, catalogRows, traitLimits, rules } = input;
  if (!choices.length) return;

  const heritageChoices = choices.filter((choice) =>
    choice.choiceKind.startsWith('heritage_'),
  );

  for (const kind of HERITAGE_TRAIT_SLOTS) {
    if (
      !heritageChoices.some(
        (choice) => choice.choiceKind === kind && choice.choiceSlug?.trim(),
      )
    ) {
      throw new BadRequestException(`Missing heritage trait choice for '${kind}'`);
    }
  }

  const speedTrade = heritageChoices.find(
    (choice) => choice.choiceKind === HERITAGE_SPEED_TRADE_KIND,
  )?.choiceSlug;
  const hasSpeedTradeRow = catalogRows.some(
    (row) => row.choiceKind === HERITAGE_SPEED_TRADE_KIND,
  );
  if (rules.allowsSpeedTrade || hasSpeedTradeRow) {
    if (!speedTrade) {
      throw new BadRequestException(
        `Missing heritage choice for '${HERITAGE_SPEED_TRADE_KIND}'`,
      );
    }
  }
  if (speedTrade === 'yes') {
    const ninth = heritageChoices.find(
      (choice) => choice.choiceKind === HERITAGE_TRAIT_SLOT_9,
    );
    if (!ninth?.choiceSlug?.trim()) {
      throw new BadRequestException(
        `Heritage speed trade requires '${HERITAGE_TRAIT_SLOT_9}'`,
      );
    }
  }

  if (rules.allowsSizeChoice) {
    const size = heritageChoices.find(
      (choice) => choice.choiceKind === HERITAGE_SIZE_KIND,
    )?.choiceSlug;
    if (!size) {
      throw new BadRequestException(
        `Missing heritage choice for '${HERITAGE_SIZE_KIND}'`,
      );
    }
  }

  const allowedKinds = new Set(catalogRows.map((row) => row.choiceKind));
  for (const choice of heritageChoices) {
    if (!allowedKinds.has(choice.choiceKind)) {
      throw new BadRequestException(
        `Heritage choice kind '${choice.choiceKind}' is not valid for '${heritageSlug}'`,
      );
    }
    const valid = catalogRows.some(
      (row) =>
        row.choiceKind === choice.choiceKind && row.traitSlug === choice.choiceSlug,
    );
    if (!valid) {
      throw new BadRequestException(
        `Heritage choice '${choice.choiceKind}/${choice.choiceSlug}' is invalid for '${heritageSlug}'`,
      );
    }
  }

  const kinds = heritageChoices.map((choice) => choice.choiceKind);
  assertUnique(kinds, 'Duplicate heritage choice slots are not allowed');

  validateMaxTakes(collectHeritageTraitPicks(heritageChoices), traitLimits);
}

function validateMaxTakes(
  traitPicks: readonly HeritageTraitPick[],
  traitLimits: readonly HeritageTraitLimitRow[],
): void {
  const limitsBySlug = new Map(traitLimits.map((row) => [row.slug, row.maxTakes]));
  const takes = aggregateTraitTakes(traitPicks);

  for (const entry of takes) {
    const maxTakes = limitsBySlug.get(entry.traitSlug);
    if (maxTakes === undefined || maxTakes === null) continue;
    if (entry.takeCount > maxTakes) {
      throw new BadRequestException(
        `Heritage trait '${entry.traitSlug}' allows at most ${maxTakes} take(s), got ${entry.takeCount}`,
      );
    }
  }
}
