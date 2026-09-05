import { featCombatNotes } from "./combat-notes";
import type { CatalogEffect } from "@game/effects";

describe("featCombatNotes", () => {
  it("returns empty when feat has no catalog effects", () => {
    expect(featCombatNotes({ featSlugs: ["lucky"] })).toEqual([]);
  });

  it("lists notes from catalog effects only", () => {
    const effects = [
      {
        kind: "table_note",
        ownerKind: "feat",
        ownerSlug: "alert",
        trigger: "passive",
        note: { note: "Proficiência em Iniciativa (+PB)." },
      },
      {
        kind: "combat_note",
        ownerKind: "feat",
        ownerSlug: "archery",
        trigger: "passive",
        note: { note: "+2 nas jogadas de ataque com armas à Distância." },
      },
    ] as CatalogEffect[];
    const notes = featCombatNotes({
      featSlugs: ["alert", "archery", "alert"],
      featEffects: effects,
    });
    expect(notes.some((n) => n.includes("Iniciativa"))).toBe(true);
    expect(notes.some((n) => n.includes("+2 nas jogadas"))).toBe(true);
    expect(
      notes.filter((n) => n.includes("Proficiência em Iniciativa")).length,
    ).toBe(1);
  });

  it("ignores unknown slugs without effects", () => {
    expect(featCombatNotes({ featSlugs: ["not-a-feat"] })).toEqual([]);
  });

  it("does not invent notes for GH estilo without featEffects", () => {
    expect(
      featCombatNotes({ featSlugs: ["close-combat-artillerist"] }),
    ).toEqual([]);
  });
});
