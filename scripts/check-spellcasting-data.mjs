/**
 * Checagens de qualidade: listas por classe e tabelas de progressão.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { CLASS_NAME_TO_ID, SPELL_LIST_CLASSES } from "./spell-class-map.mjs";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const spellsDir = path.join(root, "data/phb/spells");
const byClassDir = path.join(spellsDir, "by-class");

const spellIndex = JSON.parse(
  fs.readFileSync(path.join(spellsDir, "index.json"), "utf8")
);

const expectedByClass = Object.fromEntries(
  SPELL_LIST_CLASSES.map(({ id }) => [id, new Set()])
);

for (const entry of spellIndex.spells) {
  const spell = JSON.parse(
    fs.readFileSync(path.join(spellsDir, entry.file), "utf8")
  );
  for (const className of spell.classes) {
    const classId = CLASS_NAME_TO_ID[className];
    if (!classId) throw new Error(`Classe desconhecida: ${className}`);
    expectedByClass[classId].add(spell.id);
  }
}

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

for (const { id, name } of SPELL_LIST_CLASSES) {
  const doc = JSON.parse(
    fs.readFileSync(path.join(byClassDir, `${id}.json`), "utf8")
  );

  if (doc.classId !== id) fail(`${id}: classId incorreto`);
  if (doc.className !== name) fail(`${id}: className incorreto`);

  const ids = new Set();
  for (const [level, spells] of Object.entries(doc.byLevel)) {
    for (const s of spells) {
      if (ids.has(s.id)) fail(`${id}: magia duplicada ${s.id}`);
      ids.add(s.id);
      const levelNum = Number(level);
      const original = JSON.parse(
        fs.readFileSync(path.join(spellsDir, `${s.id}.json`), "utf8")
      );
      if (original.level !== levelNum) {
        fail(`${id}: ${s.id} no círculo ${level}, mas magia é círculo ${original.level}`);
      }
      if (!original.classes.includes(name)) {
        fail(`${id}: ${s.id} não lista ${name} no JSON da magia`);
      }
    }
  }

  const expected = expectedByClass[id];
  if (ids.size !== expected.size) {
    fail(`${id}: contagem ${ids.size}, esperado ${expected.size}`);
  }
  for (const spellId of expected) {
    if (!ids.has(spellId)) fail(`${id}: falta magia ${spellId}`);
  }
  if (doc.spellCount !== ids.size) {
    fail(`${id}: spellCount=${doc.spellCount}, real=${ids.size}`);
  }
}

for (const [classId, progression] of Object.entries(CLASS_PROGRESSION)) {
  const classFile = path.join(root, "data/phb/classes", `${classId}.json`);
  const doc = JSON.parse(fs.readFileSync(classFile, "utf8"));

  if (!doc.progression) {
    fail(`classes/${classId}: sem progression`);
    continue;
  }

  if (doc.progression.levels.length !== 20) {
    fail(`classes/${classId}: progression com ${doc.progression.levels.length} níveis`);
  }

  for (let i = 0; i < 20; i++) {
    const row = doc.progression.levels[i];
    const expectedLevel = i + 1;
    if (row.level !== expectedLevel) {
      fail(`classes/${classId}: nível ${i} tem level=${row.level}`);
    }
    const expectedPb = Math.min(6, 2 + Math.floor((expectedLevel - 1) / 4));
    if (row.proficiencyBonus !== expectedPb) {
      fail(
        `classes/${classId} nível ${expectedLevel}: PB=${row.proficiencyBonus}, esperado +${expectedPb}`
      );
    }
  }

  if (JSON.stringify(doc.progression) !== JSON.stringify(CLASS_PROGRESSION[classId])) {
    fail(`classes/${classId}: progression diverge dos dados fonte`);
  }

  const cols = new Set(doc.progression.columns);
  for (const row of doc.progression.levels) {
    for (const key of Object.keys(row)) {
      if (key === "level") continue;
      if (!cols.has(key)) {
        fail(`classes/${classId} L${row.level}: coluna extra "${key}"`);
      }
    }
    if (classId === "warlock") {
      if (row.spellSlots) fail(`classes/warlock L${row.level}: não deve ter spellSlots`);
      if (!row.pactSlots || !row.pactSlotLevel)
        fail(`classes/warlock L${row.level}: pactSlots/pactSlotLevel ausentes`);
    } else if (classId === "paladin" || classId === "ranger") {
      if (row.cantrips != null) fail(`classes/${classId} L${row.level}: half-caster sem cantrips`);
    } else if (!row.cantrips && row.cantrips !== 0) {
      fail(`classes/${classId} L${row.level}: cantrips ausente`);
    }
  }

  const classDoc = doc;
  const listLabel = `Lista de Magias de ${classDoc.name}`;
  const byClass = JSON.parse(
    fs.readFileSync(path.join(byClassDir, `${classId}.json`), "utf8")
  );
  if (byClass.listLabel !== listLabel) {
    fail(`classes/${classId}: listLabel diverge da lista (${byClass.listLabel})`);
  }
  if (classDoc.related?.spells?.[0] !== listLabel) {
    fail(`classes/${classId}: related.spells não aponta para ${listLabel}`);
  }
}

// Conjuradores não devem ter progression; não-conjuradores não devem ter
const CASTER_IDS = new Set(Object.keys(CLASS_PROGRESSION));
const classIndex = JSON.parse(
  fs.readFileSync(path.join(root, "data/phb/index.json"), "utf8")
);
for (const cls of classIndex.classes) {
  const doc = JSON.parse(
    fs.readFileSync(path.join(root, "data/phb", cls.file), "utf8")
  );
  const isCaster = CASTER_IDS.has(cls.id);
  if (isCaster && !doc.progression) fail(`classes/${cls.id}: conjurador sem progression`);
  if (!isCaster && doc.progression) fail(`classes/${cls.id}: não-conjurador com progression`);
}

// Ordem alfabética nas listas
for (const { id } of SPELL_LIST_CLASSES) {
  const doc = JSON.parse(fs.readFileSync(path.join(byClassDir, `${id}.json`), "utf8"));
  for (const [level, spells] of Object.entries(doc.byLevel)) {
    const names = spells.map((s) => s.name);
    const sorted = [...names].sort((a, b) => a.localeCompare(b, "pt-BR"));
    if (names.join("|") !== sorted.join("|")) {
      fail(`${id} círculo ${level}: lista fora de ordem alfabética`);
    }
  }
}

// Amostras cruzadas (níveis 1, 10, 20) — fonte única: class-progression-data.mjs
const SPOT_LEVELS = [1, 10, 20];
for (const [classId, progression] of Object.entries(CLASS_PROGRESSION)) {
  const doc = JSON.parse(
    fs.readFileSync(path.join(root, "data/phb/classes", `${classId}.json`), "utf8")
  );
  for (const lvl of SPOT_LEVELS) {
    const expected = progression.levels[lvl - 1];
    const row = doc.progression.levels[lvl - 1];
    if (JSON.stringify(row) !== JSON.stringify(expected)) {
      fail(`classes/${classId} L${lvl}: diverge da fonte de progressão`);
    }
  }
}

// Antecedentes com spellList devem apontar para classe existente
const bgIndex = JSON.parse(
  fs.readFileSync(path.join(root, "data/phb/backgrounds/index.json"), "utf8")
);
for (const bg of bgIndex.backgrounds) {
  const file = path.join(root, "data/phb/backgrounds", bg.file);
  const doc = JSON.parse(fs.readFileSync(file, "utf8"));
  if (!doc.feat?.spellList) continue;
  const classId = CLASS_NAME_TO_ID[doc.feat.spellList];
  if (!classId) fail(`background ${bg.id}: spellList inválido ${doc.feat.spellList}`);
  const listFile = path.join(byClassDir, `${classId}.json`);
  if (!fs.existsSync(listFile)) fail(`background ${bg.id}: lista ${classId} ausente`);
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log("✓ Checagens OK — listas por classe e progressão consistentes");
process.exit(0);
