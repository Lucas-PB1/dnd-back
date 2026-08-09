import { DataSource } from 'typeorm';
import type { EldritchInvocationEffectRow } from '../domain/warlock-features';

type CatalogQueryRow = {
  slug: string;
  name: string;
  min_level: number;
  requires_pact_slug: string | null;
  requires_invocation_slug: string | null;
  repeatable: boolean;
  kind: string;
  granted_spell_slug: string | null;
};

export async function loadEldritchInvocationEffectCatalog(
  dataSource: DataSource,
): Promise<EldritchInvocationEffectRow[]> {
  const rows = await dataSource.query<CatalogQueryRow[]>(
    `SELECT slug, name, min_level, requires_pact_slug, requires_invocation_slug,
            repeatable, kind::text AS kind, granted_spell_slug
     FROM rpg.phb_eldritch_invocation`,
  );
  return rows.map((row) => ({
    slug: row.slug,
    name: row.name,
    minLevel: row.min_level,
    requiresPactSlug: row.requires_pact_slug,
    requiresInvocationSlug: row.requires_invocation_slug,
    repeatable: row.repeatable,
    kind: row.kind,
    grantedSpellSlug: row.granted_spell_slug,
  }));
}
