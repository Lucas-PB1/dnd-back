/**
 * Sync PT user-facing strings from Valda SQL seeds → extracted.json
 * One-shot: node scripts/sync-valda-pt-from-seeds.mjs
 */
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

/** Parse SQL VALUES tuples into arrays of JS values (strings/numbers/null/raw). */
function parseValuesBlocks(sql) {
  const blocks = [];
  const re = /VALUES\s*\(/gi;
  let match;
  while ((match = re.exec(sql))) {
    let i = match.index + match[0].length - 1; // at '('
    // Multi-row: VALUES (...), (...), (...)
    while (i < sql.length && sql[i] === "(") {
      const values = [];
      i += 1;
      while (i < sql.length) {
        while (i < sql.length && /[\s,]/.test(sql[i])) i += 1;
        if (sql[i] === ")") {
          i += 1;
          break;
        }
        if (sql[i] === "'") {
          i += 1;
          let s = "";
          while (i < sql.length) {
            if (sql[i] === "'" && sql[i + 1] === "'") {
              s += "'";
              i += 2;
              continue;
            }
            if (sql[i] === "'") {
              i += 1;
              break;
            }
            s += sql[i];
            i += 1;
          }
          if (sql.slice(i, i + 2) === "::") {
            while (i < sql.length && !/[\s,]/.test(sql[i]) && sql[i] !== ")") {
              i += 1;
            }
            values.push({ cast: s });
            continue;
          }
          values.push(s);
          continue;
        }
        if (/[0-9-]/.test(sql[i])) {
          let n = "";
          if (sql[i] === "-") {
            n += "-";
            i += 1;
          }
          while (i < sql.length && /[0-9.]/.test(sql[i])) {
            n += sql[i];
            i += 1;
          }
          values.push(Number(n));
          continue;
        }
        if (sql.slice(i, i + 4).toUpperCase() === "NULL") {
          values.push(null);
          i += 4;
          continue;
        }
        if (sql.slice(i, i + 5).toUpperCase() === "FALSE") {
          values.push(false);
          i += 5;
          continue;
        }
        if (sql.slice(i, i + 4).toUpperCase() === "TRUE") {
          values.push(true);
          i += 4;
          continue;
        }
        let depth = 0;
        let raw = "";
        while (i < sql.length) {
          const c = sql[i];
          if (c === "(") depth += 1;
          if (c === ")") {
            if (depth === 0) break;
            depth -= 1;
          }
          if (c === "," && depth === 0) break;
          raw += c;
          i += 1;
        }
        values.push({ raw: raw.trim() });
      }
      blocks.push(values);
      while (i < sql.length && /\s/.test(sql[i])) i += 1;
      if (sql[i] === ",") {
        i += 1;
        while (i < sql.length && /\s/.test(sql[i])) i += 1;
        continue;
      }
      break;
    }
  }
  return blocks;
}

function slugFromSelect(raw) {
  if (!raw || typeof raw !== "object" || !raw.raw) return null;
  const m = raw.raw.match(/slug\s*=\s*'([^']+)'/i);
  return m ? m[1] : null;
}

function readSql(rel) {
  return fs.readFileSync(path.join(root, rel), "utf8");
}

function writeJson(rel, data) {
  fs.writeFileSync(
    path.join(root, rel),
    `${JSON.stringify(data, null, 2)}\n`,
    "utf8",
  );
}

