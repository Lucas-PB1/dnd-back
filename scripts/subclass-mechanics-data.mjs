/**
 * Mecânicas estruturadas de subclasse — fonte para seed SQL (não altera JSON do PHB).
 * Chave: "classId:subclassId"
 */

/** Sobrescritas explícitas por nome do traço (PT-BR, PHB 2024). */
export const FEATURE_KIND_BY_NAME = {
  "Magias Dracônicas": "always_prepared",
  "Magias Psiônicas": "always_prepared",
  "Magias Mecânicas": "always_prepared",
  "Magias do Domínio": "always_prepared",
  "Magias do Círculo": "always_prepared",
  "Magias de Juramento": "always_prepared",
  "Magias de Patrono": "always_prepared",
  "Magias de Andarilho Feérico": "always_prepared",
  "Magias de Vigilante das Sombras": "always_prepared",
  Conjuração: "spellcasting",
  "Marés do Caos": "resource",
  "Restaurar Equilíbrio": "resource",
  "Asas de Dragão": "resource",
  "Afinidade Elemental": "choice",
  "Versado em Abjuração": "spellbook_bonus",
  "Versado em Adivinhação": "spellbook_bonus",
  "Versado em Evocação": "spellbook_bonus",
  "Versado em Ilusão": "spellbook_bonus",
};

/** Recursos de subclasse rastreáveis na ficha. */
export const SUBCLASS_RESOURCES = {
  "sorcerer:draconic": [
    {
      slug: "dragon-wings",
      name: "Asas de Dragão",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Asas de Dragão",
    },
  ],
  "sorcerer:clockwork": [
    {
      slug: "restore-balance",
      name: "Restaurar Equilíbrio",
      unlockLevel: 3,
      maxFormula: "charisma_mod",
      featureName: "Restaurar Equilíbrio",
    },
  ],
};

/** Opções de escolha obrigatórias por subclasse. */
export const SUBCLASS_OPTIONS = {
  "sorcerer:draconic": [
    {
      optionKey: "elementalAffinity",
      label: "Afinidade Elemental",
      unlockLevel: 6,
      featureName: "Afinidade Elemental",
      values: [
        { valueId: "acid", label: "Ácido" },
        { valueId: "cold", label: "Gélido" },
        { valueId: "fire", label: "Ígneo" },
        { valueId: "lightning", label: "Elétrico" },
        { valueId: "poison", label: "Venenoso" },
      ],
    },
  ],
  "sorcerer:clockwork": [
    {
      optionKey: "orderManifestation",
      label: "Manifestação da Ordem",
      unlockLevel: 3,
      values: [
        { valueId: "1", label: "Engrenagens espectrais" },
        { valueId: "2", label: "Ponteiros de relógio nos olhos" },
        { valueId: "3", label: "Pele acobreada brilhante" },
        { valueId: "4", label: "Equações geométricas" },
        { valueId: "5", label: "Foco em forma de mecanismo" },
        { valueId: "6", label: "Tique-taque de engrenagens" },
      ],
    },
  ],
};

export function subclassKey(classId, subclassId) {
  return `${classId}:${subclassId}`;
}

export function inferFeatureKind(featureName, hasPreparedSpells) {
  if (FEATURE_KIND_BY_NAME[featureName]) {
    return FEATURE_KIND_BY_NAME[featureName];
  }
  if (hasPreparedSpells && /^Magias\b/.test(featureName)) {
    return "always_prepared";
  }
  return "passive";
}

export function resourcesForSubclass(classId, subclassId) {
  return SUBCLASS_RESOURCES[subclassKey(classId, subclassId)] ?? [];
}

export function optionsForSubclass(classId, subclassId) {
  return SUBCLASS_OPTIONS[subclassKey(classId, subclassId)] ?? [];
}

/** Valor default de opção de subclasse (determinístico por seed). */
export function defaultSubclassOptionValue(optionDef, seed = 0) {
  const values = optionDef.values ?? [];
  if (!values.length) return null;
  return values[seed % values.length].valueId;
}

/** Max de recurso de subclasse para a ficha. */
export function subclassResourceMax(formula, doc, fixedMax = null) {
  const pb = Math.floor((doc.level - 1) / 4) + 2;
  const mod = (ab) => Math.floor((doc.abilities[ab] - 10) / 2);
  switch (formula) {
    case "fixed":
      return fixedMax ?? 1;
    case "proficiency_bonus":
      return pb;
    case "charisma_mod":
      return Math.max(1, mod("carisma"));
    case "wisdom_mod":
      return Math.max(1, mod("sabedoria"));
    case "constitution_mod":
      return Math.max(1, mod("constituicao"));
    case "intelligence_mod":
      return Math.max(1, mod("inteligencia"));
    case "level":
      return doc.level;
    default:
      return fixedMax ?? 1;
  }
}
