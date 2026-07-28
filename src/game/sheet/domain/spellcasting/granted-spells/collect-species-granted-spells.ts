import { SpeciesChoiceDto } from '../../../dto/character-sheet.dto';
import { SpeciesGrantedSpellRow } from './types';

function choiceSlugOf(
  choices: readonly SpeciesChoiceDto[] | undefined,
  choiceKind: string,
): string | undefined {
  return choices?.find((choice) => choice.choiceKind === choiceKind)?.choiceSlug;
}

/**
 * Slugs de magia concedidos por espécie a partir do catálogo,
 * filtrados por escolhas da ficha e nível.
 */
export function collectSpeciesGrantedSpellSlugs(
  speciesSlug: string | undefined,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  level: number,
  catalogRows: readonly SpeciesGrantedSpellRow[],
): Set<string> {
  const slugs = new Set<string>();
  if (!speciesSlug) return slugs;

  for (const row of catalogRows) {
    if (row.speciesSlug !== speciesSlug) continue;
    if (row.unlockLevel > level) continue;

    if (row.choiceKind == null) {
      slugs.add(row.spellSlug);
      continue;
    }

    const selected = choiceSlugOf(speciesChoices, row.choiceKind);
    if (selected && selected === row.choiceSlug) {
      slugs.add(row.spellSlug);
    }
  }

  return slugs;
}
