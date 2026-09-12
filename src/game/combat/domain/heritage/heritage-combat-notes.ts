import {
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  type HeritageTraitPick,
} from '@game/sheet/domain/heritage/aggregate-trait-takes';

export type HeritageCombatNoteRow = {
  traitSlug: string;
  minTraitTakes: number;
  note: string;
};

export function heritageCombatNotes(input: {
  heritageChoices?: readonly HeritageTraitPick[];
  catalogNotes?: readonly HeritageCombatNoteRow[];
}): string[] {
  const picks = collectHeritageTraitPicks(input.heritageChoices ?? []);
  if (picks.length === 0) return [];
  const catalog = input.catalogNotes ?? [];
  if (catalog.length === 0) return [];

  const notes: string[] = [];
  const aggregated = aggregateTraitTakes(picks);

  for (const entry of aggregated) {
    const matching = catalog
      .filter(
        (row) =>
          row.traitSlug === entry.traitSlug &&
          entry.takeCount >= row.minTraitTakes,
      )
      .sort((a, b) => b.minTraitTakes - a.minTraitTakes);
    const row = matching[0];
    if (!row) continue;
    notes.push(row.note.replaceAll('{takes}', String(entry.takeCount)));
  }

  return notes;
}

export async function loadHeritageCombatNotes(
  dataSource: import('typeorm').DataSource,
): Promise<HeritageCombatNoteRow[]> {
  const rows = await dataSource.query<
    Array<{ trait_slug: string; min_trait_takes: number; note: string }>
  >(
    `SELECT ht.slug AS trait_slug, n.min_trait_takes, n.note
     FROM rpg.phb_heritage_combat_note n
     JOIN rpg.phb_heritage_trait ht ON ht.id = n.trait_id`,
  );
  return rows.map((row) => ({
    traitSlug: row.trait_slug,
    minTraitTakes: Number(row.min_trait_takes),
    note: row.note,
  }));
}

export async function loadHeritageHitPointsBonus(
  dataSource: import('typeorm').DataSource,
  heritageChoices: readonly HeritageTraitPick[],
  level: number,
): Promise<number> {
  const aggregated = aggregateTraitTakes(collectHeritageTraitPicks(heritageChoices));
  if (aggregated.length === 0) return 0;

  const rows = await dataSource.query<
    Array<{
      trait_slug: string;
      per_level_bonus: number;
      flat_bonus: number;
      min_trait_takes: number;
      from_level: number;
    }>
  >(
    `SELECT trait_slug, per_level_bonus, flat_bonus, min_trait_takes, from_level
     FROM rpg.v_phb_heritage_passive_modifier
     WHERE kind = 'hp_bonus'`,
  );

  let bonus = 0;
  for (const entry of aggregated) {
    const matching = rows
      .filter(
        (candidate) =>
          candidate.trait_slug === entry.traitSlug &&
          entry.takeCount >= Number(candidate.min_trait_takes),
      )
      .sort(
        (left, right) =>
          Number(right.min_trait_takes) - Number(left.min_trait_takes),
      );
    const row = matching[0];
    if (!row) continue;
    const fromLevel = Number(row.from_level) || 1;
    if (level < fromLevel) continue;
    bonus += Number(row.flat_bonus) || 0;
    const perLevel = Number(row.per_level_bonus) || 0;
    bonus += perLevel * level * Math.max(1, entry.takeCount);
  }
  return bonus;
}
