/**
 * Dados canônicos das 18 perícias PHB 2024 (PT-BR).
 */
export const SKILL_ABILITIES = [
  { id: "forca", name: "Força" },
  { id: "destreza", name: "Destreza" },
  { id: "constituicao", name: "Constituição" },
  { id: "inteligencia", name: "Inteligência" },
  { id: "sabedoria", name: "Sabedoria" },
  { id: "carisma", name: "Carisma" },
];

export const SKILLS = [
  {
    id: "acrobatics",
    name: "Acrobacia",
    abilityId: "destreza",
    exampleUses:
      "Manter-se em pé em uma situação complicada ou realizar uma acrobacia.",
    actionIds: ["hide", "escape-grapple"],
    pdfPages: [14, 369],
  },
  {
    id: "animal-handling",
    name: "Lidar com Animais",
    abilityId: "sabedoria",
    exampleUses:
      "Acalmar ou treinar um animal, ou fazer com que ele se comporte de uma determinada maneira.",
    actionIds: ["influence"],
    influenceUse: "Convencer com gentileza uma Fera ou Monstruosidade",
    pdfPages: [14, 370],
  },
  {
    id: "arcana",
    name: "Arcanismo",
    abilityId: "inteligencia",
    exampleUses:
      "Recordar conhecimentos sobre magias, itens mágicos e planos de existência.",
    actionIds: ["analyze"],
    knowledgeAreas: {
      topics: [
        "Itens mágicos",
        "magias",
        "planos de existência",
        "símbolos arcanos",
        "tradições mágicas",
      ],
      creatureTypes: ["Aberrações", "Constructos", "Elementais", "Feéricos", "Monstruosidades"],
    },
    pdfPages: [14, 361],
  },
  {
    id: "athletics",
    name: "Atletismo",
    abilityId: "forca",
    exampleUses:
      "Pular mais longe do que o normal, manter-se à tona em águas agitadas ou quebrar algo.",
    actionIds: ["climb", "escape-grapple"],
    pdfPages: [14, 368, 372],
  },
  {
    id: "performance",
    name: "Atuação",
    abilityId: "carisma",
    exampleUses: "Atuar, contar uma história, tocar música ou dançar.",
    actionIds: ["influence"],
    influenceUse: "Entreter um monstro",
    pdfPages: [14, 370],
  },
  {
    id: "deception",
    name: "Enganação",
    abilityId: "carisma",
    exampleUses: "Contar uma mentira convincente ou usar um disfarce de forma convincente.",
    actionIds: ["influence"],
    influenceUse: "Enganar um monstro que entende você",
    pdfPages: [14, 370],
  },
  {
    id: "stealth",
    name: "Furtividade",
    abilityId: "destreza",
    exampleUses:
      "Evitar ser notado movendo-se silenciosamente e se escondendo atrás de objetos.",
    actionIds: ["hide"],
    pdfPages: [14, 368],
  },
  {
    id: "history",
    name: "História",
    abilityId: "inteligencia",
    exampleUses: "Relembrar fatos sobre eventos históricos, pessoas, nações e culturas.",
    actionIds: ["analyze"],
    knowledgeAreas: {
      topics: ["Eventos e pessoas históricas", "civilizações antigas", "guerras"],
      creatureTypes: ["Gigantes", "Humanoides"],
    },
    pdfPages: [14, 361],
  },
  {
    id: "intimidation",
    name: "Intimidação",
    abilityId: "carisma",
    exampleUses: "Atemorizar ou ameaçar alguém para que faça o que você quer.",
    actionIds: ["influence"],
    influenceUse: "Intimidar um monstro",
    pdfPages: [14, 20, 370],
  },
  {
    id: "insight",
    name: "Intuição",
    abilityId: "sabedoria",
    exampleUses: "Perceber o humor e as intenções de uma pessoa.",
    actionIds: ["search"],
    searchUse: "Estado mental de uma criatura",
    pdfPages: [14, 373],
  },
  {
    id: "investigation",
    name: "Investigação",
    abilityId: "inteligencia",
    exampleUses: "Encontrar informações obscuras em livros ou deduzir como algo funciona.",
    actionIds: ["analyze"],
    knowledgeAreas: {
      topics: ["Armadilhas", "códigos", "dispositivos", "enigmas"],
    },
    pdfPages: [14, 361],
  },
  {
    id: "medicine",
    name: "Medicina",
    abilityId: "sabedoria",
    exampleUses:
      "Diagnosticar uma doença ou determinar o que matou uma pessoa que morreu recentemente.",
    actionIds: ["search", "stabilize"],
    searchUse: "Enfermidade de uma criatura ou causa da morte",
    pdfPages: [14, 373],
  },
  {
    id: "nature",
    name: "Natureza",
    abilityId: "inteligencia",
    exampleUses: "Relembrar fatos sobre o terreno, as plantas, os animais e o clima.",
    actionIds: ["analyze"],
    knowledgeAreas: {
      topics: ["Clima", "flora", "terreno"],
      creatureTypes: ["Dragões", "Feras", "Gosmas", "Plantas"],
    },
    pdfPages: [14, 361],
  },
  {
    id: "perception",
    name: "Percepção",
    abilityId: "sabedoria",
    exampleUses:
      "Usando uma combinação de sentidos, notar algo que é fácil de passar despercebido.",
    actionIds: ["search", "passive"],
    searchUse: "Criatura ou objeto oculto",
    pdfPages: [14, 372, 373],
  },
  {
    id: "persuasion",
    name: "Persuasão",
    abilityId: "carisma",
    exampleUses: "Convencer alguém de algo de forma honesta e graciosa.",
    actionIds: ["influence"],
    influenceUse: "Persuadir um monstro que entende você",
    pdfPages: [14, 370],
  },
  {
    id: "sleight-of-hand",
    name: "Prestidigitação",
    abilityId: "destreza",
    exampleUses: "Furtar um bolso, ocultar um objeto portátil ou fazer truque com as mãos.",
    pdfPages: [14],
  },
  {
    id: "religion",
    name: "Religião",
    abilityId: "inteligencia",
    exampleUses: "Relembrar fatos sobre deuses, rituais religiosos e símbolos sagrados.",
    actionIds: ["analyze"],
    knowledgeAreas: {
      topics: ["Cultos", "deidades", "hierarquias e ritos religiosos", "símbolos sagrados"],
      creatureTypes: ["Celestiais", "Ínferos", "Mortos-Vivos"],
    },
    pdfPages: [14, 361],
  },
  {
    id: "survival",
    name: "Sobrevivência",
    abilityId: "sabedoria",
    exampleUses:
      "Seguir rastros, procurar alimentos, encontrar uma trilha ou evitar perigos naturais.",
    actionIds: ["search"],
    searchUse: "Comida ou rastros",
    pdfPages: [14, 373],
  },
];

export const SKILL_RULES = [
  {
    id: "proficiency",
    file: "proficiency.json",
    title: "Proficiências em Perícias",
    pdfPages: [13, 14],
  },
  {
    id: "alternate-ability",
    file: "alternate-ability.json",
    title: "Perícias com Atributos Diferentes",
    pdfPages: [14, 14],
  },
  {
    id: "knowledge-areas",
    file: "knowledge-areas.json",
    title: "Áreas de Conhecimento (Analisar)",
    pdfPages: [361, 361],
  },
  {
    id: "search",
    file: "search.json",
    title: "Procurar",
    pdfPages: [373, 373],
  },
  {
    id: "influence",
    file: "influence.json",
    title: "Testes de Influência",
    pdfPages: [370, 370],
  },
  {
    id: "passive-perception",
    file: "passive-perception.json",
    title: "Percepção Passiva",
    pdfPages: [372, 372],
  },
  {
    id: "expertise",
    file: "expertise.json",
    title: "Especialização",
    pdfPages: [368, 368],
  },
];
