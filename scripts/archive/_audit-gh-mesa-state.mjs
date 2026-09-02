import { loadEnv } from "../lib/load-env.mjs";
import { createPgClient } from "../lib/pg-client.mjs";

loadEnv();
const c = createPgClient(process.env.DATABASE_URL);
await c.connect();

const ghSub = `sc.source_citation_id IN (
  SELECT id FROM rpg.phb_source_citation
  WHERE slug LIKE 'grim-hollow-players-guide-2024-en:chapter-2%'
)`;

const checks = [
  [
    "j029",
    `SELECT COUNT(*)::int AS rows, COUNT(DISTINCT sc.slug)::int AS subs
     FROM rpg.phb_subclass_prepared_spell p
     JOIN rpg.phb_subclass sc ON sc.id = p.subclass_id
     WHERE ${ghSub}`,
    [],
  ],
  [
    "cap7_spells",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_spell
     WHERE description LIKE '%[Sangromancia]%' OR slug IN (
       SELECT DISTINCT sp.slug FROM rpg.phb_spell sp
       JOIN rpg.phb_spell_class sc ON sc.spell_id = sp.id
       WHERE sc.class_id IS NULL AND sp.slug NOT LIKE 'curse-%'
     )`,
    [],
  ],
  [
    "economy_gh",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_class_economy_action ea
     JOIN rpg.phb_subclass sc ON sc.id = ea.subclass_id
     WHERE ${ghSub}`,
    [],
  ],
  [
    "economy_with_resource",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_class_economy_action ea
     JOIN rpg.phb_subclass sc ON sc.id = ea.subclass_id
     WHERE ${ghSub} AND ea.resource_slug IS NOT NULL`,
    [],
  ],
  [
    "combat_mod_gh_sub",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_combat_modifier cm
     JOIN rpg.phb_subclass sc ON sc.id = cm.owner_id
     WHERE cm.owner_kind = 'subclass' AND ${ghSub}`,
    [],
  ],
  [
    "heritage_economy",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_class_economy_action
     WHERE heritage_trait_id IS NOT NULL`,
    [],
  ],
  [
    "heritage_resources",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_resource_definition
     WHERE scope = 'heritage'::rpg.resource_scope`,
    [],
  ],
  [
    "heritage_combat_mod",
    `SELECT COUNT(*)::int AS n FROM rpg.phb_combat_modifier
     WHERE owner_kind = 'heritage'`,
    [],
  ],
  [
    "t093_applied",
    `SELECT EXISTS (
       SELECT 1 FROM information_schema.columns
       WHERE table_schema = 'rpg' AND table_name = 'phb_resource_definition'
         AND column_name = 'heritage_trait_id'
     ) AS ok`,
    [],
  ],
  [
    "enum_heritage_owner",
    `SELECT EXISTS (
       SELECT 1 FROM pg_enum e
       JOIN pg_type t ON t.oid = e.enumtypid
       WHERE t.typname = 'resource_owner_kind' AND e.enumlabel = 'heritage'
     ) AS ok`,
    [],
  ],
];

/** Manter em sync com `grim-hollow-subclass-combat-notes-data.ts`. */
const GH_COMBAT_NOTE_SUBS = 40;

for (const [label, sql, params] of checks) {
  const { rows } = await c.query(sql, params);
  console.log(`${label}:`, rows[0]);
}
console.log("gh_combat_notes_subs:", { n: GH_COMBAT_NOTE_SUBS });

// J029 subs still at 0
const { rows: noSpells } = await c.query(
  `SELECT sc.slug FROM rpg.phb_subclass sc
   LEFT JOIN rpg.phb_subclass_prepared_spell p ON p.subclass_id = sc.id
   WHERE ${ghSub}
   GROUP BY sc.slug HAVING COUNT(p.*) = 0
   ORDER BY sc.slug`,
);
console.log("subs_sem_j029:", noSpells.map((r) => r.slug).join(", ") || "(none)");

// EN leftover sample
const { rows: enFeat } = await c.query(
  `SELECT COUNT(*)::int AS n FROM rpg.phb_subclass_feature sf
   JOIN rpg.phb_subclass sc ON sc.id = sf.subclass_id
   WHERE ${ghSub}
     AND sf.description ~ '[A-Za-z]{4,} (you|your|when|while|until)'`,
);
console.log("features_en_heuristic:", enFeat[0]);

await c.end();
