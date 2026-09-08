import {
  FIGHTER_CTX,
  catchpole,
  dagger,
  greataxe,
  longbow,
  longsword,
  shortsword,
} from "./fixtures";
import type { WeaponAttackCase } from "./expect";

const PB2 = { proficiencyBonus: 2 as const };
const DEX16 = { forca: 10, destreza: 16 };
const GWM_CTX = { ...FIGHTER_CTX, featSlugs: ["great-weapon-master"] as const };
const GWF_CTX = {
  ...FIGHTER_CTX,
  fightingStyleSlugs: ["great-weapon-fighting"] as const,
};

export const VERSATILE_CASES: WeaponAttackCase[] = [
  {
    label: "versatile 2H alone in main hand",
    pieces: [longsword()],
    ctx: FIGHTER_CTX,
    expect: {
      attackBonus: 5,
      damageDice: "1d10",
      damageBonus: 3,
      proficient: true,
      attackNoteContains: "versátil (2 mãos)",
    },
  },
  {
    label: "versatile 1H with shield",
    pieces: [longsword()],
    ctx: { ...FIGHTER_CTX, hasShield: true },
    expect: {
      damageDice: "1d8",
      attackNoteContains: "versátil (1 mão)",
    },
  },
  {
    label: "versatile 1H with off-hand weapon",
    pieces: [longsword("main_hand"), dagger("off_hand")],
    ctx: FIGHTER_CTX,
    pick: { itemSlug: "longsword", mode: "melee" },
    expect: { damageDice: "1d8" },
  },
];

export const PROFICIENCY_CASES: WeaponAttackCase[] = [
  {
    label: "omits PB without category proficiency",
    pieces: [longsword()],
    ctx: { ...PB2, weaponProficiencySlugs: ["armas-simples"] },
    expect: { proficient: false, attackBonus: 3 },
  },
  {
    label: "grants proficiency from specific weapon group",
    pieces: [dagger()],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: [
        "adagas",
        "dardos",
        "fundas",
        "bordoes",
        "bestas-leves",
      ],
    },
    scores: DEX16,
    pick: { mode: "melee" },
    expect: { proficient: true, attackBonus: 5 },
  },
  {
    label: "does not grant longsword from adagas-only list",
    pieces: [longsword()],
    ctx: { ...PB2, weaponProficiencySlugs: ["adagas"] },
    expect: { proficient: false },
  },
  {
    label: "grants martial light from armas-marciais-leves",
    pieces: [shortsword("main_hand")],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: ["armas-simples", "armas-marciais-leves"],
    },
    scores: DEX16,
    pick: { mode: "melee" },
    expect: { proficient: true },
  },
  {
    label: "grants martial finesse/light from armas-marciais-acuidade-ou-leves",
    pieces: [shortsword("main_hand")],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: [
        "armas-simples",
        "armas-marciais-acuidade-ou-leves",
      ],
    },
    scores: DEX16,
    pick: { mode: "melee" },
    expect: { proficient: true },
  },
  {
    label: "denies longsword from armas-marciais-acuidade-ou-leves",
    pieces: [longsword()],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: [
        "armas-simples",
        "armas-marciais-acuidade-ou-leves",
      ],
    },
    expect: { proficient: false },
  },
  {
    label: "grants advanced proficiency from feat",
    pieces: [catchpole()],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: ["armas-simples"],
      featSlugs: ["advanced-weapon-proficiency"],
    },
    expect: { proficient: true },
  },
  {
    label: "grants martial proficiency from martial-weapon-training",
    pieces: [longsword()],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: ["armas-simples"],
      featSlugs: ["martial-weapon-training"],
    },
    expect: { proficient: true, attackBonus: 5 },
  },
];

export const GWM_CASES: WeaponAttackCase[] = [
  {
    label: "heavy melee",
    pieces: [greataxe()],
    ctx: GWM_CTX,
    expect: { damageBonus: 5, damageNoteContains: "Mestre em Armas Grandes" },
  },
  {
    label: "non-heavy weapon",
    pieces: [longsword()],
    ctx: GWM_CTX,
    expect: { damageBonus: 3 },
  },
  {
    label: "heavy ranged",
    pieces: [longbow()],
    ctx: GWM_CTX,
    expect: { damageBonus: 4 },
  },
];

export const GWF_CASES: WeaponAttackCase[] = [
  {
    label: "two-handed melee",
    pieces: [greataxe()],
    ctx: GWF_CTX,
    expect: { greatWeaponFighting: true, damageNoteContains: "GWF" },
  },
  {
    label: "versatile 2H melee",
    pieces: [longsword()],
    ctx: { ...FIGHTER_CTX, featSlugs: ["great-weapon-fighting"] },
    expect: { greatWeaponFighting: true },
  },
  {
    label: "versatile 1H with shield",
    pieces: [longsword()],
    ctx: { ...GWF_CTX, hasShield: true },
    expect: { greatWeaponFighting: false },
  },
  {
    label: "ranged",
    pieces: [longbow()],
    ctx: GWF_CTX,
    expect: { greatWeaponFighting: false },
  },
];
