/**
 * Auditoria e validação de talentos (feats) nas fichas e no PostgreSQL.
 */
import {
  buildAllBlueprints,
  buildCharacter,
  TARGET_CHARACTER_COUNT,
} from "./lib/character-generator.mjs";
import {
  validateCharacterRules,
  validateExpertiseList,
  validateFeatRoster,
  validateFeatPrerequisites,
  validateGeneralFeats,
  validateHp,
  validateMagicInitiate,
} from "./character-rules.mjs";
import { GENERAL_FEAT_ROTATION } from "./general-feat-mechanics-data.mjs";
import {
  allPhbFeatIds,
  catalogOnlyFeatIds,
  FEAT_MECHANICS,
  FIGHTING_STYLE_FEAT_IDS,
  implementedFeatIds,
} from "./feat-mechanics-data.mjs";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

let errors = 0;

function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

// —— Relatório de cobertura do catálogo ——
const allIds = allPhbFeatIds();
const implemented = implementedFeatIds();
const catalogOnly = catalogOnlyFeatIds();

console.log("=== Catálogo PHB ===");
console.log(`  talentos no PHB: ${allIds.length}`);
console.log(`  com mecânica no engine: ${implemented.length}`);
console.log(`  só catálogo (texto): ${catalogOnly.length}`);
console.log(
  "  hooks:",
  Object.entries(FEAT_MECHANICS)
    .map(([id, m]) => `${id}(${m.hooks.join("+")})`)
    .join(", ")
);
console.log(`  estilos de luta (via classChoices): ${FIGHTING_STYLE_FEAT_IDS.length}`);

// —— Fichas em memória ——
const blueprints = buildAllBlueprints();
const featCounts = new Map();
const originFeatSeen = new Set();
const featValidators = [
  validateFeatRoster,
  validateFeatPrerequisites,
  validateGeneralFeats,
  validateMagicInitiate,
  validateHp,
  validateExpertiseList,
];

for (let i = 0; i < blueprints.length; i++) {
  const bp = blueprints[i];
  const id = `pc-${String(i + 1).padStart(3, "0")}`;
  const char = buildCharacter({ ...bp, id, name: id });

  for (const fn of featValidators) {
    const r = fn(char);
    if (!r.ok) fail(`${id}: [${fn.name}] ${r.reason}`);
  }

  const full = validateCharacterRules(char);
  if (!full.ok) fail(`${id}: [${full.validator}] ${full.reason}`);

  for (const f of char.feats ?? []) {
    featCounts.set(f.featId, (featCounts.get(f.featId) ?? 0) + 1);
    if (f.source === "background") originFeatSeen.add(f.featId);
  }
}

console.log("\n=== Fichas geradas ===");
console.log(`  personagens: ${blueprints.length}`);
console.log(`  feats distintos em uso: ${featCounts.size}`);
console.log(
  "  por feat:",
  [...featCounts.entries()]
    .sort((a, b) => b[1] - a[1])
    .map(([id, n]) => `${id}=${n}`)
    .join(", ")
);
console.log(`  talentos de origem vistos: ${originFeatSeen.size}/10`);

const missingOrigin = [
  "alert",
  "artisan",
  "healer",
  "lucky",
  "magic-initiate",
  "musician",
  "savage-attacker",
  "skilled",
  "tavern-brawler",
  "tough",
].filter((id) => !originFeatSeen.has(id));
if (missingOrigin.length) {
  fail(`talentos de origem sem ficha de teste: ${missingOrigin.join(", ")}`);
} else {
  console.log("  ✓ todos os 10 talentos de origem aparecem em alguma ficha");
}

const generalFeatSeen = new Set(
  [...featCounts.entries()].filter(([id]) => GENERAL_FEAT_ROTATION.includes(id)).map(([id]) => id)
);
const missingGeneral = GENERAL_FEAT_ROTATION.filter((id) => !generalFeatSeen.has(id));
if (missingGeneral.length) {
  fail(`talentos gerais implementados sem ficha de teste: ${missingGeneral.join(", ")}`);
} else {
  console.log(`  ✓ todos os ${GENERAL_FEAT_ROTATION.length} talentos gerais implementados aparecem em alguma ficha`);
}

// —— PostgreSQL ——
try {
  const pg = await import("pg");
  const client = new pg.default.Client({ connectionString: url });
  await client.connect();

  const { rows: featCnt } = await client.query(`SELECT COUNT(*)::int AS n FROM rpg.phb_feat`);
  if (featCnt[0].n !== allIds.length) {
    fail(`catálogo: ${featCnt[0].n} feats no DB, esperado ${allIds.length}`);
  }

  const { rows: byFeat } = await client.query(`
    SELECT f.slug, pcf.source, COUNT(*)::int AS n
    FROM rpg.player_character_feat pcf
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id
    GROUP BY f.slug, pcf.source
    ORDER BY f.slug, pcf.source
  `);
  console.log("\n=== PostgreSQL (player_character_feat) ===");
  for (const r of byFeat) {
    console.log(`  ${r.slug} [${r.source}]: ${r.n}`);
  }

  const { rows: miMissing } = await client.query(`
    SELECT pc.id
    FROM rpg.player_character pc
    JOIN rpg.player_character_feat pcf ON pcf.character_id = pc.id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id AND f.slug = 'magic-initiate'
    LEFT JOIN rpg.player_character_feat_magic_initiate mi ON mi.character_id = pc.id
      AND mi.feat_id = pcf.feat_id
    WHERE mi.character_id IS NULL
    LIMIT 5
  `);
  if (miMissing.length) {
    for (const r of miMissing) fail(`${r.id}: magic-initiate sem linha em feat_magic_initiate`);
  }

  const { rows: miSpells } = await client.query(`
    SELECT pc.id
    FROM rpg.player_character pc
    JOIN rpg.player_character_feat pcf ON pcf.character_id = pc.id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id AND f.slug = 'magic-initiate'
    LEFT JOIN rpg.player_character_spell_list psl ON psl.character_id = pc.id
      AND psl.source_id = (SELECT id FROM rpg.phb_spell_source WHERE slug = 'magic-initiate')
    WHERE psl.character_id IS NULL
    LIMIT 5
  `);
  if (miSpells.length) {
    for (const r of miSpells) fail(`${r.id}: magic-initiate sem magias na spell_list`);
  }

  const { rows: toughHp } = await client.query(`
    SELECT pc.id, pc.hp_max, pc.level
    FROM rpg.player_character pc
    JOIN rpg.player_character_feat pcf ON pcf.character_id = pc.id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id AND f.slug = 'tough'
    LIMIT 3
  `);
  if (toughHp.length) {
    console.log(`  ✓ ${toughHp.length}+ fichas com Vigoroso (HP validado em memória)`);
  }

  await client.end();
} catch (e) {
  fail(`PostgreSQL: ${e.message}`);
}

if (errors) {
  console.error(`\n${errors} falha(s) em talentos.`);
  process.exit(1);
}

console.log("\n✓ Talentos validados — mecânicas implementadas OK nas 982 fichas");
console.log(
  `  nota: ${catalogOnly.length} feats do PHB ainda são só catálogo (sem motor de benefícios)`
);
process.exit(0);
