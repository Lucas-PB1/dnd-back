/** Invocações Místicas — picks válidos até o limite do nível (greedy + shuffle). */

export function warlockInvocationLimit(level) {
  if (level >= 18) return 10;
  if (level >= 15) return 9;
  if (level >= 12) return 8;
  if (level >= 9) return 7;
  if (level >= 7) return 6;
  if (level >= 5) return 5;
  if (level >= 2) return 3;
  if (level >= 1) return 1;
  return 0;
}

function knownPactSlugs(pickedSlugs) {
  return new Set(
    pickedSlugs.filter((slug) =>
      ['pact-of-the-tome', 'pact-of-the-blade', 'pact-of-the-chain'].includes(
        slug,
      ),
    ),
  );
}

function validatePicks(level, picks, catalog) {
  const bySlug = new Map(catalog.map((row) => [row.slug, row]));
  const pickedSlugs = picks.map((p) => p.slug);
  const counts = new Map();
  for (const slug of pickedSlugs) {
    counts.set(slug, (counts.get(slug) ?? 0) + 1);
  }
  const pactKnown = knownPactSlugs(pickedSlugs);
  const invocationKnown = new Set(pickedSlugs);
  const errors = [];
  if (picks.length > warlockInvocationLimit(level)) {
    errors.push('over limit');
  }
  for (const pick of picks) {
    const row = bySlug.get(pick.slug);
    if (!row) {
      errors.push(`unknown ${pick.slug}`);
      continue;
    }
    if (level < row.minLevel) errors.push(`level ${pick.slug}`);
    if (row.requiresPactSlug && !pactKnown.has(row.requiresPactSlug)) {
      errors.push(`pact ${pick.slug}`);
    }
    if (
      row.requiresInvocationSlug &&
      !invocationKnown.has(row.requiresInvocationSlug)
    ) {
      errors.push(`prereq ${pick.slug}`);
    }
    if (!row.repeatable && (counts.get(pick.slug) ?? 0) > 1) {
      errors.push(`repeat ${pick.slug}`);
    }
  }
  return errors;
}

function shuffle(items) {
  const next = [...items];
  for (let i = next.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [next[i], next[j]] = [next[j], next[i]];
  }
  return next;
}

/**
 * @param {{ level: number, catalog: Array<{ slug: string, minLevel: number, requiresPactSlug: string | null, requiresInvocationSlug: string | null, repeatable: boolean }>, limit?: number }} input
 */
export function pickRandomValidEldritchInvocations(input) {
  const limit = input.limit ?? warlockInvocationLimit(input.level);
  const eligible = input.catalog.filter((row) => row.minLevel <= input.level);
  const picks = [];
  while (picks.length < limit) {
    const candidates = shuffle(
      eligible.filter((row) => {
        const trial = [
          ...picks,
          { slug: row.slug, instanceIndex: picks.length },
        ];
        return validatePicks(input.level, trial, input.catalog).length === 0;
      }),
    );
    if (candidates.length === 0) break;
    picks.push({ slug: candidates[0].slug, instanceIndex: picks.length });
  }
  return picks;
}

/**
 * @param {import('pg').Client | import('typeorm').DataSource} db
 * @param {number} level
 */
export async function loadAndPickEldritchInvocationOptions(db, level) {
  const rows = await db.query(
    `SELECT slug, min_level, requires_pact_slug, requires_invocation_slug, repeatable
     FROM rpg.phb_eldritch_invocation
     ORDER BY sort_order`,
  );
  const list = Array.isArray(rows) ? rows : (rows.rows ?? []);
  const catalog = list.map((row) => ({
    slug: row.slug,
    minLevel: row.min_level,
    requiresPactSlug: row.requires_pact_slug,
    requiresInvocationSlug: row.requires_invocation_slug,
    repeatable: row.repeatable,
  }));
  return pickRandomValidEldritchInvocations({ level, catalog }).map(
    (pick) => ({
      optionKey: 'eldritch-invocation',
      valueId: pick.slug,
      instanceIndex: pick.instanceIndex,
    }),
  );
}
