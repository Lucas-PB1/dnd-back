import fs from 'fs';
import path from 'path';

function walk(d, pred, acc = []) {
  for (const e of fs.readdirSync(d, { withFileTypes: true })) {
    const p = path.join(d, e.name);
    if (e.isDirectory()) {
      if (e.name === 'node_modules' || e.name === 'dist') continue;
      walk(d === 'src' && e.name === 'game' ? p : p, pred, acc);
      walk(p, pred, acc);
    } else if (pred(e.name, p)) acc.push(p);
  }
  return acc;
}

// Fix double-walk bug - rewrite cleanly
function walk2(d, pred, acc = []) {
  for (const e of fs.readdirSync(d, { withFileTypes: true })) {
    const p = path.join(d, e.name);
    if (e.isDirectory()) {
      if (e.name === 'node_modules' || e.name === 'dist') continue;
      walk2(p, pred, acc);
    } else if (pred(e.name, p)) acc.push(p);
  }
  return acc;
}

const sessionFiles = walk2(
  'src/game/session/application',
  (n) =>
    n.endsWith('.ts') &&
    !n.endsWith('.spec.ts') &&
    n !== 'index.ts' &&
    !n.endsWith('.dto.ts'),
);

const allSrc = walk2('src', (n) => n.endsWith('.ts'));

const orphans = [];
for (const f of sessionFiles) {
  const base = path.basename(f, '.ts');
  const text = fs.readFileSync(f, 'utf8');
  const exportNames = [];
  for (const m of text.matchAll(
    /export\s+(?:async\s+)?(?:function|const|class|type|interface|enum)\s+(\w+)/g,
  )) {
    exportNames.push(m[1]);
  }
  for (const m of text.matchAll(/export\s*\{([^}]+)\}/g)) {
    for (const part of m[1].split(',')) {
      const cleaned = part.trim();
      if (!cleaned) continue;
      const asMatch = cleaned.match(/^(?:\w+\s+as\s+)?(\w+)$/);
      if (asMatch) exportNames.push(asMatch[1]);
    }
  }

  // File is orphan if no other file imports its path basename or any export
  let imported = false;
  const relHints = [
    base,
    f.replace(/\\/g, '/').replace(/^src\//, ''),
  ];
  for (const other of allSrc) {
    if (path.resolve(other) === path.resolve(f)) continue;
    const ot = fs.readFileSync(other, 'utf8');
    if (ot.includes(`/${base}'`) || ot.includes(`/${base}"`) || ot.includes(`\\${base}'`)) {
      imported = true;
      break;
    }
    if (ot.includes(`from './${base}'`) || ot.includes(`from \"./${base}\"`)) {
      imported = true;
      break;
    }
    if (ot.includes(`/${base}/`) || ot.includes(`'${base}'`)) {
      // weak
    }
  }
  // stronger: check path fragment
  const fragment = f.replace(/\\/g, '/').split('/application/')[1]?.replace(/\.ts$/, '');
  if (fragment) {
    for (const other of allSrc) {
      if (path.resolve(other) === path.resolve(f)) continue;
      const ot = fs.readFileSync(other, 'utf8');
      if (ot.includes(fragment) || ot.includes(base)) {
        // check import-like
        if (
          /from ['"][^'"]*/.test(ot) &&
          (ot.includes(`/${base}'`) ||
            ot.includes(`/${base}"`) ||
            ot.includes(`./${base}'`) ||
            ot.includes(`./${base}"`) ||
            ot.includes(`../${base}'`) ||
            ot.includes(`${fragment}'`) ||
            ot.includes(`${fragment}"`))
        ) {
          imported = true;
          break;
        }
      }
    }
  }

  if (!imported) {
    orphans.push({
      f: f.replace(/\\/g, '/'),
      exports: exportNames.slice(0, 8),
    });
  }
}

console.log('session app files', sessionFiles.length, 'orphan suspects', orphans.length);
for (const o of orphans) console.log(o.f, 'exports:', o.exports.join(', '));
