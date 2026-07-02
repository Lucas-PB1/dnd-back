/**
 * Mecânicas estruturadas de subclasse — fonte para seed SQL (não altera JSON do PHB).
 * Chave: "classId:subclassId"
 */

/** Sobrescritas explícitas por nome do traço (PT-BR, PHB 2024). */
export const FEATURE_KIND_BY_NAME = {
  // Feiticeiro — magias sempre preparadas
  "Magias Dracônicas": "always_prepared",
  "Magias Psiônicas": "always_prepared",
  "Magias Mecânicas": "always_prepared",
  // Domínios / círculos / juramentos / ranger
  "Magias do Domínio": "always_prepared",
  "Magias do Círculo": "always_prepared",
  "Magias de Juramento": "always_prepared",
  "Magias do Andarilho Feérico": "always_prepared",
  "Magias do Vigilante das Sombras": "always_prepared",
  "Magias de Domínio da Vida": "always_prepared",
  "Magias de Domínio da Luz": "always_prepared",
  "Magias de Domínio da Trapaça": "always_prepared",
  "Magias de Domínio da Guerra": "always_prepared",
  "Magias do Círculo da Lua": "always_prepared",
  "Magias do Círculo da Terra": "always_prepared",
  "Magias do Círculo do Mar": "always_prepared",
  "Magias do Juramento da Devoção": "always_prepared",
  "Magias do Juramento dos Anciões": "always_prepared",
  "Magias do Juramento da Glória": "always_prepared",
  "Magias do Juramento da Vingança": "always_prepared",
  // Bruxo — magias de pacto
  "Magias de Pacto do Grande Antigo": "always_prepared",
  "Magia de Pacto do Celestial": "always_prepared",
  "Magias de Pacto do Ínfero": "always_prepared",
  "Magias de Pacto da Arquifada": "always_prepared",
  // Third-casters
  Conjuração: "spellcasting",
  // Mago — grimório
  "Versado em Abjuração": "spellbook_bonus",
  "Versado em Adivinhação": "spellbook_bonus",
  "Versado em Evocação": "spellbook_bonus",
  "Versado em Ilusão": "spellbook_bonus",
  // Recursos rastreáveis
  "Marés do Caos": "resource",
  "Restaurar Equilíbrio": "resource",
  "Asas de Dragão": "resource",
  "Companheiro Dracônico": "resource",
  "Implosão de Distorção": "resource",
  "Transe da Ordem": "resource",
  "Cavalgada Mecânica": "resource",
  "Surto Controlado": "resource",
  "Luz Medicinal": "resource",
  "Vingança Calcinante": "resource",
  "A Sorte do Próprio Tenebroso": "resource",
  "Lançar no Inferno": "resource",
  "Passos Feéricos": "resource",
  "Defesas Sedutoras": "resource",
  "Combatente Clarividente": "resource",
  "Coroa de Luz": "resource",
  "Bênção do Trapaceiro": "resource",
  "Sacerdote da Guerra": "resource",
  "Passo Lunar": "resource",
  "Recuperação Natural": "resource",
  "Presságio Cósmico": "resource",
  "Resplendor Sagrado": "resource",
  "Sentinela Imortal": "resource",
  "Campeão Ancestral": "resource",
  "Defesa Gloriosa": "resource",
  "Lenda Viva": "resource",
  "Anjo Vingador": "resource",
  "Emboscador das Sombras": "resource",
  "Reforços Feéricos": "resource",
  "Andarilho Nebuloso": "resource",
  "Superioridade em Combate": "resource",
  "Conheça Seu Inimigo": "resource",
  "Poder Psiônico": "resource",
  "Adepto Telecinético": "resource",
  "Baluarte de Energia": "resource",
  "Mestre Telecinético": "resource",
  "Presença Intimidante": "resource",
  "Campeão dos Deuses": "resource",
  "Presença Zelosa": "resource",
  "Fúria dos Deuses": "resource",
  "Integridade Corporal": "resource",
  "Torrente de Cura e Dolo": "resource",
  "Mão da Misericórdia Final": "resource",
  "Véu Psíquico": "resource",
  "Rasgar Mente": "resource",
  "Ladrão de Magias": "resource",
  // Escolhas
  "Afinidade Elemental": "choice",
  "Estilo de Luta Adicional": "choice",
  "Fúria dos Selvagens": "choice",
  "Aspecto dos Selvagens": "choice",
  "Poder dos Selvagens": "choice",
  "Fúria Divina": "choice",
  "Ápice Elemental": "choice",
  "Presa do Caçador": "choice",
  "Táticas Defensivas": "choice",
  "Companheiro Primal": "choice",
  "Forma Estrelada": "choice",
  "Mapa Estelar": "choice",
  "Mente de Ferro": "choice",
  "Glamour Transcendental": "choice",
};

