import fs from "node:fs";

const files = [
  "database/schema/030_views/0002_v_phb_feat_category.sql",
  "database/schema/030_views/0036_v_phb_species_trait_choices.sql",
  "database/schema/030_views/0037_v_phb_heritage_trait_choices.sql",
  "database/schema/030_views/0056_v_phb_condition.sql",
  "database/schema/030_views/0003_v_phb_weapon_proficiency.sql",
];

for (const f of files) {
  const s = fs.readFileSync(f, "utf8");
  const bad = /Ã.|Â.|â€|‰/.test(s);
  console.log(f.split("/").pop(), "mojibake?", bad);
}

const heritage = fs.readFileSync(
  "database/schema/030_views/0037_v_phb_heritage_trait_choices.sql",
  "utf8",
);
console.log(
  "medium:",
  JSON.stringify(heritage.split(/\n/).find((l) => l.includes("'medium'"))),
);
const featCat = fs.readFileSync(
  "database/schema/030_views/0002_v_phb_feat_category.sql",
  "utf8",
);
console.log("epic:", JSON.stringify(featCat.split(/\n/)[5]));
