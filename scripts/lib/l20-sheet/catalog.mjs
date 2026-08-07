/**
 * Carrega catálogo PHB necessário para montar fichas L20.
 * @param {import('pg').Client} client
 */
export async function loadCatalog(client) {
  const classes = (
    await client.query(
      `SELECT slug, name, skill_choice_count AS "skillChoiceCount"
       FROM rpg.phb_class ORDER BY slug`,
    )
  ).rows;

  const skillPools = (
    await client.query(`
      SELECT c.slug AS "classSlug", s.slug AS "skillSlug"
      FROM rpg.phb_class_skill_pool p
      JOIN rpg.phb_class c ON c.id = p.class_id
      JOIN rpg.phb_skill s ON s.id = p.skill_id
      ORDER BY 1, 2
    `)
  ).rows;

  const subclasses = (
    await client.query(`
      SELECT c.slug AS "classSlug", s.slug, s.name
      FROM rpg.phb_subclass s
      JOIN rpg.phb_class c ON c.id = s.class_id
      ORDER BY 1, 2
    `)
  ).rows;

  const species = (
    await client.query(`SELECT slug, name FROM rpg.phb_species ORDER BY slug`)
  ).rows;

  const traitChoices = (
    await client.query(`
      SELECT species_slug AS "speciesSlug",
             choice_kind::text AS "choiceKind",
             choice_slug AS "choiceSlug",
             choice_name AS "choiceName"
      FROM rpg.v_phb_species_trait_choices
      ORDER BY 1, 2, 3
    `)
  ).rows;

  const backgrounds = (
    await client.query(`
      SELECT b.slug, b.name,
             b.tool_proficiency_kind AS "toolProficiencyKind",
             b.language_choice_count AS "languageChoiceCount",
             f.slug AS "originFeatSlug"
      FROM rpg.phb_background b
      LEFT JOIN rpg.phb_feat f ON f.id = b.feat_id
      ORDER BY b.slug
    `)
  ).rows;

  const backgroundSkills = (
    await client.query(`
      SELECT b.slug AS "backgroundSlug", s.slug AS "skillSlug"
      FROM rpg.phb_background_skill bs
      JOIN rpg.phb_background b ON b.id = bs.background_id
      JOIN rpg.phb_skill s ON s.id = bs.skill_id
    `)
  ).rows;

  const backgroundAbilities = (
    await client.query(`
      SELECT b.slug AS "backgroundSlug", a.slug AS "abilitySlug"
      FROM rpg.phb_background_ability_option bao
      JOIN rpg.phb_background b ON b.id = bao.background_id
      JOIN rpg.phb_ability a ON a.id = bao.ability_id
      ORDER BY 1, 2
    `)
  ).rows;

  const backgroundTools = (
    await client.query(`
      SELECT b.slug AS "backgroundSlug", i.slug AS "itemSlug"
      FROM rpg.phb_background_tool_option t
      JOIN rpg.phb_background b ON b.id = t.background_id
      JOIN rpg.phb_item i ON i.id = t.item_id
    `)
  ).rows;

  const backgroundLanguages = (
    await client.query(`
      SELECT b.slug AS "backgroundSlug", l.slug AS "languageSlug"
      FROM rpg.phb_background_language bl
      JOIN rpg.phb_background b ON b.id = bl.background_id
      JOIN rpg.phb_language l ON l.id = bl.language_id
    `)
  ).rows;

  const allLanguages = (
    await client.query(`SELECT slug FROM rpg.phb_language ORDER BY slug`)
  ).rows.map((r) => r.slug);

  const progression = (
    await client.query(`
      SELECT c.slug AS "classSlug", cp.level,
             cp.weapon_mastery AS "weaponMastery",
             cp.cantrips AS "cantrips",
             cp.prepared_spells AS "preparedSpells"
      FROM rpg.phb_class_progression cp
      JOIN rpg.phb_class c ON c.id = cp.class_id
      WHERE cp.level = 20
    `)
  ).rows;

  const classSpells = (
    await client.query(`
      SELECT class_slug AS "classSlug", spell_slug AS "spellSlug", spell_level AS "spellLevel"
      FROM rpg.v_spell_by_class
      ORDER BY 1, 3, 2
    `)
  ).rows;

  const classEquipment = (
    await client.query(`
      SELECT class_slug AS "classSlug", package_slug AS "packageSlug",
             item_slug AS "itemSlug", quantity, choice_text AS "choiceText",
             gold_amount AS "goldAmount", sort_order AS "sortOrder"
      FROM rpg.v_phb_class_equipment
      ORDER BY 1, 2, sort_order
    `)
  ).rows;

  const backgroundEquipment = (
    await client.query(`
      SELECT background_slug AS "backgroundSlug", package_slug AS "packageSlug",
             item_slug AS "itemSlug", quantity, choice_text AS "choiceText",
             package_gold AS "packageGold", sort_order AS "sortOrder"
      FROM rpg.v_phb_background_equipment
      ORDER BY 1, 2, sort_order
    `)
  ).rows;

  const masteryWeapons = (
    await client.query(`
      SELECT DISTINCT i.slug
      FROM rpg.phb_weapon w
      JOIN rpg.phb_item i ON i.id = w.item_id
      WHERE w.mastery_id IS NOT NULL
      ORDER BY i.slug
    `)
  ).rows.map((r) => r.slug);

  const fightingStyleFeats = (
    await client.query(`
      SELECT slug FROM rpg.phb_feat
      WHERE category = 'fighting-style'::rpg.feat_category
      ORDER BY slug
    `)
  ).rows.map((r) => r.slug);

  const featOptionDefs = (
    await client.query(`
      SELECT f.slug AS "featSlug", d.option_key AS "optionKey", d.value_type AS "valueType"
      FROM rpg.phb_option_def d
      JOIN rpg.phb_feat f ON f.id = d.owner_id
      WHERE d.scope = 'feat'
      ORDER BY 1, d.sort_order, d.option_key
    `)
  ).rows;

  const featOptionValues = (
    await client.query(`
      SELECT f.slug AS "featSlug", v.option_key AS "optionKey", v.value_id AS "valueId"
      FROM rpg.phb_option_value v
      JOIN rpg.phb_feat f ON f.id = v.owner_id
      WHERE v.scope = 'feat'
      ORDER BY 1, v.option_key, v.sort_order
    `)
  ).rows;

  return {
    classes,
    skillPools,
    subclasses,
    species,
    traitChoices,
    backgrounds,
    backgroundSkills,
    backgroundAbilities,
    backgroundTools,
    backgroundLanguages,
    allLanguages,
    progression,
    classSpells,
    classEquipment,
    backgroundEquipment,
    masteryWeapons,
    fightingStyleFeats,
    featOptionDefs,
    featOptionValues,
  };
}

