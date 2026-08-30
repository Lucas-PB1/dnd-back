/**
 * Nomes PT de features GH Cap. 2 (subclasse + classe MH).
 * Chave: nome EN exato do extract.
 */
import { translateGhpgProse } from './ghpg-mechanical-glossary.mjs';

/** Mapa editorial (prioridade sobre heurísticas). */
export const FEATURE_NAME_PT = {
  'Sangromancy Savant': 'Especialista em Sangromancia',
  'Full-Blooded': 'Sangue Pleno',
  'Sanguine Vigor': 'Vigor Sanguíneo',
  'Blood for Blood': 'Sangue por Sangue',
  'Red Renewal': 'Renovação Rubra',
  'Close Quarters': 'Corpo a Corpo',
  'True Grit': 'Determinação Inabalável',
  'Terrorize the Terrors': 'Aterrorizar os Terrores',
  'Controlled Footwork': 'Passos Controlados',
  'Transmuting Metabolism': 'Metabolismo Transmutador',
  'Consume Portion': 'Consumir Porção',
  'Harvest Portion': 'Colher Porção',
  'Arcane Response': 'Resposta Arcana',
  'Agile Response': 'Resposta Ágil',
  'Trapper Gadgets': 'Gadgets de Armadilheiro',
  'Elemental Arrows': 'Flechas Elementais',
  'Monster-Hide Armor': 'Armadura de Pele de Monstro',
  'Spellcasting': 'Conjuração',
  'Equipped for Battle': 'Preparado para a Batalha',
  'Deadly Redirect': 'Redirecionamento Mortal',
};

const SPELL_LIST_SUFFIX = / (?:Domain |Guild )?Spells$/;

