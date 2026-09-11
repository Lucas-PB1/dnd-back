import { dagger } from "./fixtures";
import { fixtureSchedulesFor } from "../../feature-schedule.fixtures";
import type { WeaponAttackCase } from "./expect";

const PB2 = { proficiencyBonus: 2 as const };
const DEX16 = { forca: 10, destreza: 16 };
const MONK_L5 = {
  proficiencyBonus: 3,
  weaponProficiencySlugs: [] as string[],
  classSlug: "monk" as const,
  level: 5,
  featureSchedules: fixtureSchedulesFor("monk"),
};

export const MONK_CASES: WeaponAttackCase[] = [
  {
    label: "synthetic unarmed strike",
    pieces: [],
    ctx: MONK_L5,
    scores: DEX16,
    pick: { itemSlug: "unarmed-strike" },
    expect: {
      proficient: true,
      abilitySlug: "destreza",
      attackBonus: 6,
      damageDice: "1d8",
      martialArtsDie: "1d8",
    },
  },
  {
    label: "monk weapon die upgrade",
    pieces: [dagger("main_hand")],
    ctx: {
      ...PB2,
      weaponProficiencySlugs: ["armas-simples"],
      classSlug: "monk",
      level: 11,
      featureSchedules: fixtureSchedulesFor("monk"),
    },
    scores: DEX16,
    pick: { itemSlug: "dagger", mode: "melee" },
    expect: {
      abilitySlug: "destreza",
      damageDice: "1d10",
      martialArtsDie: "1d10",
    },
  },
  {
    label: "no martial arts with shield",
    pieces: [],
    ctx: { ...MONK_L5, hasShield: true },
    pick: { itemSlug: "unarmed-strike" },
    expect: { martialArtsDie: null, damageDice: "1" },
  },
];
