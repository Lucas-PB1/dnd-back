import fs from 'fs';
import path from 'path';

/**
 * @param {string} baseDir
 * @param {string} [pattern]
 */
export function listSqlFiles(baseDir, pattern = '**/*.sql') {
  if (!fs.existsSync(baseDir)) {
    throw new Error(`Directory not found: ${baseDir}`);
  }

  const files = [];

  function walk(dir) {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        walk(fullPath);
      } else if (entry.isFile() && entry.name.endsWith('.sql')) {
        files.push(fullPath);
      }
    }
  }

  walk(baseDir);
  files.sort((a, b) => a.localeCompare(b, undefined, { sensitivity: 'base' }));
  return files;
}

/**
 * @param {string} filePath
 * @param {string} baseDir
 */
export function migrationVersion(filePath, baseDir) {
  const relative = path.relative(baseDir, filePath).replace(/\\/g, '/');
  return relative.replace(/\.sql$/i, '');
}
