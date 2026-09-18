/**
 * Aplica docs/source/extracts/grim-hollow/cap7-spells-pt.json
 * sobre database/seeds/spell/grim-hollow/phb_spell.cap7.sql
 * (name, description, higher_levels; preserva prefixo [Sangromancia]).
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const overlayPath = path.join(
  root,
  'docs/source/extracts/grim-hollow/cap7-spells-pt.json',
);
const seedPath = path.join(
  root,
  'database/seeds/spell/grim-hollow/phb_spell.cap7.sql',
);

function sqlString(value) {
  if (value == null) return 'NULL';
  return "'" + String(value).replace(/'/g, "''") + "'";
}

function splitSqlFields(s) {
  const fields = [];
  let cur = '';
  let depth = 0;
  let inStr = false;
  for (let i = 0; i < s.length; i++) {
    const ch = s[i];
    if (inStr) {
      cur += ch;
      if (ch === "'" && s[i + 1] === "'") {
        cur += s[++i];
        continue;
      }
      if (ch === "'") inStr = false;
      continue;
    }
    if (ch === "'") {
      inStr = true;
      cur += ch;
      continue;
    }
    if (ch === '(') {
      depth++;
      cur += ch;
      continue;
    }
    if (ch === ')') {
      depth--;
      cur += ch;
      continue;
    }
    if (ch === ',' && depth === 0) {
      fields.push(cur.trim());
      cur = '';
      continue;
    }
    cur += ch;
  }
  if (cur.trim()) fields.push(cur.trim());
  return fields;
}

function parseSqlString(field) {
  const t = field.trim();
  if (t.toUpperCase() === 'NULL') return null;
  const m = t.match(/^'((?:[^']|'')*)'$/s);
  return m ? m[1].replace(/''/g, "'") : null;
}

const overlay = JSON.parse(fs.readFileSync(overlayPath, 'utf8'));
let text = fs.readFileSync(seedPath, 'utf8');
const needle = 'INSERT INTO rpg.phb_spell';
let applied = 0;
let missing = [];
let searchFrom = 0;

while (searchFrom < text.length) {
  const start = text.indexOf(needle, searchFrom);
  if (start < 0) break;
  const valuesIdx = text.indexOf('VALUES', start);
  if (valuesIdx < 0) break;
  let i = valuesIdx + 'VALUES'.length;
  while (i < text.length && /\s/.test(text[i])) i++;
  if (text[i] !== '(') {
    searchFrom = i + 1;
    continue;
  }
  const tupStart = i;
  let depth = 0;
  let inStr = false;
  for (; i < text.length; i++) {
    const ch = text[i];
    if (inStr) {
      if (ch === "'" && text[i + 1] === "'") {
        i++;
        continue;
      }
      if (ch === "'") inStr = false;
      continue;
    }
    if (ch === "'") {
      inStr = true;
      continue;
    }
    if (ch === '(') depth++;
    else if (ch === ')') {
      depth--;
      if (depth === 0) {
        i++;
        break;
      }
    }
  }
  const tupEnd = i;
  const fields = splitSqlFields(text.slice(tupStart + 1, tupEnd - 1));
  const slug = parseSqlString(fields[0] ?? '');
  if (!slug || !overlay[slug]) {
    searchFrom = tupEnd;
    continue;
  }
  const pt = overlay[slug];
  const oldDesc = parseSqlString(fields[15] ?? '') ?? '';
  const sangPrefix = oldDesc.startsWith('[Sangromancia]')
    ? '[Sangromancia] '
    : '';
  const next = [...fields];
  if (pt.name) next[1] = sqlString(pt.name);
  if (pt.materialDescription != null) {
    next[10] = sqlString(pt.materialDescription);
  }
  if (pt.componentsLabel != null) {
    next[11] = sqlString(pt.componentsLabel);
  }
  if (pt.description != null) {
    next[15] = sqlString(sangPrefix + pt.description);
  }
  if ('higherLevels' in pt) {
    next[16] = sqlString(pt.higherLevels);
  }
  const rebuilt = `(\n${next.map((f) => `  ${f}`).join(',\n')}\n)`;
  text = text.slice(0, tupStart) + rebuilt + text.slice(tupEnd);
  applied++;
  searchFrom = tupStart + rebuilt.length;
}

for (const slug of Object.keys(overlay)) {
  if (!text.includes(`'${slug}'`)) missing.push(slug);
}

fs.writeFileSync(seedPath, text);
console.log(
  JSON.stringify(
    {
      applied,
      overlayEntries: Object.keys(overlay).length,
      missingInSeed: missing,
    },
    null,
    2,
  ),
);
