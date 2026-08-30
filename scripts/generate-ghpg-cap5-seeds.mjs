/**
 * Gera seeds J001–J007 e J036 (Grim Hollow Player's Guide — Cap. 5).
 * Uso: node scripts/generate-ghpg-cap5-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';
import { isArmorShieldKind } from './lib/ghpg-cap5-catalog.mjs';
import { CAP5_MASTERY_DESCRIPTIONS_PT } from './lib/ghpg-cap5-descriptions-pt.mjs';
import {
  CAP5_MASTERY_NAMES_PT,
  CAP5_NAMES_PT,
  CAP5_PROPERTY_NAMES_PT,
} from './lib/ghpg-cap5-names-pt.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const extractPath = extracts.grimHollow.cap5AdvancedEquipment;
const ptOverlayPath = extracts.grimHollow.cap5AdvancedEquipmentPt;
const outDir = path.join(apiRoot, 'database/seeds/grim-hollow');
const migTypes = path.join(apiRoot, 'database/migrations/010_types');
const migViews = path.join(apiRoot, 'database/migrations/060_views');

const EDITION = 'grim-hollow-players-guide-2024-en';
const CITATION_CAP5 = `${EDITION}:chapter-5-advanced-weapons-equipment`;
const CITATION_CAP4 = `${EDITION}:chapter-4-character-feats`;
const SOURCE = 'grim-hollow';

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value).replace(/'/g, "''")}'`;
}

/** @param {unknown} value */
function sqlJson(value) {
  return `'${JSON.stringify(value).replace(/'/g, "''")}'::jsonb`;
}

const NEW_PROPERTIES = [
  [
    'armor-piercing',
    'Perfuração de Armadura',
    'Ataques com esta arma ou munição ignoram Resistência a dano não mágico.',
  ],
  [
    'blackpowder',
    'Pólvora',
    'Arma de fogo de pólvora. Requer munição adequada; propriedades especiais exigem proficiência em Armas Avançadas.',
  ],
  [
    'cumbersome',
    'Desajeitada',
    'Você tem Desvantagem em testes de Destreza e em testes de Destreza (Furtividade) enquanto empunha esta arma.',
  ],
  [
    'damage',
    'Dano',
    'Esta arma pode causar tipos de dano adicionais indicados entre parênteses além do dano base.',
  ],
  [
    'double',
    'Dupla',
    'Arma com duas extremidades distintas; cada extremidade pode ter dano, tipo e maestria próprios.',
  ],
  [
    'hafted',
    'Haste',
    'Pode atacar com a lâmina ou com a extremidade da haste; a haste usa o dano e a maestria indicados para ela.',
  ],
  [
    'magazine',
    'Pente',
    'Carrega várias munições de uma vez; o número entre parênteses é a capacidade do pente.',
  ],
  [
    'momentum',
    'Momentum',
    'Enquanto montado, ao acertar um ataque você pode rolar dados de momentum extras (indicados entre parênteses) e somá-los ao dano.',
  ],
  [
    'repeater',
    'Repetição',
    'Pode realizar múltiplos ataques com uma única ação Atacar, conforme as regras da arma repetidora.',
  ],
  [
    'ranging',
    'Alcance Estendido',
    'Munição que aumenta o alcance normal e máximo da arma que a dispara.',
  ],
  [
    'whistling',
    'Assobio',
    'Munição que emite assobio audível; útil para sinalização ou distração.',
  ],
  [
    'blessed-ammo',
    'Abençoada',
    'Munição abençoada com propriedades contra criaturas profanas ou mortas-vivas.',
  ],
  [
    'brutal-ammo',
    'Brutal (munição)',
    'Munição que maximiza o dano em acertos críticos ou adiciona efeito brutal conforme a descrição.',
  ],
  [
    'desecrated-ammo',
    'Profanada',
    'Munição profanada com efeitos contra alvos sagrados ou vivos.',
  ],
  [
    'incendiary-ammo',
    'Incendiária',
    'Munição que pode inflamar o alvo ou causar dano de Fogo adicional.',
  ],
  [
    'alchemical-ammo',
    'Alquímica',
    'Munição alquímica com efeito especial descrito no item.',
  ],
];

