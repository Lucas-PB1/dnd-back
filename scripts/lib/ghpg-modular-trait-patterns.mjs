/**
 * Padrões de prosa para traços modulares GH Cap. 1 (benefit_base / benefit_improved).
 * Complementa ghpg-mechanical-glossary + ghpg-prose-patterns.
 */

/** Perícias PHB 2024 PT */
export const GHPG_SKILL_NAMES_PT = {
  'Animal Handling': 'Adestrar Animais',
  Arcana: 'Arcanismo',
  Athletics: 'Atletismo',
  Deception: 'Enganação',
  History: 'História',
  Insight: 'Intuição',
  Intimidation: 'Intimidação',
  Investigation: 'Investigação',
  Medicine: 'Medicina',
  Nature: 'Natureza',
  Perception: 'Percepção',
  Performance: 'Atuação',
  Persuasion: 'Persuasão',
  Religion: 'Religião',
  Stealth: 'Furtividade',
  Survival: 'Sobrevivência',
};

/** @type {[RegExp, string][]} — frases longas primeiro; aplicar no texto EN bruto */
export const GHPG_MODULAR_TRAIT_RAW_PATTERNS = [
  [
    /Time spent among beasts has gifted you a way with those creatures\./g,
    'Tempo entre feras lhe deu jeito com essas criaturas.',
  ],
  [
    /Something must be done about that elf\. Last time I confronted her, she sicced my own dog on me\.\s*\n\s*—Disgruntled Neighbor/g,
    'Algo precisa ser feito com aquela elfa. Da última vez que a confrontei, ela sicou meu próprio cão contra mim.\n\n— Vizinho ressentido',
  ],
  [
    /When you desire to stand out, you have a natural gift for impressing others\./g,
    'Quando você quer se destacar, tem um dom natural para impressionar os outros.',
  ],
  [
    /Your reserves of physical power have kept you alive on more than one occasion\./g,
    'Suas reservas de força física já o mantiveram vivo em mais de uma ocasião.',
  ],
  [
    /You've learned that paying attention to the environment around you is the best way to predict its threats\./g,
    'Você aprendeu que prestar atenção ao ambiente ao redor é a melhor forma de prever suas ameaças.',
  ],
  [
    /You’ve learned that paying attention to the environment around you is the best way to predict its threats\./g,
    'Você aprendeu que prestar atenção ao ambiente ao redor é a melhor forma de prever suas ameaças.',
  ],
  [
    /When trouble comes for you, you excel at making sure it can't find you\./g,
    'Quando o perigo vem atrás de você, você se destaca em garantir que ele não o encontre.',
  ],
  [
    /When others suffer, you are there to help\./g,
    'Quando outros sofrem, você está lá para ajudar.',
  ],
  [
    /The lessons of the past are harsh, but learning those lessons might give you the best insight for navigating the future\./g,
    'As lições do passado são duras, mas aprendê-las pode dar a melhor perspectiva para navegar o futuro.',
  ],
  [
    /The wilds of Etharis have claimed many who lack the skill to navigate them\./g,
    'As terras selvagens de Etharis reclamaram muitos que não tinham perícia para navegá-las.',
  ],
  [
    /You revere the crafting skill of ancestors long dead\./g,
    'Você reverencia a perícia artesanal de ancestrais há muito mortos.',
  ],
  [
    /You have proficiency in the (.+?) skill\.?/gi,
    'Você tem proficiência na perícia $1.',
  ],
  [
    /You have proficiency in (.+?) skill\.?/gi,
    'Você tem proficiência na perícia $1.',
  ],
  [
    /You have proficiency with (.+?)\./gi,
    'Você tem proficiência com $1.',
  ],
  [
    /If you take this trait twice, you have Advantage on (.+?) checks\.?/gi,
    'Se você escolher este traço duas vezes, você tem Vantagem em testes de $1.',
  ],
  [
    /If you take this trait multiple times, you gain its benefit for a new environment each time\./gi,
    'Se você escolher este traço várias vezes, você ganha o benefício para um novo ambiente a cada vez.',
  ],
  [
    /If you take this trait multiple times, you gain proficiency with a new tool each time\./gi,
    'Se você escolher este traço várias vezes, você ganha proficiência com uma nova ferramenta a cada vez.',
  ],
  [
    /You can use this feature a number of times equal to twice your Proficiency Bonus, regaining all expended uses when you finish a Long Rest\./gi,
    'Você pode usar este recurso um número de vezes igual a duas vezes seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  ],
  [
    /You can use this feature a number of times equal to your Proficiency Bonus, regaining all expended uses when you finish a Long Rest\./gi,
    'Você pode usar este recurso um número de vezes igual ao seu Bônus de Proficiência, recuperando todos os usos ao terminar um Descanso Longo.',
  ],
  [
    /Choose an Artisan's Tool\. You have proficiency with that tool\./gi,
    'Escolha uma ferramenta de artesão. Você tem proficiência com essa ferramenta.',
  ],
  [
    /Choose an environment: arctic, coastal, desert, forest, grassland, hill and mountain, swamp, subterranean, or underwater\./gi,
    'Escolha um ambiente: ártico, costeiro, deserto, floresta, pradaria, colina e montanha, pântano, subterrâneo ou subaquático.',
  ],
];

/** Limpeza de híbridos EN/PT após glossário */
export const GHPG_MODULAR_TRAIT_CLEANUP_PATTERNS = [
  [/proficiência em ([^.]+?) skill/gi, 'proficiência na perícia $1'],
  [/Vantagem em ([^.]+?) testes/gi, 'Vantagem em testes de $1'],
  [/Vantagem em the ([^.]+?) testes/gi, 'Vantagem em testes de $1'],
  [/Quando você make/gi, 'Quando você faz'],
  [/Quando você fail/gi, 'Quando você falha'],
  [/Quando você desire/gi, 'Quando você deseja'],
  [/Quando você reach/gi, 'Quando você alcança'],
  [/você pode use/gi, 'você pode usar'],
  [/você pode choose/gi, 'você pode escolher'],
  [/you gain/gi, 'você ganha'],
  [/you have/gi, 'você tem'],
  [/you roll/gi, 'você rola'],
  [/you make/gi, 'você faz'],
  [/when you/gi, 'quando você'],
  [/When you/gi, 'Quando você'],
  [/that tool/gi, 'essa ferramenta'],
  [/that environment/gi, 'esse ambiente'],
  [/instead of your normal bonus/gi, 'em vez do seu bônus normal'],
  [/you are considered proficient in/gi, 'você é considerado proficiente em'],
  [/you are considered to have/gi, 'você é considerado como tendo'],
  [/appropriate skill for the check/gi, 'a perícia apropriada para o teste'],
  [/involving hearing/gi, 'que envolvem audição'],
  [/the check/gi, 'o teste'],
  [/You regain the use of this feature when you finish a Long Rest\./gi,
    'Você recupera o uso deste recurso ao terminar um Descanso Longo.'],
  [/You regain the use of this feature when you finish a Short Rest\./gi,
    'Você recupera o uso deste recurso ao terminar um Descanso Curto.'],
  [/You regain the use this feature when you finish a/gi,
    'Você recupera o uso deste recurso ao terminar um'],
  [/Se você take/gi, 'Se você escolher'],
  [/Se você escolher this trait twice/gi, 'Se você escolher este traço duas vezes'],
  [/Vantagem on/gi, 'Vantagem em'],
  [/Vantagem em Ataque de Oportunidades/gi, 'Vantagem em Ataques de Oportunidade'],
  [/take this trait twice/gi, 'escolher este traço duas vezes'],
  [/take this trait multiple times/gi, 'escolher este traço várias vezes'],
  [/Escolha umn /gi, 'Escolha um '],
  [/ e ser /gi, ' e seu '],
  [/ e seu connection/gi, ' e sua conexão'],
  [/The natural world is a dangerous place/gi, 'O mundo natural é um lugar perigoso'],
  [/While in that environment/gi, 'Enquanto estiver nesse ambiente'],
  [/whenever you make an ability check/gi, 'sempre que você faz um teste de atributo'],
  [/and you add double/gi, 'e você soma o dobro'],
  [/Environmental Awareness/gi, 'Percepção Ambiental'],
  [/any tool you selected with Artisanal Focus/gi,
    'qualquer ferramenta que você escolheu com Foco Artesanal'],
  [/ checks\./g, ' testes.'],
  [/ checks /g, ' testes '],
  [/ skill\./g, '.'],
  [/ skill$/g, ''],
];

export function translateSkillNames(text) {
  if (!text) return text;
  let out = text;
  const entries = Object.entries(GHPG_SKILL_NAMES_PT).sort(
    (a, b) => b[0].length - a[0].length,
  );
  for (const [en, pt] of entries) {
    out = out.replace(new RegExp(`\\b${escapeRegExp(en)}\\b`, 'g'), pt);
  }
  return out;
}

function applyPatternList(text, patterns) {
  if (!text) return text;
  let out = text;
  for (let pass = 0; pass < 3; pass += 1) {
    let next = out;
    for (const [pattern, replacement] of patterns) {
      next = next.replace(pattern, replacement);
    }
    if (next === out) break;
    out = next;
  }
  return out;
}

export function applyModularTraitRawPatterns(text) {
  return applyPatternList(text, GHPG_MODULAR_TRAIT_RAW_PATTERNS);
}

export function cleanupHybridModularTrait(text) {
  return applyPatternList(text, GHPG_MODULAR_TRAIT_CLEANUP_PATTERNS);
}

/** Remove prefixo EN do nome do traço e usa rótulo PT. */
export function stripEnglishTraitPrefix(text, englishName, namePt) {
  if (!text?.trim() || !englishName?.trim() || !namePt?.trim()) return text;
  const en = englishName.replace(/\.$/, '').trim();
  const pt = namePt.replace(/\.$/, '').trim();
  return text.replace(new RegExp(`^${escapeRegExp(en)}\\.?\\s*`, 'i'), `${pt}. `);
}

function escapeRegExp(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

export function translateGhpgModularTrait(text, options = {}) {
  const { englishName, namePt } = options;
  let out = text;
  for (let i = 0; i < 2; i += 1) {
    out = cleanupHybridModularTrait(out);
    out = translateSkillNames(out);
  }
  if (englishName && namePt) {
    const en = englishName.replace(/\.$/, '').trim();
    const pt = namePt.replace(/\.$/, '').trim();
    out = out.replace(new RegExp(`\\b${escapeRegExp(en)}\\.`, 'gi'), `${pt}.`);
    out = stripEnglishTraitPrefix(out, englishName, namePt);
    if (options.improvedEnglishName) {
      out = stripEnglishTraitPrefix(out, options.improvedEnglishName, namePt);
    }
  }
  return out;
}
