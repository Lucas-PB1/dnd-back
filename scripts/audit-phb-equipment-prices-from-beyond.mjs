/**
 * Audita preços PHB Equipment (Beyond HTML local, fora do repo)
 * vs seed S031. Gera docs/source/phb-2024-equipment-prices-audit.md
 *
 * Uso:
 *   PHB_EQUIPMENT_HTML=/caminho/Equipment….html node scripts/audit-phb-equipment-prices-from-beyond.mjs
 * Scrapes Beyond não ficam em docs/source/ (ver docs/source/README.md).
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..');
const htmlPath = process.env.PHB_EQUIPMENT_HTML
  ? path.resolve(process.env.PHB_EQUIPMENT_HTML)
  : null;
const seedPath = path.join(root, 'database/seeds/phb/S031_phb_item.sql');
const outPath = path.join(root, 'docs/source/phb-2024-equipment-prices-audit.md');

/** Coin Values (PHB) — valor em GP. */
export const COIN_VALUES_GP = {
  CP: 1 / 100,
  SP: 1 / 10,
  EP: 1 / 2,
  GP: 1,
  PP: 10,
};

/** EN Beyond name → slug PT (gear/tools focados). Armas/armaduras usam slug EN. */
const EN_TO_SLUG = {
  Acid: 'acido',
  "Alchemist's Fire": 'fogo-alquimico',
  Antitoxin: 'antitoxina',
  Backpack: 'mochila',
  'Ball Bearings': 'esferas-de-metal',
  Barrel: 'barril',
  Basket: 'cesta',
  Bedroll: 'saco-de-dormir',
  Bell: 'sino',
  Blanket: 'cobertor',
  'Block and Tackle': 'roldana-e-polias',
  Book: 'livro',
  'Bottle, Glass': 'garrafa-de-vidro-1-litro',
  Bucket: 'balde',
  "Burglar's Pack": 'kit-de-assaltante',
  Caltrops: 'estrepes',
  Candle: 'vela',
  'Case, Crossbow Bolt': 'estojo-virote-de-besta',
  'Case, Map or Scroll': 'estojo-mapa-ou-pergaminho',
  Chain: 'corrente',
  Chest: 'bau',
  "Climber's Kit": 'kit-de-escalada',
  "Clothes, Fine": 'roupas-finas',
  "Clothes, Traveler's": 'roupas-viagem',
  'Component Pouch': 'bolsa-de-componentes',
  Costume: 'roupas-fantasia',
  Crowbar: 'pe-de-cabra',
  "Diplomat's Pack": 'kit-de-diplomata',
  "Dungeoneer's Pack": 'kit-de-explorador-de-masmorras',
  "Entertainer's Pack": 'kit-de-artista',
  "Explorer's Pack": 'kit-de-aventureiro',
  Flask: 'frasco',
  'Grappling Hook': 'arpeu',
  "Healer's Kit": 'kit-de-curandeiro',
  'Holy Water': 'agua-benta',
  'Hunting Trap': 'armadilha-de-caca',
  Ink: 'tinta',
  'Ink Pen': 'caneta-tinteiro',
  Jug: 'jarro-4-litros',
  Ladder: 'escada',
  Lamp: 'lampada',
  'Lantern, Bullseye': 'lanterna-foca-facho',
  'Lantern, Hooded': 'lanterna-coberta',
  Lock: 'cadeado',
  'Magnifying Glass': 'lupa',
  Manacles: 'grilhoes',
  Map: 'mapa',
  Mirror: 'espelho',
  Net: 'rede',
  Oil: 'oleo',
  Paper: 'papel',
  Parchment: 'pergaminho',
  Perfume: 'perfume',
  'Poison, Basic': 'veneno-basico',
  Pole: 'baliza',
  'Pot, Iron': 'pote-ferro',
  'Potion of Healing': 'pocao-de-cura',
  Pouch: 'algibeira',
  "Priest's Pack": 'kit-de-sacerdote',
  Quiver: 'aljava',
  'Ram, Portable': 'ariete-portavel',
  Rations: 'racoes',
  Robe: 'tunica',
  Rope: 'corda',
  Sack: 'saca',
  "Scholar's Pack": 'kit-de-erudito',
  Shovel: 'pa',
  'Signal Whistle': 'apito-sinalizador',
  'Spell Scroll (Cantrip)': 'pergaminho-magico-truque',
  'Spell Scroll (Level 1)': 'pergaminho-magico-1-circulo',
  'Spikes, Iron': 'estacas-de-ferro',
  Spyglass: 'luneta',
  String: 'cordao',
  Tent: 'tenda',
  Tinderbox: 'caixa-para-fogo',
  Torch: 'tocha',
  Vial: 'pote',
  Waterskin: 'cantil-cheio',
  // Armor short names
  Padded: 'padded',
  Leather: 'leather',
  'Studded Leather': 'studded-leather',
  Hide: 'hide',
  'Chain Shirt': 'chain-shirt',
  'Scale Mail': 'scale-mail',
  Breastplate: 'breastplate',
  'Half Plate': 'half-plate',
  'Ring Mail': 'ring-mail',
  'Chain Mail': 'chain-mail',
  Splint: 'splint',
  Plate: 'plate',
  Shield: 'shield',
  // Tools
  "Alchemist's Supplies": 'suprimentos-de-alquimista',
  "Brewer's Supplies": 'suprimentos-de-cervejeiro',
  "Calligrapher's Supplies": 'suprimentos-de-caligrafo',
  "Carpenter's Tools": 'ferramentas-de-carpinteiro',
  "Cartographer's Tools": 'ferramentas-de-cartografo',
  "Cobbler's Tools": 'ferramentas-de-sapateiro',
  "Cook's Utensils": 'utensilios-de-cozinheiro',
  "Glassblower's Tools": 'ferramentas-de-vidreiro',
  "Jeweler's Tools": 'ferramentas-de-joalheiro',
  "Leatherworker's Tools": 'ferramentas-de-coureiro',
  "Mason's Tools": 'ferramentas-de-pedreiro',
  "Painter's Supplies": 'suprimentos-de-pintor',
  "Potter's Tools": 'ferramentas-de-oleiro',
  "Smith's Tools": 'ferramentas-de-ferreiro',
  "Tinker's Tools": 'ferramentas-de-funileiro',
  "Weaver's Tools": 'ferramentas-de-tecelao',
  "Woodcarver's Tools": 'ferramentas-de-entalhador',
  'Disguise Kit': 'kit-de-disfarce',
  'Forgery Kit': 'kit-de-falsificacao',
  'Herbalism Kit': 'kit-de-herbalismo',
  "Navigator's Tools": 'ferramentas-de-navegador',
  "Poisoner's Kit": 'kit-de-veneno',
  "Thieves' Tools": 'ferramentas-de-ladrao',
};