const GHPG_CAP5_MASTERY_SLUGS = [
  'brutal',
  'defending',
  'disarming',
  'entangling',
  'returning',
  'scatter',
  'set',
  'strong-draw',
  'swift',
];

/** @type {[string, string, string][]} */
const NEW_MASTERIES = GHPG_CAP5_MASTERY_SLUGS.map((slug) => [
  slug,
  CAP5_MASTERY_NAMES_PT[slug] ?? slug,
  CAP5_MASTERY_DESCRIPTIONS_PT[slug] ?? '',
]);

/** @param {Record<string, unknown>} meta @param {string[]} propertySlugs @param {string | null | undefined} masterySlug @param {Record<string, unknown> | undefined} requirement @param {{ catalogKind?: string, ddbKind?: string | null }} [catalog] */
function buildItemProperties(meta, propertySlugs, masterySlug, requirement, catalog = {}) {
  const props = {
    propertyIds: propertySlugs,
    source: SOURCE,
    editionSlug: EDITION,
    citationSlug: CITATION_CAP5,
    catalogKind: catalog.catalogKind ?? 'advanced-weapon',
    ...(catalog.ddbKind ? { ddbKind: catalog.ddbKind } : {}),
  };
  if (requirement) props.advancedRequirement = requirement;
  if (masterySlug) props.masteryId = masterySlug;
  if (meta.range) props.range = meta.range;
  if (meta.versatileDamage) props.versatileDamage = meta.versatileDamage;
  if (meta.momentumDice) props.momentumDice = meta.momentumDice;
  if (meta.magazine) props.magazine = meta.magazine;
  if (meta.damageTypes) props.damageTypes = meta.damageTypes;
  return props;
}

/** @param {Record<string, unknown>} item @param {Record<string, unknown>} [extra] */
function buildCatalogItemProperties(item, extra = {}) {
  const props = {
    source: SOURCE,
    editionSlug: EDITION,
    citationSlug: CITATION_CAP5,
    catalogKind: item.catalogKind,
    ...(item.ddbKind ? { ddbKind: item.ddbKind } : {}),
    ...(item.requirement ? { advancedRequirement: item.requirement } : {}),
    ...extra,
  };
  if (item.weaponLike) props.weaponLike = true;
  if (item.upgrade) props.catalogUpgrade = item.upgrade;
  if (item.listInCatalog === false) props.listInCatalog = false;
  if (item.armor?.shieldVariant) {
    props.shieldVariant = item.armor.shieldVariant;
    props.shieldProficiencySlug = 'shield';
    if (item.armor.speedPenaltyM != null) {
      props.speedPenaltyM = item.armor.speedPenaltyM;
    }
  }
  if (item.catalogKind === 'spellcasting-focus') {
    props.spellcastingFocus = true;
  }
  return props;
}

/** @param {Record<string, { items?: Record<string, { name?: string, description?: string }>, weaponProperties?: Record<string, { name?: string, description?: string }>, weaponMasteries?: Record<string, { name?: string, description?: string }> }> | null} ptOverlay @param {string} slug @param {string} fallbackName @param {string} fallbackDescription */
function resolveItemPt(ptOverlay, slug, fallbackName, fallbackDescription) {
  const row = ptOverlay?.items?.[slug];
  return {
    name: row?.name ?? CAP5_NAMES_PT[slug] ?? fallbackName,
    description: row?.description ?? fallbackDescription,
  };
}

/** @param {typeof NEW_PROPERTIES} rows @param {Record<string, { name?: string, description?: string }> | undefined} fromOverlay */
function resolvePropertyRows(rows, fromOverlay) {
  return rows.map(([slug, fallbackName, fallbackDescription]) => {
    const row = fromOverlay?.[slug];
    return [
      slug,
      row?.name ?? CAP5_PROPERTY_NAMES_PT[slug] ?? fallbackName,
      row?.description ?? fallbackDescription,
    ];
  });
}

/** @param {typeof NEW_MASTERIES} rows @param {Record<string, { name?: string, description?: string }> | undefined} fromOverlay */
function resolveMasteryRows(rows, fromOverlay) {
  return rows.map(([slug, fallbackName, fallbackDescription]) => {
    const row = fromOverlay?.[slug];
    return [
      slug,
      row?.name ?? CAP5_MASTERY_NAMES_PT[slug] ?? fallbackName,
      row?.description ?? fallbackDescription,
    ];
  });
}

