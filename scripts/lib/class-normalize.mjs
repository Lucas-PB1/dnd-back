/** Normalização de classes PHB para o catálogo SQL. */

const ABILITY_PT = {
  Força: "forca",
  Destreza: "destreza",
  Constituição: "constituicao",
  Inteligência: "inteligencia",
  Sabedoria: "sabedoria",
  Carisma: "carisma",
};

export function hitDieSlug(hitDie) {
  return hitDie?.toLowerCase() ?? null;
}

export function inferPrimaryAbilityOperator(label) {
  if (!label) return null;
  if (label.includes(" ou ")) return "or";
  if (label.includes(" e ")) return "and";
  return null;
}

export function primaryAbilitySlugs(cls) {
  if (cls.primaryAbilityIds?.length) return cls.primaryAbilityIds;
  if (cls.primaryAbilityId) return [cls.primaryAbilityId];
  return [];
}

export function weaponProfSlug(label) {
  return label
    .toLowerCase()
    .normalize("NFD")
    .replace(/\p{M}/gu, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

export function spellAbilitySlug(spellcasting) {
  if (!spellcasting?.ability) return null;
  return ABILITY_PT[spellcasting.ability] ?? null;
}

export function packageSlugFromLabel(label) {
  return String(label).toLowerCase().trim();
}

export function extractClassCatalog(classes) {
  const weaponProfTerms = new Map();
  const classPrimaryAbilities = [];
  const classArmorTraining = [];
  const classWeaponProficiencies = [];
  const classStartingPackages = [];
  const classStartingItems = [];
  const classSpellcasting = [];

  const classesNorm = classes.map((cls) => {
    let abilityOrder = 0;
    for (const abilityId of primaryAbilitySlugs(cls)) {
      abilityOrder += 1;
      classPrimaryAbilities.push({
        classId: cls.id,
        abilityId,
        sortOrder: abilityOrder,
      });
    }

    for (const [cat, enabled] of Object.entries(cls.armorTraining ?? {})) {
      if (enabled) {
        classArmorTraining.push({ classId: cls.id, categorySlug: cat === "shields" ? "shield" : cat });
      }
    }

    for (const label of cls.weaponProficiencies ?? []) {
      const slug = weaponProfSlug(label);
      if (!weaponProfTerms.has(slug)) weaponProfTerms.set(slug, label);
      classWeaponProficiencies.push({ classId: cls.id, proficiencySlug: slug });
    }

    for (const [pkgIndex, pkg] of (cls.startingEquipment?.options ?? []).entries()) {
      const packageSlug = packageSlugFromLabel(pkg.label);
      classStartingPackages.push({
        classId: cls.id,
        packageSlug,
        label: pkg.label,
        sortOrder: pkgIndex + 1,
      });
      let itemOrder = 0;
      for (const entry of pkg.items ?? []) {
        itemOrder += 1;
        if (entry.id) {
          classStartingItems.push({
            classId: cls.id,
            packageSlug,
            itemId: entry.id,
            quantity: entry.quantity ?? 1,
            choiceText: null,
            goldAmount: null,
            sortOrder: itemOrder,
          });
        } else if (entry.choice) {
          classStartingItems.push({
            classId: cls.id,
            packageSlug,
            itemId: null,
            quantity: 1,
            choiceText: entry.choice,
            goldAmount: null,
            sortOrder: itemOrder,
          });
        } else if (entry.gold != null) {
          classStartingItems.push({
            classId: cls.id,
            packageSlug,
            itemId: null,
            quantity: 1,
            choiceText: null,
            goldAmount: entry.gold,
            sortOrder: itemOrder,
          });
        }
      }
    }

    if (cls.spellcasting) {
      classSpellcasting.push({
        classId: cls.id,
        castingType: cls.spellcasting.type,
        abilityId: spellAbilitySlug(cls.spellcasting),
        focusLabel: cls.spellcasting.focus ?? null,
        focusItemId: cls.spellcasting.focusItemId ?? null,
        ritual: Boolean(cls.spellcasting.ritual),
      });
    }

    const hp = cls.hitPoints ?? {};
    const sc = cls.skillChoices ?? {};
    return {
      ...cls,
      hitDieSlug: hitDieSlug(cls.hitDie),
      primaryAbilityOperator: inferPrimaryAbilityOperator(cls.primaryAbility),
      hpLevel1DieValue: hp.level1DieValue ?? null,
      hpFixedPerLevel: hp.fixedHpPerLevel ?? null,
      hpMinimumGainPerLevel: hp.minimumGainPerLevel ?? null,
      hpConstitutionModApplies: hp.constitutionModApplies ?? true,
      skillChoiceCount: sc.count ?? null,
      skillChoiceFrom: sc.from === "any" ? "any" : null,
    };
  });

  return {
    classesNorm,
    weaponProfTerms: [...weaponProfTerms.entries()].map(([slug, label]) => ({ slug, label })),
    classPrimaryAbilities,
    classArmorTraining,
    classWeaponProficiencies,
    classStartingPackages,
    classStartingItems,
    classSpellcasting,
  };
}