/** Palavras comuns em títulos de features GH → PT. */
const TITLE_WORD_PT = {
  Acolyte: 'Acólito',
  Acquired: 'Adquirido',
  Aggressive: 'Agressiva',
  Aid: 'Auxílio',
  Alchemical: 'Alquímica',
  Antagonistic: 'Antagônica',
  Apex: 'Ápice',
  Apocalyptic: 'Apocalíptica',
  Arcane: 'Arcana',
  Assertive: 'Assertivo',
  Aura: 'Aura',
  Bad: 'Má',
  Bear: 'Testemunhar',
  Beat: 'Espancar',
  Become: 'Tornar-se',
  Better: 'Melhor',
  Blood: 'Sangue',
  Bloodied: 'Ferido',
  Bloodstitch: 'Costura Sangrenta',
  Bloodthirst: 'Sede de Sangue',
  Bloody: 'Sanguinário',
  Borrowed: 'Emprestadas',
  Brains: 'Cérebro',
  Brawn: 'Músculo',
  Breathe: 'Respirar',
  Bruised: 'Machucado',
  Catastrophic: 'Catastrófico',
  Chilling: 'Gélida',
  Circle: 'Círculo',
  Cleanse: 'Purificar',
  Compel: 'Compelir',
  Compound: 'Composto',
  Creature: 'Criatura',
  Cruel: 'Cruel',
  Crushing: 'Esmagadora',
  Cunning: 'Astúcia',
  Brutal: 'Brutalidade',
  Curse: 'Maldição',
  Dark: 'Sombria',
  Deadly: 'Mortal',
  Death: 'Morte',
  Deathly: 'Mortífero',
  Debilitating: 'Debilitante',
  Desperado: 'Desesperado',
  Disgusting: 'Nojenta',
  Drain: 'Drenar',
  Dual: 'Dupla',
  Egotistical: 'Egotista',
  Eldritch: 'Eldritch',
  Endless: 'Infinita',
  Entropic: 'Entrópica',
  Envenomed: 'Envenenado',
  Equipped: 'Preparado',
  Eternal: 'Eterna',
  Ever: 'Sempre',
  Evil: 'Maligno',
  Exsanguinate: 'Exsanguinar',
  Face: 'Face',
  Fair: 'Justo',
  Foul: 'Torpe',
  Filth: 'Imundície',
  Fortitude: 'Fortitude',
  Final: 'Final',
  Follow: 'Seguir',
  Forbidden: 'Proibida',
  Frenzied: 'Frenético',
  Gallows: 'Forca',
  Gnawing: 'Roedora',
  Good: 'Boa',
  Hag: 'Bruxa',
  Hair: 'Gatilho',
  Trigger: 'Instantâneo',
  Halt: 'Interromper',
  Herbal: 'Herbal',
  Horse: 'Cavalo',
  Lord: 'Senhor',
  Improved: 'Aprimorado',
  Improvisational: 'Improvisacional',
  Infectious: 'Infecciosa',
  Irrational: 'Irracional',
  Kin: 'Parentesco',
  Larval: 'Larval',
  Last: 'Última',
  Living: 'Vivo',
  Mage: 'Mago',
  Hunter: 'Caçador',
  Magical: 'Mágico',
  Aegis: 'Égide',
  Many: 'Muitos',
  Mark: 'Marca',
  Mask: 'Máscara',
  Medicinal: 'Medicinal',
  Misfortunist: 'Azarento',
  Mutate: 'Mutar',
  Night: 'Noturno',
  Nocturnal: 'Noturno',
  Occult: 'Oculto',
  Otherworldly: 'Sobrenatural',
  Pain: 'Dor',
  Party: 'Festa',
  Phantom: 'Fantasma',
  Physical: 'Físico',
  Specimen: 'Espécime',
  Plaguebringer: 'Portador da Peste',
  Pluck: 'Arrancar',
  Poison: 'Veneno',
  Potion: 'Poção',
  Powered: 'Alimentado',
  Primal: 'Primordial',
  Primordial: 'Primordial',
  Prophecy: 'Profecia',
  Protective: 'Protetora',
  Psionic: 'Psiônica',
  Psychic: 'Psíquica',
  Rage: 'Fúria',
  Rapid: 'Rápida',
  Rebuke: 'Repreender',
  Redoubled: 'Redobrados',
  Relive: 'Reviver',
  Ride: 'Cavalgar',
  Rite: 'Rito',
  Ruin: 'Ruína',
  Sear: 'Cauterizar',
  Shade: 'Sombra',
  Shake: 'Sacudir',
  Shape: 'Forma',
  Share: 'Compartilhar',
  Shared: 'Compartilhada',
  Sing: 'Cantar',
  Sixth: 'Sexto',
  Sense: 'Sentido',
  Size: 'Avaliar',
  Skilled: 'Hábil',
  Skinrider: 'Montaria de Pele',
  Sneaky: 'Furtiva',
  Crafty: 'Astuta',
  Spawn: 'Gerar',
  Spell: 'Magia',
  Siphon: 'Sifão',
  Steal: 'Roubar',
  Stir: 'Agitar',
  Stolen: 'Roubado',
  Student: 'Estudante',
  Subtle: 'Sutil',
  Supernal: 'Supernal',
  Safeguard: 'Salvaguarda',
  Swarming: 'Enxame',
  Symbiotic: 'Simbiótico',
  Sentinel: 'Sentinela',
  Synchronized: 'Sincronizada',
  Talented: 'Talentoso',
  Tall: 'Altas',
  Tales: 'Histórias',
  Terrifying: 'Aterrorizante',
  Threatening: 'Ameaçadora',
  Toxic: 'Tóxica',
  Tradecraft: 'Ofício',
  Toxin: 'Toxina',
  Transmutation: 'Transmutação',
  Trusty: 'Fiel',
  Unclean: 'Imunda',
  Unearthly: 'Sobrenatural',
  Unhinged: 'Desequilibradas',
  Unnatural: 'Antinatural',
  Unnerving: 'Inquietante',
  Unsubtle: 'Descarado',
  Variegated: 'Variadas',
  Vexations: 'Vexações',
  Vengeful: 'Vingativa',
  Verminkin: 'Verminata',
  Ward: 'Proteção',
  Weather: 'Resistir',
  Weave: 'Tece',
  Well: 'Bem',
  Rounded: 'Preparado',
  Witch: 'Bruxa',
  Witching: 'Feiticeiras',
  Wretched: 'Miserável',
  Attack: 'Ataque',
  Defense: 'Defesa',
  Taste: 'Paladar',
  Antics: 'Travessuras',
  Revelation: 'Revelação',
  Apocrypha: 'Apócrifa',
  Interference: 'Interferência',
  Attacker: 'Atacante',
  Clarity: 'Clareza',
  Rampant: 'Desenfreada',
  Sickness: 'Doença',
  Luck: 'Sorte',
  Charm: 'Amuleto',
  Medicine: 'Medicina',
  Witness: 'Testemunhar',
  Down: 'Derrubar',
  Door: 'Porta',
  Pallor: 'Palidez',
  Fever: 'Febre',
  Resilience: 'Resiliência',
  Life: 'Vida',
  Doom: 'Perdição',
  Redirect: 'Redirecionar',
  Eruption: 'Erupção',
  Prideful: 'Orgulhoso',
  Vigilant: 'Vigilante',
  Eye: 'Olho',
  Guilt: 'Culpa',
  Power: 'Poder',
  Melody: 'Melodia',
  Forms: 'Formas',
  Fire: 'Fogo',
  Confession: 'Confissão',
  Creator: 'Criador',
  Night: 'Noite',
  Jest: 'Gracejo',
  Hunger: 'Fome',
  Craft: 'Ofício',
  Visage: 'Semblante',
  Guile: 'Astúcia',
  Assault: 'Ataque',
  Lore: 'Conhecimento',
  Wind: 'Vento',
  Talent: 'Talento',
  Spread: 'Propagação',
  Retaliation: 'Retaliação',
  Beasts: 'Feras',
  Regeneration: 'Regeneração',
  Laugh: 'Risada',
  Catalyst: 'Catalisador',
  Cauldron: 'Caldeirão',
  Master: 'Mestre',
  Roads: 'Caminhos',
  Ruin: 'Ruína',
  Heretic: 'Herege',
  Civility: 'Civilidade',
  Pathos: 'Pathos',
  Companion: 'Companheiro',
  Possession: 'Possessão',
  Heartstrings: 'Corações',
  Control: 'Controle',
  Pawn: 'Peão',
  Secrets: 'Segredos',
  Alchemy: 'Alquimia',
  Hand: 'Mão',
  Strikes: 'Golpes',
  Response: 'Resposta',
  Adventurer: 'Aventureiro',
  Arrows: 'Flechas',
  Battle: 'Batalha',
  Blades: 'Lâminas',
  Boon: 'Dádiva',
  Burden: 'Fardo',
  Catharsis: 'Catarse',
  Decoctions: 'Decocções',
  Gastronomy: 'Gastronomia',
  Evolution: 'Evolução',
  Infection: 'Infecção',
  Knight: 'Cavaleiro',
  Lust: 'Luxúria',
  Mount: 'Montaria',
  Planner: 'Organizador',
  Predator: 'Predador',
  Presence: 'Presença',
  Slaughter: 'Massacre',
  Strike: 'Golpe',
  Summons: 'Invocação',
  Taunt: 'Provocação',
  Tinkerer: 'Engenheiro',
  Ties: 'Laços',
  Tongues: 'Línguas',
  Hides: 'Peles',
  Transmutation: 'Transmutação',
  Transmuting: 'Transmutador',
  Vigor: 'Vigor',
  War: 'Guerra',
  World: 'Mundo',
  Storm: 'Tempestade',
  Corruption: 'Corrupção',
  Elements: 'Elementos',
  Exit: 'Saída',
  Given: 'Negado',
  Not: 'Não',
  Traveled: 'Percorrida',
  Nigh: 'Próximo',
  End: 'Fim',
  Earth: 'Terra',
  Wild: 'Selvagem',
  Bones: 'Ossos',
  Imperfections: 'Imperfeições',
  Regret: 'Arrependimento',
  Through: 'Através',
  Them: 'Eles',
  It: 'Isso',
  In: 'Em',
  With: 'Com',
  The: '',
  Of: 'de',
  For: 'para',
  And: 'e',
  A: '',
  An: '',
  To: 'a',
  Against: 'Contra',
  Is: 'É',
  But: 'Mas',
  Road: 'Estrada',
};

