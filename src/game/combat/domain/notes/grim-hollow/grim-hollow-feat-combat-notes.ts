/** Passivos de talentos Grim Hollow Cap. 4 (coluna Passivas). */
import {
  GH_CAP4_FEAT_PASSIVE_NOTES,
} from './grim-hollow-feat-combat-notes-data';

export function grimHollowFeatCombatNotes(input: {
  featSlugs: readonly string[];
}): string[] {
  const notes: string[] = [];
  const seen = new Set<string>();

  for (const slug of input.featSlugs) {
    if (seen.has(slug)) continue;
    seen.add(slug);
    const lines = GH_CAP4_FEAT_PASSIVE_NOTES[slug];
    if (!lines?.length) continue;
    for (const line of lines) notes.push(line);
  }

  return notes;
}
