import type { CatalogEffect } from '@game/effects';
import { speciesGrantedSpellSlugsFromEffects } from '@game/effects';
import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

function choiceSlugOf(
  choices: readonly SpeciesChoiceDto[] | undefined,
  choiceKind: string,
): string | undefined {
  return choices?.find((choice) => choice.choiceKind === choiceKind)?.choiceSlug;
}

/**
 * Slugs de magia concedidos por espécie via `phb_effect` `grant_spell`
 * (já gated por `loadGatedSpeciesEffects`).
 * Alto Elfo: `high_elf_cantrip` substitui o truque L1 default.
 * Andari: `andari_druid_cantrip` adiciona o truque de Druida escolhido.
 */
export function collectSpeciesGrantedSpellSlugs(
  speciesSlug: string | undefined,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  level: number,
  speciesEffects?: readonly CatalogEffect[],
): Set<string> {
  const slugs = new Set<string>();
  if (!speciesSlug) return slugs;

  const effects = speciesEffects ?? [];
  for (const slug of speciesGrantedSpellSlugsFromEffects(effects, level)) {
    slugs.add(slug);
  }
  applyHighElfCantripOverrideFromEffects(
    speciesSlug,
    speciesChoices,
    effects,
    slugs,
  );
  applyAndariDruidCantrip(speciesSlug, speciesChoices, slugs);
  return slugs;
}

function applyHighElfCantripOverrideFromEffects(
  speciesSlug: string,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  speciesEffects: readonly CatalogEffect[],
  slugs: Set<string>,
): void {
  if (speciesSlug !== 'elf') return;
  if (choiceSlugOf(speciesChoices, 'elf_lineage') !== 'high-elf') return;
  const cantrip = choiceSlugOf(speciesChoices, 'high_elf_cantrip');
  if (!cantrip) return;

  for (const effect of speciesEffects) {
    if (effect.kind !== 'grant_spell' && effect.kind !== 'grant_spell_by_level') {
      continue;
    }
    if (effect.unlockLevel !== 1) continue;
    const slug = effect.spell?.spellSlug?.trim();
    if (slug) slugs.delete(slug);
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
