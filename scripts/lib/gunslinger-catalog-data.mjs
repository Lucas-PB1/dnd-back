/**
 * Dados estruturados do pack Gunslinger (firearms / props / ammo)
 * derivados de docs/sources/valda-gunslinger/page.html
 */

export const NEW_WEAPON_PROPERTIES = [
  {
    slug: 'firearm',
    name: 'Firearm',
    description:
      "You don't add your ability modifier to the weapon's damage, unless otherwise stated. Firearm ammunition is destroyed upon use.",
  },
  {
    slug: 'recoil',
    name: 'Recoil',
    description:
      "After you make an attack with this weapon, you can't make ranged attacks beyond the weapon's normal range until the end of the current turn.",
  },
  {
    slug: 'reload',
    name: 'Reload',
    description:
      'This weapon can be used to make a number of attacks before it must be reloaded. If you are proficient with the weapon, reloading it takes an Action or a Bonus Action; otherwise, reloading it takes an Action.',
  },
];

export const NEW_WEAPON_MASTERIES = [
  {
    slug: 'automatic',
    name: 'Automatic',
    description:
      "When you make an attack with this weapon, you can choose to make two attacks instead. These attacks are always made with Disadvantage, regardless of circumstance. You can't replace these attacks. If this weapon has the Ammunition property, these attacks use twice the normal amount of ammunition.",
  },
  {
    slug: 'explode',
    name: 'Explode',
    description:
      "When you take the Attack action, you can replace one of your attacks with an explosion from this weapon's projectile. This explosion is a 5-foot-radius Sphere centered on a point you choose within the weapon's normal range. Each creature within the Sphere makes a Dexterity saving throw (DC 8 plus your Strength or Dexterity modifier and your Proficiency Bonus). On a failed save, a creature takes the weapon's damage, but don't add your ability modifier to that damage unless that modifier is negative. On a successful save, a creature takes half as much damage. You can create an explosion only once per turn.",
  },
  {
    slug: 'scatter',
    name: 'Scatter',
    description:
      "Being within 5 feet of an enemy doesn't impose Disadvantage on your ranged attack rolls with this weapon.",
  },
  {
    slug: 'sighted',
    name: 'Sighted',
    description:
      "Attacking at long range with this weapon doesn't impose Disadvantage on your attack rolls. When you hit a creature with an attack using this weapon at long range, you can reroll any of the damage dice and must use the new roll.",
  },
];

/** @typedef {{ slug: string, name: string, era: string, category: 'simple'|'martial', damage: string, damageType: string, propertyIds: string[], masteryId: string, rangeNormal: number, rangeMax: number, ammoType: string, reload?: number, weight: string, costGp: number, description: string, skipIfExists?: boolean }} FirearmDef */