/** @param {import('../docs/source/extracts/grim-hollow/cap5-advanced-equipment.json')} extract @param {Record<string, unknown>} ptOverlay */
function generateSeeds(extract, ptOverlay) {
  fs.mkdirSync(outDir, { recursive: true });

  const j001 = `-- Grim Hollow Player's Guide — edição + citações Cap. 4 e 5

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  ${sqlLiteral(EDITION)},
  'Grim Hollow Player''s Guide 2024',
  'Grim Hollow: Player''s Guide',
  'pt',
  NOW(),
  'Grim Hollow — armas avançadas, equipamento e talentos; textos em PT-BR'
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  book = EXCLUDED.book,
  language = EXCLUDED.language,
  notes = EXCLUDED.notes,
  extracted_at = EXCLUDED.extracted_at;

INSERT INTO rpg.phb_source_citation (slug, edition_id, chapter, chapter_title, extracted_at)
VALUES
  (
    ${sqlLiteral(CITATION_CAP4)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    4,
    'Grim Hollow — Capítulo 4: Talentos de Personagem',
    NOW()
  ),
  (
    ${sqlLiteral(CITATION_CAP5)},
    (SELECT id FROM rpg.phb_edition WHERE slug = ${sqlLiteral(EDITION)}),
    5,
    'Grim Hollow — Capítulo 5: Armas e Equipamento Avançados',
    NOW()
  )
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
`;
  fs.writeFileSync(path.join(outDir, 'J001_phb_edition_citation.sql'), j001);

  const propValues = resolvePropertyRows(
    NEW_PROPERTIES,
    ptOverlay?.weaponProperties,
  )
    .map(
      ([slug, name, description]) =>
        `  (${sqlLiteral(slug)}, ${sqlLiteral(name)}, ${sqlLiteral(description)})`,
    )
    .join(',\n');

  const j002 = `-- Propriedades de arma avançadas (Grim Hollow Cap. 5)

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
${propValues}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
`;
  fs.writeFileSync(path.join(outDir, 'J002_phb_weapon_property.sql'), j002);

  const masteryValues = resolveMasteryRows(
    NEW_MASTERIES,
    ptOverlay?.weaponMasteries,
  )
    .map(
      ([slug, name, description]) =>
        `  (${sqlLiteral(slug)}, ${sqlLiteral(name)}, ${sqlLiteral(description)})`,
    )
    .join(',\n');

  const j003 = `-- Maestrias de arma avançadas (Grim Hollow Cap. 5)

INSERT INTO rpg.phb_weapon_mastery (slug, name, description)
VALUES
${masteryValues}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
`;
  fs.writeFileSync(path.join(outDir, 'J003_phb_weapon_mastery.sql'), j003);

  const j004 = `-- Talentos Grim Hollow — Proficiência em Armas Avançadas (Cap. 4)

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES (
  'advanced-weapon-proficiency',
  'Proficiência em Armas Avançadas',
  'fighting-style',
  FALSE,
  'Característica de Estilo de Luta (ou nível 8+ como talento Geral)',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = ${sqlLiteral(CITATION_CAP4)})
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_feat_benefit (feat_id, sort_order, name, description)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'advanced-weapon-proficiency'),
    1,
    'Proficiência com Armas',
    'Você tem proficiência com armas Avançadas e pode usar as propriedades de maestria dessas armas.'
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'advanced-weapon-proficiency'),
    2,
    'Especial',
    'Este talento pode ser escolhido como talento Geral por personagens de nível 8 ou superior.'
  )
ON CONFLICT (feat_id, sort_order) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

INSERT INTO rpg.phb_fighting_style (slug, name, description)
VALUES (
  'advanced-weapon-proficiency',
  'Proficiência em Armas Avançadas',
  'Você tem proficiência com armas Avançadas e pode usar as propriedades de maestria dessas armas.'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
`;
  fs.writeFileSync(path.join(outDir, 'J004_phb_feat_advanced_weapon.sql'), j004);

  const weapons = [...extract.meleeWeapons, ...extract.rangedWeapons];
  const itemRows = [];
  const weaponRows = [];
  const linkRows = [];

  for (const w of weapons) {
    const pt = resolveItemPt(ptOverlay, w.slug, w.name, w.description);
    const props = buildItemProperties(
      w.propertyMeta ?? {},
      w.propertySlugs ?? [],
      w.masterySlug,
      w.requirement,
      { catalogKind: w.catalogKind ?? 'advanced-weapon', ddbKind: w.ddbKind ?? 'weapons' },
    );
    itemRows.push(
      `  (${sqlLiteral(w.slug)}, 'weapon'::rpg.item_type, ${sqlLiteral(pt.name)}, ${sqlJson(w.cost)}, ${w.weight ? sqlLiteral(w.weight) : 'NULL'}, ${sqlLiteral(pt.description)}, ${sqlJson(props)})`,
    );
    const masterySql = w.masterySlug
      ? `(SELECT id FROM rpg.phb_weapon_mastery WHERE slug = ${sqlLiteral(w.masterySlug)})`
      : 'NULL';
    weaponRows.push(
      `  ((SELECT id FROM rpg.phb_item WHERE slug = ${sqlLiteral(w.slug)}), 'advanced'::rpg.weapon_category, ${sqlLiteral(w.damage)}, ${sqlLiteral(w.damageType)}, ${masterySql})`,
    );
    for (const propSlug of w.propertySlugs ?? []) {
      linkRows.push(
        `INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = ${sqlLiteral(w.slug)}), (SELECT id FROM rpg.phb_weapon_property WHERE slug = ${sqlLiteral(propSlug)})) ON CONFLICT DO NOTHING;`,
      );
    }
  }

  const j005 = `-- Armas avançadas Grim Hollow (Cap. 5)

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
${itemRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id)
VALUES
${weaponRows.join(',\n')}
ON CONFLICT (item_id) DO UPDATE SET
  category = EXCLUDED.category,
  damage = EXCLUDED.damage,
  damage_type = EXCLUDED.damage_type,
  mastery_id = EXCLUDED.mastery_id;

${linkRows.join('\n')}
`;
  fs.writeFileSync(path.join(outDir, 'J005_phb_weapon_advanced.sql'), j005);

  const equipment = extract.equipment ?? [];
  const shields = equipment.filter((g) => isArmorShieldKind(g.catalogKind));
  const gearItems = equipment.filter((g) => !isArmorShieldKind(g.catalogKind));

  const gearRows = gearItems.map((g) => {
    const pt = resolveItemPt(ptOverlay, g.slug, g.name, g.description);
    const itemType = g.itemType ?? 'gear';
    const props = buildCatalogItemProperties(g);
    return `  (${sqlLiteral(g.slug)}, ${sqlLiteral(itemType)}::rpg.item_type, ${sqlLiteral(pt.name)}, ${sqlJson(g.cost)}, ${g.weight ? sqlLiteral(g.weight) : 'NULL'}, ${sqlLiteral(pt.description)}, ${sqlJson(props)})`;
  });

  const j006 = `-- Equipamento avançado Grim Hollow (Cap. 5) — gear, focos, upgrades, venenos

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
${gearRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;
`;
  fs.writeFileSync(path.join(outDir, 'J006_phb_gear_advanced.sql'), j006);

  const shieldItemRows = shields.map((s) => {
    const pt = resolveItemPt(ptOverlay, s.slug, s.name, s.description);
    const props = buildCatalogItemProperties(s);
    return `  (${sqlLiteral(s.slug)}, 'armor'::rpg.item_type, ${sqlLiteral(pt.name)}, ${sqlJson(s.cost)}, ${s.weight ? sqlLiteral(s.weight) : 'NULL'}, ${sqlLiteral(pt.description)}, ${sqlJson(props)})`;
  });

  const shieldArmorRows = shields.map((s) => {
    const armor = s.armor ?? { acFormula: '+2', strengthReq: null, stealthDisadvantage: false };
    const strengthSql = armor.strengthReq != null ? String(armor.strengthReq) : 'NULL';
    const stealthSql = armor.stealthDisadvantage ? 'TRUE' : 'FALSE';
    return `  ((SELECT id FROM rpg.phb_item WHERE slug = ${sqlLiteral(s.slug)}), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), NULL, ${sqlLiteral(armor.acFormula)}, ${strengthSql}, ${stealthSql})`;
  });

  const j036 = `-- Escudos avançados Grim Hollow (Cap. 5) — phb_armor

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
${shieldItemRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage)
VALUES
${shieldArmorRows.join(',\n')}
ON CONFLICT (item_id) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  ac_base = EXCLUDED.ac_base,
  ac_formula = EXCLUDED.ac_formula,
  strength_req = EXCLUDED.strength_req,
  stealth_disadvantage = EXCLUDED.stealth_disadvantage;
`;
  fs.writeFileSync(path.join(outDir, 'J036_phb_armor_advanced_shields.sql'), j036);

  const ammoRows = extract.ammunition.map((a) => {
    const pt = resolveItemPt(ptOverlay, a.slug, a.name, a.description);
    const props = buildCatalogItemProperties(a, {
      ammunition: true,
      propertyIds: a.propertySlugs ?? [],
      section: a.section,
      ...a.propertyMeta,
    });
    return `  (${sqlLiteral(a.slug)}, 'gear'::rpg.item_type, ${sqlLiteral(pt.name)}, ${sqlJson(a.cost)}, ${a.weight ? sqlLiteral(a.weight) : 'NULL'}, ${sqlLiteral(pt.description)}, ${sqlJson(props)})`;
  });

  const j007 = `-- Munição avançada Grim Hollow (Cap. 5)

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
${ammoRows.join(',\n')}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;
`;
  fs.writeFileSync(path.join(outDir, 'J007_phb_ammunition_advanced.sql'), j007);

  console.log(`Seeds em ${outDir}`);
  console.log(
    `  weapons=${weapons.length} shields=${shields.length} gear=${gearItems.length} ammo=${extract.ammunition.length}`,
  );
}

