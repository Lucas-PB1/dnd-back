/**
 * Extrai Cap. 5 Northlands (Magic and Miscellany) do scrape Beyond → JSON + MD.
 * Uso: node scripts/extract-northlands-cap5.mjs
 */
import fs from 'fs';

const HTML =
  'docs/source/new/Magic and Miscellany - Northlands Worldbook - Dungeons & Dragons - Sources - D&D Beyond.html';
const JSON_OUT = 'docs/source/northlands-cap5-extract.json';
const MD_OUT = 'docs/plans/northlands-magic-and-miscellany.md';

function toText(html) {
  const articleMatch = html.match(
    /<div class="p-article-content[^"]*"[^>]*>([\s\S]*?)(?:<footer|<\/article|id="SiteFooter"|$)/i,
  );
  const chunk = articleMatch ? articleMatch[1] : html;
  return chunk
    .replace(/<script[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?<\/style>/gi, '')
    .replace(/<!--[\s\S]*?-->/g, '')
    .replace(/<br\s*\/?>/gi, '\n')
    .replace(/<\/(p|div|h[1-6]|li|tr|section)>/gi, '\n')
    .replace(/<(h[1-6])[^>]*>/gi, (_, tag) => `\n###H${tag[1]}### `)
    .replace(/<[^>]+>/g, ' ')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&rsquo;|&lsquo;|&#39;/g, "'")
    .replace(/&rdquo;|&ldquo;/g, '"')
    .replace(/&mdash;/g, '—')
    .replace(/&ndash;/g, '–')
    .replace(/&#(\d+);/g, (_, n) => String.fromCharCode(Number(n)))
    .replace(/[ \t]+/g, ' ')
    .replace(/ ?\n ?/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function slugify(name) {
  return name
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/['’‘`]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

function sliceBetween(text, startMarker, endMarker) {
  const start = text.indexOf(startMarker);
  if (start < 0) return '';
  const from = start + startMarker.length;
  const end = endMarker ? text.indexOf(endMarker, from) : -1;
  return (end < 0 ? text.slice(from) : text.slice(from, end)).trim();
}

function parseH5Blocks(sectionText) {
  const parts = sectionText.split(/\n###H5###\s+/);
  const blocks = [];
  for (let i = 1; i < parts.length; i++) {
    const raw = parts[i].trim();
    const nl = raw.indexOf('\n');
    const name = (nl < 0 ? raw : raw.slice(0, nl)).trim();
    const body = (nl < 0 ? '' : raw.slice(nl + 1)).trim();
    if (!name || name === 'Armor' || name === 'Adventuring Gear' || name === 'Mounts' || name === 'Land Vehicles') {
      continue;
    }
    blocks.push({ name, body });
  }
  return blocks;
}

function parseItemMeta(body) {
  const rarityMatch = body.match(
    /\b(Common|Uncommon|Rare|Very Rare|Legendary|Artifact|Fabled)\b(?:\s*\(([^)]+)\))?/i,
  );
  const attune = /Requires Attunement|require attunement/i.test(body);
  const firstPara = body.split(/\n\n+/)[0]?.replace(/\s+/g, ' ').trim() ?? '';
  return {
    rarity: rarityMatch?.[1] ?? null,
    rarityNote: rarityMatch?.[2]?.trim() ?? null,
    requiresAttunement: attune,
    summary: firstPara.slice(0, 280),
  };
}

function parseSpellMeta(body) {
  const header = body.split(/\n\n+/)[0]?.replace(/\s+/g, ' ').trim() ?? '';
  // "Evocation Cantrip (Druid, …)" | "Level 9 Conjuration (Cleric, …)"
  const cantrip = header.match(
    /^([A-Za-z]+(?:\s+[A-Za-z]+)?)\s+Cantrip\s*(?:\(([^)]*)\))?/i,
  );
  const leveled = header.match(
    /^Level\s+(\d+)\s+([A-Za-z]+(?:\s+[A-Za-z]+)?)\s*(?:\(([^)]*)\))?/i,
  );
  let level = null;
  let school = null;
  let listedClasses = [];
  if (cantrip) {
    level = 0;
    school = cantrip[1].trim();
    listedClasses = (cantrip[2] ?? '')
      .split(',')
      .map((s) => s.trim())
      .filter(Boolean);
  } else if (leveled) {
    level = Number(leveled[1]);
    school = leveled[2].trim();
    listedClasses = (leveled[3] ?? '')
      .split(',')
      .map((s) => s.trim())
      .filter(Boolean);
  }

  const casting =
    body.match(/Casting\s*time:\s*([^\n]+)/i)?.[1]?.trim() ?? null;
  const range = body.match(/Range:\s*([^\n]+)/i)?.[1]?.trim() ?? null;
  const components =
    body.match(/Components:\s*([^\n]+)/i)?.[1]?.trim() ?? null;
  const duration =
    body.match(/Duration:\s*([^\n]+)/i)?.[1]?.trim() ?? null;
  const firstPara = body
    .split(/\n\n+/)
    .find(
      (p) =>
        p &&
        !/^(Level\s+\d+|.*Cantrip|Casting\s*time:|Range:|Components:|Duration:)/i.test(
          p.trim(),
        ),
    )
    ?.replace(/\s+/g, ' ')
    .trim();
  return {
    level,
    school,
    listedClasses,
    castingTime: casting,
    range,
    components,
    duration,
    summary: (firstPara ?? '').slice(0, 280),
  };
}

function parseSpellLists(spellListsText) {
  const lists = {};
  const classBlocks = spellListsText.split(/\n###H4###\s+/);
  for (let i = 1; i < classBlocks.length; i++) {
    const block = classBlocks[i];
    const nl = block.indexOf('\n');
    const classTitle = (nl < 0 ? block : block.slice(0, nl)).trim();
    const classSlug = slugify(classTitle.replace(/\s+Spells$/i, ''));
    if (!/spells/i.test(classTitle)) continue;
    lists[classSlug] = {};
    const levelParts = block.split(/\n###H5###\s+/);
    for (let j = 1; j < levelParts.length; j++) {
      const part = levelParts[j];
      const nli = part.indexOf('\n');
      const levelLabel = (nli < 0 ? part : part.slice(0, nli)).trim();
      const namesBody = (nli < 0 ? '' : part.slice(nli + 1)).trim();
      const level =
        /cantrip/i.test(levelLabel)
          ? 0
          : Number(levelLabel.match(/(\d+)/)?.[1] ?? NaN);
      if (Number.isNaN(level)) continue;
      const names = namesBody
        .split(/\n+/)
        .map((l) => l.trim())
        .filter((l) => l && !/^###H/.test(l) && l.length < 80);
      lists[classSlug][String(level)] = names;
    }
  }
  return lists;
}

function parseWeaponTable(weaponsText) {
  // Heuristic rows from known names already in extract
  const weapons = [];
  const known = [
    'Seax',
    'Snaerispear',
    'Atgeir',
    'Bearded Axe',
    'Breidox',
    'Bryntroll',
    'Ulfberht Blade',
  ];
  for (const name of known) {
    const re = new RegExp(
      `${name}\\n\\n([^\\n]+)\\n\\n([^\\n]+)\\n\\n([^\\n]+)\\n\\n([^\\n]+)\\n\\n([^\\n]+)`,
    );
    const m = weaponsText.match(re);
    if (!m) continue;
    weapons.push({
      name,
      slug: slugify(name),
      damage: m[1].trim(),
      properties: m[2].trim(),
      mastery: m[3].trim(),
      weight: m[4].trim(),
      cost: m[5].trim(),
      category: ['Seax', 'Snaerispear'].includes(name)
        ? 'simple-melee'
        : 'martial-melee',
    });
  }
  return weapons;
}

const html = fs.readFileSync(HTML, 'utf8');
const text = toText(html);

const equipmentSection = sliceBetween(text, '###H2### Equipment', '###H2### Mounts and Land Vehicles');
const mountsSection = sliceBetween(
  text,
  '###H2### Mounts and Land Vehicles',
  '###H2### Longships',
);
const longshipsSection = sliceBetween(text, '###H2### Longships', '###H2### Magic Items');
const magicSection = sliceBetween(text, '###H2### Magic Items', '###H2### Spells');
const spellsSection = sliceBetween(text, '###H2### Spells', null);

const weaponsText = sliceBetween(equipmentSection, '###H3### Weapons', '###H3### Armor');
const pullText = sliceBetween(weaponsText, '###H4### Pull', '###H3### Armor') ||
  sliceBetween(text, '###H4### Pull', '###H3### Armor');
const armorText = sliceBetween(equipmentSection, '###H3### Armor', '###H3### Adventuring Gear');
const gearText = sliceBetween(equipmentSection, '###H3### Adventuring Gear', null);

const magicItems = parseH5Blocks(magicSection).map((b) => ({
  name: b.name,
  slug: slugify(b.name),
  ...parseItemMeta(b.body),
  body: b.body,
}));

const spellListsText = sliceBetween(
  spellsSection,
  '###H3### Spell Lists',
  '###H3### Spell Descriptions',
);
const spellDescText = sliceBetween(spellsSection, '###H3### Spell Descriptions', null);
const spellLists = parseSpellLists(spellListsText);
const spells = parseH5Blocks(spellDescText)
  .filter((b) => b.name !== 'Leviathan Avatar') // nested creature block often
  .map((b) => ({
    name: b.name,
    slug: slugify(b.name),
    ...parseSpellMeta(b.body),
    body: b.body,
  }));

// Attach class lists reverse index
const classesBySpell = {};
for (const [cls, levels] of Object.entries(spellLists)) {
  for (const [lvl, names] of Object.entries(levels)) {
    for (const name of names) {
      const key = slugify(name);
      if (!classesBySpell[key]) classesBySpell[key] = [];
      classesBySpell[key].push({ classSlug: cls, level: Number(lvl) });
    }
  }
}
for (const spell of spells) {
  spell.classAccess = classesBySpell[spell.slug] ?? [];
}

const payload = {
  source: {
    editionSlug: 'northlands-heroes-2024-en',
    chapter: 5,
    title: 'Magic and Miscellany',
    book: 'Northlands Worldbook: Heroes of the Sagas',
    scrapedHtml:
      'docs/source/new/Magic and Miscellany - Northlands Worldbook - Dungeons & Dragons - Sources - D&D Beyond.html',
    extractedAt: new Date().toISOString().slice(0, 10),
  },
  notes: {
    masterworkWeapons:
      'Masterwork: +1 attack/damage if proficient; cost = base + 300 gp; ammo 5 gp; does not stack with magic weapons.',
    pullMastery: pullText.replace(/\s+/g, ' ').trim().slice(0, 500),
  },
  equipment: {
    weapons: parseWeaponTable(weaponsText),
    armorNotes: armorText.slice(0, 2500),
    adventuringGearNotes: gearText.slice(0, 2500),
    mountsNotes: mountsSection.slice(0, 3500),
    longshipsNotes: longshipsSection.slice(0, 4500),
  },
  magicItems,
  spellLists,
  spells,
  counts: {
    weapons: parseWeaponTable(weaponsText).length,
    magicItems: magicItems.length,
    spells: spells.length,
    spellListEntries: Object.values(spellLists).reduce(
      (n, levels) =>
        n + Object.values(levels).reduce((m, arr) => m + arr.length, 0),
      0,
    ),
  },
};

fs.writeFileSync(JSON_OUT, JSON.stringify(payload, null, 2));
console.log('JSON', JSON_OUT, payload.counts);

function mdEscape(s) {
  return String(s ?? '').replace(/\|/g, '\\|');
}

const md = [];
md.push('# Northlands — Cap. 5 Magic and Miscellany (extração)');
md.push('');
md.push(
  'Fonte: scrape Beyond Cap. 5 (`docs/source/new/…Magic and Miscellany….html`).',
);
md.push('Edição: `northlands-heroes-2024-en`.');
md.push(
  `JSON máquina: [\`docs/source/northlands-cap5-extract.json\`](../source/northlands-cap5-extract.json) (${payload.counts.magicItems} itens, ${payload.counts.spells} magias).`,
);
md.push('');
md.push('## Não implementar ainda');
md.push('');
md.push(
  'Esta é **só extração**. Seeds/API/UI ficam para a leva de refino (backlog Cap. 5). Inclui equipamento mundano novo, mastery **Pull**, veículos/longships, itens mágicos e magias + listas por classe.',
);
md.push('');
md.push('## Contagens');
md.push('');
md.push('| Bloco | Qtd |');
md.push('|-------|-----|');
md.push(`| Armas novas (tabela) | ${payload.counts.weapons} |`);
md.push(`| Itens mágicos (descrições) | ${payload.counts.magicItems} |`);
md.push(`| Magias (descrições) | ${payload.counts.spells} |`);
md.push(`| Entradas em spell lists | ${payload.counts.spellListEntries} |`);
md.push('');
md.push('## Equipment (resumo)');
md.push('');
md.push('### Masterwork');
md.push('');
md.push(payload.notes.masterworkWeapons);
md.push('');
md.push('### Mastery — Pull');
md.push('');
md.push(payload.notes.pullMastery || '(ver JSON / fonte)');
md.push('');
md.push('### Armas');
md.push('');
md.push('| Nome | Dano | Props | Mastery | Peso | Custo |');
md.push('|------|------|-------|---------|------|-------|');
for (const w of payload.equipment.weapons) {
  md.push(
    `| ${mdEscape(w.name)} | ${mdEscape(w.damage)} | ${mdEscape(w.properties)} | ${mdEscape(w.mastery)} | ${mdEscape(w.weight)} | ${mdEscape(w.cost)} |`,
  );
}
md.push('');
md.push(
  'Armaduras / gear / montarias / longships: texto completo no JSON (`equipment.armorNotes`, `adventuringGearNotes`, `mountsNotes`, `longshipsNotes`). Inclui Beinagrind, Double Mail, Hardened Mail Shirt, Walrus Hide; Dog Sled / Ogre War Sled; Drakkar, Karvi, Knarr, Skeid, Snekkja.',
);
md.push('');
md.push('## Magic items');
md.push('');
md.push('| Nome | Slug | Raridade | Attune |');
md.push('|------|------|----------|--------|');
for (const item of magicItems) {
  md.push(
    `| ${mdEscape(item.name)} | \`${item.slug}\` | ${mdEscape(item.rarity ?? '—')}${item.rarityNote ? ` (${mdEscape(item.rarityNote)})` : ''} | ${item.requiresAttunement ? 'sim' : '—'} |`,
  );
}
md.push('');
md.push('Corpo completo de cada item: campo `body` no JSON.');
md.push('');
md.push('## Spells');
md.push('');
md.push('### Listas por classe (nomes)');
md.push('');
for (const [cls, levels] of Object.entries(spellLists)) {
  md.push(`#### ${cls}`);
  md.push('');
  for (const lvl of Object.keys(levels).sort((a, b) => Number(a) - Number(b))) {
    const label = lvl === '0' ? 'Cantrip' : `${lvl}º`;
    md.push(`- **${label}:** ${levels[lvl].join('; ')}`);
  }
  md.push('');
}
md.push('### Descrições (índice)');
md.push('');
md.push('| Nome | Slug | Nível | Escola | Classes |');
md.push('|------|------|-------|--------|---------|');
for (const spell of spells) {
  const classes = (spell.classAccess ?? [])
    .map((c) => c.classSlug)
    .filter((v, i, a) => a.indexOf(v) === i)
    .join(', ');
  md.push(
    `| ${mdEscape(spell.name)} | \`${spell.slug}\` | ${spell.level ?? '—'} | ${mdEscape(spell.school ?? '—')} | ${mdEscape(classes || '—')} |`,
  );
}
md.push('');
md.push('Corpo completo: `spells[].body` no JSON. Healing Spirit (Spirit Caller) — conferir se aparece nas listas/descrições ao refinar.');
md.push('');
md.push('## Próximo passo (refino)');
md.push('');
md.push('1. Traduzir PT-BR + slugs alinhados ao glossário');
md.push('2. Seeds `northlands-heroes` (itens + magias + `phb_spell_class` + mastery Pull)');
md.push('3. Wiring mesa só onde couber o padrão economy/cast existente');
md.push('');

fs.writeFileSync(MD_OUT, md.join('\n'));
console.log('MD', MD_OUT);
