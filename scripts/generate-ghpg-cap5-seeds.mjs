/**
 * Gera seeds J001–J008 (Grim Hollow Player's Guide — Cap. 5).
 * Uso: node scripts/generate-ghpg-cap5-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const extractPath = extracts.grimHollow.cap5AdvancedEquipment;
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

const NEW_MASTERIES = [
  [
    'brutal',
    'Brutal',
    'Quando você rola o dano de um ataque com esta arma, pode rolar novamente qualquer dado que mostrar 1 ou 2 no dano da arma e usar o novo resultado.',
  ],
  [
    'defending',
    'Defensiva',
    'Se você atingir uma criatura com esta arma, pode usar uma Reação para ganhar +1 na CA contra ataques dessa criatura até o início do seu próximo turno.',
  ],
  [
    'disarming',
    'Desarmar',
    'Se você atingir uma criatura com esta arma, pode forçá-la a fazer uma salvaguarda de Força; em falha, deixa cair um objeto que segura.',
  ],
  [
    'entangling',
    'Enredar',
    'Se você atingir uma criatura com esta arma, pode restringir o movimento dela (condição Enredado ou redução de Deslocamento conforme a arma).',
  ],
  [
    'returning',
    'Retorno',
    'Após arremessar esta arma, ela retorna à sua mão no final do seu turno se não houver obstáculo.',
  ],
  [
    'set',
    'Preparada',
    'Se você não se moveu neste turno, o primeiro ataque com esta arma tem Vantagem.',
  ],
  [
    'strong-draw',
    'Tensão Forte',
    'Se você não se moveu neste turno antes do ataque, adicione +2 à jogada de dano do ataque à distância.',
  ],
  [
    'swift',
    'Rápida',
    'Após acertar um ataque com esta arma, você pode se mover até 3 metros sem provocar Ataques de Oportunidade.',
  ],
];

/** @param {Record<string, unknown>} meta @param {string[]} propertySlugs */
function buildItemProperties(meta, propertySlugs, masterySlug) {
  const props = {
    propertyIds: propertySlugs,
    source: SOURCE,
    editionSlug: EDITION,
    citationSlug: CITATION_CAP5,
  };
  if (masterySlug) props.masteryId = masterySlug;
  if (meta.range) props.range = meta.range;
  if (meta.versatileDamage) props.versatileDamage = meta.versatileDamage;
  if (meta.momentumDice) props.momentumDice = meta.momentumDice;
  if (meta.magazine) props.magazine = meta.magazine;
  if (meta.damageTypes) props.damageTypes = meta.damageTypes;
  return props;
}

/** @param {import('../docs/source/extracts/grim-hollow/cap5-advanced-equipment.json')} extract */
function generateSeeds(extract) {
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

  const propValues = NEW_PROPERTIES.map(
    ([slug, name, description]) =>
      `  (${sqlLiteral(slug)}, ${sqlLiteral(name)}, ${sqlLiteral(description)})`,
  ).join(',\n');

  const j002 = `-- Propriedades de arma avançadas (Grim Hollow Cap. 5)

INSERT INTO rpg.phb_weapon_property (slug, name, description)
VALUES
${propValues}
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
`;
  fs.writeFileSync(path.join(outDir, 'J002_phb_weapon_property.sql'), j002);

  const masteryValues = NEW_MASTERIES.map(
    ([slug, name, description]) =>
      `  (${sqlLiteral(slug)}, ${sqlLiteral(name)}, ${sqlLiteral(description)})`,
  ).join(',\n');

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
    const props = buildItemProperties(w.propertyMeta ?? {}, w.propertySlugs ?? [], w.masterySlug);
    itemRows.push(
      `  (${sqlLiteral(w.slug)}, 'weapon'::rpg.item_type, ${sqlLiteral(w.name)}, ${sqlJson(w.cost)}, ${w.weight ? sqlLiteral(w.weight) : 'NULL'}, ${sqlLiteral(w.description)}, ${sqlJson(props)})`,
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

  const gearRows = extract.equipment.map(
    (g) =>
      `  (${sqlLiteral(g.slug)}, 'gear'::rpg.item_type, ${sqlLiteral(g.name)}, ${sqlJson(g.cost)}, ${g.weight ? sqlLiteral(g.weight) : 'NULL'}, ${sqlLiteral(g.description)}, ${sqlJson({ source: SOURCE, editionSlug: EDITION, citationSlug: CITATION_CAP5 })})`,
  );

  const j006 = `-- Equipamento avançado Grim Hollow (Cap. 5)

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

  const ammoRows = extract.ammunition.map((a) => {
    const props = {
      ammunition: true,
      source: SOURCE,
      editionSlug: EDITION,
      citationSlug: CITATION_CAP5,
      propertyIds: a.propertySlugs ?? [],
      ...a.propertyMeta,
    };
    return `  (${sqlLiteral(a.slug)}, 'gear'::rpg.item_type, ${sqlLiteral(a.name)}, ${sqlJson(a.cost)}, ${a.weight ? sqlLiteral(a.weight) : 'NULL'}, ${sqlLiteral(a.description)}, ${sqlJson(props)})`;
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
  console.log(`  weapons=${weapons.length} gear=${extract.equipment.length} ammo=${extract.ammunition.length}`);
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

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
generateSeeds(extract);
console.log('Migrações: 014_weapon_category_advanced.sql, V068_v_phb_weapon_proficiency_advanced.sql');
