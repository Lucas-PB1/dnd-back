import fs from 'fs';
import path from 'path';

function walk(d, pred, acc = []) {
  for (const e of fs.readdirSync(d, { withFileTypes: true })) {
    const p = path.join(d, e.name);
    if (e.isDirectory()) walk(p, pred, acc);
    else if (pred(e.name, p)) acc.push(p);
  }
  return acc;
}

const barrels = walk(
  'src/game/session/application',
  (n) => n === 'index.ts',
);
const allSrc = walk('src', (n) => n.endsWith('.ts'));

function collectExports(file) {
  const t = fs.readFileSync(file, 'utf8');
  const names = new Set();
  for (const m of t.matchAll(/export\s+(?:async\s+)?(?:function|const|class|type|interface|enum)\s+(\w+)/g)) {
    names.add(m[1]);
  }
  for (const m of t.matchAll(/export\s*\{([^}]+)\}/g)) {
    for (const part of m[1].split(',')) {
      const cleaned = part.trim();
      if (!cleaned) continue;
      const asMatch = cleaned.match(/^(\w+)\s+as\s+(\w+)$/);
      if (asMatch) names.add(asMatch[2]);
      else names.add(cleaned.split(/\s+/)[0]);
    }
  }
  for (const m of t.matchAll(/export\s+\*\s+from\s+['"]([^'"]+)['"]/g)) {
    names.add(`*from:${m[1]}`);
  }
  return { text: t, names: [...names] };
}

const report = [];
for (const barrel of barrels) {
  const { text, names } = collectExports(barrel);
  const named = names.filter((n) => !n.startsWith('*from:'));
  const starFrom = names.filter((n) => n.startsWith('*from:')).map((n) => n.slice(6));
  const deadNamed = [];
  for (const name of named) {
    let hits = 0;
    for (const other of allSrc) {
      if (path.resolve(other) === path.resolve(barrel)) continue;
      const ot = fs.readFileSync(other, 'utf8');
      if (ot.includes(name)) hits++;
    }
    if (hits === 0) deadNamed.push(name);
  }
  report.push({
    barrel: barrel.replace(/\\/g, '/'),
    namedCount: named.length,
    deadNamed,
    starFrom,
    preview: text.slice(0, 200).replace(/\s+/g, ' '),
  });
}

for (const r of report) {
  if (r.deadNamed.length || r.namedCount === 0) {
    console.log(JSON.stringify(r, null, 0));
  }
}
console.log('---');
console.log('barrels', barrels.length);
