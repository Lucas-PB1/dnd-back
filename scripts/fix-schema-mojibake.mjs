import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const iconv = require("../node_modules/iconv-lite");

function looksLikeMojibake(s) {
  return /Ã.|Â.|â€|‰|œ|ž|Ÿ/.test(s);
}

function fixText(s) {
  if (!looksLikeMojibake(s)) return s;
  try {
    const buf = iconv.encode(s, "win1252");
    const fixed = iconv.decode(buf, "utf8");
    if (fixed.includes("\uFFFD")) return s;
    if (looksLikeMojibake(fixed) && fixed.length >= s.length) return s;
    return fixed;
  } catch {
    return s;
  }
}

const root = path.resolve("database/schema");
let changed = 0;

function walk(dir) {
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, ent.name);
    if (ent.isDirectory()) {
      walk(p);
      continue;
    }
    if (!ent.name.endsWith(".sql")) continue;
    const raw = fs.readFileSync(p, "utf8");
    let next = raw;
    for (let i = 0; i < 3; i++) {
      const t = fixText(next);
      if (t === next) break;
      next = t;
    }
    if (next !== raw) {
      fs.writeFileSync(p, next, "utf8");
      changed += 1;
      console.log("fixed", path.relative(process.cwd(), p));
    }
  }
}

walk(root);
console.log("changed", changed);