/** @type {FirearmDef[]} */
export const FIREARMS = [
  {
    slug: 'blunderbuss',
    name: 'Blunderbuss',
    era: 'renaissance',
    category: 'martial',
    damage: '1d12',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'heavy', 'loading', 'two-handed'],
    masteryId: 'scatter',
    rangeNormal: 20,
    rangeMax: 60,
    ammoType: 'shot',
    weight: '15 lb.',
    costGp: 750,
    description:
      'This distinctive short-range firearm features a dramatically flared muzzle designed to launch shot in a wide spray.',
  },
  // musket / pistol already in PHB — skip seed items
  {
    slug: 'double-barrel-shotgun',
    name: 'Double-Barrel Shotgun',
    era: 'industrial',
    category: 'simple',
    damage: '2d6',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'recoil', 'reload', 'two-handed'],
    masteryId: 'scatter',
    rangeNormal: 20,
    rangeMax: 60,
    ammoType: 'shell',
    reload: 2,
    weight: '8 lb.',
    costGp: 175,
    description:
      'A classic design with two loaded barrels, trading ammo capacity and range for reliability and firepower.',
  },
  {
    slug: 'hunting-rifle',
    name: 'Hunting Rifle',
    era: 'industrial',
    category: 'simple',
    damage: '2d6',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'reload', 'two-handed'],
    masteryId: 'sighted',
    rangeNormal: 80,
    rangeMax: 320,
    ammoType: 'bullet',
    reload: 4,
    weight: '8 lb.',
    costGp: 150,
    description:
      'Designed for big game, Hunting Rifles are slow but accurate, requiring bolt action between shots.',
  },
  {
    slug: 'parlor-gun',
    name: 'Parlor Gun',
    era: 'industrial',
    category: 'simple',
    damage: '2d4',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'light', 'reload'],
    masteryId: 'vex',
    rangeNormal: 30,
    rangeMax: 120,
    ammoType: 'bullet',
    reload: 2,
    weight: '1 lb.',
    costGp: 75,
    description:
      'The smallest usable firearm; can be tucked into a stocking or hidden down a sleeve.',
  },
  {
    slug: 'revolver',
    name: 'Revolver',
    era: 'industrial',
    category: 'martial',
    damage: '2d6',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'recoil', 'reload'],
    masteryId: 'slow',
    rangeNormal: 30,
    rangeMax: 120,
    ammoType: 'bullet',
    reload: 6,
    weight: '3 lb.',
    costGp: 125,
    description:
      'An iconic handgun storing six bullets in a rotating cylinder; favored by Gunslingers.',
  },
  {
    slug: 'cannon',
    name: 'Cannon',
    era: 'industrial',
    category: 'martial',
    damage: '2d8',
    damageType: 'Ígneo',
    propertyIds: ['ammunition', 'firearm', 'heavy', 'loading', 'two-handed'],
    masteryId: 'explode',
    rangeNormal: 100,
    rangeMax: 400,
    ammoType: 'cannonball',
    weight: '225 lb.',
    costGp: 1500,
    description:
      'Smoothbore muzzleloading Cannons common on pirate ships and fortifications.',
  },
  {
    slug: 'gatling-gun',
    name: 'Gatling Gun',
    era: 'industrial',
    category: 'martial',
    damage: '2d6',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'heavy', 'reload', 'two-handed'],
    masteryId: 'automatic',
    rangeNormal: 60,
    rangeMax: 240,
    ammoType: 'bullet',
    reload: 40,
    weight: '125 lb.',
    costGp: 750,
    description:
      'Rotates and fires six or more barrels in succession; cumbersome and terrifying.',
  },
  {
    slug: 'magnum',
    name: 'Magnum',
    era: 'industrial',
    category: 'martial',
    damage: '2d8',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'heavy', 'recoil', 'reload'],
    masteryId: 'slow',
    rangeNormal: 30,
    rangeMax: 120,
    ammoType: 'bullet',
    reload: 6,
    weight: '6 lb.',
    costGp: 600,
    description:
      'Chambered for large-caliber bullets; packs maximum kick into a single shot.',
  },
  {
    slug: 'flare-gun',
    name: 'Flare Gun',
    era: 'modern',
    category: 'simple',
    damage: '2d6',
    damageType: 'Ígneo',
    propertyIds: ['ammunition', 'firearm', 'loading'],
    masteryId: 'slow',
    rangeNormal: 30,
    rangeMax: 120,
    ammoType: 'flare',
    weight: '1 lb.',
    costGp: 100,
    description:
      'A survival tool that fires a single white-hot flare for distress signals or last-ditch defense.',
  },
  {
    slug: 'handgun',
    name: 'Handgun',
    era: 'modern',
    category: 'simple',
    damage: '2d4',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'light', 'reload'],
    masteryId: 'vex',
    rangeNormal: 30,
    rangeMax: 120,
    ammoType: 'bullet',
    reload: 10,
    weight: '3 lb.',
    costGp: 125,
    description:
      'Portable and reliable with a generous magazine; go-to for self-defense.',
  },
  {
    slug: 'assault-rifle',
    name: 'Assault Rifle',
    era: 'modern',
    category: 'martial',
    damage: '2d6',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'reload', 'two-handed'],
    masteryId: 'automatic',
    rangeNormal: 80,
    rangeMax: 320,
    ammoType: 'bullet',
    reload: 20,
    weight: '7 lb.',
    costGp: 300,
    description:
      'High rate of fire with rifle-grade ballistics; flexible and formidable.',
  },
  {
    slug: 'pump-shotgun',
    name: 'Pump Shotgun',
    era: 'modern',
    category: 'martial',
    damage: '2d8',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'heavy', 'recoil', 'reload', 'two-handed'],
    masteryId: 'scatter',
    rangeNormal: 20,
    rangeMax: 60,
    ammoType: 'shell',
    reload: 8,
    weight: '7 lb.',
    costGp: 550,
    description:
      "Distinctive sliding grip on the barrel that is 'pumped' to chamber a new round.",
  },
  {
    slug: 'sniper-rifle',
    name: 'Sniper Rifle',
    era: 'modern',
    category: 'martial',
    damage: '2d8',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'heavy', 'loading', 'two-handed'],
    masteryId: 'sighted',
    rangeNormal: 100,
    rangeMax: 400,
    ammoType: 'bullet',
    weight: '8 lb.',
    costGp: 450,
    description:
      'Instrument of ranged precision for distant, nearly invisible shots.',
  },
  {
    slug: 'submachine-gun',
    name: 'Submachine Gun',
    era: 'modern',
    category: 'martial',
    damage: '2d4',
    damageType: 'Perfurante',
    propertyIds: ['ammunition', 'firearm', 'light', 'reload'],
    masteryId: 'automatic',
    rangeNormal: 20,
    rangeMax: 60,
    ammoType: 'bullet',
    reload: 16,
    weight: '6 lb.',
    costGp: 250,
    description:
      'Fires lighter, easier-to-control rounds as an alternative to larger automatic weapons.',
  },
];

