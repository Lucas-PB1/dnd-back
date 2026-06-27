/**
 * Relatório estatístico das fichas + verificação cruzada PV/CA/passiva + cobertura de traços.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import {
  AASIMAR_REVELATIONS,
  DRAGON_ANCESTRIES,
  ELF_LINEAGE_SPELLS,
  GIANT_ANCESTRIES,
  GNOME_LINEAGES,
  TIEFLING_LEGACIES,
  expectedArmorClass,
  expectedMaxHpForCharacter,
  expectedPassivePerception,
  expectedSpeciesResources,
} from "./character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const charsDir = path.join(__dirname, "..", "data/characters");
const SPECIES_INDEX = JSON.parse(
  fs.readFileSync(path.join(__dirname, "..", "data/phb/species/index.json"), "utf8")
);

const files = fs.readdirSync(charsDir).filter((f) => f.endsWith(".json"));
const docs = files.map((f) => JSON.parse(fs.readFileSync(path.join(charsDir, f), "utf8")));

const issues = [];
const byClass = {};
const byLevel = {};
const bySpecies = {};
const bySubclass = {};
const withStyle = { blessed: 0, druidic: 0, other: 0 };
const resources = { rage: 0, focus: 0, channelDivinity: 0 };
const speciesResources = {};
const feats = {};

const speciesLevels = {};
const elfLineages = new Set();
const tieflingLegacies = new Set();
const gnomeLineages = new Set();
const dragonAncestries = new Set();
const giantAncestries = new Set();
const aasimarRevelations = new Set();

for (const doc of docs) {
  byClass[doc.classId] = (byClass[doc.classId] ?? 0) + 1;
  byLevel[doc.level] = (byLevel[doc.level] ?? 0) + 1;
  bySpecies[doc.speciesId] = (bySpecies[doc.speciesId] ?? 0) + 1;

  if (!speciesLevels[doc.speciesId]) speciesLevels[doc.speciesId] = new Set();
  speciesLevels[doc.speciesId].add(doc.level);

  const sc = doc.speciesChoices ?? {};
  if (sc.lineageId) elfLineages.add(sc.lineageId);
  if (sc.infernalLegacyId) tieflingLegacies.add(sc.infernalLegacyId);
  if (sc.gnomeLineageId) gnomeLineages.add(sc.gnomeLineageId);
  if (sc.dragonAncestryId) dragonAncestries.add(sc.dragonAncestryId);
  if (sc.giantAncestryId) giantAncestries.add(sc.giantAncestryId);
  if (sc.aasimarRevelationId) aasimarRevelations.add(sc.aasimarRevelationId);

  for (const key of Object.keys(expectedSpeciesResources(doc))) {
    speciesResources[key] = (speciesResources[key] ?? 0) + 1;
  }

  if (doc.subclassId) {
    const key = `${doc.classId}/${doc.subclassId}`;
    bySubclass[key] = (bySubclass[key] ?? 0) + 1;
  }

  const style = doc.classChoices?.fightingStyleId;
  if (style === "blessed-warrior") withStyle.blessed++;
  else if (style === "druidic-warrior") withStyle.druidic++;
  else if (style) withStyle.other++;

  if (doc.resources?.rage) resources.rage++;
  if (doc.resources?.focusPoints) resources.focus++;
  if (doc.resources?.channelDivinity) resources.channelDivinity++;

  for (const f of doc.feats ?? []) {
    feats[f.featId] = (feats[f.featId] ?? 0) + 1;
  }

  const hp = expectedMaxHpForCharacter(doc);
  if (doc.hp?.max !== hp) {
    issues.push(`${doc.id}: PV ${doc.hp?.max} ≠ ${hp}`);
  }
  const ac = expectedArmorClass(doc);
  if (doc.armorClass?.total !== ac.total) {
    issues.push(`${doc.id}: CA ${doc.armorClass?.total} ≠ ${ac.total}`);
  }
  const passive = expectedPassivePerception(doc);
  if (doc.passivePerception !== passive) {
    issues.push(`${doc.id}: passiva ${doc.passivePerception} ≠ ${passive}`);
  }
}

function printHistogram(title, obj) {
  console.log(`\n### ${title}`);
  for (const [k, v] of Object.entries(obj).sort((a, b) => b[1] - a[1])) {
    console.log(`- ${k}: ${v}`);
  }
}

function coverageLine(label, found, expected) {
  const missing = expected.filter((id) => !found.has(id));
  const ok = missing.length === 0;
  console.log(`- ${label}: ${found.size}/${expected.length}${ok ? " ✓" : ` — faltam: ${missing.join(", ")}`}`);
  if (!ok) issues.push(`${label} incompleto: ${missing.join(", ")}`);
}

console.log(`# Análise de ${docs.length} fichas (classe única — sem multiclasse)\n`);

printHistogram("Por classe", byClass);
printHistogram("Por nível", byLevel);
printHistogram("Por espécie", bySpecies);
printHistogram("Subclasses (amostra)", bySubclass);

console.log("\n### Cobertura por espécie (níveis 1–20)");
for (const sp of SPECIES_INDEX.species) {
  const levels = speciesLevels[sp.id] ?? new Set();
  const missing = [];
  for (let l = 1; l <= 20; l++) {
    if (!levels.has(l)) missing.push(l);
  }
  const status = missing.length === 0 ? "✓" : `faltam ${missing.length} níveis`;
  console.log(`- ${sp.id}: ${levels.size}/20 (${status})`);
  if (missing.length) issues.push(`${sp.id}: níveis ausentes ${missing.join(", ")}`);
}

console.log("\n### Variantes de traços de espécie");
coverageLine("Linhagens élficas", elfLineages, Object.keys(ELF_LINEAGE_SPELLS));
coverageLine("Legados tiferinos", tieflingLegacies, TIEFLING_LEGACIES);
coverageLine("Linhagens gnômicas", gnomeLineages, GNOME_LINEAGES);
coverageLine("Heranças dracônicas", dragonAncestries, DRAGON_ANCESTRIES);
coverageLine("Ancestralidades de golias", giantAncestries, GIANT_ANCESTRIES);
coverageLine("Revelações aasimar", aasimarRevelations, AASIMAR_REVELATIONS);

console.log("\n### Recursos de espécie (fichas com traço)");
printHistogram("Traços com usos", speciesResources);

console.log("\n### Estilos de luta especiais");
console.log(`- Combatente Abençoado: ${withStyle.blessed}`);
console.log(`- Combatente Druídico: ${withStyle.druidic}`);
console.log(`- Outros estilos: ${withStyle.other}`);

console.log("\n### Recursos de classe");
console.log(`- Fúria: ${resources.rage}`);
console.log(`- Pontos de Foco: ${resources.focus}`);
console.log(`- Canalizar Divindade: ${resources.channelDivinity}`);

printHistogram("Talentos (top)", Object.fromEntries(Object.entries(feats).slice(0, 12)));

if (issues.length) {
  console.log(`\n## Inconsistências (${issues.length})`);
  for (const msg of issues.slice(0, 30)) console.log(`- ${msg}`);
  if (issues.length > 30) console.log(`- … e mais ${issues.length - 30}`);
  process.exit(1);
}

console.log("\n✓ Todas as fichas coerentes com PV, CA, passiva e cobertura de traços.");
process.exit(0);