function slugifyEn(name) {
  return name
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/[''`]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function normalizeCostEn(raw) {
  const t = raw.replace(/,/g, '').trim();
  if (/^varies$/i.test(t)) return { text: 'Varia', copper: null };
  const m = t.match(/^(\d+(?:\.\d+)?)\s*(CP|SP|EP|GP|PP)\b/i);
  if (!m) return { text: t, copper: null };
  const amount = Number(m[1]);
  const unit = m[2].toUpperCase();
  const gp = amount * COIN_VALUES_GP[unit];
  const copper = Math.round(gp * 100);
  const ptUnit =
    unit === 'CP'
      ? 'PC'
      : unit === 'SP'
        ? 'PP'
        : unit === 'EP'
          ? 'PE'
          : unit === 'GP'
            ? 'PO'
            : 'PL';
  const amountText =
    amount >= 1000
      ? amount.toLocaleString('pt-BR').replace(/\u00a0/g, '.')
      : String(amount);
  return { text: `${amountText} ${ptUnit}`, copper, amount, unit: ptUnit };
}

function parseSeedCosts(sql) {
  const map = new Map();
  const re =
    /\(\s*'([^']+)'\s*,\s*'[^']+'::rpg\.item_type\s*,\s*'((?:[^']|'')*)'\s*,\s*'(\{"text":"[^"]+"\})'::jsonb/g;
  let m;
  while ((m = re.exec(sql))) {
    const slug = m[1];
    let costJson;
    try {
      costJson = JSON.parse(m[3]);
    } catch {
      continue;
    }
    map.set(slug, costJson.text ?? null);
  }
  return map;
}

function costTextToCopper(text) {
  if (!text || /^varia$/i.test(text.trim())) return null;
  const matches = [
    ...text.matchAll(/(\d{1,3}(?:\.\d{3})*|\d+)\s*(PC|PP|PE|PO|PL|PPl)\b/gi),
  ];
  if (!matches.length) return null;
  let copper = 0;
  const rates = { pc: 1, pp: 10, pe: 50, po: 100, pl: 1000, ppl: 1000 };
  for (const match of matches) {
    const amount = Number(match[1].replace(/\./g, ''));
    const key = match[2].toLowerCase();
    copper += amount * (rates[key] ?? 0);
  }
  return copper;
}

function extractTableRows(html, tableIdHint) {
  const rows = [];
  // Find caption/h3 with id, then following <tbody>
  const idRe = new RegExp(
    `id="${tableIdHint}"[\\s\\S]*?<tbody>([\\s\\S]*?)</tbody>`,
    'i',
  );
  const block = html.match(idRe);
  if (!block) return rows;
  const trRe = /<tr>([\s\S]*?)<\/tr>/gi;
  let tr;
  while ((tr = trRe.exec(block[1]))) {
    const cells = [...tr[1].matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)].map(
      (c) =>
        c[1]
          .replace(/<[^>]+>/g, '')
          .replace(/&nbsp;/g, ' ')
          .replace(/&amp;/g, '&')
          .replace(/\s+/g, ' ')
          .trim(),
    );
    if (cells.length < 2) continue;
    if (/^(Simple|Martial|Light|Medium|Heavy)/i.test(cells[0])) continue;
    if (/colspan/i.test(tr[1]) && cells.length === 1) continue;
    rows.push(cells);
  }
  return rows;
}

function extractHeadingPrices(html) {
  const items = [];
  const re =
    /id="([A-Za-z0-9]+)(\d+)(GP|SP|CP|EP|PP)"[\s\S]{0,400}?<a[^>]*>([^<]+)<\/a>/gi;
  let m;
  while ((m = re.exec(html))) {
    const name = m[4].trim();
    const amount = Number(m[2]);
    const unit = m[3].toUpperCase();
    items.push({ name, raw: `${amount} ${unit}` });
  }
  // Spell scroll special
  items.push({ name: 'Spell Scroll (Cantrip)', raw: '30 GP' });
  items.push({ name: 'Spell Scroll (Level 1)', raw: '50 GP' });
  return items;
}

function resolveSlug(enName) {
  if (EN_TO_SLUG[enName]) return EN_TO_SLUG[enName];
  const bare = enName
    .replace(/\s*\([^)]*\)\s*$/, '')
    .replace(/\s+Armor$/i, '')
    .trim();
  if (EN_TO_SLUG[bare]) return EN_TO_SLUG[bare];
  return slugifyEn(bare);
}

function main() {
  if (!htmlPath || !fs.existsSync(htmlPath)) {
    console.error(
      'Defina PHB_EQUIPMENT_HTML com o caminho do HTML Beyond (fora do repo).',
      htmlPath ?? '(não definido)',
    );
    process.exit(1);
  }
  const html = fs.readFileSync(htmlPath, 'utf8');
  const seed = fs.readFileSync(seedPath, 'utf8');
  const seedCosts = parseSeedCosts(seed);

  const beyond = [];

  for (const cells of extractTableRows(html, 'WeaponsTable')) {
    // Name, Damage, Properties, Mastery, Weight, Cost
    if (cells.length < 6) continue;
    beyond.push({
      section: 'weapons',
      name: cells[0],
      costRaw: cells[5],
      slug: resolveSlug(cells[0]),
    });
  }
  for (const cells of extractTableRows(html, 'ArmorTable')) {
    // Name, Armor Class, Strength, Stealth, Weight, Cost — or similar
    if (cells.length < 6) continue;
    beyond.push({
      section: 'armor',
      name: cells[0],
      costRaw: cells[cells.length - 1],
      slug: resolveSlug(cells[0]),
    });
  }

  for (const item of extractHeadingPrices(html)) {
    beyond.push({
      section: 'gear-heading',
      name: item.name,
      costRaw: item.raw,
      slug: resolveSlug(item.name),
    });
  }

  const mismatches = [];
  const matched = [];
  const missingInSeed = [];
  const seen = new Set();

  for (const row of beyond) {
    const key = `${row.slug}|${row.costRaw}`;
    if (seen.has(row.slug)) continue;
    seen.add(row.slug);

    const expected = normalizeCostEn(row.costRaw);
    const seedText = seedCosts.get(row.slug);
    if (seedText == null) {
      missingInSeed.push(row);
      continue;
    }
    const seedCopper = costTextToCopper(seedText);
    const ok =
      expected.copper != null &&
      seedCopper != null &&
      expected.copper === seedCopper;
    const entry = {
      slug: row.slug,
      name: row.name,
      section: row.section,
      beyond: expected.text,
      seed: seedText,
      beyondCopper: expected.copper,
      seedCopper,
    };
    if (ok) matched.push(entry);
    else mismatches.push(entry);
  }

  const lines = [
    '# Auditoria de preços — PHB Equipment (Beyond) vs S031',
    '',
    `Fonte: PHB 2024 Cap. 6 Equipment (Beyond) — scrape local fora do repo.`,
    `Seed: \`database/seeds/phb/S031_phb_item.sql\``,
    '',
    '## Coin Values (PHB)',
    '',
    '| Moeda EN | Abrev PT | Valor em PO |',
    '|----------|----------|-------------|',
    '| Copper (CP) | PC | 1/100 |',
    '| Silver (SP) | PP | 1/10 |',
    '| Electrum (EP) | PE | 1/2 |',
    '| Gold (GP) | PO | 1 |',
    '| Platinum (PP) | PL | 10 |',
    '',
    '## Resumo',
    '',
    `- Comparados (únicos com slug no seed): **${matched.length + mismatches.length}**`,
    `- Match cobre: **${matched.length}**`,
    `- Mismatch: **${mismatches.length}**`,
    `- Beyond sem slug no S031: **${missingInSeed.length}**`,
    '',
    '## Mismatches',
    '',
  ];

  if (!mismatches.length) {
    lines.push('_Nenhum mismatch de valor (cobre) nos itens mapeados._', '');
  } else {
    lines.push('| Slug | Beyond | Seed |', '|------|--------|------|');
    for (const m of mismatches) {
      lines.push(`| \`${m.slug}\` | ${m.beyond} | ${m.seed} |`);
    }
    lines.push('');
  }

  lines.push('## Beyond sem entrada S031 (amostra)', '');
  for (const m of missingInSeed.slice(0, 40)) {
    lines.push(`- ${m.name} → \`${m.slug}\` (${m.costRaw})`);
  }
  if (missingInSeed.length > 40) {
    lines.push(`- … +${missingInSeed.length - 40} itens`);
  }
  lines.push('');

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  console.log('wrote', outPath);
  console.log('matched', matched.length, 'mismatch', mismatches.length);
  if (mismatches.length) {
    console.log(
      mismatches
        .slice(0, 20)
        .map((m) => `${m.slug}: beyond=${m.beyond} seed=${m.seed}`)
        .join('\n'),
    );
  }
}

main();
