/**
 * Gera taxonomia + seeds do lote §0 #1 (poção / óleo / pergaminho).
 * node docs/source/generate-dmg-consumable-lote.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const jsonPath = path.join(__dirname, 'dmg-2024-itens-magicos-az.json');
const { items } = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));

const lote = items.filter((i) =>
  /^(Po[cç][aã]o|[OÓ]leo|Pergaminho)\b/i.test(i.header),
);

function kindOf(it) {
  if (/^Pergaminho/i.test(it.header)) return 'pergaminho';
  if (/^óleo|^oleo/i.test(it.name) || /óleo|oleo/i.test(it.slug)) return 'oleo';
  return 'pocao';
}

function bucketOf(kind) {
  if (kind === 'pocao') return 'bonus';
  return 'action';
}

function verbOf(kind) {
  if (kind === 'pocao') return 'Beber';
  if (kind === 'oleo') return 'Aplicar';
  return 'Ler';
}

function sqlString(value) {
  return `'${String(value).replace(/'/g, "''")}'`;
}

function oneLine(text, max = 160) {
  const t = String(text || '')
    .replace(/\s+/g, ' ')
    .trim();
  if (t.length <= max) return t;
  return `${t.slice(0, max - 1)}…`;
}

const taxLines = [
  '# Taxonomia — lote §0 #1 (poção / óleo / pergaminho)',
  '# Gerado por generate-dmg-consumable-lote.mjs',
  `# Total: ${lote.length}`,
  '',
  'meta:',
  '  fase: 1-wiring',
  '  padrao: consumable-reminder',
  '  nota: |',
  '    Sem pool regenerável (consumo real = quantity no inventário).',
  '    Economy = lembrete (table_action NULL).',
  '    Aparece na aba Ações se quantity>0 e properties.consumable=true (mochila ou equipado).',
  '    Poções: bucket bonus (Beber). Óleos/pergaminhos: action.',
  '',
  'items:',
];

const slugList = [];
const economyRows = [];
let sort = 500;

for (const it of lote) {
  const kind = kindOf(it);
  const bucket = bucketOf(kind);
  const verb = verbOf(kind);
  const actionId = `item-${it.slug}-usar`;
  const summary = `${verb}: ${oneLine(it.description, 100)}`;
  const description = oneLine(it.description, 600);

  taxLines.push(`  - slug: ${it.slug}`);
  taxLines.push(`    name: ${JSON.stringify(it.name)}`);
  taxLines.push(`    kind: ${kind}`);
  taxLines.push(`    header: ${JSON.stringify(it.header)}`);
  taxLines.push(`    tipo: reminder`);
  taxLines.push(`    consumable: true`);
  taxLines.push(`    abilities:`);
  taxLines.push(`      - id: ${actionId}`);
  taxLines.push(`        name: ${JSON.stringify(`${verb} · ${it.name}`)}`);
  taxLines.push(`        bucket: ${bucket}`);
  taxLines.push(`        table_action: null`);
  taxLines.push(`        resource: null`);
  taxLines.push(`        status: wired`);
  taxLines.push(`    mesa_complete: parcial  # lembrete; quantity manual após uso`);
  taxLines.push('');

  slugList.push(it.slug);
  economyRows.push({
    actionId,
    slug: it.slug,
    name: `${verb} · ${it.name}`,
    bucket,
    summary,
    description,
    sort: sort++,
  });
}

const taxPath = path.join(__dirname, 'dmg-item-mesa-taxonomy-consumables.yaml');
fs.writeFileSync(taxPath, taxLines.join('\n'), 'utf8');

const dmgDir = path.join(__dirname, '..', '..', 'database', 'seeds', 'dmg');
const combatDir = path.join(__dirname, '..', '..', 'database', 'seeds', 'combat');
fs.mkdirSync(dmgDir, { recursive: true });

const d011 = [
  '-- DMG lote §0 #1: marca consumíveis (poção / óleo / pergaminho)',
  '-- Gerado por docs/source/generate-dmg-consumable-lote.mjs',
  '',
  'UPDATE rpg.phb_item',
  `SET properties = COALESCE(properties, '{}'::jsonb) || '{"consumable":true}'::jsonb`,
  'WHERE slug IN (',
  slugList.map((s) => `  ${sqlString(s)}`).join(',\n'),
  ');',
  '',
].join('\n');
fs.writeFileSync(path.join(dmgDir, 'D011_phb_item_consumable_flag.sql'), d011, 'utf8');

const c016Parts = [
  '-- DMG lote §0 #1: economy lembrete (Beber / Aplicar / Ler)',
  '-- Gerado por docs/source/generate-dmg-consumable-lote.mjs',
  '-- Sem resource regenerável — consumir = reduzir quantity no inventário.',
  '',
  'INSERT INTO rpg.phb_class_economy_action (',
  '  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,',
  '  resource_slug, free_resource_slug, always_spends_resource,',
  '  summary, description, table_action, spend_amount, sort_order,',
  '  requires_option_key, requires_option_value',
  ') VALUES',
];

const valueBlocks = economyRows.map((r, idx) => {
  const comma = idx === economyRows.length - 1 ? '' : ',';
  return `(
  ${sqlString(r.actionId)}, NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = ${sqlString(r.slug)}), NULL,
  ${sqlString(r.name)}, ${sqlString(r.bucket)}::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  ${sqlString(r.summary)},
  ${sqlString(r.description)},
  NULL, NULL, ${r.sort}, NULL, NULL
)${comma}`;
});

c016Parts.push(valueBlocks.join('\n'));
c016Parts.push(`ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
  item_id = EXCLUDED.item_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
`);

fs.writeFileSync(
  path.join(combatDir, 'C016_phb_item_economy_action_dmg_consumables.sql'),
  c016Parts.join('\n'),
  'utf8',
);

console.log('taxonomy', taxPath);
console.log('items', lote.length);
console.log('D011 + C016 written');
