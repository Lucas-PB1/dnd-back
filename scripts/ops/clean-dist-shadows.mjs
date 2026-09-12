/**
 * Remove dist/*.js that shadow a same-named folder whose entry is index.js.
 * Node resolves the file before the directory — stale after file→folder refactors.
 *
 * Does NOT remove when the folder is only a namespace (helpers) and the .js file
 * is the real module (e.g. build-response.ts + build-response/*.ts).
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const distRoot = path.resolve(
  path.dirname(fileURLToPath(import.meta.url)),
  '../..',
  'dist',
);

function walkDirs(dir, visit) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      visit(full);
      walkDirs(full, visit);
    }
  }
}

let removed = 0;
walkDirs(distRoot, (dirPath) => {
  const shadowJs = `${dirPath}.js`;
  if (!fs.existsSync(shadowJs)) return;
  const indexJs = path.join(dirPath, 'index.js');
  if (!fs.existsSync(indexJs)) return;

  for (const ext of ['.js', '.js.map', '.d.ts', '.d.ts.map']) {
    const file = `${dirPath}${ext}`;
    if (!fs.existsSync(file)) continue;
    fs.unlinkSync(file);
    removed += 1;
  }
});

if (removed > 0) {
  console.log(`[clean-dist-shadows] removed ${removed} stale file(s)`);
}
