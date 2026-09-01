/**
 * Tradução de prosa para talentos GH Cap. 4 — padrões estruturados antes do glossário genérico.
 */
import { applyGhpgProsePatterns } from './ghpg-prose-patterns.mjs';
import { applyGhpgGlossary } from './ghpg-mechanical-glossary.mjs';
import { toMetricProse } from './metric-prose.mjs';
import { CAP4_FEAT_NAMES_PT } from './ghpg-cap4-feat-names-pt.mjs';

const ABILITY_PT = {
  Strength: 'Força',
  Dexterity: 'Destreza',
  Constitution: 'Constituição',
  Intelligence: 'Inteligência',
  Wisdom: 'Sabedoria',
  Charisma: 'Carisma',
};

const TRANSFORMATION_FLAW_PT = {
  'Friendless Transformation Flaw': 'Falha de Transformação Solitária',
  'Fraying Reality Transformation Flaw': 'Falha de Transformação Realidade Desfiada',
  'Weakened Constitution Transformation Flaw': 'Falha de Transformação Constituição Enfraquecida',
  'Pull of The Netherworld Transformation Flaw': 'Falha de Transformação Puxão do Submundo',
  'Primordial Chaos Transformation Flaw': 'Falha de Transformação Caos Primordial',
  'Seraph Corruption Transformation Flaw': 'Falha de Transformação Corrupção Serafim',
};

const TRANSFORMATION_BOON_PT = {
  'Specter Transformation Boon': 'Dádiva de Transformação Espectro',
  'Aberrant Horror Transformation Boon': 'Dádiva de Transformação Horror Aberrante',
  'Fey Transformation Boon': 'Dádiva de Transformação Fey',
  'Fiend Transformation Boon': 'Dádiva de Transformação Diabo',
  'Seraph Transformation Boon': 'Dádiva de Transformação Serafim',
};

function formatAbilityList(raw) {
  const names = raw
    .replace(/\s+or\s+/gi, ', ')
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean)
    .map((name) => ABILITY_PT[name] ?? name);
  if (names.length <= 1) return names[0] ?? raw;
  if (names.length === 2) return `${names[0]} ou ${names[1]}`;
  return `${names.slice(0, -1).join(', ')} ou ${names.at(-1)}`;
}

