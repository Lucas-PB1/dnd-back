/**
 * Normaliza northlands-cap5-spells-pt.json: move "Usando um Espaço..." para higherLevels.
 * Uso: node scripts/fix-northlands-cap5-spells-pt.mjs
 */
import fs from 'fs';

const PT_PATH = 'docs/source/northlands-cap5-spells-pt.json';
const EN_PATH = 'docs/source/northlands-cap5-extract.json';

const pt = JSON.parse(fs.readFileSync(PT_PATH, 'utf8'));
const en = JSON.parse(fs.readFileSync(EN_PATH, 'utf8'));
const enBySlug = Object.fromEntries((en.spells ?? []).map((s) => [s.slug, s]));

const HL_RE =
  /\n\nUsando um Espa[cç]o de Magia de C[ií]rculo Superior\.?\s*/i;

let fixed = 0;
for (const [slug, entry] of Object.entries(pt)) {
  const desc = entry.description ?? '';
  const m = desc.match(HL_RE);
  if (m) {
    const idx = desc.search(HL_RE);
    entry.description = desc.slice(0, idx).trim();
    const hl = desc.slice(idx).replace(HL_RE, '').trim();
    if (!entry.higherLevels) {
      entry.higherLevels = hl;
    }
    fixed += 1;
  }
}

// Reações / textos curtos demais: preencher a partir do EN se PT ficou truncado
const SHORT = ['glimpse-the-wyrd', 'bergelmirs-provocation'];
for (const slug of SHORT) {
  const src = enBySlug[slug];
  if (!src || !pt[slug]) continue;
  if ((pt[slug].description ?? '').length >= 120) continue;
  // leave marker — filled below manually in same script for known cases
}

// glimpse-the-wyrd
if (pt['glimpse-the-wyrd']) {
  pt['glimpse-the-wyrd'].description =
    'Você adiciona ou subtrai 1d6 do Teste de D20.';
}

// bergelmirs-provocation — reintroduzir gatilho de reação
if (pt['bergelmirs-provocation']) {
  const d = pt['bergelmirs-provocation'].description ?? '';
  if (!/Quando uma criatura/i.test(d) && !/reação/i.test(d)) {
    pt['bergelmirs-provocation'].description =
      'Quando você vê uma criatura fazer um ataque ou ataque mágico, você pode usar sua Reação para provocar o atacante.\n\n' +
      d.replace(/^Quando uma criatura[\s\S]*?Reação para provocar o atacante\.\n\n/i, '');
  }
}

fs.writeFileSync(PT_PATH, JSON.stringify(pt, null, 2) + '\n');
console.log('fixed higherLevels splits:', fixed);
