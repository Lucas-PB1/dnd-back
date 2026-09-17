import { BadRequestException } from '@nestjs/common';
import { assertUnique } from '@common/assert';
import {
  HERITAGE_SIZE_KIND,
  HERITAGE_SPEED_TRADE_KIND,
  HERITAGE_TRAIT_SLOT_9,
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  heritageTraitSlotIndex,
  isHeritageOptKind,
  parseHeritageOptKind,
  requiredHeritageOptKinds,
  requiredHeritageTraitSlotKinds,
  type HeritageTraitOptionCatalog,
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
  traitOptions?: readonly HeritageTraitOptionCatalog[];
  rules: HeritageChoiceRules;
}

export function validateHeritageChoices(input: ValidateHeritageChoicesInput): void {
  const {
    heritageSlug,
    choices,
    catalogRows,
    traitLimits,
    traitOptions = [],
    rules,
  } = input;
  if (!choices.length) return;

  const heritageChoices = choices.filter((choice) =>
    choice.choiceKind.startsWith('heritage_'),
  );

  const requiredTraitSlots = requiredHeritageTraitSlotKinds(heritageChoices);
  for (const kind of requiredTraitSlots) {
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

  const requiredOptKinds = requiredHeritageOptKinds(
    heritageChoices,
    traitOptions,
  );
  for (const kind of requiredOptKinds) {
    if (
      !heritageChoices.some(
        (choice) => choice.choiceKind === kind && choice.choiceSlug?.trim(),
      )
    ) {
      throw new BadRequestException(`Missing heritage trait choice for '${kind}'`);
    }
  }

  const allowedKinds = new Set(catalogRows.map((row) => row.choiceKind));
  for (const kind of requiredOptKinds) allowedKinds.add(kind);

  const valueIdsByTraitOption = new Map<string, Set<string>>();
  for (const row of traitOptions) {
    const key = `${row.traitSlug}:${row.optionKey}`;
    const ids = valueIdsByTraitOption.get(key) ?? new Set<string>();
    for (const valueId of row.valueIds) ids.add(valueId);
    valueIdsByTraitOption.set(key, ids);
  }

  for (const choice of heritageChoices) {
    if (!allowedKinds.has(choice.choiceKind)) {
      throw new BadRequestException(
        `Heritage choice kind '${choice.choiceKind}' is not valid for '${heritageSlug}'`,
      );
    }
    if (isHeritageOptKind(choice.choiceKind)) {
      assertHeritageOptValue({
        choice,
        heritageChoices,
        valueIdsByTraitOption,
        heritageSlug,
      });
      continue;
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

function assertHeritageOptValue(input: {
  choice: HeritageTraitPick;
  heritageChoices: readonly HeritageTraitPick[];
  valueIdsByTraitOption: Map<string, Set<string>>;
  heritageSlug: string;
}): void {
  const parsed = parseHeritageOptKind(input.choice.choiceKind);
  if (!parsed) {
    throw new BadRequestException(
      `Heritage choice kind '${input.choice.choiceKind}' is not valid for '${input.heritageSlug}'`,
    );
  }
  const traitSlug = input.heritageChoices.find(
    (choice) =>
      heritageTraitSlotIndex(choice.choiceKind) === parsed.slotIndex,
  )?.choiceSlug;
  if (!traitSlug?.trim()) {
    throw new BadRequestException(
      `Heritage choice '${input.choice.choiceKind}' has no trait in slot ${parsed.slotIndex}`,
    );
  }
  const allowed = input.valueIdsByTraitOption.get(
    `${traitSlug}:${parsed.optionKey}`,
  );
  if (!allowed?.has(input.choice.choiceSlug)) {
    throw new BadRequestException(
      `Heritage choice '${input.choice.choiceKind}/${input.choice.choiceSlug}' is invalid for '${input.heritageSlug}'`,
    );
  }
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
