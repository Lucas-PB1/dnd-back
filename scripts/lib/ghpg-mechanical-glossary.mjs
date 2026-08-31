/**
 * Glossário mecânico EN → PHB 2024 PT para texto extraído do D&D Beyond.
 */
import { toMetricProse } from './metric-prose.mjs';
import { applyGhpgProsePatterns } from './ghpg-prose-patterns.mjs';

const REPLACEMENTS = [
  ['Ability Score Improvement', 'Aprimoramento de Atributo'],
  ['Temporary Hit Points', 'Pontos de Vida Temporários'],
  ['Hit Point maximum', 'máximo de Pontos de Vida'],
  ['Hit Points', 'Pontos de Vida'],
  ['Proficiency Bonus', 'Bônus de Proficiência'],
  ['Bonus Action', 'Ação Bônus'],
  ['Free Action', 'Ação Livre'],
  ['Unarmed Strike', 'Ataque Desarmado'],
  ['Unarmed Strikes', 'Ataques Desarmados'],
  ['Critical Hit', 'Acerto Crítico'],
  ['Critical Hits', 'Acertos Críticos'],
  ['Long Rest', 'Descanso Longo'],
  ['Short Rest', 'Descanso Curto'],
  ['Fighting Style', 'Estilo de Luta'],
  ['Weapon Mastery', 'Maestria em Armas'],
  ['Spellcasting Focus', 'Foco de Conjuração'],
  ['Spell Slots', 'Espaços de Magia'],
  ['spell slots', 'espaços de magia'],
  ['saving throw', 'salvaguarda'],
  ['saving throws', 'salvaguardas'],
  ['Saving Throw', 'Salvaguarda'],
  ['Saving Throws', 'Salvaguardas'],
  ['attack roll', 'jogada de ataque'],
  ['attack rolls', 'jogadas de ataque'],
  ['damage roll', 'jogada de dano'],
  ['damage rolls', 'jogadas de dano'],
  ['Disadvantage', 'Desvantagem'],
  ['Advantage', 'Vantagem'],
  ['Incapacitated', 'Incapacitado'],
  ['Incapacitated condition', 'condição Incapacitado'],
  ['Prone condition', 'condição Caído'],
  ['Prone', 'Caído'],
  ['Reaction', 'Reação'],
  ['Action', 'Ação'],
  ['Attack action', 'ação Atacar'],
  ['Attack Action', 'Ação Atacar'],
  ['Disengage', 'Desengajar'],
  ['Help action', 'ação Ajudar'],
  ['Help Action', 'Ação Ajudar'],
  ['Resistance', 'Resistência'],
  ['Immune', 'Imune'],
  ['Immunity', 'Imunidade'],
  ['Concentration', 'Concentração'],
  ['Ritual', 'Ritual'],
  ['Emanation', 'Emanação'],
  ['Friendly', 'Aliado'],
  ['Hostile', 'Hostil'],
  ['Humanoids', 'Humanoides'],
  ['Humanoid', 'Humanoide'],
  ['Monster Grimoire', 'Grimório de Monstros'],
  ['Monster Hunters', 'Caçadores de Monstros'],
  ['Monster Hunter', 'Caçador de Monstros'],
  ['Bloodied', 'Ferido'],
  ['Hit Point Die', 'Dado de Vida'],
  ['Hit Point Dice', 'Dados de Vida'],
  ['Hit Dice', 'Dados de Vida'],
  ['Sangromancy', 'Sangromancia'],
  ['Sangromancy Die', 'Dado de Sangromancia'],
  ['Sangromancy Dice', 'Dados de Sangromancia'],
  ['spell slot', 'espaço de magia'],
  ['Wizard level', 'nível de Mago'],
  ['Wizard spell', 'magia de Mago'],
  ['Wizard spells', 'magias de Mago'],
  ['spellbook', 'grimório'],
  ['Melee weapon', 'arma corpo a corpo'],
  ['Melee weapons', 'armas corpo a corpo'],
  ['Ranged weapon', 'arma à distância'],
  ['Studied Response', 'Resposta Estudada'],
  ['Intelligence modifier', 'modificador de Inteligência'],
  ['Strength modifier', 'modificador de Força'],
  ['Dexterity modifier', 'modificador de Destreza'],
  ['Constitution modifier', 'modificador de Constituição'],
  ['Wisdom modifier', 'modificador de Sabedoria'],
  ['Charisma modifier', 'modificador de Carisma'],
  ['Intelligence', 'Inteligência'],
  ['Strength', 'Força'],
  ['Dexterity', 'Destreza'],
  ['Constitution', 'Constituição'],
  ['Wisdom', 'Sabedoria'],
  ['Charisma', 'Carisma'],
  ['Force damage', 'dano de Força'],
  ['Psychic damage', 'dano Psíquico'],
  ['Necrotic damage', 'dano Necrótico'],
  ['Radiant damage', 'dano Radiante'],
  ['Cold damage', 'dano Gélido'],
  ['Fire damage', 'dano de Fogo'],
  ['Poison damage', 'dano de Veneno'],
  ['Acid damage', 'dano Ácido'],
  ['Lightning damage', 'dano de Relâmpago'],
  ['Thunder damage', 'dano Trovejante'],
  ['Bludgeoning', 'Contundente'],
  ['Piercing', 'Perfurante'],
  ['Slashing', 'Cortante'],
  ['Cantrips', 'Truques'],
  ['cantrips', 'truques'],
  ['Epic Boon', 'Dádiva Épica'],
  ['Extra Attack', 'Ataque Extra'],
  ['Hunting Guild', 'Guilda de Caça'],
  ['Arcane Focus', 'Foco Arcano'],
  ['Simple and Martial weapons', 'armas simples e marciais'],
  ['Simple weapons', 'armas simples'],
  ['Martial weapons', 'armas marciais'],
  ['Light and Medium armor', 'armadura leve e média'],
  ['Heavy armor', 'armadura pesada'],
  ["Alchemist's Supplies", 'Suprimentos de Alquimista'],
  ["Cook's Utensils", 'Utensílios de Cozinheiro'],
  ["Artisan's Tools", 'Ferramentas de Artesão'],
  ['Utilize action', 'ação Utilizar'],
  ['Utilize Action', 'Ação Utilizar'],
  ['Magic action', 'ação Mágica'],
  ['Magic Action', 'Ação Mágica'],
  ['Opportunity Attack', 'Ataque de Oportunidade'],
  ['Opportunity Attacks', 'Ataques de Oportunidade'],
  ['Death Saving Throws', 'Salvaguardas contra Morte'],
  ['Death Saving Throw', 'Salvaguarda contra Morte'],
  ['Exhaustion level', 'nível de Exaustão'],
  ['Exhaustion levels', 'níveis de Exaustão'],
  ['Poisoned condition', 'condição Envenenado'],
  ['Poisoned', 'Envenenado'],
  ['Grappled condition', 'condição Agarrado'],
  ['Grappled', 'Agarrado'],
  ['Frightened condition', 'condição Amedrontado'],
  ['Frightened', 'Amedrontado'],
  ['D20 Test', 'Teste D20'],
  ['Shields', 'Escudos'],
  ['Shield', 'Escudo'],
  ['Animal Handling', 'Adestrar Animais'],
  ['Performance', 'Atuação'],
  ['Athletics', 'Atletismo'],
  ['Stealth', 'Furtividade'],
  ['Medicine', 'Medicina'],
  ['History', 'História'],
  ['Survival', 'Sobrevivência'],
  ['Perception', 'Percepção'],
  ['Nature', 'Natureza'],
  ['Deception', 'Enganação'],
  ['Intimidation', 'Intimidação'],
  ['Persuasion', 'Persuasão'],
  ['Investigation', 'Investigação'],
  ['Insight', 'Intuição'],
  ['Arcana', 'Arcanismo'],
  ['Religion', 'Religião'],
];

export function applyGhpgGlossary(text) {
  if (!text) return text;
  let out = text;
  for (const [en, pt] of REPLACEMENTS) {
    out = out.replaceAll(en, pt);
  }
  return out
    .replace(/\ban attack roll\b/gi, 'uma jogada de ataque')
    .replace(/\ban jogada de ataque\b/gi, 'uma jogada de ataque')
    .replace(/\bGP\b/g, 'PO')
    .replace(/\bd20\b/g, 'd20')
    .replace(/\bDC\b/g, 'CD');
}

export function translateGhpgProse(text) {
  return toMetricProse(applyGhpgProsePatterns(applyGhpgGlossary(text)));
}

/** Prosa longa (subclasses/features) — múltiplas passadas glossário + padrões. */
export function translateGhpgBody(text) {
  if (!text) return text;
  let out = text;
  for (let i = 0; i < 2; i += 1) {
    out = translateGhpgProse(out);
  }
  return out;
}
