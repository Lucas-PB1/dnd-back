import type { SubclassCombatNoteEntry } from '../types';

/** Guildas MH, bárbaro, bardo, clérigo, druida, guerreiro. */
export const NOTES_BATCH_A: Record<string, SubclassCombatNoteEntry[]> = {
  'carver-guild': [
    {
      minLevel: 7,
      text: 'Couro de Monstro: armadura leve/média com 2 modificações; resistência a 2 tipos (ácido, frio, fogo, relâmpago, veneno ou trovão).',
    },
  ],
  'devourer-guild': [
    {
      minLevel: 10,
      text: 'Fome Roedora: ao causar dano corpo a corpo, PV temporários = metade do dano (total vs tipos do Grimório).',
    },
  ],
  'occultist-guild': [
    {
      minLevel: 3,
      text: 'Interferência Arcana: vantagem em salvaguardas contra magias de tipos no Grimório de Monstros.',
    },
  ],
  'trapper-guild': [
    {
      minLevel: 7,
      text: 'Vantagem do Emboscador: +INT na Iniciativa; não pode ser surpreendido por tipos no Grimório.',
    },
  ],
  'pathofthe-fractured': [
    {
      minLevel: 6,
      text: 'Cérebro e Músculo: sem Fúria — resistência psíquica; com Fúria — resistência a todos os tipos exceto força e psíquico.',
    },
  ],
  'pathofthe-primal-spirit': [
    {
      minLevel: 3,
      text: 'Fúria Compartilhada: com Fúria ativa, companheiro primal tem resistência a concussão, perfuração e corte.',
    },
  ],
  'pathofthe-wrathful-dead': [
    {
      minLevel: 3,
      text: 'Fúria dos Mortos: com Fúria — +3 m deslocamento, visão espectral 36 m, atravessa terreno difícil e espaços ocupados.',
    },
    {
      minLevel: 10,
      text: 'Morte é mas uma Porta: vantagem em salvaguardas contra morte; falha em 4 salvaguardas para morrer.',
    },
  ],
  'collegeof-adventurers': [
    {
      minLevel: 3,
      text: 'Talento de Aventureiro: escolha talentos de aventureiro (L3/6/14) — ver descrição da subclasse.',
    },
  ],
  'collegeof-fools': [
    {
      minLevel: 14,
      text: 'Última Risada: Reação quando Ferido — resistência a todo dano por 1 min (1×/DL).',
    },
  ],
  'collegeof-requiems': [
    {
      minLevel: 3,
      text: 'Puxar Cordas da Vida: Inspiração Bárdica pode evitar 0 PV ou adicionar dano necrótico no ataque.',
    },
  ],
  'eldritch-domain': [
    {
      minLevel: 6,
      text: 'Calma Sobrenatural: resistência a dano psíquico; vantagem para evitar/encerrar Enfeitiçado e Amedrontado.',
    },
  ],
  'inquisition-domain': [
    {
      minLevel: 3,
      text: 'Golpe do Caçador de Bruxas: +1d8 de força vs Aberrações, Celestiais, Demônios, Dragões ou Mortos-vivos.',
    },
  ],
  'purification-domain': [
    {
      minLevel: 3,
      text: 'Marca Impura: vantagem em salvaguardas contra doenças e efeitos que alteram forma (ex.: Polimorfia).',
    },
  ],
  'circleof-blood': [
    {
      minLevel: 10,
      text: 'Com Lua de Sangue ativa: resistência a dano de concussão, perfuração e corte.',
    },
  ],
  'circleof-entropy': [
    {
      minLevel: 3,
      text: 'Ruína Incarnate: CA base 17 + Sab (mín. +1) se sua CA for menor; 2 ataques na ação Atacar.',
    },
    {
      minLevel: 6,
      text: 'Com Ruína Incarnate ativa: dano elemental/necrótico nos acertos; +Sab em salv. FOR/DES.',
    },
  ],
  'circleof-mutation': [
    {
      minLevel: 10,
      text: 'Mutações: tremorsense 9 m; resistência elemental (ácido/frio/fogo/relâmpago/veneno/trovão) via pontos de mutação.',
    },
  ],
  'bulwark-warrior': [
    {
      minLevel: 18,
      text: 'Interromper o Ataque: Reação — sofre o ataque no lugar de aliado a 1,5 m; resistência a todo o dano desse ataque.',
    },
  ],
  'living-crucible': [
    {
      minLevel: 15,
      text: 'Transmutação Tóxica: resistência a dano de veneno; Ação Bônus para encerrar Envenenado e ganhar PV temporários.',
    },
  ],
  nightwatcher: [
    {
      minLevel: 3,
      text: 'Sempre Vigilante: visão no escuro 18 m; vantagem em Iniciativa e testes de Percepção.',
    },
  ],
};
