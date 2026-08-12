import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
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
 * Alto Elfo: `high_elf_cantrip` substitui o truque L1 default do catálogo.
 * Andari: `andari_druid_cantrip` adiciona o truque de Druida escolhido.
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

  applyHighElfCantripOverride(speciesSlug, speciesChoices, catalogRows, slugs);
  applyAndariDruidCantrip(speciesSlug, speciesChoices, slugs);
  return slugs;
}

function applyHighElfCantripOverride(
  speciesSlug: string,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  catalogRows: readonly SpeciesGrantedSpellRow[],
  slugs: Set<string>,
): void {
  if (speciesSlug !== 'elf') return;
  if (choiceSlugOf(speciesChoices, 'elf_lineage') !== 'high-elf') return;
  const cantrip = choiceSlugOf(speciesChoices, 'high_elf_cantrip');
  if (!cantrip) return;

  for (const row of catalogRows) {
    if (
      row.speciesSlug === 'elf' &&
      row.choiceKind === 'elf_lineage' &&
      row.choiceSlug === 'high-elf' &&
      row.unlockLevel === 1
    ) {
      slugs.delete(row.spellSlug);
    }
  }
  slugs.add(cantrip);
}

/** Andari (Bearfolk): adiciona o truque de Druida escolhido (sem default no catálogo). */
function applyAndariDruidCantrip(
  speciesSlug: string,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  slugs: Set<string>,
): void {
  if (speciesSlug !== 'bearfolk') return;
  if (choiceSlugOf(speciesChoices, 'bearfolk_lineage') !== 'andari') return;
  const cantrip = choiceSlugOf(speciesChoices, 'andari_druid_cantrip');
  if (cantrip) slugs.add(cantrip);
}
