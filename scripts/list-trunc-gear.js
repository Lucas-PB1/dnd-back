const fs = require("fs");
const t = fs.readFileSync(
  "d:/Projetos/dnd-work/dnd-api/database/seeds/phb/S046_phb_item.sql",
  "utf8",
);
const lines = t.split(/\n/).filter((l) => /^\s+\('/.test(l));
function parse(line) {
  const m = line.match(
    /^\s+\('([^']+)',\s*'(\w+)'::rpg\.item_type,\s*'((?:\\'|[^'])*)',\s*('\{[^']*\}'|NULL)::jsonb,\s*'((?:\\'|[^'])*)',\s*(NULL|'((?:\\'|[^'])*)')/,
  );
  if (!m) return null;
  const desc = m[6] === "NULL" ? null : m[7].replace(/\\'/g, "'");
  return { slug: m[1], type: m[2], name: m[3], desc, len: desc ? desc.length : 0 };
}
const rows = lines.map(parse).filter(Boolean);
const gear = rows.filter((r) => r.type === "gear" || r.type === "focus");
const complete = gear.filter(
  (r) => r.desc && /[.!?)]$/.test(r.desc.trim()),
);
const trunc = gear.filter(
  (r) => r.desc && !/[.!?)]$/.test(r.desc.trim()),
);
console.log(
  JSON.stringify(
    {
      total: gear.length,
      complete: complete.length,
      trunc: trunc.length,
      completeSlugs: complete.map((r) => r.slug),
      truncSlugs: trunc.map((r) => r.slug),
    },
    null,
    2,
  ),
);
fs.writeFileSync(
  "d:/Projetos/dnd-work/dnd-api/database/seeds/phb/_trunc-gear.json",
  JSON.stringify(trunc, null, 2),
);