const t088 = `-- Categoria de arma avançada (Grim Hollow)

ALTER TYPE rpg.weapon_category ADD VALUE IF NOT EXISTS 'advanced';
`;
fs.writeFileSync(path.join(migTypes, '014_weapon_category_advanced.sql'), t088);

const v068 = `-- Proficiência em Armas Avançadas (Grim Hollow)

CREATE OR REPLACE VIEW rpg.v_phb_weapon_proficiency AS
SELECT slug, label FROM (VALUES
  ('armas-simples', 'Armas Simples'),
  ('armas-marciais', 'Armas Marciais'),
  ('armas-avancadas', 'Armas Avançadas'),
  ('adagas', 'Adagas'),
  ('dardos', 'Dardos'),
  ('fundas', 'Fundas'),
  ('bordoes', 'Bordões'),
  ('bestas-leves', 'Bestas Leves'),
  ('bestas-de-mao', 'Bestas de Mão'),
  ('espada-longa', 'Espada Longa'),
  ('rapieira', 'Rapieira'),
  ('espada-curta', 'Espada Curta'),
  ('machadinhas', 'Machadinhas'),
  ('armas-marciais-leves', 'Armas Marciais (leves)'),
  ('armas-marciais-a-distancia', 'Armas Marciais (à Distância)')
) AS t(slug, label);
`;
fs.writeFileSync(path.join(migViews, 'V068_v_phb_weapon_proficiency_advanced.sql'), v068);

if (!fs.existsSync(extractPath)) {
  console.error(`Extract ausente: ${extractPath}. Rode extract-ghpg-cap5.mjs primeiro.`);
  process.exit(1);
}

if (!fs.existsSync(ptOverlayPath)) {
  console.error(
    `Overlay PT ausente: ${ptOverlayPath}. Rode build-ghpg-cap5-pt-overlay.mjs primeiro.`,
  );
  process.exit(1);
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const ptOverlay = JSON.parse(fs.readFileSync(ptOverlayPath, 'utf8'));
generateSeeds(extract, ptOverlay);
console.log('Migrações: 014_weapon_category_advanced.sql, V068_v_phb_weapon_proficiency_advanced.sql');
