/**
 * Extrai do Cap. 6 Equipment (Beyond HTML local, fora do repo) o que ainda
 * NÃO está no S031: montarias, veículos, serviços, variantes Varia, etc.
 *
 * Uso:
 *   PHB_EQUIPMENT_HTML=/caminho/Equipment….html node scripts/compile-phb-equipment-gaps-from-beyond.mjs
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
const outPath = path.join(
  root,
  'docs/source/phb-2024-equipment-gaps-catalog.md',
);

function stripHtml(s) {
  return s
    .replace(/<[^>]+>/g, '')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&rsquo;/g, "'")
    .replace(/&#39;/g, "'")
    .replace(/\s+/g, ' ')
    .trim();
}

function slugify(name) {
  return name
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/[''`]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function slugFromHref(cellHtml) {
  const m = cellHtml.match(
    /href="https:\/\/www\.dndbeyond\.com\/equipment\/\d+-([^"?]+)"/i,
  );
  return m ? m[1] : null;
}

function primaryNameFromCell(cellHtml) {
  const link = cellHtml.match(/<a[^>]*>([\s\S]*?)<\/a>/i);
  if (link) return stripHtml(link[1]);
  return stripHtml(cellHtml);
}

/** Traduz só a parte monetária; preserva sufixos (per day / per mile). */
function enCostToPt(raw) {
  const t = String(raw ?? '')
    .replace(/,/g, '')
    .trim();
  if (/^varies$/i.test(t) || /^—$/i.test(t) || t === '') return t || '—';

  const m = t.match(
    /^(\d+(?:\.\d+)?)\s*(CP|SP|EP|GP|PP)\b(.*)$/i,
  );
  if (!m) return t;
  const amount = Number(m[1]);
  const unit = m[2].toUpperCase();
  const suffix = m[3]
    .replace(/\bper day\b/gi, '/ dia')
    .replace(/\bper mile\b/gi, '/ milha')
    .trim();
  const pt =
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
  return suffix ? `${amountText} ${pt} ${suffix}` : `${amountText} ${pt}`;
}

function parseSeedSlugs(sql) {
  const set = new Set();
  const re = /\(\s*'([^']+)'\s*,\s*'[^']+'::rpg\.item_type/g;
  let m;
  while ((m = re.exec(sql))) set.add(m[1]);
  return set;
}

/**
 * @returns {{ section: string|null, name: string, slug: string, cells: string[] }[]}
 */
function extractTableRows(html, id) {
  const re = new RegExp(
    `id="${id}"[\\s\\S]*?<tbody>([\\s\\S]*?)</tbody>`,
    'i',
  );
  const block = html.match(re);
  if (!block) return [];

  const rows = [];
  let section = null;
  const trRe = /<tr>([\s\S]*?)<\/tr>/gi;
  let tr;
  while ((tr = trRe.exec(block[1]))) {
    const raw = tr[1];
    const sectionMatch = raw.match(/colspan[^>]*>\s*<em>([\s\S]*?)<\/em>/i);
    if (sectionMatch) {
      section = stripHtml(sectionMatch[1]);
      continue;
    }
    if (/colspan/i.test(raw)) continue;

    const tdMatches = [...raw.matchAll(/<t[dh][^>]*>([\s\S]*?)<\/t[dh]>/gi)];
    if (tdMatches.length < 2) continue;

    const firstHtml = tdMatches[0][1];
    const cells = tdMatches.map((c) => stripHtml(c[1]));
    if (/^(Simple|Martial|Light|Medium|Heavy|Item|Name|Ship|Focus|Symbol|Type|Service)$/i.test(cells[0])) {
      continue;
    }

    const slug = slugFromHref(firstHtml) ?? slugify(primaryNameFromCell(firstHtml));
    const name = primaryNameFromCell(firstHtml);
    const nameExtra = stripHtml(firstHtml).replace(name, '').trim();
    const displayName = nameExtra ? `${name} ${nameExtra}` : name;

    rows.push({
      section,
      name: displayName,
      slug,
      cells,
    });
  }
  return rows;
}

function mapCostRows(rows) {
  return rows.map((r) => {
    const costEn = r.cells[r.cells.length - 1];
    return {
      ...r,
      weight: r.cells.length >= 3 ? r.cells[1] : '—',
      costEn,
      costPt: enCostToPt(costEn),
    };
  });
}

