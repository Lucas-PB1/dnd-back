import type { DataSource } from 'typeorm';
import {
  defensesFromAffinityRows,
  emptyDamageTypeDefenses,
  type DamageAffinityKind,
  type DamageTypeDefenses,
} from '../domain/apply-damage-type-modifiers';

export async function loadCreatureTemplateDamageDefenses(
  dataSource: DataSource,
  templateSlug: string | null | undefined,
): Promise<DamageTypeDefenses> {
  const slug = templateSlug?.trim();
  if (!slug) return emptyDamageTypeDefenses();
  const rows = await dataSource.query<
    { damage_type_slug: string; kind: DamageAffinityKind }[]
  >(
    `SELECT damage_type_slug, kind
     FROM rpg.phb_creature_template_damage_affinity
     WHERE template_slug = $1`,
    [slug],
  );
  return defensesFromAffinityRows(
    rows.map((row) => ({
      damageTypeSlug: row.damage_type_slug,
      kind: row.kind,
    })),
  );
}