export const AMMUNITION = [
  {
    slug: 'bullets',
    name: 'Bullets (10)',
    amount: 10,
    weight: '1 lb.',
    costGp: 3,
    description: 'Firearm ammunition (bullets). Destroyed upon use.',
  },
  {
    slug: 'cannonballs',
    name: 'Cannonballs (5)',
    amount: 5,
    weight: '10 lb.',
    costGp: 25,
    description: 'Firearm ammunition (cannonballs). Destroyed upon use.',
  },
  {
    slug: 'flares',
    name: 'Flares (5)',
    amount: 5,
    weight: '5 lb.',
    costGp: 5,
    description: 'Firearm ammunition (flares). Destroyed upon use.',
  },
  {
    slug: 'shells',
    name: 'Shells (10)',
    amount: 10,
    weight: '1 lb.',
    costGp: 5,
    description: 'Firearm ammunition (shells). Destroyed upon use.',
  },
  {
    slug: 'shot',
    name: 'Shot (10)',
    amount: 10,
    weight: '2 lb.',
    costGp: 1,
    description: 'Firearm ammunition (shot). Destroyed upon use.',
  },
];

export const SKIP_FEAT_SLUGS = new Set(['iron-hero']);
export const SKIP_SPELL_SLUGS = new Set(['finger-guns']);

export const RISK_DIE_BY_LEVEL = {
  1: null,
  2: 8,
  3: 8,
  4: 8,
  5: 8,
  6: 8,
  7: 8,
  8: 8,
  9: 8,
  10: 10,
  11: 10,
  12: 10,
  13: 10,
  14: 10,
  15: 10,
  16: 10,
  17: 10,
  18: 12,
  19: 12,
  20: 12,
};

export const RISK_COUNT_SCHEDULE = [
  { unlockLevel: 2, fixedMax: 4 },
  { unlockLevel: 6, fixedMax: 5 },
  { unlockLevel: 14, fixedMax: 6 },
];

export const WEAPON_MASTERY_BY_LEVEL = {
  // L1–3: 2, L4–9: 3, L10–20: 4
  ranges: [
    { from: 1, to: 3, count: 2 },
    { from: 4, to: 9, count: 3 },
    { from: 10, to: 20, count: 4 },
  ],
};

export const FIGHTING_STYLE_SLUGS = [
  'archery',
  'blind-fighting',
  'defense',
  'dueling',
  'great-weapon-fighting',
  'interception',
  'protection',
  'thrown-weapon-fighting',
  'two-weapon-fighting',
  'unarmed-fighting',
];