function extractVariantsParagraph(html, id) {
  const re = new RegExp(
    `id="${id}"[\\s\\S]*?<strong>Variants:<\\/strong>([\\s\\S]*?)<\\/(?:p|hr)`,
    'i',
  );
  const m = html.match(re);
  if (!m) return [];
  const chunk = m[1];
  const out = [];
  const linkRe =
    /<a[^>]*href="https:\/\/www\.dndbeyond\.com\/equipment\/\d+-([^"?]+)"[^>]*>([\s\S]*?)<\/a>\s*\(([^)]+)\)/gi;
  let lm;
  while ((lm = linkRe.exec(chunk))) {
    const slug = lm[1];
    const name = stripHtml(lm[2]);
    const meta = lm[3].trim();
    const costMatch = meta.match(/([\d,]+)\s*(CP|SP|EP|GP|PP)/i);
    const weightMatch = meta.match(/([\d½¼¾.]+)\s*lb\.?/i);
    const costEn = costMatch
      ? `${costMatch[1].replace(/,/g, '')} ${costMatch[2].toUpperCase()}`
      : meta;
    out.push({
      name,
      slug,
      costEn,
      costPt: enCostToPt(costEn),
      weight: weightMatch ? `${weightMatch[1]} lb.` : '—',
      meta,
    });
  }
  return out;
}

function extractParagraphNearId(html, id, maxChars = 900) {
  const re = new RegExp(
    `id="${id}"[\\s\\S]{0,200}?<\\/h[2-4]>([\\s\\S]{0,${maxChars}})`,
    'i',
  );
  const m = html.match(re);
  if (!m) return '';
  return stripHtml(m[1]).slice(0, 500);
}

function tableMd(headers, rows) {
  const lines = [
    `| ${headers.join(' | ')} |`,
    `| ${headers.map(() => '---').join(' | ')} |`,
    ...rows.map((r) => `| ${r.join(' | ')} |`),
  ];
  return lines.join('\n');
}

function inSeed(seedSlugs, slug) {
  return seedSlugs.has(slug);
}

/** Beyond EN slug → slug PT usado no S031 (quando diferente). */
const BEYOND_SLUG_TO_SEED = {
  camel: 'camelo',
  elephant: 'elefante',
  'draft-horse': 'cavalo-de-carga',
  'riding-horse': 'cavalo-de-montaria',
  mastiff: 'mastim',
  mule: 'mula',
  pony: 'ponei',
  warhorse: 'cavalo-de-guerra',
  carriage: 'carruagem',
  cart: 'carroca',
  chariot: 'carro-de-guerra',
  'feed-per-day': 'racao-animal-por-dia',
  'exotic-saddle': 'sela-exotica',
  'military-saddle': 'sela-militar',
  'riding-saddle': 'sela-de-montaria',
  sled: 'treno',
  'stabling-per-day': 'estabulo-por-dia',
  wagon: 'vagao',
  airship: 'aeronave',
  galley: 'galera',
  keelboat: 'barco-de-quilla',
  longship: 'navio-longo',
  rowboat: 'bote',
  'sailing-ship': 'navio-a-vela',
  warship: 'navio-de-guerra',
  arrows: 'flechas',
  bolts: 'virotes',
  'firearm-bullets': 'balas-arma-de-fogo',
  'sling-bullets': 'balas-de-funda',
  needles: 'agulhas',
  crystal: 'cristal',
  orb: 'orbe',
  rod: 'bastao',
  staff: 'cajado-arcano',
  wand: 'varinha',
  'sprig-of-mistletoe': 'ramo-de-visco',
  'wooden-staff': 'cajado-de-madeira',
  'yew-wand': 'varinha-de-teixo',
  amulet: 'amuleto',
  emblem: 'emblema',
  reliquary: 'relicario',
  dice: 'conjunto-de-dados',
  dragonchess: 'xadrez-do-dragao',
  'playing-cards': 'baralho',
  'three-dragon-ante': 'ante-dos-tres-dragoes',
  bagpipes: 'gaita-de-foles',
  drum: 'tambor',
  dulcimer: 'salterio',
  flute: 'flauta',
  horn: 'trompa',
  lute: 'alaude',
  lyre: 'lira',
  'pan-flute': 'flauta-de-pan',
  shawm: 'charamela',
  viol: 'viola',
};

function seedSlugFor(beyondSlug) {
  return BEYOND_SLUG_TO_SEED[beyondSlug] ?? beyondSlug;
}

