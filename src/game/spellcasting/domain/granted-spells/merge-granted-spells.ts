import type { CharacterSpellDto } from '@game/sheet/dto/character-sheet.dto';
import { collectFeatGrantedSpellSlugs } from './collect-feat-granted-spells';
import { collectSpeciesGrantedSpellSlugs } from './collect-species-granted-spells';
import { collectSubclassGrantedSpellSlugs } from './collect-subclass-granted-spells';
import { GrantedSpellMergeContext } from './types';

/**
 * Mantém magias da classe/subclasse e sincroniza always_prepared de talento/espécie.
 * Remove always_prepared que eram só concessão gerenciada e não estão mais concedidas.
 */
export function mergeCharacterSpellsWithGrantedSources(
  baseSpells: readonly CharacterSpellDto[],
  context: GrantedSpellMergeContext,
): CharacterSpellDto[] {
  const level = context.level ?? 1;
  const previousLevel = context.previousLevel ?? level;
  const featFixed = context.featFixedSpells ?? [];
  const speciesCatalog = context.speciesCatalog ?? [];
  const subclassGrants = context.subclassGrantedSpells ?? [];

  const nextGranted = unionSets(
    collectFeatGrantedSpellSlugs(
      context.featOptions,
      context.characterFeats,
      featFixed,
    ),
    collectSpeciesGrantedSpellSlugs(
      context.speciesSlug,
      context.speciesChoices,
      level,
      speciesCatalog,
    ),
    collectSubclassGrantedSpellSlugs(level, subclassGrants),
    context.extraGrantedSpellSlugs ?? new Set(),
  );
  const previousGranted = unionSets(
    collectFeatGrantedSpellSlugs(
      context.previousFeatOptions,
      context.previousCharacterFeats,
      featFixed,
    ),
    collectSpeciesGrantedSpellSlugs(
      context.previousSpeciesSlug,
      context.previousSpeciesChoices,
      previousLevel,
      speciesCatalog,
    ),
    collectSubclassGrantedSpellSlugs(
      previousLevel,
      context.previousSubclassGrantedSpells ?? subclassGrants,
    ),
    context.previousExtraGrantedSpellSlugs ?? new Set(),
  );

  const kept = baseSpells.filter((spell) => {
    if (spell.listType !== 'always_prepared') return true;
    if (!previousGranted.has(spell.spellSlug)) return true;
    return nextGranted.has(spell.spellSlug);
  });

  const result = kept.map((spell) => ({ ...spell }));

  for (const spellSlug of nextGranted) {
    const alreadyAlways = result.some(
      (spell) =>
        spell.spellSlug === spellSlug && spell.listType === 'always_prepared',
    );
    if (alreadyAlways) continue;
    result.push({ spellSlug, listType: 'always_prepared' });
  }

  return result;
}

function unionSets(...sets: ReadonlySet<string>[]): Set<string> {
  const result = new Set<string>();
  for (const set of sets) {
    for (const value of set) result.add(value);
  }
  return result;
}
