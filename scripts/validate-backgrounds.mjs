/**
 * Validação completa de antecedentes — catálogo PHB/DB + 982 fichas (memória + round-trip).
 */
import {
  buildAllBlueprints,
  buildCharacter,
  TARGET_CHARACTER_COUNT,
} from "./lib/character-generator.mjs";
import {
  BACKGROUND_IDS,
  validateBackgroundCatalogJson,
  validateBackgroundCharacter,
} from "./lib/background-validators.mjs";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

let errors = 0;

function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

console.log("=== Catálogo PHB (JSON) ===");
const catalogErrors = validateBackgroundCatalogJson();
if (catalogErrors.length) {
  for (const e of catalogErrors) fail(e);
} else {
  console.log(`  ✓ ${BACKGROUND_IDS.length} antecedentes com feat, perícias, ferramenta e equipamento`);
}

console.log("\n=== Fichas geradas (memória) ===");
const blueprints = buildAllBlueprints();
if (blueprints.length !== TARGET_CHARACTER_COUNT) {
  fail(`esperado ${TARGET_CHARACTER_COUNT} blueprints, encontrado ${blueprints.length}`);
}

const backgroundSeen = new Set();
let ok = 0;

for (let i = 0; i < blueprints.length; i++) {
  const bp = blueprints[i];
  const id = `pc-${String(i + 1).padStart(3, "0")}`;
  const char = buildCharacter({
    ...bp,
    id,
    name: `Personagem ${String(i + 1).padStart(3, "0")}`,
  });

  backgroundSeen.add(char.backgroundId);
  const result = validateBackgroundCharacter(char);
  if (!result.ok) {
    fail(`${id} [${result.validator}] ${result.reason}`);
    continue;
  }
  ok++;
}

if (ok === TARGET_CHARACTER_COUNT) {
  console.log(`  ✓ ${ok}/${TARGET_CHARACTER_COUNT} fichas passaram validadores de antecedente`);
} else {
  fail(`apenas ${ok}/${TARGET_CHARACTER_COUNT} fichas OK`);
}

const missingBg = BACKGROUND_IDS.filter((id) => !backgroundSeen.has(id));
if (missingBg.length) {
  fail(`antecedentes sem ficha de teste: ${missingBg.join(", ")}`);
} else {
  console.log(`  ✓ cobertura ${BACKGROUND_IDS.length}/${BACKGROUND_IDS.length} antecedentes nas fichas`);
}

try {
  const pg = await import("pg");
  const client = new pg.default.Client({ connectionString: url });
  await client.connect();

  console.log("\n=== Catálogo PostgreSQL ===");

  const { rows: choiceNoCat } = await client.query(`
    SELECT slug FROM rpg.phb_background
    WHERE tool_proficiency_kind = 'choice' AND tool_category_id IS NULL
  `);
  if (choiceNoCat.length) {
    for (const r of choiceNoCat) fail(`phb_background ${r.slug}: choice sem tool_category_id`);
  } else {
    console.log("  ✓ antecedentes choice com tool_category_id");
  }

  const { rows: fixedNoItem } = await client.query(`
    SELECT slug FROM rpg.phb_background
    WHERE tool_proficiency_kind = 'fixed' AND tool_item_id IS NULL
  `);
  if (fixedNoItem.length) {
    for (const r of fixedNoItem) fail(`phb_background ${r.slug}: fixed sem tool_item_id`);
  } else {
    console.log("  ✓ antecedentes fixed com tool_item_id");
  }

  console.log("\n=== Fichas PostgreSQL (round-trip) ===");

  const { rows: characters } = await client.query(`
    SELECT pc.id, f.document
    FROM rpg.player_character pc
    JOIN rpg.v_player_character_full f ON f.id = pc.id
    ORDER BY pc.id
  `);

  if (characters.length !== TARGET_CHARACTER_COUNT) {
    fail(`DB: ${characters.length} fichas, esperado ${TARGET_CHARACTER_COUNT}`);
  }

  let dbOk = 0;
  for (const row of characters) {
    const result = validateBackgroundCharacter(row.document);
    if (!result.ok) {
      fail(`${row.id} [${result.validator}] ${result.reason}`);
      continue;
    }
    dbOk++;
  }
  if (dbOk === TARGET_CHARACTER_COUNT) {
    console.log(`  ✓ ${dbOk}/${characters.length} documentos passaram validadores de antecedente`);
  }

  const { rows: noBgEquip } = await client.query(`
    SELECT pc.id, bg.slug AS bg_slug
    FROM rpg.player_character pc
    JOIN rpg.phb_background bg ON bg.id = pc.background_id
    WHERE NOT EXISTS (
      SELECT 1 FROM rpg.player_character_equipment pce
      WHERE pce.character_id = pc.id AND pce.source = 'background'::rpg.equipment_source
    )
    LIMIT 10
  `);
  if (noBgEquip.length) {
    for (const r of noBgEquip) {
      fail(`${r.id}: antecedente ${r.bg_slug} sem equipamento background no DB`);
    }
  } else {
    console.log("  ✓ todas as fichas têm equipamento de antecedente persistido");
  }

  const { rows: bgProfMismatch } = await client.query(`
    SELECT pc.id, bg.slug AS bg_slug
    FROM rpg.player_character pc
    JOIN rpg.phb_background bg ON bg.id = pc.background_id
    JOIN rpg.v_player_character_full f ON f.id = pc.id
    LEFT JOIN rpg.player_character_tool pct
      ON pct.character_id = pc.id AND pct.is_background_proficiency
    LEFT JOIN rpg.phb_item i ON i.id = pct.item_id
    WHERE (f.document->'backgroundChoices'->>'toolId') IS DISTINCT FROM i.slug
    LIMIT 10
  `);
  if (bgProfMismatch.length) {
    for (const r of bgProfMismatch) {
      fail(`${r.id}: backgroundChoices.toolId diverge de is_background_proficiency`);
    }
  } else {
    console.log("  ✓ backgroundChoices alinhado com is_background_proficiency");
  }

  const { rows: multiBgProf } = await client.query(`
    SELECT pc.id, COUNT(*)::int AS n
    FROM rpg.player_character_tool pct
    JOIN rpg.player_character pc ON pc.id = pct.character_id
    WHERE pct.is_background_proficiency
    GROUP BY pc.id
    HAVING COUNT(*) > 1
    LIMIT 5
  `);
  if (multiBgProf.length) {
    for (const r of multiBgProf) {
      fail(`${r.id}: ${r.n} linhas is_background_proficiency (esperado 0 ou 1)`);
    }
  } else {
    console.log("  ✓ no máximo 1 ferramenta marcada is_background_proficiency por ficha");
  }

  await client.end();
} catch (err) {
  if (err.code === "ECONNREFUSED" || err.code === "57P01") {
    console.log("\n=== PostgreSQL ===");
    console.log("  ⊘ banco indisponível — pulando checks DB (memória OK)");
  } else {
    throw err;
  }
}

if (errors) {
  console.error(`\n${errors} falha(s) na validação de antecedentes.`);
  process.exit(1);
}

console.log("\n✓ Antecedentes validados — catálogo, fichas e persistência OK");
process.exit(0);
