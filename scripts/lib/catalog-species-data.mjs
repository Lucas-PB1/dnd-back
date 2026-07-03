/** Dados estáticos de espécie usados na geração do catálogo SQL. */

export const ELF_LINEAGE_SPELLS = {
  "high-elf": { 1: ["prestidigitacao-arcana"], 3: ["detectar-magia"], 5: ["passo-nebuloso"] },
  drow: { 1: ["luzes-dancantes"], 3: ["fogo-das-fadas"], 5: ["escuridao"] },
  "wood-elf": { 1: ["arte-druidica"], 3: ["passos-largos"], 5: ["passo-sem-rastro"] },
};

export const TIEFLING_LEGACY_SPELLS = {
  abyssal: { 1: ["rajada-de-veneno"], 3: ["raio-nauseante"], 5: ["paralisar-pessoa"] },
  chthonic: { 1: ["toque-necrotico"], 3: ["vitalidade-vazia"], 5: ["raio-do-enfraquecimento"] },
  infernal: { 1: ["raio-de-fogo"], 3: ["repreensao-diabolica"], 5: ["escuridao"] },
};

export const GNOME_LINEAGE_SPELLS = {
  "rock-gnome": { cantrips: ["prestidigitacao-arcana", "reparar"], prepared: [] },
  "forest-gnome": { cantrips: ["ilusao-menor"], prepared: ["falar-com-animais"] },
};

export const DRAGON_ANCESTRIES = [
  "blue", "black", "white", "gold", "bronze", "silver", "copper", "green", "brass", "red",
];

export const GIANT_ANCESTRIES = ["ice", "fire", "stone", "cloud", "hill", "storm"];

export const TIEFLING_LEGACIES = ["abyssal", "chthonic", "infernal"];

export const GNOME_LINEAGES = ["rock-gnome", "forest-gnome"];

export const AASIMAR_REVELATIONS = ["celestial-wings", "necrotic-shroud", "radiant-consumption"];
