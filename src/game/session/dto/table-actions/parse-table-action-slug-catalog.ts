import * as fs from 'fs';
import * as path from 'path';

const REPO_ROOT = path.resolve(__dirname, '../../../../..');

function walk(dir: string, pred: (p: string) => boolean, out: string[] = []): string[] {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, pred, out);
    else if (pred(p)) out.push(p);
  }
  return out;
}

function splitSqlFields(s: string): string[] {
  const fields: string[] = [];
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

function parseSqlString(field: string): string | null {
  const t = field.trim();
  if (t.toUpperCase() === 'NULL') return null;
  const m = t.match(/^'((?:[^']|'')*)'$/);
  return m ? m[1].replace(/''/g, "'") : null;
}

/** Extrai tuples de INSERT … VALUES até ON CONFLICT / ; fora de string. */
function extractInsertValueTuples(
  text: string,
  tableName: string,
): { cols: string[]; fields: string[] }[] {
  const out: { cols: string[]; fields: string[] }[] = [];
  const needle = `INSERT INTO ${tableName}`;
  let searchFrom = 0;
  while (searchFrom < text.length) {
    const start = text.toUpperCase().indexOf(needle.toUpperCase(), searchFrom);
    if (start < 0) break;
    const afterInsert = start + needle.length;
    const colsOpen = text.indexOf('(', afterInsert);
    if (colsOpen < 0) break;
    let i = colsOpen;
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
    const colsRaw = text.slice(colsOpen + 1, i - 1);
    const cols = colsRaw.split(',').map((c) => c.trim().toLowerCase());
    const valuesIdx = text.toUpperCase().indexOf('VALUES', i);
    if (valuesIdx < 0) break;
    i = valuesIdx + 'VALUES'.length;
    while (i < text.length) {
      while (i < text.length && /\s/.test(text[i])) i++;
      if (i >= text.length) break;
      const head = text.slice(i, i + 11).toUpperCase();
      if (head.startsWith('ON CONFLICT') || text[i] === ';') break;
      if (text[i] !== '(') {
        i++;
        continue;
      }
      const tupStart = i;
      depth = 0;
      inStr = false;
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
      const tuple = text.slice(tupStart, i);
      out.push({ cols, fields: splitSqlFields(tuple.slice(1, -1)) });
      while (i < text.length && /\s/.test(text[i])) i++;
      if (text[i] === ',') i++;
    }
    searchFrom = i;
  }
  return out;
}

function classSlugFromField(field: string): string | null {
  const m = field.match(/phb_class\s+WHERE\s+slug\s*=\s*'([^']+)'/i);
  return m?.[1] ?? null;
}

export type ClassSlugSet = Map<string, Set<string>>;

function add(map: ClassSlugSet, classSlug: string, action: string): void {
  let set = map.get(classSlug);
  if (!set) {
    set = new Set();
    map.set(classSlug, set);
  }
  set.add(action);
}

/** table_action class-owned em seeds de economy. */
export function loadEconomyTableActionsByClass(options?: {
  /** Se true, ignora seeds GH Cap.2 bulk (sem wire no DTO de classe). */
  excludeGrimHollowBulk?: boolean;
}): ClassSlugSet {
  const map: ClassSlugSet = new Map();
  const files = walk(
    path.join(REPO_ROOT, 'database/seeds/economy'),
    (p) => {
      if (!p.includes('phb_class_economy_action') || !p.endsWith('.sql')) {
        return false;
      }
      if (
        options?.excludeGrimHollowBulk &&
        /grim-hollow-cap2-bulk\.sql$/i.test(p)
      ) {
        return false;
      }
      return true;
    },
  );
  for (const file of files) {
    const text = fs.readFileSync(file, 'utf8');
    for (const row of extractInsertValueTuples(
      text,
      'rpg.phb_class_economy_action',
    )) {
      const classIdx = row.cols.indexOf('class_id');
      const taIdx = row.cols.indexOf('table_action');
      if (classIdx < 0 || taIdx < 0) continue;
      const classSlug = classSlugFromField(row.fields[classIdx] ?? '');
      if (!classSlug) continue;
      const tableAction = parseSqlString(row.fields[taIdx] ?? '');
      if (!tableAction) continue;
      add(map, classSlug, tableAction);
    }
  }
  return map;
}

