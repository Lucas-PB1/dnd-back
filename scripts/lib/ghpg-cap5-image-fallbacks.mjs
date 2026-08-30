/**
 * Imagens Cap. 5 GH — scrape Beyond + fallbacks PHB (sprites S080).
 * Caminhos relativos a public/catalog/equipment/.
 */

/** @typedef {{ src: string, dest: string, slugs: string[] }} ScrapeImageBundle */

/** Ilustrações do HTML Cap. 5 (_files/06-*.png|jpg). */
export const SCRAPE_IMAGE_BUNDLES = [
  {
    src: '06-004.catchpole.png',
    dest: 'catchpole.png',
    slugs: ['catchpole', 'military-fork', 'guardian-poleaxe', 'polearm'],
  },
  {
    src: '06-002.smoke-bomb.png',
    dest: 'smoke-bomb.png',
    slugs: ['smoke-bomb', 'breath-of-beleth-poison'],
  },
  {
    src: '06-001.advanced-equipment.png',
    dest: 'fire-bomb.png',
    slugs: ['fire-bomb', 'hunters-armor', 'shadowsteel-focus', 'seeing-glass'],
  },
  {
    src: '06-005.arrows-shield.png',
    dest: 'arrows-shield.png',
    slugs: [
      'arrows-and-bolts-bludgeoning-1',
      'arrows-and-bolts-ranging-1',
      'arrows-and-bolts-slashing-1',
      'arrows-and-bolts-whistling-1',
      'sling-bullets-piercing-1',
      'sling-bullets-ranging-1',
      'sling-bullets-whistling-1',
      'alchemical-ammunition-arrow-1',
      'alchemical-ammunition-bolt-1',
      'alchemical-ammunition-sling-bullet-1',
      'specialized-ammunition-arrow-5',
      'specialized-ammunition-bolt-5',
      'specialized-ammunition-paper-cartridge-bullet-10',
      'specialized-ammunition-sling-bullet-5',
      'other-ranged-ammunition-bellows-cannister',
      'other-ranged-ammunition-dragon-shot',
      'other-ranged-ammunition-magazine',
      'other-ranged-ammunition-paper-cartridge-bullet',
    ],
  },
  {
    src: '06-003.artificer-tinkering.jpg',
    dest: 'gh-advanced-gear.jpg',
    slugs: [
      'grappling-gun',
      'noisemaker',
      'prosthetics',
      'concealed-blade',
      'stitching-needle',
      'mastercraft-instrument',
      'watchers-candle',
      'blessed-stake',
    ],
  },
];

/**
 * Slug → arquivo PHB já em public/catalog/equipment (sem copiar).
 * @type {Record<string, string>}
 */
export const PHB_FALLBACK_IMAGE = {
  'cavalry-flail': 'flail.png',
  'cavalry-hammer': 'warhammer.png',
  'cavalry-pick': 'war-pick.png',
  chakram: 'dart.png',
  claymore: 'greatsword.png',
  'double-blade': 'greatsword.png',
  'double-spear': 'spear.png',
  'elite-rapier': 'rapier.png',
  'fighting-chain': 'whip.png',
  'fighting-chain-brutal': 'whip.png',
  'fighting-chain-hook': 'whip.png',
  'fighting-chain-sickle': 'whip.png',
  'gladiator-net': 'rede.png',
  'knightly-lance': 'lance.png',
  'knightly-sword': 'longsword.png',
  'parrying-dagger': 'dagger.png',
  'punching-dagger': 'dagger.png',
  'returning-club': 'club.png',
  sabre: 'scimitar.png',
  'sheathed-staff': 'quarterstaff.png',
  'side-handle-baton': 'club.png',
  'wrath-axe': 'battleaxe.png',
  'wrath-maul': 'maul.png',
  arbalest: 'heavy-crossbow.png',
  'blackpowder-pistol': 'pistol.png',
  'blackpowder-rifle': 'musket.png',
  'blunderbuss-grim-hollow': 'musket.png',
  'blunderbuss-hand': 'musket.png',
  'composite-longbow': 'longbow.png',
  'composite-shortbow': 'shortbow.png',
  'dragon-pistol': 'pistol.png',
  'dragon-rifle': 'musket.png',
  'flame-bellows': 'blowgun.png',
  'repeater-crossbow': 'light-crossbow.png',
  'repeater-crossbow-hand': 'hand-crossbow.png',
  'repeater-crossbow-heavy': 'heavy-crossbow.png',
  'repeater-needler': 'blowgun.png',
  'repeater-slinger': 'sling.png',
  'buckler-grim-hollow': 'shield.png',
  'retractable-shield': 'shield.png',
  'tower-shield-grim-hollow': 'shield.png',
  'iron-net': 'rede.png',
};

/** @param {string} slug @param {Set<string>} [assigned] */
export function resolveCap5ImagePath(slug, assigned = new Set()) {
  for (const bundle of SCRAPE_IMAGE_BUNDLES) {
    if (bundle.slugs.includes(slug)) {
      return `/catalog/equipment/${bundle.dest}`;
    }
  }
  const phb = PHB_FALLBACK_IMAGE[slug];
  if (phb) return `/catalog/equipment/${phb}`;
  return null;
}

/** @param {string[]} catalogSlugs */
export function buildCap5ImageManifest(catalogSlugs) {
  const assigned = new Set();
  const items = {};
  for (const slug of catalogSlugs) {
    const imageUrl = resolveCap5ImagePath(slug, assigned);
    if (imageUrl) {
      items[slug] = { imageUrl };
      assigned.add(slug);
    }
  }
  return {
    generatedAt: new Date().toISOString(),
    scrapeBundles: SCRAPE_IMAGE_BUNDLES.length,
    covered: Object.keys(items).length,
    total: catalogSlugs.length,
    items,
  };
}
