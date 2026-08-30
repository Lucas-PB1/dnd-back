/**
 * Gera mapa nome EN (D&D Beyond) → slug phb_spell a partir de S014.
 * Uso: node scripts/lib/build-phb-spell-slug-map.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const apiRoot = path.join(path.dirname(fileURLToPath(import.meta.url)), '../..');
const sql = fs.readFileSync(
  path.join(apiRoot, 'database/seeds/phb/S014_phb_spell.sql'),
  'utf8',
);

/** PT name → slug */
const ptNameToSlug = new Map();
for (const m of sql.matchAll(/\('([^']+)',\s*'([^']+)'/g)) {
  ptNameToSlug.set(m[2], m[1]);
}

/** EN (Beyond) → PT (PHB 2024) — magias comuns em subclasses GH */
const EN_TO_PT = {
  Aid: 'Auxílio',
  'Animal Messenger': 'Mensageiro Animal',
  'Arcane Eye': 'Olho Arcano',
  Augury: 'Augúrio',
  'Aura of Purity': 'Aura de Pureza',
  Bane: 'Ruína',
  Banishment: 'Banimento',
  'Bestow Curse': 'Impor Maldição',
  Bless: 'Bênção',
  Blight: 'Pústula',
  'Blindness/Deafness': 'Cegueira/Surdez',
  'Call Lightning': 'Evocar Raio',
  'Chill Touch': 'Toque Arrepiante',
  Command: 'Mandar',
  'Comprehend Languages': 'Compreender Idiomas',
  Confusion: 'Confusão',
  'Contact Other Plane': 'Contato Extraplanar',
  Contagion: 'Contágio',
  Counterspell: 'Contramágica',
  Creation: 'Criação',
  'Death Ward': 'Proteção contra a Morte',
  'Destructive Wave': 'Onda Destrutiva',
  'Detect Evil and Good': 'Detectar o Bem e o Mal',
  'Detect Poison and Disease': 'Detectar Veneno e Doença',
  'Detect Thoughts': 'Detectar Pensamentos',
  'Dispel Magic': 'Dissipar Magia',
  Divination: 'Adivinhação',
  'Dominate Person': 'Dominar Pessoa',
  Dream: 'Sonho',
  'False Life': 'Vida Falsa',
  Fear: 'Medo',
  'Flame Blade': 'Lâmina Flamejante',
  'Flame Strike': 'Coluna de Chamas',
  Fly: 'Voar',
  'Fog Cloud': 'Nuvem de Névoa',
  'Freedom of Movement': 'Liberdade de Movimento',
  'Gaseous Form': 'Forma Gasosa',
  Geas: 'Geas',
  'Greater Invisibility': 'Invisibilidade Maior',
  'Greater Restoration': 'Restauração Maior',
  'Guardian of Faith': 'Guardião da Fé',
  Hallow: 'Santificar',
  'Hellish Rebuke': 'Revide Infernal',
  Hex: 'Maldição',
  'Hold Monster': 'Imobilizar Monstro',
  'Hold Person': 'Imobilizar Pessoa',
  "Hunter's Mark": 'Marca do Caçador',
  Identify: 'Identificar',
  'Inflict Wounds': 'Causar Ferimentos',
  'Insect Plague': 'Praga de Insetos',
  Invisibility: 'Invisibilidade',
  Knock: 'Abrir',
  'Locate Creature': 'Localizar Criatura',
  'Locate Object': 'Localizar Objeto',
  "Melf's Acid Arrow": 'Flecha Ácida de Melf',
  'Phantasmal Killer': 'Assassino Fantasmagórico',
  Polymorph: 'Metamorfose',
  'Ray of Enfeeblement': 'Raio de Enfraquecimento',
  'Ray of Sickness': 'Raio de Doença',
  'Remove Curse': 'Remover Maldição',
  Revivify: 'Reviver',
  Scrying: 'Vidência',
  'See Invisibility': 'Ver o Invisível',
  Seeming: 'Aparência',
  Shatter: 'Estilhaçar',
  Silence: 'Silêncio',
  Sleep: 'Sono',
  'Speak with Dead': 'Falar com os Mortos',
  'Stinking Cloud': 'Nuvem Fétida',
  'Tasha\'s Hideous Laughter': 'Riso Histérico de Tasha',
  Telekinesis: 'Telecinese',
  'Toll the Dead': 'Badalar os Mortos',
  Tongues: 'Línguas',
  'Unseen Servant': 'Servo Invisível',
  'Wall of Fire': 'Muralha de Fogo',
  'Wall of Stone': 'Muralha de Pedra',
  'Word of Radiance': 'Palavra de Radiância',
  'Burning Hands': 'Mãos Flamejantes',
  'Detect Magic': 'Detectar Magia',
  'Protection from Evil and Good': 'Proteção contra o Bem e o Mal',
};

const map = {};
for (const [en, pt] of Object.entries(EN_TO_PT)) {
  const slug = ptNameToSlug.get(pt);
  if (slug) map[en] = slug;
}

console.log(JSON.stringify(map, null, 2));
