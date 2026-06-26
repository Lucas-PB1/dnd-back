/**
 * Auditoria profunda: progressão × PDF e listas × magias.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { PDFParse } from "pdf-parse";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";
import { CLASS_NAME_TO_ID } from "./spell-class-map.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");

const TABLE_PAGES = {
  bard: 66,
  cleric: 88,
  druid: 98,
  sorcerer: 110,
  wizard: 154,
  warlock: 76,
  paladin: 174,
  ranger: 124,
};

function parseTailTokens(tailStr) {
  return tailStr
    .trim()
    .split(/\s+/)
    .map((t) => (t === "—" || t === "-" ? 0 : Number(t)));
}

function slotsFromValues(values, slotCount) {
  const slots = {};
  const start = values.length - slotCount;
  for (let i = 0; i < slotCount; i++) {
    const v = values[start + i];
    if (v > 0) slots[String(i + 1)] = v;
  }
  return slots;
}

function compareSlots(a, b) {
  return JSON.stringify(a ?? {}) === JSON.stringify(b ?? {});
}

function isHeaderLine(line) {
  return /^[1-9](?:\s+[1-9])+$/.test(line.trim());
}

function extractProgressionLines(text, warlock = false) {
  const rows = new Map();
  for (const raw of text.split(/\r?\n/)) {
    const line = raw.trim();
    if (!line || isHeaderLine(line)) continue;
    const m = warlock
      ? line.match(/^(\d{1,2}) (\d) /)
      : line.match(/^(\d{1,2}) \+(\d) /);
    if (!m) continue;
    const level = Number(m[1]);
    if (level < 1 || level > 20) continue;
    rows.set(level, { line, pb: Number(m[2]) });
  }
  return rows;
}

/** Cauda numérica após o texto de características. */
function numericTail(line, warlock = false) {
  const m = warlock
    ? line.match(/^(\d{1,2}) (\d) (.+)$/)
    : line.match(/^(\d{1,2}) \+(\d) (.+)$/);
  if (!m) return null;
  const rest = m[3];
  const tailMatch = rest.match(/((?:\d+|—|D\d+)(?:\s+(?:\d+|—|D\d+))+)\s*$/);
  if (!tailMatch) return null;
  return tailMatch[1];
}

const parser = new PDFParse({
  data: fs.readFileSync(path.join(root, "doc/livro-jogador.pdf")),
});

const issues = [];
function fail(msg) {
  issues.push(msg);
}

