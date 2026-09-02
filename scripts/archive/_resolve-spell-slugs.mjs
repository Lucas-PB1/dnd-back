import { loadEnv } from "../lib/load-env.mjs";
import { createPgClient } from "../lib/pg-client.mjs";
import { SPELL_SLUG_MAP } from "../lib/ghpg-cap2-spell-slug-map.mjs";

loadEnv();

/** EN name (source) → candidate PT slugs to try */
const NEED = {
  Counterspell: ["contramagia"],
  "Dissonant Whispers": ["sussurros-dissonantes"],
  "Vicious Mockery": ["zombaria-cruel"],
  "Animate Dead": ["animar-mortos"],
  "Animal Friendship": ["amizade-com-animais"],
  "Speak with Animals": ["falar-com-animais"],
  "Cure Wounds": ["curar-ferimentos"],
  "Raise Dead": ["reviver-os-mortos", "ressuscitar"],
  Revivify: ["reviver"],
  "Find Steed": ["encontrar-corcel"],
  "Detect Evil and Good": ["detectar-o-bem-e-o-mal"],
  "Bestow Curse": ["impor-maldicao"],
  "Dominate Person": ["dominar-pessoa"],
  "Mage Hand": ["mao-magica"],
  "Protection from Evil and Good": ["protecao-contra-o-bem-e-o-mal"],
  "Hold Person": ["imobilizar-pessoa"],
  Levitate: ["levitar"],
  Shatter: ["estilhacar"],
  "Dispel Evil and Good": ["dissipar-o-bem-e-o-mal"],
  "Hold Monster": ["imobilizar-monstro"],
  Telekinesis: ["telecinese"],
  "Wall of Force": ["muralha-de-forca"],
  "Hunter's Mark": ["marca-do-cacador", "marca-do-predador"],
  Cloudkill: ["nuvem-da-morte"],
  "Death Ward": ["protecao-contra-a-morte"],
  "Conjure Animals": ["convocar-animais"],
};

const SEARCH = {
  Counterspell: ["contramagia", "contra-magia"],
  "Dissonant Whispers": ["sussurro", "dissonant"],
  "Vicious Mockery": ["zombaria", "insulto"],
  "Animate Dead": ["animar-mortos", "animar mortos"],
  "Animal Friendship": ["amizade", "animais"],
  "Speak with Animals": ["falar com animais", "falar-com-animais"],
  "Cure Wounds": ["curar ferimentos", "curar-ferimentos"],
  "Raise Dead": ["reviver os mortos", "ressuscitar"],
  Revivify: ["reviver"],
  "Find Steed": ["corcel", "montar"],
  "Detect Evil and Good": ["detectar", "bem e o mal"],
  "Bestow Curse": ["maldicao", "impor"],
  "Dominate Person": ["dominar"],
  "Mage Hand": ["mao magica", "mão mágica"],
  "Protection from Evil and Good": ["protecao contra", "proteção contra"],
  "Hold Person": ["imobilizar pessoa"],
  Levitate: ["levitar"],
  Shatter: ["estilhacar", "estilhaçar"],
  "Dispel Evil and Good": ["dissipar"],
  "Hold Monster": ["imobilizar monstro"],
  Telekinesis: ["telecinese"],
  "Wall of Force": ["muralha", "forca"],
  "Hunter's Mark": ["marca", "cacador", "predador"],
  Cloudkill: ["nuvem"],
  "Death Ward": ["protecao contra a morte", "morte"],
  "Conjure Animals": ["convocar animais"],
};

const client = createPgClient(process.env.DATABASE_URL);
await client.connect();

const mapHits = Object.entries(SPELL_SLUG_MAP);
const mapSlugs = [...new Set(mapHits.map(([, s]) => s))];
const { rows: mapRows } = await client.query(
  `SELECT slug, name FROM rpg.phb_spell WHERE slug = ANY($1)`,
  [mapSlugs],
);
console.log("=== SPELL_SLUG_MAP validation ===");
console.log(`map entries: ${mapHits.length}, unique slugs in DB: ${mapRows.length}`);
for (const [en, slug] of mapHits) {
  const hit = mapRows.find((r) => r.slug === slug);
  if (!hit) console.log(`MISSING MAP ${en} => ${slug}`);
}

console.log("\n=== Gap spells resolve ===");
const resolved = {};
for (const [en, candidates] of Object.entries(NEED)) {
  const { rows } = await client.query(
    `SELECT slug, name FROM rpg.phb_spell WHERE slug = ANY($1)`,
    [candidates],
  );
  if (rows.length === 1) {
    resolved[en] = rows[0].slug;
    console.log(`${en} => ${rows[0].slug} (${rows[0].name})`);
    continue;
  }
  if (rows.length > 1) {
    console.log(`${en} AMBIGUOUS:`, rows.map((r) => r.slug).join(", "));
    continue;
  }
  const terms = SEARCH[en] ?? [];
  let found = [];
  for (const term of terms) {
    const r = await client.query(
      `SELECT slug, name FROM rpg.phb_spell
       WHERE slug ILIKE $1 OR name ILIKE $1
       ORDER BY slug LIMIT 8`,
      [`%${term}%`],
    );
    found = found.concat(r.rows);
  }
  const uniq = [...new Map(found.map((r) => [r.slug, r])).values()];
  if (uniq.length === 0) console.log(`${en} => NOT FOUND`);
  else if (uniq.length === 1) {
    resolved[en] = uniq[0].slug;
    console.log(`${en} => ${uniq[0].slug} (${uniq[0].name}) [search]`);
  } else {
    console.log(
      `${en} => candidates:`,
      uniq.map((r) => `${r.slug}|${r.name}`).join("; "),
    );
  }
}

console.log("\n=== JSON for map ===");
console.log(JSON.stringify(resolved, null, 2));

await client.end();
