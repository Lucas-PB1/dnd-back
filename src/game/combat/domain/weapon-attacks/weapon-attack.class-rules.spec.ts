import {
  assertSoulknifePsychicBlades,
  blackpowderPistol,
  expectWeaponAttack,
  FIGHTER_CTX,
  greataxe,
  GUNSLINGER_RANGED_CTX,
  longsword,
  MONK_CASES,
  oneAttack,
  revolver,
  runAttacks,
  runWeaponAttackCase,
  SOULKNIFE_PSYCHIC_BLADES,
} from "./weapon-attack.spec.helpers";
import { fixtureSchedulesFor } from "../feature-schedule.fixtures";

describe("computeWeaponAttacks — class rules", () => {
  it.each(MONK_CASES)("$label", runWeaponAttackCase);

  it("omits ability damage on firearms and expands crit for gunslinger", () => {
    const attack = oneAttack(
      [revolver()],
      {
        ...GUNSLINGER_RANGED_CTX,
        classSlug: "gunslinger",
        level: 5,
        featureSchedules: fixtureSchedulesFor("gunslinger"),
      },
      undefined,
      { destreza: 16 },
    );
    expect(attack.isFirearm).toBe(true);
    expect(attack.damageBonus).toBe(0);
    expect(attack.omitsAbilityDamage).toBe(true);
    expect(attack.critThreshold).toBe(19);
    expect(attack.reloadCapacity).toBe(6);
  });

  it("applies overkill ability mod on firearms at level 11+", () => {
    expectWeaponAttack(
      [revolver()],
      {
        ...GUNSLINGER_RANGED_CTX,
        proficiencyBonus: 4,
        classSlug: "gunslinger",
        level: 11,
        featureSchedules: fixtureSchedulesFor("gunslinger"),
      },
      undefined,
      { destreza: 16 },
      {
        damageBonus: 3,
        omitsAbilityDamage: false,
        damageNoteContains: "Exagero",
      },
    );
  });

  it("adds rage damage on barbarian melee Strength while raging", () => {
    const attack = oneAttack(
      [greataxe()],
      {
        proficiencyBonus: 3,
        weaponProficiencySlugs: ["armas-simples", "armas-marciais"],
        classSlug: "barbarian",
        level: 9,
        rageActive: true,
        featureSchedules: fixtureSchedulesFor("barbarian"),
      },
      undefined,
      { forca: 16 },
    );
    expect(attack.rageDamageBonus).toBe(3);
    expect(attack.damageBonus).toBe(6);
    expect(attack.damageNote).toContain("Fúria +3");
    expect(attack.brutalStrikeDice).toBe("1d10");
  });

  it("grants pistol proficiency and fast reload with blackpowder-pistol-expert", () => {
    const attack = oneAttack(
      [blackpowderPistol()],
      {
        proficiencyBonus: 2,
        weaponProficiencySlugs: ["armas-simples"],
        featSlugs: ["blackpowder-pistol-expert"],
        classSlug: "fighter",
        level: 5,
        featureSchedules: fixtureSchedulesFor("fighter"),
      },
      undefined,
      { destreza: 16 },
    );
    expect(attack.proficient).toBe(true);
    expect(attack.reloadCapacity).toBeNull();
    expect(attack.ignoresReload).toBe(true);
    expect(attack.attackNote).toContain("Recarga Rápida");
    expect(attack.attackNote).toContain("Olho de Águia");
  });

  it("exposes quick strike dice for resolutionofthe-syndicate", () => {
    expect(
      oneAttack([longsword()], {
        ...FIGHTER_CTX,
        featSlugs: ["resolutionofthe-syndicate"],
        level: 9,
      }).quickStrikeDice,
    ).toBe("2d4");
  });

  it("computes Soulknife Psychic Blades from catalog pieces", () => {
    assertSoulknifePsychicBlades(
      runAttacks(
        SOULKNIFE_PSYCHIC_BLADES,
        {
          proficiencyBonus: 4,
          weaponProficiencySlugs: [],
          classSlug: "rogue",
          subclassSlug: "soulknife",
          level: 9,
          featureSchedules: fixtureSchedulesFor("rogue", "soulknife"),
        },
        { forca: 10, destreza: 16 },
      ),
    );
  });
});