for (const [classId, pageNum] of Object.entries(TABLE_PAGES)) {
  const result = await parser.getText({ partial: [pageNum] });
  const text = result.pages[0].text;
  const warlock = classId === "warlock";
  const pdfLines = extractProgressionLines(text, warlock);
  const data = CLASS_PROGRESSION[classId];

  if (pdfLines.size < 20) {
    fail(`${classId}: ${pdfLines.size}/20 linhas na pág. ${pageNum}`);
  }

  for (let level = 1; level <= 20; level++) {
    const pdfRow = pdfLines.get(level);
    const our = data.levels[level - 1];
    if (!pdfRow) {
      fail(`${classId} L${level}: linha ausente no PDF`);
      continue;
    }
    if (our.proficiencyBonus !== pdfRow.pb) {
      fail(`${classId} L${level}: PB ${our.proficiencyBonus} ≠ +${pdfRow.pb}`);
    }

    const tailStr = numericTail(pdfRow.line, warlock);
    if (!tailStr) {
      fail(`${classId} L${level}: cauda numérica não encontrada`);
      continue;
    }

    if (classId === "bard") {
      const die = Number(tailStr.match(/D(\d+)/)?.[1]);
      const afterDie = tailStr.replace(/D\d+\s*/, "");
      const vals = parseTailTokens(afterDie);
      if (vals.length !== 11) {
        fail(`${classId} L${level}: esperava 11 colunas, obteve ${vals.length}`);
        continue;
      }
      const [cantrips, prepared, ...slotVals] = vals;
      const slots = slotsFromValues(slotVals, 9);
      if (our.inspirationDie !== die)
        fail(`${classId} L${level}: inspirationDie D${our.inspirationDie} ≠ D${die}`);
      if (our.cantrips !== cantrips)
        fail(`${classId} L${level}: cantrips ${our.cantrips} ≠ ${cantrips}`);
      if (our.preparedSpells !== prepared)
        fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      if (!compareSlots(our.spellSlots, slots))
        fail(`${classId} L${level}: slots divergem`);
    } else if (classId === "warlock") {
      const vals = parseTailTokens(tailStr);
      if (vals.length !== 5) {
        fail(`${classId} L${level}: esperava 5 colunas, obteve ${vals.length} (${tailStr})`);
        continue;
      }
      const [invocations, cantrips, prepared, pactSlots, pactLevel] = vals;
      if (our.invocations !== invocations)
        fail(`${classId} L${level}: invocations ${our.invocations} ≠ ${invocations}`);
      if (our.cantrips !== cantrips)
        fail(`${classId} L${level}: cantrips ${our.cantrips} ≠ ${cantrips}`);
      if (our.preparedSpells !== prepared)
        fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      if (our.pactSlots !== pactSlots)
        fail(`${classId} L${level}: pactSlots ${our.pactSlots} ≠ ${pactSlots}`);
      if (our.pactSlotLevel !== pactLevel)
        fail(`${classId} L${level}: pactSlotLevel ${our.pactSlotLevel} ≠ ${pactLevel}`);
    } else if (classId === "paladin" || classId === "ranger") {
      const vals = parseTailTokens(tailStr);
      if (vals.length !== 7) {
        fail(`${classId} L${level}: esperava 7 colunas, obteve ${vals.length}`);
        continue;
      }
      const [extra, prepared, ...slotVals] = vals;
      const slots = slotsFromValues(slotVals, 5);
      if (our.preparedSpells !== prepared)
        fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      if (classId === "ranger" && our.favoredEnemy !== extra)
        fail(`${classId} L${level}: favoredEnemy ${our.favoredEnemy} ≠ ${extra}`);
      if (classId === "paladin" && our.channelDivinity !== extra)
        fail(`${classId} L${level}: channelDivinity ${our.channelDivinity} ≠ ${extra}`);
      if (!compareSlots(our.spellSlots, slots))
        fail(`${classId} L${level}: slots divergem`);
    } else {
      const vals = parseTailTokens(tailStr);
      const expected = 11;
      if (vals.length !== expected) {
        fail(`${classId} L${level}: esperava ${expected} colunas, obteve ${vals.length}`);
        continue;
      }
      const slots = slotsFromValues(vals, 9);

      if (classId === "wizard") {
        const [cantrips, prepared] = vals;
        if (our.cantrips !== cantrips)
          fail(`${classId} L${level}: cantrips ${our.cantrips} ≠ ${cantrips}`);
        if (our.preparedSpells !== prepared)
          fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      } else if (classId === "cleric") {
        const [cd, cantrips, prepared] = vals;
        if (our.channelDivinity !== cd)
          fail(`${classId} L${level}: channelDivinity ${our.channelDivinity} ≠ ${cd}`);
        if (our.cantrips !== cantrips)
          fail(`${classId} L${level}: cantrips ${our.cantrips} ≠ ${cantrips}`);
        if (our.preparedSpells !== prepared)
          fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      } else if (classId === "druid") {
        const [ws, cantrips, prepared] = vals;
        if (our.wildShape !== ws)
          fail(`${classId} L${level}: wildShape ${our.wildShape} ≠ ${ws}`);
        if (our.cantrips !== cantrips)
          fail(`${classId} L${level}: cantrips ${our.cantrips} ≠ ${cantrips}`);
        if (our.preparedSpells !== prepared)
          fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      } else if (classId === "sorcerer") {
        const [sp, cantrips, prepared] = vals;
        if (our.sorceryPoints !== sp)
          fail(`${classId} L${level}: sorceryPoints ${our.sorceryPoints} ≠ ${sp}`);
        if (our.cantrips !== cantrips)
          fail(`${classId} L${level}: cantrips ${our.cantrips} ≠ ${cantrips}`);
        if (our.preparedSpells !== prepared)
          fail(`${classId} L${level}: prepared ${our.preparedSpells} ≠ ${prepared}`);
      }
      if (!compareSlots(our.spellSlots, slots))
        fail(`${classId} L${level}: slots divergem`);
    }
  }
}

const spellsDir = path.join(root, "data/phb/spells");
const spellIndex = JSON.parse(fs.readFileSync(path.join(spellsDir, "index.json"), "utf8"));
for (const entry of spellIndex.spells) {
  const spell = JSON.parse(fs.readFileSync(path.join(spellsDir, entry.file), "utf8"));
  for (const cn of spell.classes) {
    if (!CLASS_NAME_TO_ID[cn]) fail(`magia ${spell.id}: classe desconhecida "${cn}"`);
  }
}

await parser.destroy();

if (issues.length) {
  console.error(`✗ ${issues.length} problema(s) na auditoria profunda:\n`);
  for (const i of issues) console.error(" -", i);
  process.exit(1);
}
console.log("✓ Auditoria profunda OK (progressão × PDF + listas)");
process.exit(0);