const PACT_SPELL_NAME = /^Magias? de Pacto|^Magias (do|da|de) /;

/** Recursos de subclasse rastreáveis na ficha. */
export const SUBCLASS_RESOURCES = {
  "sorcerer:wild-magic": [
    {
      slug: "tides-of-chaos",
      name: "Marés do Caos",
      unlockLevel: 3,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Marés do Caos",
    },
    {
      slug: "controlled-surge",
      name: "Surto Controlado",
      unlockLevel: 18,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Surto Controlado",
    },
  ],
  "sorcerer:aberrant": [
    {
      slug: "warp-implosion",
      name: "Implosão de Distorção",
      unlockLevel: 18,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Implosão de Distorção",
    },
  ],
  "sorcerer:draconic": [
    {
      slug: "dragon-wings",
      name: "Asas de Dragão",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Asas de Dragão",
    },
    {
      slug: "dragon-companion",
      name: "Companheiro Dracônico",
      unlockLevel: 18,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Companheiro Dracônico",
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
    {
      slug: "order-trance",
      name: "Transe da Ordem",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Transe da Ordem",
    },
    {
      slug: "clockwork-cavalcade",
      name: "Cavalgada Mecânica",
      unlockLevel: 18,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Cavalgada Mecânica",
    },
  ],
  "warlock:celestial": [
    {
      slug: "healing-light",
      name: "Luz Medicinal",
      unlockLevel: 3,
      maxFormula: "level_plus_one",
      featureName: "Luz Medicinal",
    },
    {
      slug: "searing-vengeance",
      name: "Vingança Calcinante",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Vingança Calcinante",
    },
  ],
  "warlock:fiend": [
    {
      slug: "dark-ones-luck",
      name: "A Sorte do Próprio Tenebroso",
      unlockLevel: 6,
      maxFormula: "charisma_mod",
      featureName: "A Sorte do Próprio Tenebroso",
    },
    {
      slug: "hurl-through-hell",
      name: "Lançar no Inferno",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Lançar no Inferno",
    },
  ],
  "warlock:archfey": [
    {
      slug: "fey-steps",
      name: "Passos Feéricos",
      unlockLevel: 3,
      maxFormula: "charisma_mod",
      featureName: "Passos Feéricos",
    },
    {
      slug: "beguiling-defenses",
      name: "Defesas Sedutoras",
      unlockLevel: 10,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Defesas Sedutoras",
    },
  ],
  "warlock:great-old-one": [
    {
      slug: "clairvoyant-competitor",
      name: "Combatente Clarividente",
      unlockLevel: 6,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Combatente Clarividente",
    },
  ],
  "cleric:light": [
    {
      slug: "corona-of-light",
      name: "Coroa de Luz",
      unlockLevel: 17,
      maxFormula: "wisdom_mod",
      featureName: "Coroa de Luz",
    },
  ],
  "cleric:trickery": [
    {
      slug: "tricksters-blessing",
      name: "Bênção do Trapaceiro",
      unlockLevel: 3,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Bênção do Trapaceiro",
    },
  ],
  "cleric:war": [
    {
      slug: "war-priest",
      name: "Sacerdote da Guerra",
      unlockLevel: 3,
      maxFormula: "wisdom_mod",
      featureName: "Sacerdote da Guerra",
    },
  ],
  "druid:moon": [
    {
      slug: "lunar-step",
      name: "Passo Lunar",
      unlockLevel: 10,
      maxFormula: "wisdom_mod",
      featureName: "Passo Lunar",
    },
  ],
  "druid:land": [
    {
      slug: "natural-recovery",
      name: "Recuperação Natural",
      unlockLevel: 6,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Recuperação Natural",
    },
  ],
  "druid:stars": [
    {
      slug: "stellar-guidance",
      name: "Mapa Estelar",
      unlockLevel: 3,
      maxFormula: "wisdom_mod",
      featureName: "Mapa Estelar",
    },
    {
      slug: "cosmic-omen",
      name: "Presságio Cósmico",
      unlockLevel: 6,
      maxFormula: "wisdom_mod",
      featureName: "Presságio Cósmico",
    },
  ],
  "paladin:devotion": [
    {
      slug: "holy-nimbus",
      name: "Resplendor Sagrado",
      unlockLevel: 20,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Resplendor Sagrado",
    },
  ],
  "paladin:ancients": [
    {
      slug: "undying-sentinel",
      name: "Sentinela Imortal",
      unlockLevel: 15,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Sentinela Imortal",
    },
    {
      slug: "elder-champion",
      name: "Campeão Ancestral",
      unlockLevel: 20,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Campeão Ancestral",
    },
  ],
  "paladin:glory": [
    {
      slug: "glorious-defense",
      name: "Defesa Gloriosa",
      unlockLevel: 15,
      maxFormula: "charisma_mod",
      featureName: "Defesa Gloriosa",
    },
    {
      slug: "living-legend",
      name: "Lenda Viva",
      unlockLevel: 20,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Lenda Viva",
    },
  ],
  "paladin:vengeance": [
    {
      slug: "avenging-angel",
      name: "Anjo Vingador",
      unlockLevel: 20,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Anjo Vingador",
    },
  ],
  "ranger:gloom-stalker": [
    {
      slug: "dread-strike",
      name: "Emboscador das Sombras",
      unlockLevel: 3,
      maxFormula: "wisdom_mod",
      featureName: "Emboscador das Sombras",
    },
  ],
  "ranger:fey-wanderer": [
    {
      slug: "fey-reinforcements",
      name: "Reforços Feéricos",
      unlockLevel: 11,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Reforços Feéricos",
    },
    {
      slug: "misty-wanderer",
      name: "Andarilho Nebuloso",
      unlockLevel: 15,
      maxFormula: "wisdom_mod",
      featureName: "Andarilho Nebuloso",
    },
  ],
  "fighter:battle-master": [
    {
      slug: "superiority-dice",
      name: "Superioridade em Combate",
      unlockLevel: 3,
      maxFormula: "superiority_dice_count",
      featureName: "Superioridade em Combate",
    },
    {
      slug: "know-your-enemy",
      name: "Conheça Seu Inimigo",
      unlockLevel: 7,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Conheça Seu Inimigo",
    },
  ],
  "fighter:psi-warrior": [
    {
      slug: "psi-energy-dice",
      name: "Poder Psiônico",
      unlockLevel: 3,
      maxFormula: "psi_energy_dice_count",
      featureName: "Poder Psiônico",
    },
    {
      slug: "psychic-leap",
      name: "Salto com Impulsão Psíquica",
      unlockLevel: 7,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Adepto Telecinético",
    },
    {
      slug: "energy-bulwark",
      name: "Baluarte de Energia",
      unlockLevel: 15,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Baluarte de Energia",
    },
    {
      slug: "telekinetic-master",
      name: "Mestre Telecinético",
      unlockLevel: 18,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Mestre Telecinético",
    },
  ],
  "barbarian:berserker": [
    {
      slug: "intimidating-presence",
      name: "Presença Intimidante",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Presença Intimidante",
    },
  ],
  "barbarian:zealot": [
    {
      slug: "divine-fury-dice",
      name: "Campeão dos Deuses",
      unlockLevel: 3,
      maxFormula: "zealot_healing_dice_count",
      featureName: "Campeão dos Deuses",
    },
    {
      slug: "zealous-presence",
      name: "Presença Zelosa",
      unlockLevel: 10,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Presença Zelosa",
    },
    {
      slug: "rage-of-the-gods",
      name: "Fúria dos Deuses",
      unlockLevel: 14,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Fúria dos Deuses",
    },
  ],
  "monk:open-hand": [
    {
      slug: "wholeness-of-body",
      name: "Integridade Corporal",
      unlockLevel: 6,
      maxFormula: "wisdom_mod",
      featureName: "Integridade Corporal",
    },
  ],
  "monk:mercy": [
    {
      slug: "hand-of-harm-flurry",
      name: "Torrente de Cura e Dolo",
      unlockLevel: 11,
      maxFormula: "wisdom_mod",
      featureName: "Torrente de Cura e Dolo",
    },
    {
      slug: "hand-of-ultimate-mercy",
      name: "Mão da Misericórdia Final",
      unlockLevel: 17,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Mão da Misericórdia Final",
    },
  ],
  "rogue:soulknife": [
    {
      slug: "soulknife-psi-dice",
      name: "Poder Psiônico",
      unlockLevel: 3,
      maxFormula: "psi_energy_dice_count",
      featureName: "Poder Psiônico",
    },
    {
      slug: "psychic-veil",
      name: "Véu Psíquico",
      unlockLevel: 13,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Véu Psíquico",
    },
    {
      slug: "rend-mind",
      name: "Rasgar Mente",
      unlockLevel: 17,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Rasgar Mente",
    },
  ],
  "rogue:arcane-trickster": [
    {
      slug: "spell-thief",
      name: "Ladrão de Magias",
      unlockLevel: 17,
      maxFormula: "fixed",
      fixedMax: 1,
      featureName: "Ladrão de Magias",
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
      featureName: "Magias Mecânicas",
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
  "warlock:fiend": [
    {
      optionKey: "infernalResilience",
      label: "Resistência Ínfera",
      unlockLevel: 10,
      featureName: "Resistência Ínfera",
      values: [
        { valueId: "acid", label: "Ácido" },
        { valueId: "cold", label: "Gélido" },
        { valueId: "fire", label: "Ígneo" },
        { valueId: "lightning", label: "Elétrico" },
        { valueId: "necrotic", label: "Necrótico" },
        { valueId: "poison", label: "Venenoso" },
        { valueId: "psychic", label: "Psíquico" },
        { valueId: "radiant", label: "Radiante" },
        { valueId: "thunder", label: "Trovejante" },
      ],
    },
  ],
  "druid:stars": [
    {
      optionKey: "starMapForm",
      label: "Forma do Mapa Estelar",
      unlockLevel: 3,
      featureName: "Mapa Estelar",
      values: [
        { valueId: "scroll", label: "Rolo de pergaminho" },
        { valueId: "stone", label: "Placa de pedra" },
        { valueId: "palm", label: "Palma da mão" },
        { valueId: "crystal", label: "Orrery de cristal" },
        { valueId: "tattoo", label: "Tatuagem minuciosa" },
        { valueId: "carving", label: "Entalhe enrunado" },
      ],
    },
    {
      optionKey: "stellarConstellation",
      label: "Constelação da Forma Estrelada",
      unlockLevel: 3,
      featureName: "Forma Estrelada",
      values: [
        { valueId: "archer", label: "Arqueiro" },
        { valueId: "dragon", label: "Dragão" },
        { valueId: "chalice", label: "Taça" },
      ],
    },
  ],
  "ranger:hunter": [
    {
      optionKey: "huntersPrey",
      label: "Presa do Caçador",
      unlockLevel: 3,
      featureName: "Presa do Caçador",
      values: [
        { valueId: "colossus-slayer", label: "Assassino de Colossos" },
        { valueId: "horde-breaker", label: "Destruidor de Hordas" },
      ],
    },
    {
      optionKey: "defensiveTactics",
      label: "Táticas Defensivas",
      unlockLevel: 7,
      featureName: "Táticas Defensivas",
      values: [
        { valueId: "multiattack-defense", label: "Defesa Contra Ataques Múltiplos" },
        { valueId: "escape-the-horde", label: "Escapar de Hordas" },
      ],
    },
  ],
  "ranger:beast-master": [
    {
      optionKey: "primalCompanion",
      label: "Companheiro Primal",
      unlockLevel: 3,
      featureName: "Companheiro Primal",
      values: [
        { valueId: "earth", label: "Fera da Terra" },
        { valueId: "sky", label: "Fera do Céu" },
        { valueId: "sea", label: "Fera do Mar" },
      ],
    },
  ],
  "ranger:fey-wanderer": [
    {
      optionKey: "feyGift",
      label: "Dádiva de Faéria",
      unlockLevel: 3,
      featureName: "Magias do Andarilho Feérico",
      values: [
        { valueId: "1", label: "Borboletas ilusórias" },
        { valueId: "2", label: "Flores no cabelo" },
        { valueId: "3", label: "Fragrância natural" },
        { valueId: "4", label: "Sombra dançante" },
        { valueId: "5", label: "Chifres ou galhadas" },
        { valueId: "6", label: "Pele e cabelo mutáveis" },
      ],
    },
    {
      optionKey: "glamourSkill",
      label: "Perícia do Glamour Transcendental",
      unlockLevel: 3,
      featureName: "Glamour Transcendental",
      values: [
        { valueId: "atuacao", label: "Atuação" },
        { valueId: "enganacao", label: "Enganação" },
        { valueId: "persuasao", label: "Persuasão" },
      ],
    },
  ],
  "ranger:gloom-stalker": [
    {
      optionKey: "ironMindSave",
      label: "Salvaguarda da Mente de Ferro",
      unlockLevel: 7,
      featureName: "Mente de Ferro",
      values: [
        { valueId: "carisma", label: "Carisma" },
        { valueId: "inteligencia", label: "Inteligência" },
      ],
    },
  ],
  "fighter:champion": [
    {
      optionKey: "additionalFightingStyle",
      label: "Estilo de Luta Adicional",
      unlockLevel: 7,
      featureName: "Estilo de Luta Adicional",
      values: [
        { valueId: "archery", label: "Arqueria" },
        { valueId: "blind-fighting", label: "Combate Cego" },
        { valueId: "defense", label: "Defesa" },
        { valueId: "dueling", label: "Duelo" },
        { valueId: "great-weapon-fighting", label: "Combate com Arma Grande" },
        { valueId: "interception", label: "Interceptação" },
        { valueId: "protection", label: "Proteção" },
        { valueId: "thrown-weapon-fighting", label: "Combate com Arma Arremessável" },
        { valueId: "two-weapon-fighting", label: "Combate com Duas Armas" },
        { valueId: "unarmed-fighting", label: "Combate Desarmado" },
      ],
    },
  ],
  "fighter:battle-master": [
    {
      optionKey: "maneuver1",
      label: "Manobra 1",
      unlockLevel: 3,
      values: [
        { valueId: "parry", label: "Aparar" },
        { valueId: "menacing-attack", label: "Ataque Ameaçador" },
        { valueId: "sweeping-attack", label: "Ataque de Varredura" },
        { valueId: "lunging-attack", label: "Ataque Estendido" },
        { valueId: "distracting-attack", label: "Ataque para Distrair" },
        { valueId: "precision-attack", label: "Ataque Preciso" },
      ],
    },
    {
      optionKey: "maneuver2",
      label: "Manobra 2",
      unlockLevel: 3,
      values: [
        { valueId: "parry", label: "Aparar" },
        { valueId: "menacing-attack", label: "Ataque Ameaçador" },
        { valueId: "sweeping-attack", label: "Ataque de Varredura" },
        { valueId: "lunging-attack", label: "Ataque Estendido" },
        { valueId: "distracting-attack", label: "Ataque para Distrair" },
        { valueId: "precision-attack", label: "Ataque Preciso" },
      ],
    },
    {
      optionKey: "maneuver3",
      label: "Manobra 3",
      unlockLevel: 3,
      values: [
        { valueId: "parry", label: "Aparar" },
        { valueId: "menacing-attack", label: "Ataque Ameaçador" },
        { valueId: "sweeping-attack", label: "Ataque de Varredura" },
        { valueId: "lunging-attack", label: "Ataque Estendido" },
        { valueId: "distracting-attack", label: "Ataque para Distrair" },
        { valueId: "precision-attack", label: "Ataque Preciso" },
      ],
    },
  ],
  "barbarian:wild-heart": [
    {
      optionKey: "wildRageAspect",
      label: "Aspecto da Fúria dos Selvagens",
      unlockLevel: 3,
      featureName: "Fúria dos Selvagens",
      values: [
        { valueId: "eagle", label: "Águia" },
        { valueId: "wolf", label: "Lobo" },
        { valueId: "bear", label: "Urso" },
      ],
    },
    {
      optionKey: "wildAspect",
      label: "Aspecto dos Selvagens",
      unlockLevel: 6,
      featureName: "Aspecto dos Selvagens",
      values: [
        { valueId: "owl", label: "Coruja" },
        { valueId: "panther", label: "Pantera" },
        { valueId: "salmon", label: "Salmão" },
      ],
    },
    {
      optionKey: "wildPower",
      label: "Poder dos Selvagens",
      unlockLevel: 14,
      featureName: "Poder dos Selvagens",
      values: [
        { valueId: "ram", label: "Carneiro" },
        { valueId: "hawk", label: "Falcão" },
        { valueId: "lion", label: "Leão" },
      ],
    },
  ],
  "barbarian:zealot": [
    {
      optionKey: "divineFuryDamage",
      label: "Tipo de Dano da Fúria Divina",
      unlockLevel: 3,
      featureName: "Fúria Divina",
      values: [
        { valueId: "necrotic", label: "Necrótico" },
        { valueId: "radiant", label: "Radiante" },
      ],
    },
  ],
  "monk:elements": [
    {
      optionKey: "elementalResistance",
      label: "Resistência do Ápice Elemental",
      unlockLevel: 17,
      featureName: "Ápice Elemental",
      values: [
        { valueId: "acid", label: "Ácido" },
        { valueId: "cold", label: "Gélido" },
        { valueId: "fire", label: "Ígneo" },
        { valueId: "lightning", label: "Elétrico" },
        { valueId: "thunder", label: "Trovejante" },
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
  if (hasPreparedSpells && (PACT_SPELL_NAME.test(featureName) || /^Magias\b/.test(featureName))) {
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
    case "level_plus_one":
      return doc.level + 1;
    case "superiority_dice_count":
      if (doc.level >= 15) return 6;
      if (doc.level >= 7) return 5;
      return 4;
    case "psi_energy_dice_count":
      if (doc.level >= 17) return 12;
      if (doc.level >= 13) return 10;
      if (doc.level >= 11) return 8;
      if (doc.level >= 9) return 8;
      if (doc.level >= 5) return 6;
      return 4;
    case "zealot_healing_dice_count":
      if (doc.level >= 17) return 7;
      if (doc.level >= 12) return 6;
      if (doc.level >= 6) return 5;
      return 4;
    default:
      return fixedMax ?? 1;
  }
}