// --- Player Pack ---
{
  const jsonPath = "docs/sources/valda-spire-of-secrets/extracted.json";
  const data = JSON.parse(fs.readFileSync(path.join(root, jsonPath), "utf8"));

  data.edition = {
    ...data.edition,
    label: "Valda Spire 2024",
    language: "pt",
    notes:
      "Mage Hand Press — conteúdo traduzido para PT-BR do catálogo Grimoire (regras 2024)",
  };
  if (data.citation) {
    data.citation.chapterTitle =
      "Valda's Spire of Secrets: Pacote do Jogador";
  }

  const subclassRows = parseValuesBlocks(
    readSql("database/seeds/valda/V001_phb_subclass.sql"),
  );
  const bySlug = new Map();
  for (const row of subclassRows) {
    // slug, class_id select, name, tagline, summary, description, citation
    const slug = typeof row[0] === "string" ? row[0] : null;
    if (!slug) continue;
    bySlug.set(slug, {
      name: row[2],
      tagline: row[3],
      summary: row[4],
      description: row[5],
    });
  }
  for (const sc of data.subclasses) {
    const pt = bySlug.get(sc.slug);
    if (!pt) continue;
    Object.assign(sc, pt);
  }

  const featureRows = parseValuesBlocks(
    readSql("database/seeds/valda/V002_phb_subclass_feature.sql"),
  );
  const featuresBySubclass = new Map();
  for (const row of featureRows) {
    const subclassSlug = slugFromSelect(row[0]);
    if (!subclassSlug) continue;
    const list = featuresBySubclass.get(subclassSlug) ?? [];
    list.push({
      level: row[1],
      name: row[2],
      description: row[3],
    });
    featuresBySubclass.set(subclassSlug, list);
  }
  for (const sc of data.subclasses) {
    const list = featuresBySubclass.get(sc.slug) ?? [];
    for (let i = 0; i < sc.features.length; i += 1) {
      const pt = list[i];
      if (!pt) continue;
      sc.features[i].level = pt.level;
      sc.features[i].name = pt.name;
      sc.features[i].description = pt.description;
    }
  }

  const speciesRows = parseValuesBlocks(
    readSql("database/seeds/valda/V003_phb_species.sql"),
  );
  const speciesBySlug = new Map();
  for (const row of speciesRows) {
    const slug = row[0];
    if (typeof slug !== "string") continue;
    // slug, name, creature_type, size, speed, description, ...
    speciesBySlug.set(slug, { name: row[1], description: row[5] });
  }
  for (const sp of data.species) {
    const pt = speciesBySlug.get(sp.slug);
    if (!pt) continue;
    Object.assign(sp, pt);
  }

  const traitRows = parseValuesBlocks(
    readSql("database/seeds/valda/V004_phb_species_trait.sql"),
  );
  const traitsBySpecies = new Map();
  for (const row of traitRows) {
    const speciesSlug = slugFromSelect(row[0]);
    if (!speciesSlug) continue;
    const list = traitsBySpecies.get(speciesSlug) ?? [];
    list.push({ name: row[1], description: row[2] });
    traitsBySpecies.set(speciesSlug, list);
  }
  for (const sp of data.species) {
    const list = traitsBySpecies.get(sp.slug) ?? [];
    if (!sp.traits) continue;
    for (let i = 0; i < sp.traits.length; i += 1) {
      const pt = list[i];
      if (!pt) continue;
      sp.traits[i].name = pt.name;
      sp.traits[i].description = pt.description;
    }
  }

  // option values — update labels in nested structure if present
  const optionSql = readSql(
    "database/seeds/valda/V006_phb_species_option_value.sql",
  );
  const optionRows = parseValuesBlocks(optionSql);
  // VALUES typically: option_def_id select, slug, label, ...
  const optionBySlug = new Map();
  for (const row of optionRows) {
    const slug = typeof row[1] === "string" ? row[1] : null;
    const label = typeof row[2] === "string" ? row[2] : null;
    if (slug && label) optionBySlug.set(slug, label);
  }
  function walkOptions(node) {
    if (!node || typeof node !== "object") return;
    if (Array.isArray(node)) {
      for (const item of node) walkOptions(item);
      return;
    }
    if (typeof node.slug === "string" && optionBySlug.has(node.slug)) {
      if ("label" in node) node.label = optionBySlug.get(node.slug);
      if ("name" in node && !node.name?.includes?.("-")) {
        // only if looks like option value name field used as label
      }
    }
    for (const v of Object.values(node)) walkOptions(v);
  }
  walkOptions(data.species);

  const featRows = parseValuesBlocks(
    readSql("database/seeds/valda/V007_phb_feat.sql"),
  );
  // V007: slug, name, category_id, repeatable, prerequisite, citation — sem description
  for (const feat of data.feats) {
    const matching = featRows.find((r) => r[0] === feat.slug);
    if (!matching) continue;
    if (typeof matching[1] === "string") feat.name = matching[1];
  }

  const benefitRows = parseValuesBlocks(
    readSql("database/seeds/valda/V008_phb_feat_benefit.sql"),
  );
  const benefitsByFeat = new Map();
  for (const row of benefitRows) {
    const featSlug = slugFromSelect(row[0]);
    if (!featSlug) continue;
    // feat_id, sort_order, name, description
    const list = benefitsByFeat.get(featSlug) ?? [];
    list.push({
      name: typeof row[2] === "string" ? row[2] : "",
      description: typeof row[3] === "string" ? row[3] : "",
    });
    benefitsByFeat.set(featSlug, list);
  }
  for (const feat of data.feats) {
    const list = benefitsByFeat.get(feat.slug) ?? [];
    if (!feat.benefits) continue;
    for (let i = 0; i < feat.benefits.length; i += 1) {
      const pt = list[i];
      if (!pt) continue;
      if (typeof feat.benefits[i] === "string") {
        feat.benefits[i] = pt.description || pt.name;
      } else {
        if (pt.name) feat.benefits[i].name = pt.name;
        if (pt.description) feat.benefits[i].description = pt.description;
      }
    }
    if (list.length) {
      feat.description = list.map((b) => b.description).filter(Boolean).join("\n\n");
    }
  }

  const spellRows = parseValuesBlocks(
    readSql("database/seeds/valda/V009_phb_spell.sql"),
  );
  for (const spell of data.spells) {
    const row = spellRows.find((r) => r[0] === spell.slug);
    if (!row) continue;
    const strings = row.filter((v) => typeof v === "string");
    // slug, name, ... description (longest)
    if (strings.length >= 2) spell.name = strings[1];
    const desc = strings.slice(2).sort((a, b) => b.length - a.length)[0];
    if (desc) spell.description = desc;
    // levelLabel if present as short string
    const levelish = strings.find(
      (s) =>
        s !== spell.slug &&
        s !== spell.name &&
        s !== desc &&
        /truco|nível|cantrip|level/i.test(s),
    );
    if (levelish) spell.levelLabel = levelish;
  }

  const itemRows = parseValuesBlocks(
    readSql("database/seeds/valda/V011_phb_item.sql"),
  );
  for (const item of data.magicItems ?? []) {
    const row = itemRows.find((r) => r[0] === item.slug);
    if (!row) continue;
    // slug, item_type cast, name, cost, weight, description, properties
    if (typeof row[2] === "string") item.name = row[2];
    if (typeof row[5] === "string") item.description = row[5];
  }

  writeJson(jsonPath, data);
  console.log(
    "player-pack:",
    data.subclasses[0]?.name,
    data.feats[0]?.name,
    data.species[0]?.name,
  );
}

