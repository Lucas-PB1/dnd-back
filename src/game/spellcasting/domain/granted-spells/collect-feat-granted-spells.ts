import type {
  CharacterFeatDto,
  FeatOptionDto,
} from '@game/sheet/dto/character-sheet.dto';
import { ritualSpellSlotIndex } from '../ritual-spell-option-key';
import { FeatGrantedSpellRow } from './types';

/** Keys de opção que carregam slug de magia (qualquer feat — Magic Initiate, Blessings, …). */
const FEAT_SPELL_OPTION_KEYS = new Set([
  'cantrip1',
  'cantrip2',
  'firstLevelSpell',
  'bonusSpell',
]);

function isFeatSpellOption(featSlug: string, optionKey: string): boolean {
  if (FEAT_SPELL_OPTION_KEYS.has(optionKey)) return true;
  if (featSlug === 'ritual-caster') {
    return ritualSpellSlotIndex(optionKey) !== null;
  }
  return false;
}

/** Slugs de magia concedidos por talentos (escolhas em featOptions + fixas do catálogo). */
export function collectFeatGrantedSpellSlugs(
  featOptions: readonly FeatOptionDto[] | undefined,
  characterFeats: readonly CharacterFeatDto[] | undefined,
  featFixedSpells: readonly FeatGrantedSpellRow[] = [],
): Set<string> {
  const slugs = new Set<string>();

  for (const option of featOptions ?? []) {
    if (!option.valueId) continue;
    if (isFeatSpellOption(option.featSlug, option.optionKey)) {
      slugs.add(option.valueId);
    }
  }

  const featSlugs = new Set(
    characterFeats?.length
      ? characterFeats.map((feat) => feat.featSlug)
      : (featOptions ?? []).map((option) => option.featSlug),
  );

  for (const row of featFixedSpells) {
    if (featSlugs.has(row.featSlug)) {
      slugs.add(row.spellSlug);
    }
  }

  return slugs;
}
