/**
 * Padrões de prosa EN → PT para transformações GH Cap. 6.
 */
import { applyGhpgProsePatterns } from './ghpg-prose-patterns.mjs';
import { applyGhpgGlossary } from './ghpg-mechanical-glossary.mjs';
import { toMetricProse } from './metric-prose.mjs';

const CAP6_PATTERNS = [
  [
    /When you initially undergo the ([^.]+) Transformation, you gain both Stage 1 Boons and the Stage 1 Flaw\./g,
    'Quando você passa pela Transformação em $1 pela primeira vez, ganha as duas Bênçãos do estágio 1 e a Falha do estágio 1.',
  ],
  [
    /When you initially undergo the ([^.]+) Transformation, you gain the ([^.]+) Boon and one other Stage 1 Boon of your choice\. You also gain the Stage 1 Flaw\./g,
    'Quando você passa pela Transformação em $1 pela primeira vez, ganha a Bênção $2 e mais uma Bênção do estágio 1 de sua escolha. Também ganha a Falha do estágio 1.',
  ],
  [
    /When you reach Stage (\d+) of the ([^.]+) Transformation, you select one Stage \d+ Boon and gain the Stage \d+ Flaw\./g,
    'Quando você alcança o estágio $1 da Transformação em $2, escolhe uma Bênção do estágio $1 e ganha a Falha do estágio $1.',
  ],
  [
    /When you reach Stage (\d+) of the ([^.]+) Transformation, you select two Stage \d+ Boons and gain the Stage \d+ Flaw\./g,
    'Quando você alcança o estágio $1 da Transformação em $2, escolhe duas Bênçãos do estágio $1 e ganha a Falha do estágio $1.',
  ],
  [
    /Choose one of the following effects when you use this ability:/g,
    'Escolha um dos efeitos a seguir ao usar esta habilidade:',
  ],
  [
    /Whenever you kill any creature with a spell, you may apply an additional effect depending on the damage dealt\./g,
    'Sempre que você matar uma criatura com uma magia, pode aplicar um efeito adicional conforme o dano causado.',
  ],
  [
    /This ability cannot be used when you kill a Construct, Undead, or any creature without a soul\./g,
    'Esta habilidade não pode ser usada ao matar um Constructo, Morto-vivo ou qualquer criatura sem alma.',
  ],
  [
    /Gifts of Damnation are named for the benefits you can gain after offering mortals gifts in exchange for their souls, via the Devilish Contractor Boon\s*\./g,
    'As Dádivas da Perdição são os benefícios que você ganha ao oferecer presentes a mortais em troca de suas almas, por meio da Bênção Contratante Diabólico.',
  ],
  [
    /You can gain Stage (\d+) Gifts whenever you sign a victim to an infernal contract( while at Stage \d+ or higher of the Fiend Transformation)?\./g,
    'Você pode ganhar Dádivas do estágio $1 sempre que assinar um contrato infernal com uma vítima$2.',
  ],
  [
    /Reversing ([^.]+) Traits/g,
    'Reverter traços de $1',
  ],
];

/** @param {string} text */
export function applyCap6ProsePatterns(text) {
  if (!text) return text;
  let out = text;
  for (const [pattern, replacement] of CAP6_PATTERNS) {
    out = out.replace(pattern, replacement);
  }
  return out;
}

/** @param {string} text */
export function translateCap6Prose(text) {
  if (!text) return text;
  let out = text;
  for (let i = 0; i < 2; i += 1) {
    out = applyGhpgProsePatterns(out);
    out = applyGhpgGlossary(out);
  }
  return toMetricProse(out);
}
