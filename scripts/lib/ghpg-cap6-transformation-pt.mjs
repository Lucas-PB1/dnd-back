/**
 * PT para transformações GH Cap. 6 (J019).
 * Prosa curada por slug/anchorId; fallback com glossário mecânico.
 */
import { stripCap6FlavorAside } from './ghpg-html-utils.mjs';
import {
  applyCap6ProsePatterns,
  translateCap6Prose,
} from './ghpg-cap6-transformation-prose.mjs';
import { FIEND_BENEFIT_PT } from './ghpg-cap6-fiend-pt.mjs';
import { SPECTER_BENEFIT_PT } from './ghpg-cap6-specter-pt.mjs';

/** @type {Record<string, Record<string, { name?: string; description?: string }>>} */
export const CAP6_BENEFIT_PT = {
  'gh-transformation-fiend': FIEND_BENEFIT_PT,
  'gh-transformation-specter': SPECTER_BENEFIT_PT,
};

const CAP6_EXTRA_GLOSSARY = [
  ['Transformation Stage', 'Estágio de Transformação'],
  ['Transformation Stages', 'Estágios de Transformação'],
  ['Transformation', 'Transformação'],
  ['Gift of Damnation', 'Dádiva da Perdição'],
  ['Gifts of Damnation', 'Dádivas da Perdição'],
  ['Gift of Unfettered Glory', 'Dádiva da Glória Irrestrita'],
  ['Arch Daemon', 'Arquidaemônio'],
  ['Arch Daemons', 'Arquidaemônios'],
  ['Netherworld', 'Submundo'],
  ['Fiend Transformation', 'Transformação em Corruptor'],
  ['Fiend', 'Corruptor'],
  ['Fiends', 'Corruptores'],
  ['Celestial', 'Celestial'],
  ['Celestials', 'Celestiais'],
  ['Wish spell', 'magia Desejo'],
  ['your GM', 'seu Mestre'],
  ['Your GM', 'Seu Mestre'],
  ['the GM', 'o Mestre'],
  ['The GM', 'O Mestre'],
  ['D20 Test', 'Teste D20'],
  ['D20 Tests', 'Testes D20'],
  ['Bloodied', 'Ferido'],
  ['Magic action', 'ação Mágica'],
  ['Magic Action', 'Ação Mágica'],
  ['Challenge Rating', 'ND'],
  ['Expertise', 'Especialização'],
  ['Hit Point Die', 'Dado de Vida'],
  ['Hit Point Dice', 'Dados de Vida'],
  ['when you reach Stage', 'quando você alcança o estágio'],
  ['When you reach Stage', 'Quando você alcança o estágio'],
  ['When you initially undergo', 'Quando você passa pela'],
  ['When you initially contract', 'Quando você contrai'],
  ['you select one Stage', 'você escolhe uma Bênção do estágio'],
  ['you gain the Stage', 'você ganha a Falha do estágio'],
  ['and gain the Stage', 'e ganha a Falha do estágio'],
  ['both Stage 1 Boons', 'as duas Bênçãos do estágio 1'],
  ['one other Stage 1 Boon of your choice', 'mais uma Bênção do estágio 1 de sua escolha'],
  ['Aberrant Horror Transformation', 'Transformação em Horror Aberrante'],
  ['Fey Transformation', 'Transformação em Fada'],
  ['Hag Transformation', 'Transformação em Bruxa'],
  ['Lich Transformation', 'Transformação em Lich'],
  ['Lycanthrope Transformation', 'Transformação em Licantropo'],
  ['Ooze Transformation', 'Transformação em Gosma'],
  ['Primordial Transformation', 'Transformação em Primordial'],
  ['Seraph Transformation', 'Transformação em Serafim'],
  ['Shadowsteel Ghoul Transformation', 'Transformação em Carniçal de Aço Sombrio'],
  ['Specter Transformation', 'Transformação em Espectro'],
  ['Vampire Transformation', 'Transformação em Vampiro'],
  ['Hideous Appearance', 'Aparência Horrível'],
  ['Unstable Form', 'Forma Instável'],
  ['Gifts of Damnation', 'Dádivas da Perdição'],
];

/** @param {string} text */
export function translateCap6Body(text) {
  if (!text) return text;
  let out = applyCap6ProsePatterns(text);
  for (const [en, pt] of CAP6_EXTRA_GLOSSARY) {
    out = out.replaceAll(en, pt);
  }
  return stripCap6FlavorAside(translateCap6Prose(out));
}

/** Nomes PT das Dádivas da Perdição (anchorId → nome). */
export const CAP6_GIFT_NAMES_PT = {
  GiftOfJoyousLife: 'Dádiva da Vida Jocosa',
  GiftOfProdigiousTalent: 'Dádiva do Talento Prodigioso',
  GiftOfUnsurpassedFortune: 'Dádiva da Fortuna Inigualável',
  GiftOfLiberatingFreedom: 'Dádiva da Liberdade Libertadora',
  GiftOfUnfetteredGlory: 'Dádiva da Glória Irrestrita',
  GiftOfSecondChances: 'Dádiva das Segundas Chances',
  GiftOfUnconditionalLove: 'Dádiva do Amor Incondicional',
  GiftOfMartialProwess: 'Dádiva da Prowess Marcial',
  GiftOfUnbridledPower: 'Dádiva do Poder Desenfreado',
};