// --- Gunslinger ---
{
  const jsonPath = "docs/sources/valda-gunslinger/extracted.json";
  const data = JSON.parse(fs.readFileSync(path.join(root, jsonPath), "utf8"));

  data.edition = {
    ...data.edition,
    label: "Valda Spire 2024",
    language: "pt",
    notes:
      "Mage Hand Press — conteúdo traduzido para PT-BR do catálogo Grimoire (regras 2024)",
  };
  if (data.citation) {
    data.citation.chapterTitle =
      "Valda's Spire of Secrets: A Classe do Pistoleiro";
  }

  const classRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G001_phb_class.sql"),
  );
  const classRow = classRows.find((r) => r[0] === "gunslinger");
  if (classRow && data.class) {
    data.class.name = classRow[1];
    data.class.tagline = classRow[2];
    data.class.summary = classRow[3];
    data.class.description = classRow[4];
  }

  const featureRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G008_phb_class_feature.sql"),
  );
  // class_id select, level, name, description, ...
  const classFeatures = featureRows.map((row) => ({
    level: row[1],
    name: row[2],
    description: row[3],
  }));
  if (Array.isArray(data.features)) {
    for (let i = 0; i < data.features.length; i += 1) {
      const pt = classFeatures[i];
      if (!pt) continue;
      data.features[i].name = pt.name;
      data.features[i].description = pt.description;
      if (pt.level != null) data.features[i].level = pt.level;
    }
  }

  const subclassRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G009_phb_subclass.sql"),
  );
  const scBySlug = new Map();
  for (const row of subclassRows) {
    if (typeof row[0] !== "string") continue;
    scBySlug.set(row[0], {
      name: row[2],
      tagline: row[3],
      summary: row[4],
      description: row[5],
    });
  }
  for (const sc of data.subclasses ?? []) {
    const pt = scBySlug.get(sc.slug);
    if (pt) Object.assign(sc, pt);
  }

  const scFeatureRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G010_phb_subclass_feature.sql"),
  );
  const scFeatures = new Map();
  for (const row of scFeatureRows) {
    const subclassSlug = slugFromSelect(row[0]);
    if (!subclassSlug) continue;
    const list = scFeatures.get(subclassSlug) ?? [];
    list.push({ level: row[1], name: row[2], description: row[3] });
    scFeatures.set(subclassSlug, list);
  }
  for (const sc of data.subclasses ?? []) {
    const list = scFeatures.get(sc.slug) ?? [];
    if (!sc.features) continue;
    for (let i = 0; i < sc.features.length; i += 1) {
      const pt = list[i];
      if (!pt) continue;
      sc.features[i].name = pt.name;
      sc.features[i].description = pt.description;
      sc.features[i].level = pt.level;
    }
  }

  // G011: slug, name, description (multi-row VALUES)
  for (const row of parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G011_phb_weapon_property.sql"),
  )) {
    const item = data.weaponProperties?.find((p) => p.slug === row[0]);
    if (!item) continue;
    if (typeof row[1] === "string") item.name = row[1];
    if (typeof row[2] === "string") item.description = row[2];
  }
  for (const row of parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G011b_phb_weapon_mastery.sql"),
  )) {
    const item = data.masteryProperties?.find((p) => p.slug === row[0]);
    if (!item) continue;
    if (typeof row[1] === "string") item.name = row[1];
    if (typeof row[2] === "string") item.description = row[2];
  }

  // G012 firearms: slug, type cast, name, cost jsonb, weight, description, properties
  for (const row of parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G012_phb_firearm.sql"),
  )) {
    if (typeof row[0] !== "string") continue;
    const item = data.weapons?.find((w) => w.slug === row[0]);
    if (!item) continue;
    if (typeof row[2] === "string") item.name = row[2];
    if (typeof row[5] === "string") item.description = row[5];
  }
  for (const row of parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G013_phb_ammunition.sql"),
  )) {
    if (typeof row[0] !== "string") continue;
    const item = data.ammunition?.find((a) => a.slug === row[0]);
    if (!item) continue;
    if (typeof row[2] === "string") item.name = row[2];
    if (typeof row[5] === "string") item.description = row[5];
  }

  const featRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G014_phb_feat.sql"),
  );
  for (const feat of data.feats ?? []) {
    const row = featRows.find((r) => r[0] === feat.slug);
    if (!row) continue;
    if (typeof row[1] === "string") feat.name = row[1];
  }

  const benefitRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G015_phb_feat_benefit.sql"),
  );
  const benefitsByFeat = new Map();
  for (const row of benefitRows) {
    const featSlug = slugFromSelect(row[0]);
    if (!featSlug) continue;
    const list = benefitsByFeat.get(featSlug) ?? [];
    list.push({
      name: typeof row[2] === "string" ? row[2] : "",
      description: typeof row[3] === "string" ? row[3] : "",
    });
    benefitsByFeat.set(featSlug, list);
  }
  for (const feat of data.feats ?? []) {
    const list = benefitsByFeat.get(feat.slug) ?? [];
    if (!feat.benefits) continue;
    for (let i = 0; i < feat.benefits.length; i += 1) {
      const pt = list[i];
      if (!pt) continue;
      if (typeof feat.benefits[i] === "string") {
        feat.benefits[i] = pt.description || pt.name;
      } else {
        if (pt.name) feat.benefits[i].name = pt.name;
        if (pt.description) feat.benefits[i].description = pt.description;
      }
    }
    if (list.length) {
      feat.description = list.map((b) => b.description).filter(Boolean).join("\n\n");
    }
  }

  const spellRows = parseValuesBlocks(
    readSql("database/seeds/valda-gunslinger/G016_phb_spell.sql"),
  );
  for (const spell of data.spells ?? []) {
    const row = spellRows.find((r) => r[0] === spell.slug);
    if (!row) continue;
    const strings = row.filter((v) => typeof v === "string");
    if (strings.length >= 2) spell.name = strings[1];
    const desc = strings.slice(2).sort((a, b) => b.length - a.length)[0];
    if (desc) spell.description = desc;
  }

  // Manobras no SQL: "Maneuver: Name" / "Manobra: Name"
  if (Array.isArray(data.maneuvers) && data.maneuvers.length) {
    const rest = classFeatures.slice(data.features?.length ?? 0);
    for (let i = 0; i < data.maneuvers.length; i += 1) {
      const pt = rest[i];
      if (!pt) continue;
      data.maneuvers[i].name = String(pt.name).replace(
        /^(Maneuver|Manobra):\s*/i,
        "",
      );
      data.maneuvers[i].description = pt.description;
    }
  }

  writeJson(jsonPath, data);
  console.log("gunslinger:", data.class?.name, data.subclasses?.[0]?.name);
}