/** slug do painel por classe. */
export function loadPanelActionSlugsByClass(): ClassSlugSet {
  const map: ClassSlugSet = new Map();
  const files = walk(
    path.join(REPO_ROOT, 'database/seeds'),
    (p) => p.includes('phb_class_panel_action') && p.endsWith('.sql'),
  );
  for (const file of files) {
    const text = fs.readFileSync(file, 'utf8');
    for (const row of extractInsertValueTuples(
      text,
      'rpg.phb_class_panel_action',
    )) {
      const classIdx = row.cols.indexOf('class_id');
      const slugIdx = row.cols.indexOf('slug');
      if (classIdx < 0 || slugIdx < 0) continue;
      const classSlug = classSlugFromField(row.fields[classIdx] ?? '');
      if (!classSlug) continue;
      const slug = parseSqlString(row.fields[slugIdx] ?? '');
      if (!slug) continue;
      add(map, classSlug, slug);
    }
  }
  return map;
}

/** action_slug de effects on_table_action (global — dono tipado no seed). */
export function loadOnTableActionEffectSlugs(): Set<string> {
  const out = new Set<string>();
  const files = walk(
    path.join(REPO_ROOT, 'database/seeds/effect'),
    (p) => p.endsWith('.sql'),
  );
  for (const file of files) {
    const text = fs.readFileSync(file, 'utf8');
    if (!text.includes('on_table_action')) continue;
    for (const m of text.matchAll(
      /'on_table_action'::rpg\.effect_trigger\s*,\s*'([^']+)'/g,
    )) {
      out.add(m[1]);
    }
    for (const m of text.matchAll(
      /on_table_action[\s\S]{0,500}?CROSS JOIN \(VALUES([\s\S]*?)\)\s*AS\s+v\s*\(([^)]+)\)/gi,
    )) {
      const cols = m[2].split(',').map((c) => c.trim());
      const actionIdx = cols.indexOf('action_slug');
      if (actionIdx < 0) continue;
      for (const row of m[1].matchAll(/\(([^)]*)\)/g)) {
        const fields = splitSqlFields(row[1]);
        const slug = parseSqlString(fields[actionIdx] ?? '');
        if (slug) out.add(slug);
      }
    }
    for (const m of text.matchAll(/action_slug\s*=\s*'([^']+)'/gi)) {
      out.add(m[1]);
    }
  }
  return out;
}

/** slugs de phb_subclass_table_action (namespace sem prefixo psi:). */
export function loadSubclassTableActionSlugs(): Set<string> {
  const out = new Set<string>();
  const files = walk(
    path.join(REPO_ROOT, 'database/seeds'),
    (p) => p.includes('phb_subclass_table_action') && p.endsWith('.sql'),
  );
  for (const file of files) {
    const text = fs.readFileSync(file, 'utf8');
    for (const row of extractInsertValueTuples(
      text,
      'rpg.phb_subclass_table_action',
    )) {
      const slugIdx = row.cols.indexOf('slug');
      if (slugIdx >= 0) {
        const slug = parseSqlString(row.fields[slugIdx] ?? '');
        if (slug) out.add(slug);
        continue;
      }
      // VALUES sem lista de cols: (subclass_id, 'slug', ...)
      if (row.fields.length >= 2) {
        const slug = parseSqlString(row.fields[1] ?? '');
        if (slug) out.add(slug);
      }
    }
  }
  return out;
}

/** Consts *_TABLE_ACTION_SLUGS nos DTOs de classe. */
export function loadDtoTableActionSlugsByClass(): ClassSlugSet {
  const map: ClassSlugSet = new Map();
  const files = walk(
    path.join(REPO_ROOT, 'src/game/session/dto/table-actions'),
    (p) => p.endsWith('.ts') && !p.endsWith('.spec.ts') && !p.includes('parse-'),
  );
  const constRe =
    /const\s+([A-Z_]+)_TABLE_ACTION_SLUGS\s*=\s*\[([\s\S]*?)\]\s*as const/g;
  for (const file of files) {
    const text = fs.readFileSync(file, 'utf8');
    let m: RegExpExecArray | null;
    while ((m = constRe.exec(text))) {
      const key = m[1].toLowerCase();
      const slugs = [...m[2].matchAll(/'([^']+)'/g)].map((x) => x[1]);
      map.set(key, new Set(slugs));
    }
  }
  return map;
}

export function unionCatalogForClass(
  classSlug: string,
  economy: ClassSlugSet,
  panel: ClassSlugSet,
  effects: Set<string>,
  subclassActions: Set<string>,
): Set<string> {
  const out = new Set<string>();
  for (const s of economy.get(classSlug) ?? []) out.add(s);
  for (const s of panel.get(classSlug) ?? []) out.add(s);
  for (const s of effects) out.add(s);
  for (const s of subclassActions) out.add(s);
  return out;
}

export { REPO_ROOT };
