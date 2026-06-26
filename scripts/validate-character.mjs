/**
 * Valida fichas de personagem (schema + regras derivadas do PHB).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";
import {
  LIFE_DOMAIN_PREPARED,
  allCantripIds,
  expectedChannelDivinity,
  expectedClassCantrips,
  expectedMaxHp,
  expectedPreparedCount,
  expectedProficiencyBonus,
  expectedSpellSlots,
  lineageCantrips,
  lineagePreparedSpells,
  loadBackground,
  loadClass,
} from "./character-rules.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const schemaDir = path.join(root, "data/schema");
const phb = path.join(root, "data/phb");
const charsDir = path.join(root, "data/characters");

const ajv = new Ajv2020({ allErrors: true, strict: false });
addFormats(ajv);
ajv.addSchema(JSON.parse(fs.readFileSync(path.join(schemaDir, "character.schema.json"), "utf8")));
const validateSchema = ajv.getSchema("https://rpg.local/schema/character.schema.json");

function collectItemIds() {
  const ids = new Set();
  const add = (id) => ids.add(id);
  JSON.parse(fs.readFileSync(path.join(phb, "weapons/weapons.json"), "utf8")).weapons.forEach((w) =>
    add(w.id)
  );
  JSON.parse(fs.readFileSync(path.join(phb, "armor/armor.json"), "utf8")).items.forEach((a) =>
    add(a.id)
  );
  JSON.parse(
    fs.readFileSync(path.join(phb, "equipment/gear/adventuring-gear.json"), "utf8")
  ).items.forEach((g) => add(g.id));
  for (const file of ["equipment/tools/artisan.json", "equipment/tools/other.json"]) {
    JSON.parse(fs.readFileSync(path.join(phb, file), "utf8")).tools?.forEach((t) => add(t.id));
  }
  return ids;
}

const speciesIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "species/index.json"), "utf8")).species.map((s) => s.id)
);
const backgroundIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "backgrounds/index.json"), "utf8")).backgrounds.map(
    (b) => b.id
  )
);
const classIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8")).classes.map((c) => c.id)
);
const subclassIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "index.json"), "utf8")).classes.flatMap((c) =>
    c.subclasses.map((s) => s.id)
  )
);
const featIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "feats/index.json"), "utf8")).feats.map((f) => f.id)
);
const spellIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "spells/index.json"), "utf8")).spells.map((s) => s.id)
);
const skillIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "skills/index.json"), "utf8")).skills.map((s) => s.id)
);
const itemIds = collectItemIds();

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

function validateSpellcastingRules(doc) {
  const { classId, level, subclassId, speciesChoices, classChoices, spellcasting, feats } = doc;

  let expectedCantrips = expectedClassCantrips(classId, level);
  if (expectedCantrips == null) return;

  if (classId === "cleric" && classChoices?.divineOrder === "thaumaturge") {
    expectedCantrips += 1;
  }

  const miFeat = feats.find((f) => f.featId === "magic-initiate");
  const miCantrips = miFeat?.magicInitiate?.cantripIds ?? [];
  const lineageCant = speciesChoices?.lineageId ? lineageCantrips(speciesChoices.lineageId) : [];

  const classCantrips = spellcasting.cantrips.class ?? [];
  const miCantripsListed = spellcasting.cantrips["magic-initiate"] ?? [];
  const lineageListed = spellcasting.cantrips["elf-lineage"] ?? [];

  if (classCantrips.length !== expectedCantrips) {
    fail(
      `${doc.id}: truques de classe ${classCantrips.length}, esperado ${expectedCantrips} (tabela + bônus)`
    );
  }

  if (miFeat && miCantrips.length === 2) {
    if (miCantripsListed.length !== 2) {
      fail(`${doc.id}: magic-initiate exige 2 truques, tem ${miCantripsListed.length}`);
    }
    for (const id of miCantrips) {
      if (!miCantripsListed.includes(id)) {
        fail(`${doc.id}: truque ${id} do talento não listado em spellcasting.cantrips`);
      }
    }
  }

  if (speciesChoices?.lineageId) {
    if (lineageListed.length !== lineageCant.length) {
      fail(`${doc.id}: truques de linhagem ${lineageListed.length}, esperado ${lineageCant.length}`);
    }
    for (const id of lineageCant) {
      if (!lineageListed.includes(id)) fail(`${doc.id}: truque de linhagem ${id} ausente`);
    }
  }

  const expectedPrepared = expectedPreparedCount(classId, level);
  const classPrepared = spellcasting.prepared.class ?? [];
  if (expectedPrepared != null && classPrepared.length !== expectedPrepared) {
    fail(
      `${doc.id}: magias preparadas de classe ${classPrepared.length}, esperado ${expectedPrepared} (tabela)`
    );
  }

  if (subclassId === "life" && LIFE_DOMAIN_PREPARED[level]) {
    const domainListed = spellcasting.prepared["life-domain"] ?? [];
    const expected = LIFE_DOMAIN_PREPARED[level];
    if (domainListed.length !== expected.length) {
      fail(`${doc.id}: domínio da vida ${domainListed.length} magias, esperado ${expected.length}`);
    }
    for (const id of expected) {
      if (!domainListed.includes(id)) fail(`${doc.id}: magia de domínio ${id} ausente`);
    }
  }

  if (speciesChoices?.lineageId) {
    const expectedLineage = lineagePreparedSpells(speciesChoices.lineageId, level);
    const lineagePrep = spellcasting.prepared["elf-lineage"] ?? [];
    if (lineagePrep.length !== expectedLineage.length) {
      fail(
        `${doc.id}: magias de linhagem ${lineagePrep.length}, esperado ${expectedLineage.length}`
      );
    }
    for (const id of expectedLineage) {
      if (!lineagePrep.includes(id)) fail(`${doc.id}: magia de linhagem ${id} ausente`);
    }
  }

  if (miFeat?.magicInitiate?.preparedSpellId) {
    const miPrep = spellcasting.prepared["magic-initiate"] ?? [];
    if (!miPrep.includes(miFeat.magicInitiate.preparedSpellId)) {
      fail(`${doc.id}: magia de magic-initiate não está em prepared`);
    }
  }

  const expectedSlots = expectedSpellSlots(classId, level);
  if (expectedSlots && JSON.stringify(spellcasting.slotsMax) !== JSON.stringify(expectedSlots)) {
    fail(
      `${doc.id}: slotsMax ${JSON.stringify(spellcasting.slotsMax)} ≠ tabela ${JSON.stringify(expectedSlots)}`
    );
  }

  const allCantrips = allCantripIds(doc);
  const uniqueCantrips = new Set(allCantrips);
  if (uniqueCantrips.size !== allCantrips.length) {
    fail(`${doc.id}: truque duplicado entre fontes`);
  }

  const cd = expectedChannelDivinity(classId, level);
  if (cd != null && doc.resources?.channelDivinity?.max !== cd) {
    fail(`${doc.id}: Canalizar Divindade max=${doc.resources?.channelDivinity?.max}, esperado ${cd}`);
  }
}

function validateStartingGear(doc) {
  const cls = loadClass(doc.classId);
  const bg = loadBackground(doc.backgroundId);
  const classOpt = cls.startingEquipment?.options?.find(
    (o) => o.label === doc.startingPackages.classOption
  );
  const bgOpt = bg.equipment?.packages?.find((p) => p.id === doc.startingPackages.backgroundOption);
  if (!classOpt) fail(`${doc.id}: opção de equipamento de classe inválida`);
  if (!bgOpt) fail(`${doc.id}: opção de equipamento de antecedente inválida`);
}

const files = fs.readdirSync(charsDir).filter((f) => f.endsWith(".json"));
if (!files.length) {
  console.error("✗ Nenhuma ficha em data/characters/");
  process.exit(1);
}

for (const file of files) {
  const doc = JSON.parse(fs.readFileSync(path.join(charsDir, file), "utf8"));
  const label = file;

  if (!validateSchema(doc)) {
    fail(`${label}: schema — ${ajv.errorsText(validateSchema.errors)}`);
    continue;
  }

  if (!speciesIds.has(doc.speciesId)) fail(`${label}: speciesId ${doc.speciesId}`);
  if (!backgroundIds.has(doc.backgroundId)) fail(`${label}: backgroundId ${doc.backgroundId}`);
  if (!classIds.has(doc.classId)) fail(`${label}: classId ${doc.classId}`);
  if (doc.subclassId && !subclassIds.has(doc.subclassId))
    fail(`${label}: subclassId ${doc.subclassId}`);

  for (const f of doc.feats) {
    if (!featIds.has(f.featId)) fail(`${label}: featId ${f.featId}`);
  }

  for (const ids of [Object.values(doc.spellcasting.cantrips), Object.values(doc.spellcasting.prepared)]) {
    for (const list of ids) {
      for (const id of list) if (!spellIds.has(id)) fail(`${label}: spellId ${id}`);
    }
  }

  for (const s of doc.skillProficiencies) {
    if (!skillIds.has(s.skillId)) fail(`${label}: skillId ${s.skillId}`);
  }

  for (const item of doc.equipment) {
    if (!itemIds.has(item.itemId)) fail(`${label}: itemId ${item.itemId}`);
  }

  validateSpellcastingRules(doc);
  validateStartingGear(doc);

  const expectedHp = expectedMaxHp(doc.classId, doc.level, doc.abilities.constituicao);
  if (expectedHp != null && doc.hp?.max !== expectedHp) {
    fail(`${label}: hp.max=${doc.hp?.max}, esperado ${expectedHp} (PV fixo + CON)`);
  }

  const expectedProf = expectedProficiencyBonus(doc.level);
  if (expectedProf != null && doc.proficiencyBonus != null && doc.proficiencyBonus !== expectedProf) {
    fail(`${label}: proficiencyBonus=${doc.proficiencyBonus}, esperado ${expectedProf}`);
  }
}

if (errors) {
  console.error(`\n${errors} falha(s).`);
  process.exit(1);
}

console.log(`✓ ${files.length} ficha(s) válida(s) — schema e regras`);
process.exit(0);