/** @param {string} name */
export function translateCap6BenefitName(name) {
  if (!name) return name;
  return name
    .replace(/^Stage (\d+) Boon: (.+)$/i, 'Bênção do estágio $1: $2')
    .replace(/^Stage (\d+) Flaw: (.+)$/i, 'Falha do estágio $1: $2')
    .replace(/^Stage (\d+) Gifts?$/i, 'Dádivas do estágio $1')
    .replace(/^Gift of (.+)$/i, 'Dádiva de $1')
    .replace(/^Stage (\d+)$/i, 'Estágio $1');
}

/** @param {string} anchorId @param {string} fallbackName */
export function resolveCap6GiftName(anchorId, fallbackName) {
  return CAP6_GIFT_NAMES_PT[anchorId] ?? translateCap6BenefitName(fallbackName);
}

/** Prosa introdutória curada (slug → PT). Demais slugs usam glossário no becoming EN. */
export const CAP6_BECOMING_PT = {
  'gh-transformation-fiend': `Um mortal pode tornar-se Corruptor de várias maneiras. Alguns perdem a alma e tornam-se um ao morrer. Outros realizam rituais agonizantes para receber poder terrível de um Arquidaemônio. Alguns mortais podem tornar-se Corruptores sem intenção, como recompensa ou punição por uma vida de crueldade e maldades. Ainda assim, é raro que uma criatura seja escolhida para integrar as legiões do Submundo sem antes ter feito um pacto por tal dádiva.

Conversar com o Mestre sobre criar acordos com mortais na história é uma excelente forma de interpretar sua influência no mundo do jogo. Como Corruptor, considere as motivações do personagem e quais PNJs podem ajudá-lo a alcançar seus objetivos.

Você está a serviço de um Arquidaemônio ou divindade sombria específicos? Segue apenas suas próprias ambições, fazendo os pactos necessários para isso? Que maldades você infligirá ao mundo, e com que fins? Corruptores raramente agem sem ambição, mesmo que seja simplesmente corromper tantos mortais quanto conseguir convencer a assinar um contrato.

Reverter traços de Corruptor

Tornar-se Corruptor costuma exigir atos de grande maldade. Você pode ter realizado sacrifícios de sangue ou feito pactos que causaram sofrimento a outros. Nem mesmo magia do nível da magia Desejo poderia expiar suas ações ou redimir sua alma. Somente depois de realizar um ato de sacrifício ou expiação incríveis tal magia poderia remover as bênçãos e falhas da Transformação.`,
};

/** @param {string} slug @param {string} anchorId @param {string} fallback */
export function resolveCap6BenefitDescription(slug, anchorId, fallback) {
  const curated = CAP6_BENEFIT_PT[slug]?.[anchorId]?.description;
  if (curated) return curated;
  return translateCap6Body(fallback);
}

/** @param {string} slug @param {string} anchorId @param {string} fallbackName */
export function resolveCap6BenefitName(slug, anchorId, fallbackName) {
  const curated = CAP6_BENEFIT_PT[slug]?.[anchorId]?.name;
  if (curated) return curated;
  if (anchorId.startsWith('GiftOf')) {
    return resolveCap6GiftName(anchorId, fallbackName);
  }
  return translateCap6BenefitName(fallbackName);
}

/** @param {string} slug @param {string} anchorId @param {string} fallback */
export function resolveCap6StageSummary(slug, anchorId, fallback) {
  const curated = CAP6_BENEFIT_PT[slug]?.[anchorId]?.description;
  if (curated) return curated;
  return translateCap6Body(fallback);
}

/** Une estágios "Como avançar" com o bloco mecânico do mesmo número. */
export function prepareTransformationStages(stages) {
  const prepared = [];
  for (let i = 0; i < stages.length; i += 1) {
    const stage = stages[i];
    if (/^AchievingANewStage\d+$/i.test(stage.anchorId)) {
      const next = stages[i + 1];
      if (next && next.stage === stage.stage) {
        prepared.push({
          ...next,
          advancementAnchorId: stage.anchorId,
          advancementText: stage.summary || stage.body,
        });
        i += 1;
        continue;
      }
      continue;
    }
    prepared.push({
      ...stage,
      advancementAnchorId: stage.advancementAnchorId ?? null,
      advancementText: stage.advancementText ?? null,
    });
  }
  return prepared;
}

/** @param {string} slug @param {string} becomingEn */
export function resolveCap6Becoming(slug, becomingEn) {
  return CAP6_BECOMING_PT[slug] ?? translateCap6Body(becomingEn);
}

/** @param {string} title */
export function resolveCap6AppendixTitle(title) {
  return translateCap6BenefitName(translateCap6Body(title));
}

/** @param {string} slug @param {string} anchorId @param {string} fallback */
export function resolveCap6AppendixDescription(slug, anchorId, fallback) {
  const curated = CAP6_BENEFIT_PT[slug]?.[anchorId]?.description;
  if (curated) return curated;
  return translateCap6Body(fallback);
}
