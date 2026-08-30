/**
 * Classificação de catálogo — Grim Hollow Cap. 5 (Advanced Weapons & Equipment).
 *
 * `ddbKind` vem do tooltip D&D Beyond (armor | weapons | adventuring-gear).
 * `catalogKind` é a taxonomia do produto (arma, escudo, munição, upgrade…).
 */

/** @typedef {'advanced-weapon' | 'armor-shield' | 'armor-upgrade' | 'tool-instrument-upgrade' | 'ammunition' | 'adventuring-gear' | 'weapon-like-gear' | 'poison' | 'prosthetic' | 'spellcasting-focus'} Cap5CatalogKind */

/** @typedef {'weapon' | 'armor' | 'gear' | 'focus' | 'other'} Cap5ItemType */

/**
 * @type {Record<string, {
 *   catalogKind: Cap5CatalogKind,
 *   itemType: Cap5ItemType,
 *   ddbKind?: 'armor' | 'weapons' | 'adventuring-gear',
 *   listInCatalog?: boolean,
 *   armor?: { acFormula: string, strengthReq?: number | null, stealthDisadvantage?: boolean, shieldVariant?: string, speedPenaltyM?: number },
 *   upgrade?: { appliesTo: string, costModifierText: string },
 *   weaponLike?: boolean,
 * }>}
 */
export const CAP5_EQUIPMENT_CATALOG = {
  'blessed-stake': {
    catalogKind: 'weapon-like-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
    weaponLike: true,
  },
  'breath-of-beleth-poison': {
    catalogKind: 'poison',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'buckler-grim-hollow': {
    catalogKind: 'armor-shield',
    itemType: 'armor',
    ddbKind: 'armor',
    armor: {
      acFormula: '+1',
      strengthReq: null,
      stealthDisadvantage: false,
      shieldVariant: 'buckler',
    },
  },
  'concealed-blade': {
    catalogKind: 'weapon-like-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
    weaponLike: true,
  },
  'fire-bomb': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'grappling-gun': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'hunters-armor': {
    catalogKind: 'armor-upgrade',
    itemType: 'other',
    ddbKind: 'adventuring-gear',
    listInCatalog: true,
    upgrade: { appliesTo: 'armor', costModifierText: '+500 PO' },
  },
  'iron-net': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'mastercraft-instrument': {
    catalogKind: 'tool-instrument-upgrade',
    itemType: 'other',
    ddbKind: 'adventuring-gear',
    listInCatalog: true,
    upgrade: { appliesTo: 'musical-instrument', costModifierText: '+250 PO' },
  },
  'noisemaker': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  prosthetics: {
    catalogKind: 'prosthetic',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'retractable-shield': {
    catalogKind: 'armor-shield',
    itemType: 'armor',
    ddbKind: 'armor',
    armor: {
      acFormula: '+2',
      strengthReq: null,
      stealthDisadvantage: false,
      shieldVariant: 'retractable',
    },
  },
  'seeing-glass': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'shadowsteel-focus': {
    catalogKind: 'spellcasting-focus',
    itemType: 'focus',
    ddbKind: 'adventuring-gear',
  },
  'smoke-bomb': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'stitching-needle': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
  'tower-shield-grim-hollow': {
    catalogKind: 'armor-shield',
    itemType: 'armor',
    ddbKind: 'armor',
    armor: {
      acFormula: '+3',
      strengthReq: 15,
      stealthDisadvantage: false,
      shieldVariant: 'tower',
      speedPenaltyM: 3,
    },
  },
  'watchers-candle': {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
    ddbKind: 'adventuring-gear',
  },
};

/** Reexporta requisitos mecânicos (compatível com ghpg-cap5-requirements). */
export const GEAR_ADVANCED_REQUIREMENTS = {
  'blessed-stake': { kind: 'none' },
  'breath-of-beleth-poison': { kind: 'none' },
  'buckler-grim-hollow': {
    kind: 'shield',
    notesPt: 'Usável por qualquer personagem proficiente em escudos.',
  },
  'concealed-blade': { kind: 'none' },
  'fire-bomb': { kind: 'none' },
  'grappling-gun': { kind: 'none' },
  'hunters-armor': {
    kind: 'armor-upgrade',
    notesPt: 'Modificador de +500 PO aplicado a qualquer tipo de armadura.',
  },
  'iron-net': { kind: 'none' },
  'mastercraft-instrument': {
    kind: 'instrument',
    minProficiencyBonus: 4,
    notesPt:
      'Vantagem em Performance exige proficiência no instrumento e bônus de proficiência +4.',
  },
  'noisemaker': { kind: 'none' },
  prosthetics: { kind: 'none' },
  'retractable-shield': {
    kind: 'shield',
    notesPt: 'Usável por qualquer personagem proficiente em escudos.',
  },
  'seeing-glass': { kind: 'none' },
  'shadowsteel-focus': {
    kind: 'feat-benefits',
    featSlugs: ['shadowsteel-adept', 'shadowsteel-master'],
    notesPt:
      'Funciona como foco de conjuração sem treino extra; benefícios dos talentos Shadowsteel exigem os feats homônimos.',
  },
  'smoke-bomb': { kind: 'none' },
  'stitching-needle': { kind: 'none' },
  'tower-shield-grim-hollow': {
    kind: 'shield',
    notesPt: 'Usável por qualquer personagem proficiente em escudos.',
  },
  'watchers-candle': { kind: 'none' },
};

export const GEAR_ANCHOR_BY_SLUG = {
  'blessed-stake': 'BlessedStake',
  'breath-of-beleth-poison': 'BreathofBelethPoison',
  'buckler-grim-hollow': 'Buckler',
  'concealed-blade': 'ConcealedBlade',
  'fire-bomb': 'FireBomb',
  'grappling-gun': 'GrapplingGun',
  'hunters-armor': 'HuntersArmor',
  'iron-net': 'IronNet',
  'mastercraft-instrument': 'MastercraftInstrument',
  noisemaker: 'Noisemaker',
  prosthetics: 'Prosthetics',
  'retractable-shield': 'RetractablespellsShieldspells',
  'seeing-glass': 'SeeingGlass',
  'shadowsteel-focus': 'ShadowsteelFocus',
  'smoke-bomb': 'SmokeBomb',
  'stitching-needle': 'StitchingNeedle',
  'tower-shield-grim-hollow': 'TowerspellsShieldspells',
  'watchers-candle': 'WatchersitemsCandleitems',
};

export const ADVANCED_WEAPON_REQUIREMENT = {
  kind: 'advanced-weapon',
  proficiencySlug: 'armas-avancadas',
  featSlug: 'advanced-weapon-proficiency',
  fightingStyleSlug: 'advanced-weapon-proficiency',
  disadvantageWithoutProficiency: true,
  specialPropertiesRequireProficiency: true,
  masteryRequiresAdvancedProficiency: true,
};

export const ADVANCED_AMMUNITION_REQUIREMENT = {
  kind: 'advanced-ammunition',
  minLevel: 3,
  requiresWeaponProficiency: true,
};

/** @param {string} slug */
export function gearAdvancedRequirement(slug) {
  return GEAR_ADVANCED_REQUIREMENTS[slug] ?? { kind: 'none' };
}

/** @param {string} slug */
export function equipmentCatalogMeta(slug) {
  return CAP5_EQUIPMENT_CATALOG[slug] ?? {
    catalogKind: 'adventuring-gear',
    itemType: 'gear',
  };
}

/** @param {string} catalogKind */
export function isArmorShieldKind(catalogKind) {
  return catalogKind === 'armor-shield';
}
