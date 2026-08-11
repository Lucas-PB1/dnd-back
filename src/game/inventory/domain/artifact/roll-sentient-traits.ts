import type {
  RolledSentience,
  SentientTraitTableRow,
} from './artifact-instance.types';
import type { Rng } from './roll-artifact-instance';
import { rollD100 } from './roll-artifact-instance';

function rollDie(sides: number, rng: Rng): number {
  return Math.floor(rng() * sides) + 1;
}

function roll4d6DropLowest(rng: Rng): number {
  const rolls = [rollDie(6, rng), rollDie(6, rng), rollDie(6, rng), rollDie(6, rng)];
  rolls.sort((a, b) => a - b);
  return rolls[1]! + rolls[2]! + rolls[3]!;
}

function findTrait(
  rows: readonly SentientTraitTableRow[],
  kind: SentientTraitTableRow['kind'],
  roll: number,
): SentientTraitTableRow | null {
  return (
    rows.find(
      (row) => row.kind === kind && roll >= row.rollMin && roll <= row.rollMax,
    ) ?? null
  );
}

function requireTrait(
  rows: readonly SentientTraitTableRow[],
  kind: SentientTraitTableRow['kind'],
  roll: number,
): SentientTraitTableRow {
  const row = findTrait(rows, kind, roll);
  if (!row) {
    throw new Error(`No sentient trait for kind=${kind} roll=${roll}`);
  }
  return row;
}

/**
 * Gera um bloco de senciência a partir das tabelas DMG (uso futuro / testes).
 * Artefatos nomeados NÃO usam este path — copiam sentience fixa do catálogo.
 */
export function rollSentientTraits(input: {
  tableRows: readonly SentientTraitTableRow[];
  rng: Rng;
}): RolledSentience {
  const { tableRows, rng } = input;

  const alignmentRoll = rollD100(rng);
  const alignment = requireTrait(tableRows, 'alignment', alignmentRoll);

  const communicationRoll = rollDie(10, rng);
  const communication = requireTrait(
    tableRows,
    'communication',
    communicationRoll,
  );

  const sensesRoll = rollDie(4, rng);
  const senses = requireTrait(tableRows, 'senses', sensesRoll);

  const purposeRoll = rollDie(10, rng);
  const purpose = requireTrait(tableRows, 'special_purpose', purposeRoll);

  return {
    alignment: String(alignment.payload.alignment ?? alignment.summaryPt),
    alignmentSlug: alignment.slug,
    communication: String(
      communication.payload.communication ?? communication.summaryPt,
    ),
    communicationSlug: communication.slug,
    senses: String(senses.payload.senses ?? senses.summaryPt),
    sensesSlug: senses.slug,
    purpose: String(purpose.payload.purpose ?? purpose.slug),
    purposeSlug: purpose.slug,
    purposeSummary: String(
      purpose.payload.purposeSummary ?? purpose.summaryPt,
    ),
    // Método documentado em kind=ability_scores (4d6dl1).
    inteligencia: roll4d6DropLowest(rng),
    sabedoria: roll4d6DropLowest(rng),
    carisma: roll4d6DropLowest(rng),
  };
}
