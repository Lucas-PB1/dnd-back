import type { DataSource } from 'typeorm';

export type InitiativeRuleRow = {
  ownerKind: 'class' | 'subclass';
  ownerSlug: string;
  unlockLevel: number;
  ruleKind: 'ability_bonus' | 'advantage';
  abilitySlug: string | null;
  label: string;
};

export async function loadInitiativeRules(
  dataSource: DataSource,
  classSlug: string,
  subclassSlug: string | null,
): Promise<InitiativeRuleRow[]> {
  const raw = await dataSource.query(
    `
    SELECT r.owner_kind AS "ownerKind",
           COALESCE(c.slug, s.slug) AS "ownerSlug",
           r.unlock_level AS "unlockLevel",
           r.rule_kind AS "ruleKind",
           r.ability_slug AS "abilitySlug",
           r.label AS label
    FROM rpg.phb_initiative_rule r
    LEFT JOIN rpg.phb_class c ON c.id = r.class_id
    LEFT JOIN rpg.phb_subclass s ON s.id = r.subclass_id
    WHERE (r.owner_kind = 'class' AND c.slug = $1)
       OR ($2::text IS NOT NULL AND r.owner_kind = 'subclass' AND s.slug = $2)
    ORDER BY r.unlock_level, r.id
    `,
    [classSlug, subclassSlug],
  );
  return raw as InitiativeRuleRow[];
}
