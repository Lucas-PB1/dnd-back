/**
 * Valida completude das 982 fichas via rpg.character_document + integridade relacional.
 */
import { TARGET_CHARACTER_COUNT } from "./lib/character-generator.mjs";
import { validateCharacterRulesFromDb } from "./character-rules.mjs";

const url =
  process.env.DATABASE_URL ??
  "postgresql://postgres:postgres@127.0.0.1:5432/rpg";

const pg = await import("pg");
const client = new pg.default.Client({ connectionString: url });
let errors = 0;

function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

/** Feats cujo talento implica linha em player_character_feat_asi. */
const FEAT_SLUGS_WITHOUT_ASI = new Set([
  "alert",
  "artisan",
  "healer",
  "lucky",
  "musician",
  "savage-attacker",
  "skilled",
  "tavern-brawler",
  "tough",
]);

try {
  await client.connect();

  const { rows: cnt } = await client.query(`SELECT COUNT(*)::int AS n FROM rpg.player_character`);
  if (cnt[0].n !== TARGET_CHARACTER_COUNT) {
    fail(`esperado ${TARGET_CHARACTER_COUNT} personagens, encontrado ${cnt[0].n}`);
  }

  console.log("=== Round-trip character_document ===");

  const { rows: subclassOptRows } = await client.query(`
    SELECT character_id, option_key, catalog_value_id
    FROM rpg.player_character_subclass_option
    ORDER BY character_id, option_key
  `);
  const subclassChoicesByChar = new Map();
  for (const row of subclassOptRows) {
    const bag = subclassChoicesByChar.get(row.character_id) ?? {};
    bag[row.option_key] = row.catalog_value_id;
    subclassChoicesByChar.set(row.character_id, bag);
  }

  const { rows: spellbookRows } = await client.query(`
    SELECT psl.character_id, s.slug AS spell_slug
    FROM rpg.player_character_spell_list psl
    JOIN rpg.phb_spell s ON s.id = psl.spell_id AND s.level > 0
    JOIN rpg.player_character pc ON pc.id = psl.character_id
    JOIN rpg.phb_class c ON c.id = pc.class_id AND c.slug = 'wizard'
    JOIN rpg.phb_spell_source ss ON ss.id = psl.source_id AND ss.slug = 'class'
    WHERE psl.list_type = 'known'::rpg.spell_list_type
    ORDER BY psl.character_id, s.slug
  `);
  const spellbookByChar = new Map();
  for (const row of spellbookRows) {
    const list = spellbookByChar.get(row.character_id) ?? [];
    list.push(row.spell_slug);
    spellbookByChar.set(row.character_id, list);
  }

  const { rows: characters } = await client.query(`
    SELECT pc.id, pc.hp_max, pc.passive_perception, f.document
    FROM rpg.player_character pc
    JOIN rpg.v_player_character_full f ON f.id = pc.id
    ORDER BY pc.id
  `);

  if (characters.length !== TARGET_CHARACTER_COUNT) {
    fail(`document: ${characters.length} fichas na view, esperado ${TARGET_CHARACTER_COUNT}`);
  }

  let docOk = 0;
  for (const row of characters) {
    const doc = row.document;
    if (!doc || doc.id !== row.id) {
      fail(`${row.id}: document.id ausente ou divergente`);
      continue;
    }

    const result = validateCharacterRulesFromDb(doc, {
      subclassChoices: subclassChoicesByChar.get(row.id) ?? {},
      spellbookClass: spellbookByChar.get(row.id) ?? [],
    });
    if (!result.ok) {
      fail(`${row.id}: [${result.validator}] ${result.reason}`);
      continue;
    }
    docOk++;
  }
  console.log(`  ✓ ${docOk}/${characters.length} fichas passaram validateCharacterRulesFromDb`);

  console.log("\n=== Integridade relacional (feats) ===");

  const { rows: missingAsi } = await client.query(`
    SELECT pc.id, f.slug, pcf.source::text
    FROM rpg.player_character_feat pcf
    JOIN rpg.player_character pc ON pc.id = pcf.character_id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id
    LEFT JOIN rpg.player_character_feat_asi asi
      ON asi.character_id = pcf.character_id
      AND asi.feat_id = pcf.feat_id
      AND asi.source = pcf.source
      AND asi.unlock_level = pcf.unlock_level
    WHERE asi.character_id IS NULL
      AND pcf.source IN ('general'::rpg.feat_source, 'class'::rpg.feat_source)
    LIMIT 10
  `);
  if (missingAsi.length) {
    for (const r of missingAsi) {
      if (FEAT_SLUGS_WITHOUT_ASI.has(r.slug)) continue;
      fail(`${r.id}: feat ${r.slug} [${r.source}] sem player_character_feat_asi`);
    }
  } else {
    console.log("  ✓ feats de classe/geral com ASI persistido");
  }

  const { rows: missingFeatSpells } = await client.query(`
    SELECT pc.id, f.slug AS feat_slug, ss.slug AS source_slug
    FROM rpg.player_character_feat pcf
    JOIN rpg.player_character pc ON pc.id = pcf.character_id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id
    JOIN rpg.phb_spell_source ss ON ss.feat_id = f.id AND ss.origin_type = 'feat'
    LEFT JOIN rpg.player_character_spell_list psl
      ON psl.character_id = pcf.character_id AND psl.source_id = ss.id
    WHERE psl.character_id IS NULL
    LIMIT 10
  `);
  if (missingFeatSpells.length) {
    for (const r of missingFeatSpells) {
      fail(`${r.id}: talento ${r.feat_slug} sem magias (source ${r.source_slug})`);
    }
    const { rows: total } = await client.query(`
      SELECT COUNT(*)::int AS n FROM (
        SELECT pc.id
        FROM rpg.player_character_feat pcf
        JOIN rpg.player_character pc ON pc.id = pcf.character_id
        JOIN rpg.phb_feat f ON f.id = pcf.feat_id
        JOIN rpg.phb_spell_source ss ON ss.feat_id = f.id AND ss.origin_type = 'feat'
        LEFT JOIN rpg.player_character_spell_list psl
          ON psl.character_id = pcf.character_id AND psl.source_id = ss.id
        WHERE psl.character_id IS NULL
      ) x
    `);
    if (total[0].n > missingFeatSpells.length) {
      fail(`… e mais ${total[0].n - missingFeatSpells.length} feat(s) com spell_list ausente`);
    }
  } else {
    console.log("  ✓ feats com conjuração têm linhas em spell_list");
  }

  const { rows: missingMi } = await client.query(`
    SELECT pc.id
    FROM rpg.player_character pc
    JOIN rpg.player_character_feat pcf ON pcf.character_id = pc.id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id AND f.slug = 'magic-initiate'
    LEFT JOIN rpg.player_character_feat_magic_initiate mi
      ON mi.character_id = pc.id AND mi.feat_id = pcf.feat_id
      AND mi.source = pcf.source AND mi.unlock_level = pcf.unlock_level
    WHERE mi.character_id IS NULL
    LIMIT 5
  `);
  if (missingMi.length) {
    for (const r of missingMi) fail(`${r.id}: magic-initiate sem feat_magic_initiate`);
  } else {
    console.log("  ✓ magic-initiate com linha dedicada");
  }

  const { rows: resilientBad } = await client.query(`
    SELECT pc.id
    FROM rpg.player_character pc
    JOIN rpg.phb_class c ON c.id = pc.class_id
    JOIN rpg.player_character_feat pcf ON pcf.character_id = pc.id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id AND f.slug = 'resilient'
    WHERE (
      SELECT COUNT(*)::int
      FROM rpg.player_character_saving_throw pst
      WHERE pst.character_id = pc.id
    ) <= (
      SELECT COUNT(*)::int
      FROM rpg.phb_class_saving_throw cst
      WHERE cst.class_id = c.id
    )
    LIMIT 5
  `);
  if (resilientBad.length) {
    for (const r of resilientBad) {
      fail(`${r.id}: resilient sem salvaguarda extra em player_character_saving_throw`);
    }
  } else {
    console.log("  ✓ resilient concede salvaguarda além da classe");
  }

  console.log("\n=== Campos desnormalizados ===");

  const { rows: hpMismatch } = await client.query(`
    SELECT pc.id, pc.hp_max, (f.document->'hp'->>'max')::int AS doc_hp_max
    FROM rpg.player_character pc
    JOIN rpg.v_player_character_full f ON f.id = pc.id
    WHERE pc.hp_max <> (f.document->'hp'->>'max')::int
    LIMIT 5
  `);
  if (hpMismatch.length) {
    for (const r of hpMismatch) {
      fail(`${r.id}: hp_max coluna=${r.hp_max} document=${r.doc_hp_max}`);
    }
  } else {
    console.log("  ✓ hp_max alinhado com document.hp.max");
  }

  const { rows: ppMismatch } = await client.query(`
    SELECT pc.id, pc.passive_perception, (f.document->>'passivePerception')::int AS doc_pp
    FROM rpg.player_character pc
    JOIN rpg.v_player_character_full f ON f.id = pc.id
    WHERE pc.passive_perception <> (f.document->>'passivePerception')::int
    LIMIT 5
  `);
  if (ppMismatch.length) {
    for (const r of ppMismatch) {
      fail(`${r.id}: passive_perception coluna=${r.passive_perception} document=${r.doc_pp}`);
    }
  } else {
    console.log("  ✓ passive_perception alinhado com document");
  }

  const { rows: acMismatch } = await client.query(`
    SELECT pc.id, pc.ac_total, (f.document->'armorClass'->>'total')::int AS doc_ac
    FROM rpg.player_character pc
    JOIN rpg.v_player_character_full f ON f.id = pc.id
    WHERE pc.ac_total <> (f.document->'armorClass'->>'total')::int
    LIMIT 5
  `);
  if (acMismatch.length) {
    for (const r of acMismatch) {
      fail(`${r.id}: ac_total coluna=${r.ac_total} document=${r.doc_ac}`);
    }
  } else {
    console.log("  ✓ ac_total alinhado com document.armorClass.total");
  }

  console.log("\n=== Integridade relacional (ferramentas) ===");

  const { rows: missingTools } = await client.query(`
    SELECT pc.id, f.slug AS feat_slug, i.slug AS tool_slug
    FROM rpg.player_character pc
    JOIN rpg.player_character_feat pcf ON pcf.character_id = pc.id
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id
    JOIN LATERAL (
      VALUES
        ('chef', 'utensilios-de-cozinheiro'),
        ('poisoner', 'kit-de-veneno'),
        ('actor', 'kit-de-disfarce'),
        ('healer', 'kit-de-curandeiro')
    ) AS expected(feat_slug, tool_slug) ON expected.feat_slug = f.slug
    JOIN rpg.phb_item i ON i.slug = expected.tool_slug
    LEFT JOIN rpg.player_character_tool pct
      ON pct.character_id = pc.id AND pct.item_id = i.id
    WHERE pct.character_id IS NULL
    LIMIT 10
  `);
  if (missingTools.length) {
    for (const r of missingTools) {
      fail(`${r.id}: feat ${r.feat_slug} sem ferramenta ${r.tool_slug} em player_character_tool`);
    }
  } else {
    console.log("  ✓ feats de ferramenta persistidos em player_character_tool");
  }

  const { rows: missingBgTools } = await client.query(`
    SELECT pc.id, bg.slug AS bg_slug, i.slug AS tool_slug
    FROM rpg.player_character pc
    JOIN rpg.phb_background bg ON bg.id = pc.background_id
    JOIN rpg.phb_item i ON i.id = bg.tool_item_id
    LEFT JOIN rpg.player_character_tool pct
      ON pct.character_id = pc.id AND pct.item_id = i.id
    WHERE bg.tool_proficiency_kind = 'fixed'
      AND pct.character_id IS NULL
    LIMIT 10
  `);
  if (missingBgTools.length) {
    for (const r of missingBgTools) {
      fail(`${r.id}: antecedente ${r.bg_slug} sem ferramenta ${r.tool_slug}`);
    }
  } else {
    console.log("  ✓ antecedentes fixos com ferramenta em player_character_tool");
  }

  const { rows: missingChoiceBgTools } = await client.query(`
    SELECT pc.id, bg.slug AS bg_slug
    FROM rpg.player_character pc
    JOIN rpg.phb_background bg ON bg.id = pc.background_id
    WHERE bg.tool_proficiency_kind = 'choice'
      AND NOT EXISTS (
        SELECT 1 FROM rpg.player_character_tool pct
        WHERE pct.character_id = pc.id AND pct.source = 'background'::rpg.tool_source
      )
    LIMIT 10
  `);
  if (missingChoiceBgTools.length) {
    for (const r of missingChoiceBgTools) {
      fail(`${r.id}: antecedente ${r.bg_slug} (choice) sem ferramenta background`);
    }
  } else {
    console.log("  ✓ antecedentes choice com ao menos 1 ferramenta background");
  }
} finally {
  await client.end();
}

if (errors) {
  console.error(`\n${errors} falha(s) na validação DB/documento.`);
  process.exit(1);
}

console.log("\n✓ Fichas validadas no PostgreSQL — documento + integridade relacional OK");
process.exit(0);
