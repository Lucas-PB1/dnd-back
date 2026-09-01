import { applyGhpgGlossary } from './ghpg-mechanical-glossary.mjs';
import { CAP4_FEAT_NAMES_PT } from './ghpg-cap4-feat-names-pt.mjs';

const FEAT_REFERENCES = {
  'Triage Expert Feat': `talento ${CAP4_FEAT_NAMES_PT['triage-expert']}`,
  'Shadowsteel Adept Feat': `talento ${CAP4_FEAT_NAMES_PT['shadowsteel-adept']}`,
  'Syndicate Smuggler background': 'antecedente Contrabandista do Sindicato',
  'Spellcasting or Pact Magic Feature': 'Característica de Conjuração ou Magia de Pacto',
  'Fighting Style Feature': 'Característica de Estilo de Luta',
  'Lich Transformation': 'Transformação Lich',
  'Vampire Transformation': 'Transformação Vampiro',
  'Specter Transformation': 'Transformação Espectro',
  'Aberrant Horror Transformation': 'Transformação Horror Aberrante',
  'Fey Transformation': 'Transformação Fey',
  'Fiend Transformation': 'Transformação Diabo',
  'Primordial Transformation': 'Transformação Primordial',
  'Seraph Transformation': 'Transformação Serafim',
  'Shadowsteel Ghoul Transformation': 'Transformação Carniçal de Shadowsteel',
  'Lycanthrope Transformation': 'Transformação Licantropo',
};

/** @param {string | null | undefined} text */
export function translateFeatPrerequisite(text) {
  if (!text) return null;

  let out = text
    .replace(/Level (\d+)\+/g, 'Nível $1 ou superior')
    .replace(
      /Strength or Dexterity (\d+)\+/g,
      'Força ou Destreza $1 ou superior',
    )
    .replace(/Strength (\d+)\+/g, 'Força $1 ou superior')
    .replace(/Dexterity (\d+)\+/g, 'Destreza $1 ou superior')
    .replace(/Constitution (\d+)\+/g, 'Constituição $1 ou superior')
    .replace(/, Special$/i, ', Especial');

  for (const [en, pt] of Object.entries(FEAT_REFERENCES)) {
    out = out.replaceAll(en, pt);
  }

  return applyGhpgGlossary(out);
}
