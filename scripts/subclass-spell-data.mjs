/**
 * Magias sempre preparadas por subclasse (PHB 2024 PT-BR).
 * Chaves de nível = nível de classe em que a magia é desbloqueada.
 */
export const SUBCLASS_SPELLS = {
  "cleric-light": {
    preparedSpellSourceKey: "light-domain",
    preparedSpellsByLevel: {
      "3": ["fogo-das-fadas", "maos-flamejantes", "raio-ardente", "ver-o-invisivel"],
      "5": ["bola-de-fogo", "luz-do-dia"],
      "7": ["muralha-de-fogo", "olho-arcano"],
      "9": ["coluna-de-chamas", "videncia"],
    },
  },
  "cleric-trickery": {
    preparedSpellSourceKey: "trickery-domain",
    preparedSpellsByLevel: {
      "3": ["disfarcar-se", "enfeiticar-pessoa", "invisibilidade", "passo-sem-rastro"],
      "5": ["indetectavel", "padrao-hipnotico"],
      "7": ["confusao", "porta-dimensional"],
      "9": ["dominar-pessoa", "modificar-memoria"],
    },
  },
  "cleric-war": {
    preparedSpellSourceKey: "war-domain",
    preparedSpellsByLevel: {
      "3": ["arma-espiritual", "arma-magica", "escudo-da-fe", "raio-guia"],
      "5": ["guardioes-espirituais", "manto-do-cruzado"],
      "7": ["escudo-ardente", "movimentacao-livre"],
      "9": ["golpe-de-arco", "paralisar-monstro"],
    },
  },
  "druid-moon": {
    preparedSpellSourceKey: "moon-circle",
    preparedSpellsByLevel: {
      "3": ["curar-ferimentos", "fagulha-estelar", "raio-lunar"],
      "5": ["invocar-animais"],
      "7": ["fonte-do-luar"],
      "9": ["curar-ferimentos-em-massa"],
    },
  },
  "druid-sea": {
    preparedSpellSourceKey: "sea-circle",
    preparedSpellsByLevel: {
      "3": ["despedacar", "lufada-de-vento", "nevoa-obscurecente", "onda-trovejante", "raio-de-gelo"],
      "5": ["relampago", "respirar-na-agua"],
      "7": ["controlar-agua", "tempestade-glacial"],
      "9": ["invocar-elemental", "paralisar-monstro"],
    },
  },
  "druid-land": {
    preparedSpellSourceKey: "land-circle",
    landTerrainIds: ["arid", "polar", "temperate", "tropical"],
    preparedSpellsByTerrain: {
      arid: {
        "3": ["maos-flamejantes", "turvar", "raio-de-fogo"],
        "5": ["bola-de-fogo", "muralha-de-fogo"],
        "7": ["malogro", "muralha-de-pedra"],
        "9": ["coluna-de-chamas", "videncia"],
      },
      polar: {
        "3": ["nevoa-obscurecente", "paralisar-pessoa", "raio-de-gelo"],
        "5": ["nevasca", "lentidao"],
        "7": ["cone-de-frio", "tempestade-glacial"],
        "9": ["comunhao-com-a-natureza", "passo-arboreo"],
      },
      temperate: {
        "3": ["passo-nebuloso", "toque-chocante", "sono"],
        "5": ["relampago", "crescimento-de-plantas"],
        "7": ["movimentacao-livre", "moldar-rochas"],
        "9": ["comunhao-com-a-natureza", "muralha-de-pedra"],
      },
      tropical: {
        "3": ["bolha-acida", "rajada-de-veneno", "teia"],
        "5": ["nuvem-fetida", "polimorfia"],
        "7": ["praga-de-insetos", "muralha-de-espinhos"],
        "9": ["nevoa-mortal", "passo-arboreo"],
      },
    },
  },
  "paladin-devotion": {
    preparedSpellSourceKey: "devotion-oath",
    preparedSpellsByLevel: {
      "3": ["escudo-da-fe", "protecao-contra-o-bem-e-o-mal"],
      "5": ["auxilio", "zona-da-verdade"],
      "9": ["dissipar-magia", "sinal-de-esperanca"],
      "13": ["defensor-da-fe", "movimentacao-livre"],
      "17": ["coluna-de-chamas", "comunhao"],
    },
  },
  "paladin-ancients": {
    preparedSpellSourceKey: "ancients-oath",
    preparedSpellsByLevel: {
      "3": ["falar-com-animais", "golpe-constritor"],
      "5": ["passo-nebuloso", "raio-lunar"],
      "9": ["crescimento-de-plantas", "protecao-contra-energia"],
      "13": ["pele-rocha", "tempestade-glacial"],
      "17": ["comunhao-com-a-natureza", "passo-arboreo"],
    },
  },
  "paladin-glory": {
    preparedSpellSourceKey: "glory-oath",
    preparedSpellsByLevel: {
      "3": ["heroismo", "raio-guia"],
      "5": ["aprimorar-atributo", "arma-magica"],
      "9": ["celeridade", "protecao-contra-energia"],
      "13": ["compulsao", "movimentacao-livre"],
      "17": ["lendas-e-historias", "presenca-regia-de-yolande"],
    },
  },
  "paladin-vengeance": {
    preparedSpellSourceKey: "vengeance-oath",
    preparedSpellsByLevel: {
      "3": ["marca-do-predador", "perdicao"],
      "5": ["paralisar-pessoa", "passo-nebuloso"],
      "9": ["celeridade", "protecao-contra-energia"],
      "13": ["banimento", "porta-dimensional"],
      "17": ["paralisar-monstro", "videncia"],
    },
  },
  "warlock-archfey": {
    preparedSpellSourceKey: "archfey-pact",
    preparedSpellsByLevel: {
      "3": ["acalmar-emocoes", "fogo-das-fadas", "forca-espectral", "passo-nebuloso", "sono"],
      "5": ["crescimento-de-plantas", "piscar"],
      "7": ["dominar-fera", "invisibilidade-maior"],
      "9": ["dominar-pessoa", "similaridade"],
    },
  },
  "warlock-fiend": {
    preparedSpellSourceKey: "fiend-pact",
    preparedSpellsByLevel: {
      "3": ["comando", "maos-flamejantes", "raio-ardente", "sugestao"],
      "5": ["bola-de-fogo", "nuvem-fetida"],
      "7": ["escudo-ardente", "muralha-de-fogo"],
      "9": ["missao", "praga-de-insetos"],
    },
  },
  "warlock-celestial": {
    preparedSpellSourceKey: "celestial-pact",
    preparedSpellsByLevel: {
      "3": [
        "auxilio",
        "chama-sagrada",
        "curar-ferimentos",
        "luz",
        "raio-guia",
        "restauracao-menor",
      ],
      "5": ["luz-do-dia", "revivificar"],
      "7": ["defensor-da-fe", "muralha-de-fogo"],
      "9": ["convocar-celestial", "restauracao-maior"],
    },
  },
  "warlock-great-old-one": {
    preparedSpellSourceKey: "great-old-one-pact",
    preparedSpellsByLevel: {
      "3": [
        "detectar-pensamentos",
        "forca-espectral",
        "gargalhada-nefasta-de-tasha",
        "sussurros-dissonantes",
      ],
      "5": ["clarividencia", "fome-de-hadar"],
      "7": ["confusao", "invocar-aberracao"],
      "9": ["modificar-memoria", "telecinese"],
    },
  },
  "ranger-fey-wanderer": {
    preparedSpellSourceKey: "fey-wanderer-spells",
    preparedSpellsByLevel: {
      "3": ["enfeiticar-pessoa"],
      "5": ["passo-nebuloso"],
      "9": ["convocar-feerico"],
      "13": ["porta-dimensional"],
      "17": ["despistar"],
    },
  },
  "ranger-gloom-stalker": {
    preparedSpellSourceKey: "gloom-stalker-spells",
    preparedSpellsByLevel: {
      "3": ["disfarcar-se"],
      "5": ["corda-extradimensional"],
      "9": ["medo"],
      "13": ["invisibilidade-maior"],
      "17": ["similaridade"],
    },
  },
};
