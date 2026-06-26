/**
 * Verifica progressão contra o PDF (parsers por classe).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { PDFParse } from "pdf-parse";
import { CLASS_PROGRESSION } from "./class-progression-data.mjs";

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

function sanitizeLine(line) {
  return line.replace(/CAPÍTULO[\s\S]*$/, "").trim();
}

function numericTailFromLine(line, count, warlock = false) {
  const rest = sanitizeLine(
    warlock ? line.replace(/^\d{1,2} \d+ /, "") : line.replace(/^\d{1,2} \+\d+ /, "")
  );
  const tokens = rest.split(/\s+/);
  const numeric = [];
  for (let i = tokens.length - 1; i >= 0 && numeric.length < count; i--) {
    const t = tokens[i];
    if (t === "—" || /^\d+$/.test(t)) {
      numeric.unshift(t === "—" ? 0 : Number(t));
    } else {
      break;
    }
  }
  if (numeric.length < count) {
    const pad = count - numeric.length;
    if (pad > 2) return null;
    while (numeric.length < count) numeric.push(0);
  }
  return numeric;
}

function tailFromLine(line, count, warlock = false) {
  return numericTailFromLine(line, count, warlock);
}

function slots(vals, count) {
  const s = {};
  for (let i = 0; i < count; i++) {
    if (vals[i] > 0) s[String(i + 1)] = vals[i];
  }
  return s;
}

function parseRow(classId, line) {
  const warlock = classId === "warlock";
  const m = warlock
    ? line.match(/^(\d{1,2}) (\d) /)
    : line.match(/^(\d{1,2}) \+(\d) /);
  if (!m) return null;
  const level = Number(m[1]);
  const proficiencyBonus = Number(m[2]);

  if (classId === "bard") {
    const inspirationDie = Number(line.match(/\bD(\d+)\b/)?.[1]);
    const after = line.replace(/^[\s\S]*?\bD\d+\s+/, "");
    const t = after.split(/\s+/).map((x) => (x === "—" ? 0 : Number(x)));
    const [cantrips, preparedSpells, ...rest] = t;
    return {
      level,
      proficiencyBonus,
      inspirationDie,
      cantrips,
      preparedSpells,
      spellSlots: slots(rest, 9),
    };
  }

  if (classId === "warlock") {
    const t = tailFromLine(line, 5, true);
    if (!t) return null;
    const [invocations, cantrips, preparedSpells, pactSlots, pactSlotLevel] = t;
    return {
      level,
      proficiencyBonus,
      invocations,
      cantrips,
      preparedSpells,
      pactSlots,
      pactSlotLevel,
    };
  }

  if (classId === "paladin" || classId === "ranger") {
    const t = tailFromLine(line, 7);
    if (!t) return null;
    const [extra, preparedSpells, ...rest] = t;
    const base = { level, proficiencyBonus, preparedSpells, spellSlots: slots(rest, 5) };
    if (classId === "paladin") return { ...base, channelDivinity: extra };
    return { ...base, favoredEnemy: extra };
  }

  if (classId === "wizard") {
    const t = tailFromLine(line, 11);
    if (!t) return null;
    const [cantrips, preparedSpells, ...rest] = t;
    return { level, proficiencyBonus, cantrips, preparedSpells, spellSlots: slots(rest, 9) };
  }

  if (classId === "cleric") {
    const t = tailFromLine(line, 12);
    if (!t) return null;
    const [channelDivinity, cantrips, preparedSpells, ...rest] = t;
    return {
      level,
      proficiencyBonus,
      channelDivinity,
      cantrips,
      preparedSpells,
      spellSlots: slots(rest, 9),
    };
  }

  if (classId === "druid") {
    const t = tailFromLine(line, 12);
    if (!t) return null;
    const [wildShape, cantrips, preparedSpells, ...rest] = t;
    return {
      level,
      proficiencyBonus,
      wildShape,
      cantrips,
      preparedSpells,
      spellSlots: slots(rest, 9),
    };
  }

  if (classId === "sorcerer") {
    const t = tailFromLine(line, 12);
    if (!t) return null;
    const [sorceryPoints, cantrips, preparedSpells, ...rest] = t;
    return {
      level,
      proficiencyBonus,
      sorceryPoints,
      cantrips,
      preparedSpells,
      spellSlots: slots(rest, 9),
    };
  }

  return null;
}

function getLines(text, warlock) {
  const raw = text.split(/\n/).map((l) => l.trim()).filter(Boolean);
  const merged = [];
  let buf = null;

  for (const line of raw) {
    const isStart = warlock ? /^\d{1,2} \d /.test(line) : /^\d{1,2} \+\d /.test(line);
    const isHeader =
      /^CAPÍTULO/.test(line) ||
      /^Características de/.test(line) ||
      /^Nível$/.test(line) ||
      /^Bônus de/.test(line) ||
      /^1 2 3 4/.test(line);

    if (isHeader) continue;

    if (isStart) {
      if (buf) merged.push(sanitizeLine(buf));
      buf = line;
      continue;
    }

    if (buf && !/^Subclasse/.test(line) && !/^Lista de Magias/.test(line)) {
      buf += ` ${line}`;
    }
  }
  if (buf) merged.push(sanitizeLine(buf));

  return merged.filter((line) =>
    warlock ? /^\d{1,2} \d /.test(line) : /^\d{1,2} \+\d /.test(line)
  );
}

const parser = new PDFParse({
  data: fs.readFileSync(path.join(root, "doc/livro-jogador.pdf")),
});

const issues = [];
for (const [classId, pageNum] of Object.entries(TABLE_PAGES)) {
  const result = await parser.getText({ partial: [pageNum] });
  const lines = getLines(result.pages[0].text, classId === "warlock");
  const byLevel = new Map();
  for (const line of lines) {
    const row = parseRow(classId, line);
    if (row) byLevel.set(row.level, row);
  }

  for (const expected of CLASS_PROGRESSION[classId].levels) {
    const pdf = byLevel.get(expected.level);
    if (!pdf) {
      issues.push(`${classId} L${expected.level}: linha não parseada do PDF`);
      continue;
    }
    const { level: _l, ...exp } = expected;
    const { level: _l2, ...got } = pdf;
    for (const [k, v] of Object.entries(exp)) {
      if (JSON.stringify(got[k]) !== JSON.stringify(v)) {
        issues.push(
          `${classId} L${expected.level}: ${k} PDF=${JSON.stringify(got[k])} dados=${JSON.stringify(v)}`
        );
      }
    }
  }
}

await parser.destroy();

if (issues.length) {
  console.error(`✗ ${issues.length} divergência(s) PDF × dados:\n`);
  for (const i of issues.slice(0, 30)) console.error(" -", i);
  if (issues.length > 30) console.error(` ... e mais ${issues.length - 30}`);
  process.exit(1);
}
console.log("✓ Progressão confere com PDF (8 classes × 20 níveis)");
process.exit(0);
