/** Nomes PT-BR (campo `classes` das magias) → id estável da classe. */
export const CLASS_NAME_TO_ID = {
  Bardo: "bard",
  Bruxo: "warlock",
  Clérigo: "cleric",
  Druida: "druid",
  Feiticeiro: "sorcerer",
  Guardião: "ranger",
  Mago: "wizard",
  Paladino: "paladin",
};

export const CLASS_ID_TO_NAME = Object.fromEntries(
  Object.entries(CLASS_NAME_TO_ID).map(([name, id]) => [id, name])
);

export const SPELL_LIST_CLASSES = Object.keys(CLASS_NAME_TO_ID).map((name) => ({
  id: CLASS_NAME_TO_ID[name],
  name,
  listLabel: `Lista de Magias de ${name}`,
}));