function applyStructuredFeatPatterns(text) {
  if (!text) return text;
  let out = text;

  for (const [en, pt] of Object.entries(TRANSFORMATION_FLAW_PT)) {
    out = out.replaceAll(en, pt);
  }
  for (const [en, pt] of Object.entries(TRANSFORMATION_BOON_PT)) {
    out = out.replaceAll(en, pt);
  }

  out = out
    .replace(
      /Increase one ability score of your choice by 1, to a maximum of 30\./g,
      'Aumente um atributo à sua escolha em 1, até o máximo de 30.',
    )
    .replace(
      /Increase your ((?:Strength|Dexterity|Constitution|Intelligence|Wisdom|Charisma)(?:, |, or | or )?)+ score by 1, to a maximum of 20\./gi,
      (_match, abilities) => `Aumente ${formatAbilityList(abilities)} em 1, até o máximo de 20.`,
    )
    .replace(
      /You are no longer affected by the ([^.]+)\./g,
      'Você não é mais afetado por $1.',
    )
    .replace(
      /Choose any ([^.]+) that you don.t already have but meet the prerequisites for\. You gain that Boon\./g,
      'Escolha uma $1 que você ainda não tenha e para a qual cumpra os pré-requisitos. Você ganha essa Dádiva.',
    )
    .replace(
      /When you roll a (\d+) or lower on the Unstable Form table, you can choose to roll again\. You must use the new result\. Once you use this benefit, you can.t use it again until you finish a Long Rest\./g,
      'Quando rolar $1 ou menos na tabela Forma Instável, você pode rolar novamente. Deve usar o novo resultado. Depois de usar este benefício, não pode usá-lo de novo até terminar um Descanso Longo.',
    )
    .replace(
      /On your first turn after an Initiative roll, add 1d4 to the first damage roll you make\. This extra damage increases to 2d4 at character level 9, and to 4d4 at character level 16\./g,
      'No seu primeiro turno após uma rolagem de Iniciativa, adicione 1d4 à primeira jogada de dano que fizer. Esse dano extra aumenta para 2d4 no nível de personagem 9 e para 4d4 no nível 16.',
    )
    .replace(
      /Your Hit Point maximum increases by an amount equal to your character level when you gain this feat\. Whenever you gain a character level, your Hit Point maximum increases by 1\./g,
      'Seu máximo de Pontos de Vida aumenta em um valor igual ao seu nível de personagem quando ganha este talento. Sempre que ganha um nível de personagem, seu máximo de Pontos de Vida aumenta em 1.',
    )
    .replace(
      /You always have Shadowsteel curses prepared, and you can cast them with any spell slots you have\./g,
      'Você sempre tem maldições de Shadowsteel preparadas e pode conjurá-las com quaisquer espaços de magia que tenha.',
    )
    .replace(
      /While holding your Shadowsteel Focus , you gain a \+1 bonus to spell attack rolls and to the saving throw DCs of your spells\./g,
      'Enquanto segura seu Foco de Shadowsteel, você ganha +1 em jogadas de ataque com magia e nas CDs de salvaguarda das suas magias.',
    )
    .replace(
      /If your Shadowsteel Focus is also a weapon, that weapon has a \+1 bonus to weapon attack rolls and damage rolls\./g,
      'Se seu Foco de Shadowsteel também for uma arma, essa arma ganha +1 em jogadas de ataque e de dano.',
    )
    .replace(
      /Taking the Utilize action and expending the use of a Healer['']s Kit lets you heal a creature within 5 feet of you\. The creature can expend and roll one Hit Point Die and regain a number of Hit Points equal to the roll \+ your Proficiency Bonus\./g,
      'Realizar a ação Utilizar e gastar o uso de um Kit de Curandeiro permite curar uma criatura a até 1,5 m de você. A criatura pode gastar e rolar um Dado de Vida e recuperar Pontos de Vida iguais à rolagem + seu Bônus de Proficiência.',
    )
    .replace(
      /You ignore the Loading property of the Blackpowder Pistol\./g,
      'Você ignora a propriedade Recarregar da Pistola de Pólvora Negra.',
    )
    .replace(
      /You have proficiency with Advanced weapons, and your training allows you to use the mastery properties of those weapons\./g,
      'Você tem proficiência com armas Avançadas e seu treinamento permite usar as propriedades de maestria dessas armas.',
    )
    .replace(
      /This feat can be taken as a General feat by a character of level 8 or higher\./g,
      'Este talento pode ser escolhido como talento Geral por personagens de nível 8 ou superior.',
    )
    .replace(/Triage Expert feat/gi, `talento ${CAP4_FEAT_NAMES_PT['triage-expert']}`)
    .replace(/Blood and Bone/g, 'Sangue e Osso')
    .replace(/Chapter 8: Advanced Weapons & Equipment/g, 'Capítulo 8: Armas e Equipamento Avançados')
    .replace(/Grim Hollow Campaign Guide/g, 'Grim Hollow: Guia de Campanha');

  return out;
}

function applyNegativeGuards(text) {
  return text
    .replace(/\bYou aren't\b/g, 'Você não está')
    .replace(/\byou aren't\b/g, 'você não está')
    .replace(/\bYou don't\b/g, 'Você não')
    .replace(/\byou don't\b/g, 'você não')
    .replace(/\bdoesn't\b/g, 'não')
    .replace(/\bcan't\b/g, 'não pode')
    .replace(/\bCan't\b/g, 'Não pode');
}

/** @param {string} text */
export function translateCap4FeatBody(text) {
  if (!text) return text;
  let out = applyStructuredFeatPatterns(text);
  out = applyNegativeGuards(out);
  out = applyGhpgProsePatterns(out);
  out = applyGhpgGlossary(out);
  out = applyGhpgProsePatterns(out);
  out = toMetricProse(out);
  return out.replace(/\s+/g, ' ').replace(/\s+([,.;:])/g, '$1').trim();
}

/** @param {string} text */
export function translateCap4FeatIntro(text) {
  return translateCap4FeatBody(text);
}
