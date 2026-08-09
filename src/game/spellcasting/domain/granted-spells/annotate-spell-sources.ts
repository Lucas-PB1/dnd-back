import type { CharacterSpellDto } from '@game/sheet/dto/character-sheet.dto';
import { CharacterSpellSource } from './types';

export function annotateCharacterSpellSources(
  spells: readonly CharacterSpellDto[],
  context: {
    featGrantedSlugs: ReadonlySet<string>;
    speciesGrantedSlugs?: ReadonlySet<string>;
    subclassSpellSlugs?: ReadonlySet<string>;
  },
): CharacterSpellDto[] {
  return spells.map((spell) => ({
    ...spell,
    source: resolveSpellSource(spell.spellSlug, context),
  }));
}

function resolveSpellSource(
  spellSlug: string,
  context: {
    featGrantedSlugs: ReadonlySet<string>;
    speciesGrantedSlugs?: ReadonlySet<string>;
    subclassSpellSlugs?: ReadonlySet<string>;
  },
): CharacterSpellSource {
  if (context.featGrantedSlugs.has(spellSlug)) return 'feat';
  if (context.speciesGrantedSlugs?.has(spellSlug)) return 'species';
  if (context.subclassSpellSlugs?.has(spellSlug)) return 'subclass';
  return 'class';
}