const SKIP_WORDS = new Set(['', 'de', 'e', 'a', 'para', 'com', 'em', 'o', 'os', 'a', 'as']);

function translateTitleWord(word) {
  if (!word) return '';
  const titled =
    word === word.toUpperCase()
      ? word.charAt(0) + word.slice(1).toLowerCase()
      : word.charAt(0).toUpperCase() + word.slice(1);
  if (TITLE_WORD_PT[word]) return TITLE_WORD_PT[word];
  if (TITLE_WORD_PT[titled]) return TITLE_WORD_PT[titled];
  const possessive = word.match(/^([A-Za-z]+)'s$/i);
  if (possessive) {
    const base =
      TITLE_WORD_PT[possessive[1]] ??
      TITLE_WORD_PT[possessive[1].charAt(0).toUpperCase() + possessive[1].slice(1).toLowerCase()] ??
      possessive[1];
    return base;
  }
  return word;
}

function translateTitleHeuristic(en) {
  const parts = en.split(/(\s+|-|—)/);
  const out = [];
  for (const part of parts) {
    if (/^\s+$/.test(part) || part === '-' || part === '—') {
      out.push(part.trim() ? ' ' : part);
      continue;
    }
    const word = part.trim();
    if (!word) continue;
    const pieces = word.split(/(?=[A-Z])/).filter(Boolean);
    if (pieces.length > 1 && word === pieces.join('')) {
      out.push(pieces.map((p) => translateTitleWord(p)).filter(Boolean).join(' '));
      continue;
    }
    out.push(translateTitleWord(word));
  }
  return out
    .join('')
    .replace(/\s+/g, ' ')
    .replace(/\s+de\s+de/g, ' de ')
    .replace(/^\s+de\s+/i, '')
    .trim();
}

function translateSpellListName(en) {
  const base = en.replace(SPELL_LIST_SUFFIX, '');
  if (base.startsWith('Oath of ')) {
    return `Magias do Juramento de ${translateGhpgProse(base.slice(8))}`;
  }
  if (base.startsWith('Circle of ')) {
    return `Magias do Círculo de ${translateGhpgProse(base.slice(10))}`;
  }
  if (base.endsWith(' Domain')) {
    return `Magias do ${translateGhpgProse(base)}`;
  }
  if (base.endsWith(' Spells')) {
    return `Magias de ${translateGhpgProse(base.replace(/ Spells$/, ''))}`;
  }
  return `Magias — ${translateGhpgProse(base)}`;
}

/** Traduz título de feature EN → PT (editorial + glossário). */
export function translateFeatureName(en) {
  if (!en) return en;
  if (FEATURE_NAME_PT[en]) return FEATURE_NAME_PT[en];
  if (SPELL_LIST_SUFFIX.test(en)) return translateSpellListName(en);
  if (en.startsWith('Oath of ')) return `Juramento de ${translateGhpgProse(en.slice(8))}`;
  if (en.startsWith('Circle of ')) return `Círculo de ${translateGhpgProse(en.slice(10))}`;
  if (en.startsWith('Path of the ')) return `Caminho ${translateGhpgProse(en.slice(10))}`;
  if (en.startsWith('College of ')) return `Colégio dos ${translateGhpgProse(en.slice(11))}`;
  if (en.startsWith('Warrior of ')) return `Guerreiro ${translateGhpgProse(en.slice(11))}`;
  const heuristic = translateTitleHeuristic(en);
  if (heuristic && heuristic !== en) return heuristic;
  return translateGhpgProse(en);
}