function inSeedMapped(seedSlugs, beyondSlug) {
  return seedSlugs.has(seedSlugFor(beyondSlug));
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
  const seedSlugs = parseSeedSlugs(fs.readFileSync(seedPath, 'utf8'));

  const mounts = mapCostRows(extractTableRows(html, 'MountsandOtherAnimals')).map(
    (r) => ({
      ...r,
      capacity: r.cells[1],
    }),
  );

  const tack = mapCostRows(
    extractTableRows(html, 'TackHarnessandDrawnVehicles'),
  ).map((r) => {
    // Beyond lista só "Exotic/Military/Riding" sob o cabeçalho Saddle.
    const shortSaddle =
      /^(exotic|military|riding)$/i.test(r.slug) ||
      /^(Exotic|Military|Riding)$/i.test(r.name);
    return {
      ...r,
      displayName: shortSaddle ? `${r.name} Saddle` : r.name,
      slug:
        shortSaddle && !r.slug.includes('saddle')
          ? `${r.slug}-saddle`
          : r.slug,
    };
  });

  const largeRows = extractTableRows(html, 'AirborneandWaterborneVehicles');
  const large = largeRows.map((r) => {
    const c = r.cells;
    return {
      name: r.name,
      slug: r.slug,
      speed: c[1] ?? '—',
      crew: c[2] ?? '—',
      passengers: c[3] ?? '—',
      cargo: c[4] ?? '—',
      ac: c[5] ?? '—',
      hp: c[6] ?? '—',
      damageThreshold: c[7] ?? '—',
      costEn: c[c.length - 1],
      costPt: enCostToPt(c[c.length - 1]),
    };
  });

  const lifestyleFromHeads = [
    ['Wretched', 'Free', 'Grátis'],
    ['Squalid', '1 SP per Day', '1 PP / dia'],
    ['Poor', '2 SP per Day', '2 PP / dia'],
    ['Modest', '1 GP per Day', '1 PO / dia'],
    ['Comfortable', '2 GP per Day', '2 PO / dia'],
    ['Wealthy', '4 GP per Day', '4 PO / dia'],
    ['Aristocratic', '10 GP per Day', '10 PO / dia'],
  ];

  const food = mapCostRows(extractTableRows(html, 'FoodDrinkandLodging')).map(
    (r) => ({
      ...r,
      label: r.section ? `${r.section} — ${r.name}` : r.name,
    }),
  );

  const travel = mapCostRows(extractTableRows(html, 'Travel'));
  const hirelings = mapCostRows(extractTableRows(html, 'Hirelings'));
  const spellServices = extractTableRows(html, 'SpellcastingServices').map(
    (r) => ({
      level: r.cells[0],
      availability: r.cells[1] ?? '—',
      costEn: r.cells[r.cells.length - 1],
      costPt: enCostToPt(r.cells[r.cells.length - 1]),
    }),
  );

  const scrollCosts = extractTableRows(html, 'SpellScrollCosts').map((r) => {
    const costEn = r.cells[2];
    const m = costEn?.match(/^([\d,]+)\s*GP/i);
    const sellHintPt = m
      ? `${(Number(m[1].replace(/,/g, '')) * 2).toLocaleString('pt-BR')} PO (2× scribe)`
      : '—';
    return {
      level: r.cells[0],
      time: r.cells[1],
      costEn,
      costPt: enCostToPt(costEn),
      sellHintPt,
    };
  });

  const ammo = extractTableRows(html, 'AmmunitionTable').map((r) => ({
    name: r.name,
    slug: r.slug,
    amount: r.cells[1],
    storage: r.cells[2],
    weight: r.cells[3],
    costEn: r.cells[4],
    costPt: enCostToPt(r.cells[4]),
  }));

  const arcaneFocus = mapCostRows(extractTableRows(html, 'ArcaneFocuses'));
  const druidicFocus = mapCostRows(extractTableRows(html, 'DruidicFocuses'));
  const holySymbols = mapCostRows(extractTableRows(html, 'HolySymbols'));
  const gamingSets = extractVariantsParagraph(html, 'GamingSetVaries');
  const musicalInstruments = extractVariantsParagraph(
    html,
    'MusicalInstrumentVaries',
  );

  const notes = {
    barding: extractParagraphNearId(html, 'Barding'),
    saddles: extractParagraphNearId(html, 'Saddles'),
    mountsCargo: extractParagraphNearId(html, 'MountsandCargo'),
    shipRepair: extractParagraphNearId(html, 'ShipRepair'),
    passengers: extractParagraphNearId(html, 'Passengers'),
  };

  const missingMounts = mounts.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingTack = tack.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingLarge = large.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingAmmo = ammo.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingArcane = arcaneFocus.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingDruid = druidicFocus.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingHoly = holySymbols.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingGames = gamingSets.filter((r) => !inSeedMapped(seedSlugs, r.slug));
  const missingMusic = musicalInstruments.filter((r) => !inSeedMapped(seedSlugs, r.slug));

  const variantMissingCount =
    missingAmmo.length +
    missingArcane.length +
    missingDruid.length +
    missingHoly.length +
    missingGames.length +
    missingMusic.length;

  const lines = [];
  lines.push('# PHB Equipment — gaps vs catálogo (S031)');
  lines.push('');
  lines.push(
    'Compilado a partir do Cap. 6 Equipment (Beyond) — scrape local fora do repo.',
  );
  lines.push(
    'Objetivo: comparar Cap. 6 Beyond vs `S031` (slugs PT). Variantes/montarias/serviços foram seedados — este doc serve de auditoria.',
  );
  lines.push('');
  lines.push('## Resumo');
  lines.push('');
  lines.push(
    `| Bloco | Entradas Beyond | Já no S031 (slug PT) | Faltando |`,
  );
  lines.push(`|--------|-----------------|----------------------|----------|`);
  lines.push(
    `| Montarias / animais | ${mounts.length} | ${mounts.length - missingMounts.length} | **${missingMounts.length}** |`,
  );
  lines.push(
    `| Arnês / veículos terrestres | ${tack.length} | ${tack.length - missingTack.length} | **${missingTack.length}** |`,
  );
  lines.push(
    `| Veículos grandes (ar/água) | ${large.length} | ${large.length - missingLarge.length} | **${missingLarge.length}** |`,
  );
  lines.push(
    `| Variantes (foco / munição / jogos / instrumentos) | ${ammo.length + arcaneFocus.length + druidicFocus.length + holySymbols.length + gamingSets.length + musicalInstruments.length} | ${ammo.length + arcaneFocus.length + druidicFocus.length + holySymbols.length + gamingSets.length + musicalInstruments.length - variantMissingCount} | **${variantMissingCount}** |`,
  );
  lines.push(
    `| Lifestyle / comida / viagem / hirelings / magia | tabelas de serviço | seedados como \`other\` (\`kind:service\`) | ver S031 |`,
  );
  lines.push(
    `| Barding | regra (armadura ×4 custo, ×2 peso) | 0 | regra + opcionalmente itens |`,
  );
  lines.push('');
  lines.push('## Já cobrimos (não repetir)');
  lines.push('');
  lines.push(
    '- Armas, armaduras, ferramentas, gear de aventura, poção de cura, pergaminhos truque/1º — ver `S031` + audit `phb-2024-equipment-prices-audit.md`.',
  );
  lines.push(
    '- Itens mágicos DMG A–Z — `D010` (preço por raridade).',
  );
  lines.push(
    '- Venda de equipamento = ½ custo (já no fluxo de inventário em campanha).',
  );
  lines.push('');

  lines.push('## 1. Montarias e outros animais');
  lines.push('');
  if (notes.mountsCargo) lines.push(`> ${notes.mountsCargo}`);
  lines.push('');
  lines.push(
    tableMd(
      [
        'Nome EN',
        'Slug sugerido',
        'Capacidade',
        'Custo EN',
        'Custo PT',
        'No S031?',
      ],
      mounts.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.capacity,
        r.costEn,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');
  lines.push(
    '**Nota de modelo:** montaria não é “gear” puro — precisa de capacidade de carga e (idealmente) vínculo com bloco de monstro do Apêndice B. Para loja MVP: `item_type: other` + `properties.kind: mount` + `carryingCapacityLb`.',
  );
  lines.push('');

  lines.push('## 2. Arnês, selas e veículos puxados');
  lines.push('');
  if (notes.saddles) lines.push(`> Selas: ${notes.saddles}`);
  lines.push('');
  lines.push(
    tableMd(
      [
        'Nome EN',
        'Slug sugerido',
        'Peso',
        'Custo EN',
        'Custo PT',
        'No S031?',
      ],
      tack.map((r) => [
        r.displayName,
        `\`${seedSlugFor(r.slug)}\``,
        r.weight,
        r.costEn,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');
  lines.push(
    `> Barding: ${notes.barding || 'Armadura de montaria = 4× custo e 2× peso da armadura correspondente.'}`,
  );
  lines.push('');
  lines.push(
    '**Barding (não listar 13 linhas):** gerar sob demanda a partir das armaduras do S031 (`cost × 4`, `weight × 2`) com slug `barding-{armorSlug}`.',
  );
  lines.push('');

  lines.push('## 3. Veículos grandes (ar / água)');
  lines.push('');
  if (large.length === 0) {
    lines.push(
      '_Tabela não parseada — ver HTML `#AirborneandWaterborneVehicles`._',
    );
  } else {
    lines.push(
      tableMd(
        [
          'Nome EN',
          'Slug',
          'Speed',
          'Crew',
          'Passengers',
          'Cargo (tons)',
          'AC',
          'HP',
          'DT',
          'Custo PT',
          'No S031?',
        ],
        large.map((r) => [
          r.name,
          `\`${seedSlugFor(r.slug)}\``,
          r.speed,
          r.crew,
          r.passengers,
          r.cargo,
          r.ac,
          r.hp,
          r.damageThreshold,
          r.costPt,
          inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
        ]),
      ),
    );
  }
  lines.push('');
  if (notes.passengers) lines.push(`> Passageiros: ${notes.passengers}`);
  lines.push('');
  if (notes.shipRepair) lines.push(`> Reparo: ${notes.shipRepair}`);
  lines.push('');
  lines.push(
    '**Nota:** navios exigem hirelings skilled (ver Serviços). Stats extras → `properties` JSON.',
  );
  lines.push('');

  lines.push('## 4. Serviços (não são itens de inventário)');
  lines.push('');
  lines.push(
    'Estes blocos **não** entram bem em `phb_item` como gear. Sugestão: tabela `rpg.phb_service` ou catálogo `kind: service` + UI de loja “Serviços” (debitar sem criar item, ou criar voucher consumível).',
  );
  lines.push('');

  lines.push('### 4.1 Lifestyle Expenses');
  lines.push('');
  lines.push(
    tableMd(['Estilo', 'Preço EN', 'Preço PT'], lifestyleFromHeads),
  );
  lines.push('');

  lines.push('### 4.2 Food, Drink, and Lodging');
  lines.push('');
  if (!food.length) {
    lines.push('_Tabela não parseada — ver HTML `#FoodDrinkandLodging`._');
  } else {
    lines.push(
      tableMd(
        ['Item', 'Custo EN', 'Custo PT'],
        food.map((r) => [r.label, r.costEn, r.costPt]),
      ),
    );
  }
  lines.push('');

  lines.push('### 4.3 Travel');
  lines.push('');
  if (!travel.length) {
    lines.push('_Tabela não parseada — ver HTML `#Travel`._');
  } else {
    lines.push(
      tableMd(
        ['Serviço', 'Custo EN', 'Custo PT'],
        travel.map((r) => [r.name, r.costEn, r.costPt]),
      ),
    );
  }
  lines.push('');

  lines.push('### 4.4 Hirelings');
  lines.push('');
  if (!hirelings.length) {
    lines.push('_Tabela não parseada — ver HTML `#Hirelings`._');
  } else {
    lines.push(
      tableMd(
        ['Tipo', 'Custo EN', 'Custo PT'],
        hirelings.map((r) => [r.name, r.costEn, r.costPt]),
      ),
    );
  }
  lines.push('');

  lines.push('### 4.5 Spellcasting Services');
  lines.push('');
  if (!spellServices.length) {
    lines.push('_Tabela não parseada — ver HTML `#SpellcastingServices`._');
  } else {
    lines.push(
      tableMd(
        ['Círculo', 'Disponibilidade', 'Custo EN', 'Custo PT'],
        spellServices.map((r) => [
          r.level,
          r.availability,
          r.costEn,
          r.costPt,
        ]),
      ),
    );
  }
  lines.push('');

  lines.push('## 5. Transcrição de pergaminhos (crafting, não loja)');
  lines.push('');
  lines.push(
    'Custo de **criar** (scribe). Valor de venda do Spell Scroll genérico = **2×** (já no PHB Equipment / aside Magic Item values).',
  );
  lines.push('');
  if (scrollCosts.length) {
    lines.push(
      tableMd(
        ['Nível', 'Tempo', 'Scribe EN', 'Scribe PT', 'Venda sugerida'],
        scrollCosts.map((r) => [
          r.level,
          r.time,
          r.costEn,
          r.costPt,
          r.sellHintPt,
        ]),
      ),
    );
  }
  lines.push('');
  lines.push(
    'Hoje no S031 só existem `pergaminho-magico-truque` (30 PO) e `pergaminho-magico-1-circulo` (50 PO). **Faltam** níveis 2–9 como SKUs de loja.',
  );
  lines.push('');

  lines.push('## 6. Variantes “Varia” — linhas concretas do Beyond');
  lines.push('');
  lines.push(
    'No S031 os pais (`foco-arcano`, `foco-druidico`, `simbolo-sagrado`, `municao`, `instrumento-musical`, `kit-de-jogos`) têm cost `Varia`. Abaixo, as **linhas filhas** com preço pronto para seed.',
  );
  lines.push('');

  lines.push('### 6.1 Ammunition');
  lines.push('');
  lines.push(
    tableMd(
      [
        'Nome EN',
        'Slug',
        'Qtd',
        'Storage',
        'Peso',
        'Custo PT',
        'No S031?',
      ],
      ammo.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.amount,
        r.storage,
        r.weight,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');

  lines.push('### 6.2 Arcane Focuses');
  lines.push('');
  lines.push(
    tableMd(
      ['Nome EN', 'Slug', 'Peso', 'Custo PT', 'No S031?'],
      arcaneFocus.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.weight,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');

  lines.push('### 6.3 Druidic Focuses');
  lines.push('');
  lines.push(
    tableMd(
      ['Nome EN', 'Slug', 'Peso', 'Custo PT', 'No S031?'],
      druidicFocus.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.weight,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');

  lines.push('### 6.4 Holy Symbols');
  lines.push('');
  lines.push(
    tableMd(
      ['Nome EN', 'Slug', 'Peso', 'Custo PT', 'No S031?'],
      holySymbols.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.weight,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');

  lines.push('### 6.5 Gaming Set (variantes)');
  lines.push('');
  lines.push(
    tableMd(
      ['Nome EN', 'Slug', 'Custo PT', 'No S031?'],
      gamingSets.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');

  lines.push('### 6.6 Musical Instrument (variantes)');
  lines.push('');
  lines.push(
    tableMd(
      ['Nome EN', 'Slug', 'Peso', 'Custo PT', 'No S031?'],
      musicalInstruments.map((r) => [
        r.name,
        `\`${seedSlugFor(r.slug)}\``,
        r.weight,
        r.costPt,
        inSeedMapped(seedSlugs, r.slug) ? 'sim' : '**não**',
      ]),
    ),
  );
  lines.push('');

  lines.push('## 7. Ordem sugerida para adicionar');
  lines.push('');
  lines.push(
    '1. **Variantes concretas** (foco / munição / jogos / instrumentos) — dados prontos, só seed.',
  );
  lines.push(
    '2. **Montarias + tack/selas/carroças** (loja de equipamento estendida).',
  );
  lines.push(
    '3. **Pergaminhos mágicos 2º–9º** (SKU por círculo; preço = 2× scribe).',
  );
  lines.push(
    '4. **Serviços** (lifestyle, hospedagem, hirelings, cast) — UI separada, débito sem item.',
  );
  lines.push(
    '5. **Veículos grandes + barding gerado** (mais pesado; stats extras).',
  );
  lines.push('');
  lines.push('---');
  lines.push('');
  lines.push(
    `Gerado por \`scripts/compile-phb-equipment-gaps-from-beyond.mjs\` · ${new Date().toISOString().slice(0, 10)}`,
  );

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  console.log('wrote', outPath);
  console.log({
    mounts: mounts.length,
    missingMounts: missingMounts.length,
    tack: tack.length,
    missingTack: missingTack.length,
    large: large.length,
    food: food.length,
    travel: travel.length,
    hirelings: hirelings.length,
    spellServices: spellServices.length,
    scrollCosts: scrollCosts.length,
    ammo: ammo.length,
    arcaneFocus: arcaneFocus.length,
    druidicFocus: druidicFocus.length,
    holySymbols: holySymbols.length,
    gamingSets: gamingSets.length,
    musicalInstruments: musicalInstruments.length,
    variantMissingCount,
  });
}

main();