export function indexCatalog(catalog) {
  const poolByClass = group(catalog.skillPools, 'classSlug', (r) => r.skillSlug);
  const subclassByClass = group(catalog.subclasses, 'classSlug', (r) => r.slug);
  const choicesBySpecies = new Map();
  for (const row of catalog.traitChoices) {
    const byKind = choicesBySpecies.get(row.speciesSlug) ?? new Map();
    const list = byKind.get(row.choiceKind) ?? [];
    list.push(row.choiceSlug);
    byKind.set(row.choiceKind, list);
    choicesBySpecies.set(row.speciesSlug, byKind);
  }
  const bgSkills = group(catalog.backgroundSkills, 'backgroundSlug', (r) => r.skillSlug);
  const bgAbilities = group(catalog.backgroundAbilities, 'backgroundSlug', (r) => r.abilitySlug);
  const bgTools = group(catalog.backgroundTools, 'backgroundSlug', (r) => r.itemSlug);
  const bgLangs = group(catalog.backgroundLanguages, 'backgroundSlug', (r) => r.languageSlug);
  const progByClass = new Map(catalog.progression.map((p) => [p.classSlug, p]));
  const spellsByClass = new Map();
  for (const row of catalog.classSpells) {
    const list = spellsByClass.get(row.classSlug) ?? [];
    list.push(row);
    spellsByClass.set(row.classSlug, list);
  }
  const classEquip = groupRows(catalog.classEquipment, 'classSlug');
  const bgEquip = groupRows(catalog.backgroundEquipment, 'backgroundSlug');
  const backgroundBySlug = new Map(catalog.backgrounds.map((b) => [b.slug, b]));
  const featDefsBySlug = groupRows(catalog.featOptionDefs, 'featSlug');
  const featValuesByKey = new Map();
  for (const row of catalog.featOptionValues) {
    const key = `${row.featSlug}::${row.optionKey}`;
    const list = featValuesByKey.get(key) ?? [];
    list.push(row.valueId);
    featValuesByKey.set(key, list);
  }

  return {
    ...catalog,
    poolByClass,
    subclassByClass,
    choicesBySpecies,
    bgSkills,
    bgAbilities,
    bgTools,
    bgLangs,
    progByClass,
    spellsByClass,
    classEquip,
    bgEquip,
    backgroundBySlug,
    featDefsBySlug,
    featValuesByKey,
  };
}

function group(rows, key, mapFn) {
  const m = new Map();
  for (const row of rows) {
    const list = m.get(row[key]) ?? [];
    list.push(mapFn(row));
    m.set(row[key], list);
  }
  return m;
}

function groupRows(rows, key) {
  const m = new Map();
  for (const row of rows) {
    const list = m.get(row[key]) ?? [];
    list.push(row);
    m.set(row[key], list);
  }
  return m;
}
