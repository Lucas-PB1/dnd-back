/**
 * Gera data/phb/spells/by-class/*.json a partir do campo `classes` de cada magia.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  CLASS_ID_TO_NAME,
  CLASS_NAME_TO_ID,
  SPELL_LIST_CLASSES,
} from "./spell-class-map.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const spellsDir = path.join(root, "data/phb/spells");
const outDir = path.join(spellsDir, "by-class");
fs.mkdirSync(outDir, { recursive: true });

const index = JSON.parse(
  fs.readFileSync(path.join(spellsDir, "index.json"), "utf8")
);

const lists = Object.fromEntries(
  SPELL_LIST_CLASSES.map(({ id }) => [
    id,
    { byLevel: Object.fromEntries([...Array(10)].map((_, i) => [String(i), []])) },
  ])
);

for (const entry of index.spells) {
  const spell = JSON.parse(
    fs.readFileSync(path.join(spellsDir, entry.file), "utf8")
  );

  const item = {
    id: spell.id,
    name: spell.name,
    school: spell.school,
  };
  if (spell.ritual) item.ritual = true;
  if (spell.concentration) item.concentration = true;

  for (const className of spell.classes) {
    const classId = CLASS_NAME_TO_ID[className];
    if (!classId) {
      throw new Error(`Classe desconhecida em ${spell.id}: ${className}`);
    }
    const levelKey = String(spell.level);
    lists[classId].byLevel[levelKey].push(item);
  }
}

for (const { id, name, listLabel } of SPELL_LIST_CLASSES) {
  const byLevel = lists[id].byLevel;
  for (const spells of Object.values(byLevel)) {
    spells.sort((a, b) => a.name.localeCompare(b.name, "pt-BR"));
  }

  const spellCount = Object.values(byLevel).reduce((n, arr) => n + arr.length, 0);
  const fileName = `${id}.json`;
  const doc = {
    $schema: "../../../schema/spell-by-class.schema.json",
    classId: id,
    className: name,
    listLabel,
    source: index.source,
    spellCount,
    byLevel,
  };

  fs.writeFileSync(path.join(outDir, fileName), JSON.stringify(doc, null, 2) + "\n");
  console.log(`✓ ${fileName} (${spellCount} magias)`);
}

const indexDoc = {
  $schema: "../../../schema/spells-by-class-index.schema.json",
  source: index.source,
  classCount: SPELL_LIST_CLASSES.length,
  classes: SPELL_LIST_CLASSES.map(({ id, name }) => {
    const file = `${id}.json`;
    const doc = JSON.parse(fs.readFileSync(path.join(outDir, file), "utf8"));
    return {
      classId: id,
      className: CLASS_ID_TO_NAME[id] ?? name,
      file,
      spellCount: doc.spellCount,
    };
  }),
};

fs.writeFileSync(
  path.join(outDir, "index.json"),
  JSON.stringify(indexDoc, null, 2) + "\n"
);
console.log("✓ index.json");
