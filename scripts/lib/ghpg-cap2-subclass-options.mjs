/**
 * Opções de subclasse GH Cap. 2 — dados para seeds J035.
 * Prioridade: wizard create (P0/P1).
 */

/** @typedef {{ optionKey: string, label: string, unlockLevel: number, sortOrder: number }} OptionDef */
/** @typedef {{ valueId: string, label: string, sortOrder: number }} OptionValue */

/** @type {Record<string, { defs: OptionDef[], values: Record<string, OptionValue[]> }>} */
export const GHPG_CAP2_SUBCLASS_OPTIONS = {
  'collegeof-adventurers': {
    defs: [
      { optionKey: 'adventurersTalent1', label: 'Talento de Aventureiro 1', unlockLevel: 3, sortOrder: 1 },
      { optionKey: 'adventurersTalent2', label: 'Talento de Aventureiro 2', unlockLevel: 6, sortOrder: 2 },
      { optionKey: 'adventurersTalent3', label: 'Talento de Aventureiro 3', unlockLevel: 14, sortOrder: 3 },
    ],
    values: {
      adventurersTalent1: [
        { valueId: 'barbarian', label: 'Bárbaro', sortOrder: 1 },
        { valueId: 'cleric', label: 'Clérigo', sortOrder: 2 },
        { valueId: 'druid', label: 'Druida', sortOrder: 3 },
        { valueId: 'fighter', label: 'Guerreiro', sortOrder: 4 },
        { valueId: 'monk', label: 'Monge', sortOrder: 5 },
        { valueId: 'paladin', label: 'Paladino', sortOrder: 6 },
        { valueId: 'ranger', label: 'Patrulheiro', sortOrder: 7 },
        { valueId: 'rogue', label: 'Ladino', sortOrder: 8 },
        { valueId: 'sorcerer', label: 'Feiticeiro', sortOrder: 9 },
        { valueId: 'warlock', label: 'Bruxo', sortOrder: 10 },
        { valueId: 'wizard', label: 'Mago', sortOrder: 11 },
      ],
    },
  },
  'misfortune-bringer': {
    defs: [
      { optionKey: 'misfortune1', label: 'Desgraça 1', unlockLevel: 3, sortOrder: 1 },
      { optionKey: 'misfortune2', label: 'Desgraça 2', unlockLevel: 3, sortOrder: 2 },
      { optionKey: 'misfortune3', label: 'Desgraça 3', unlockLevel: 9, sortOrder: 3 },
      { optionKey: 'misfortune4', label: 'Desgraça 4', unlockLevel: 13, sortOrder: 4 },
      { optionKey: 'misfortune5', label: 'Desgraça 5', unlockLevel: 17, sortOrder: 5 },
    ],
    values: {
      misfortune: [
        { valueId: 'curse-of-the-befuddled', label: 'Maldição do Aturdido', sortOrder: 1 },
        { valueId: 'curse-of-the-clumsy', label: 'Maldição do Desajeitado', sortOrder: 2 },
        { valueId: 'curse-of-the-debilitated', label: 'Maldição do Debilitado', sortOrder: 3 },
        { valueId: 'curse-of-the-doomed', label: 'Maldição do Condenado', sortOrder: 4 },
        { valueId: 'curse-of-the-fearful', label: 'Maldição do Medroso', sortOrder: 5 },
        { valueId: 'curse-of-the-inept', label: 'Maldição do Inábil', sortOrder: 6 },
        { valueId: 'curse-of-the-insensate', label: 'Maldição do Insensível', sortOrder: 7 },
        { valueId: 'curse-of-the-maimed', label: 'Maldição do Mutilado', sortOrder: 8 },
        { valueId: 'curse-of-the-marked', label: 'Maldição do Marcado', sortOrder: 9 },
        { valueId: 'curse-of-the-plagued', label: 'Maldição do Flagelado', sortOrder: 10 },
        { valueId: 'curse-of-the-somnolent', label: 'Maldição do Sonolento', sortOrder: 11 },
        { valueId: 'curse-of-the-unlucky', label: 'Maldição do Azarado', sortOrder: 12 },
      ],
    },
  },
  'pathofthe-wrathful-dead': {
    defs: [
      { optionKey: 'finalNightEmotion', label: 'Emoção da Catarse da Noite Final', unlockLevel: 3, sortOrder: 1 },
      { optionKey: 'darkDoomChannel', label: 'Canal da Perdição Sombria', unlockLevel: 6, sortOrder: 2 },
    ],
    values: {
      finalNightEmotion: [
        { valueId: 'hate', label: 'Ódio', sortOrder: 1 },
        { valueId: 'jealousy', label: 'Ciúme', sortOrder: 2 },
        { valueId: 'terror', label: 'Terror', sortOrder: 3 },
      ],
      darkDoomChannel: [
        { valueId: 'contamination', label: 'Contaminação', sortOrder: 1 },
        { valueId: 'hypothermia', label: 'Hipotermia', sortOrder: 2 },
        { valueId: 'immolation', label: 'Imolação', sortOrder: 3 },
      ],
    },
  },
  'living-crucible': {
    defs: [
      { optionKey: 'compound1', label: 'Composto 1', unlockLevel: 3, sortOrder: 1 },
      { optionKey: 'compound2', label: 'Composto 2', unlockLevel: 3, sortOrder: 2 },
      { optionKey: 'compound3', label: 'Composto 3', unlockLevel: 3, sortOrder: 3 },
      { optionKey: 'compound4', label: 'Composto 4', unlockLevel: 7, sortOrder: 4 },
      { optionKey: 'compound5', label: 'Composto 5', unlockLevel: 7, sortOrder: 5 },
      { optionKey: 'compound6', label: 'Composto 6', unlockLevel: 10, sortOrder: 6 },
      { optionKey: 'compound7', label: 'Composto 7', unlockLevel: 10, sortOrder: 7 },
      { optionKey: 'compound8', label: 'Composto 8', unlockLevel: 15, sortOrder: 8 },
      { optionKey: 'compound9', label: 'Composto 9', unlockLevel: 15, sortOrder: 9 },
    ],
    values: {
      compound: [
        { valueId: 'adrenal-injection', label: 'Injeção de Adrenalina', sortOrder: 1 },
        { valueId: 'allsense-injection', label: 'Injeção de Todos os Sentidos', sortOrder: 2 },
        { valueId: 'arcane-eye-oil', label: 'Óleo do Olho Arcano', sortOrder: 3 },
        { valueId: 'draught-of-bulls-strength', label: 'Elixir da Força do Touro', sortOrder: 4 },
        { valueId: 'draught-of-cats-grace', label: 'Elixir da Graça do Gato', sortOrder: 5 },
        { valueId: 'draught-of-bears-endurance', label: 'Elixir da Constituição do Urso', sortOrder: 6 },
        { valueId: 'draught-of-foxs-cunning', label: 'Elixir da Astúcia da Raposa', sortOrder: 7 },
        { valueId: 'draught-of-owls-wisdom', label: 'Elixir da Sabedoria da Coruja', sortOrder: 8 },
        { valueId: 'draught-of-eagles-splendor', label: 'Elixir do Esplendor da Águia', sortOrder: 9 },
        { valueId: 'elfsight-oil', label: 'Óleo da Visão Élfica', sortOrder: 10 },
        { valueId: 'fleshknit-phosphate', label: 'Fosfato de Costura de Carne', sortOrder: 11 },
        { valueId: 'ironmind-injection', label: 'Injeção de Mente de Ferro', sortOrder: 12 },
        { valueId: 'liquid-courage', label: 'Coragem Líquida', sortOrder: 13 },
        { valueId: 'liquid-rage', label: 'Fúria Líquida', sortOrder: 14 },
        { valueId: 'presto-powder', label: 'Pó Presto', sortOrder: 15 },
        { valueId: 'spellshine-ointment', label: 'Pomada Brilho Arcano', sortOrder: 16 },
        { valueId: 'steelskin-ointment', label: 'Pomada Pele de Aço', sortOrder: 17 },
        { valueId: 'tenmen-tincture', label: 'Tintura dos Dez Homens', sortOrder: 18 },
      ],
    },
  },
  'trapper-guild': {
    defs: [
      { optionKey: 'armorModification1', label: 'Modificação de Armadura 1', unlockLevel: 15, sortOrder: 1 },
      { optionKey: 'armorModification2', label: 'Modificação de Armadura 2', unlockLevel: 15, sortOrder: 2 },
    ],
    values: {
      armorModification: [
        { valueId: 'damage-resistance', label: 'Resistência a Dano', sortOrder: 1 },
        { valueId: 'elemental-charge', label: 'Carga Elemental', sortOrder: 2 },
        { valueId: 'hardened-defense', label: 'Defesa Endurecida', sortOrder: 3 },
        { valueId: 'phase-leap', label: 'Salto Fásico', sortOrder: 4 },
        { valueId: 'regeneration', label: 'Regeneração', sortOrder: 5 },
        { valueId: 'stealthy', label: 'Furtividade', sortOrder: 6 },
      ],
    },
  },
  'pathofthe-primal-spirit': {
    defs: [
      { optionKey: 'primalCompanionStatBlock', label: 'Forma do Companheiro Primal', unlockLevel: 3, sortOrder: 1 },
      { optionKey: 'primalCompanionEnvironment', label: 'Ambiente do Companheiro', unlockLevel: 3, sortOrder: 2 },
    ],
    values: {
      primalCompanionStatBlock: [
        { valueId: 'primal-guardian', label: 'Guardião Primal', sortOrder: 1 },
        { valueId: 'primal-striker', label: 'Atacante Primal', sortOrder: 2 },
      ],
      primalCompanionEnvironment: [
        { valueId: 'land', label: 'Terra', sortOrder: 1 },
        { valueId: 'sea', label: 'Mar', sortOrder: 2 },
        { valueId: 'sky', label: 'Céu', sortOrder: 3 },
      ],
    },
  },
};

/** Resolve catálogo de valores para uma option_key. */
export function valuesForOptionKey(subclassSlug, optionKey) {
  const group = GHPG_CAP2_SUBCLASS_OPTIONS[subclassSlug];
  if (!group) return [];
  if (group.values[optionKey]) return group.values[optionKey];
  if (optionKey.startsWith('adventurersTalent')) return group.values.adventurersTalent1 ?? [];
  if (optionKey.startsWith('misfortune')) return group.values.misfortune ?? [];
  if (optionKey.startsWith('compound')) return group.values.compound ?? [];
  if (optionKey.startsWith('armorModification')) return group.values.armorModification ?? [];
  return [];
}
