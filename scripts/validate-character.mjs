/**
 * Valida fichas de personagem (schema + regras derivadas do PHB).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";
import {
  allCantripIds,
  expectedClassCantrips,
  expectedMaxHpForCharacter,
  expectedPreparedCount,
  expectedProficiencyBonus,
  expectedSpellSlots,
  expectedSubclassPrepared,
  isSpellcaster,
  lineageCantrips,
  lineagePreparedSpells,
  loadBackground,
  loadClass,
  validateAbilityScores,
  validateArmorClass,
  validateClassResources,
  validateEquippedArmorTraining,
  validateFightingStyle,
  validatePassivePerception,
  validateSkillProficiencies,
  validateStartingEquipment,
  validateSubclassLevel,
  validateWeaponMasteryChoices,
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
const alignmentIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "creation/alignments.json"), "utf8")).alignments.map(
    (a) => a.id
  )
);
const languageIds = new Set(
  JSON.parse(fs.readFileSync(path.join(phb, "creation/languages.json"), "utf8")).languages.map(
    (l) => l.id
  )
);
const abilityMethods = new Set(
  JSON.parse(
    fs.readFileSync(path.join(phb, "creation/ability-generation.json"), "utf8")
  ).methods.map((m) => m.id)
);
const itemIds = collectItemIds();

let errors = 0;
function fail(msg) {
  console.error(`✗ ${msg}`);
  errors++;
}

function validateSpellcastingRules(doc) {
  const { classId, level, subclassId, speciesChoices, classChoices, spellcasting, feats } = doc;

  const caster = isSpellcaster(classId, level);
  const hasSpellcastingData =
    spellcasting &&
    (Object.keys(spellcasting.cantrips ?? {}).length > 0 ||
      Object.keys(spellcasting.prepared ?? {}).length > 0 ||
      Object.keys(spellcasting.slotsMax ?? {}).length > 0);

  if (!caster && !hasSpellcastingData) return;

  if (caster && !spellcasting) {
    fail(`${doc.id}: classe conjuradora exige spellcasting`);
    return;
  }

  let expectedCantrips = expectedClassCantrips(classId, level);
  if (expectedCantrips == null && !hasSpellcastingData) return;
  if (expectedCantrips == null) expectedCantrips = 0;

  if (classId === "cleric" && classChoices?.divineOrder === "thaumaturge") {
    expectedCantrips += 1;
  }

  const altStyle = classChoices?.fightingStyleId;
  if (altStyle === "blessed-warrior" || altStyle === "druidic-warrior") {
    expectedCantrips = 2;
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

  if (subclassId) {
    const domain = expectedSubclassPrepared(classId, subclassId, level, classChoices);
    if (domain?.requiresTerrain) {
      fail(`${doc.id}: classChoices.landTerrainId ausente (Círculo da Terra)`);
    } else if (domain) {
      const domainListed = spellcasting.prepared[domain.sourceKey] ?? [];
      if (domainListed.length !== domain.spellIds.length) {
        fail(
          `${doc.id}: ${domain.sourceKey} ${domainListed.length} magias, esperado ${domain.spellIds.length}`
        );
      }
      for (const id of domain.spellIds) {
        if (!domainListed.includes(id)) fail(`${doc.id}: magia de subclasse ${id} ausente`);
      }
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
}

function validateStartingGear(doc) {
  const check = validateStartingEquipment(doc);
  if (!check.ok) fail(`${doc.id}: equipamento inicial — ${check.reason}`);
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

  for (const ids of [
    Object.values(doc.spellcasting?.cantrips ?? {}),
    Object.values(doc.spellcasting?.prepared ?? {}),
  ]) {
    for (const list of ids) {
      for (const id of list) if (!spellIds.has(id)) fail(`${label}: spellId ${id}`);
    }
  }

  for (const s of doc.skillProficiencies) {
    if (!skillIds.has(s.skillId)) fail(`${label}: skillId ${s.skillId}`);
  }

  if (!alignmentIds.has(doc.alignmentId)) fail(`${label}: alignmentId ${doc.alignmentId}`);
  if (!abilityMethods.has(doc.abilityGeneration?.methodId)) {
    fail(`${label}: abilityGeneration.methodId ${doc.abilityGeneration?.methodId}`);
  }
  if (!doc.languageIds.includes("common")) {
    fail(`${label}: languageIds deve incluir common`);
  }
  for (const langId of doc.languageIds) {
    if (!languageIds.has(langId)) fail(`${label}: languageId ${langId}`);
  }

  for (const item of doc.equipment) {
    if (!itemIds.has(item.itemId)) fail(`${label}: itemId ${item.itemId}`);
  }

  validateSpellcastingRules(doc);
  validateStartingGear(doc);

  const abilityCheck = validateAbilityScores(doc);
  if (!abilityCheck.ok) {
    fail(`${label}: atributos — ${abilityCheck.reason}`);
  }

  const masteryCheck = validateWeaponMasteryChoices(doc);
  if (!masteryCheck.ok) {
    fail(`${label}: maestria em armas — ${masteryCheck.reason}`);
  }

  const armorCheck = validateEquippedArmorTraining(doc);
  if (!armorCheck.ok) {
    fail(`${label}: armadura — ${armorCheck.reason}`);
  }

  const styleCheck = validateFightingStyle(doc);
  if (!styleCheck.ok) {
    fail(`${label}: estilo de luta — ${styleCheck.reason}`);
  }

  const acCheck = validateArmorClass(doc);
  if (!acCheck.ok) {
    fail(`${label}: CA — ${acCheck.reason}`);
  }

  const skillCheck = validateSkillProficiencies(doc);
  if (!skillCheck.ok) {
    fail(`${label}: perícias — ${skillCheck.reason}`);
  }

  const subclassCheck = validateSubclassLevel(doc);
  if (!subclassCheck.ok) {
    fail(`${label}: subclasse — ${subclassCheck.reason}`);
  }

  const passiveCheck = validatePassivePerception(doc);
  if (!passiveCheck.ok) {
    fail(`${label}: percepção passiva — ${passiveCheck.reason}`);
  }

  const resourceCheck = validateClassResources(doc);
  if (!resourceCheck.ok) {
    fail(`${label}: recursos — ${resourceCheck.reason}`);
  }

  const expectedHp = expectedMaxHpForCharacter(doc);
  if (expectedHp != null && doc.hp?.max !== expectedHp) {
    fail(`${label}: hp.max=${doc.hp?.max}, esperado ${expectedHp} (PV + CON + espécie/talentos)`);
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
