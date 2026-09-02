/** Notas de passivas GH Cap. 2 — fonte para `./grim-hollow-subclass-combat-notes.ts`. */
export type SubclassCombatNoteEntry = { minLevel: number; text: string };

export const GH_SUBCLASS_COMBAT_NOTES: Record<string, SubclassCombatNoteEntry[]> =
  {
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
    'warriorofthe-leaden-crown': [
      {
        minLevel: 3,
        text: 'Mão Sutil: alcance desarmado +1,5 m; pode causar dano psíquico no lugar do tipo normal.',
      },
    ],
    'warriorof-pride': [
      {
        minLevel: 3,
        text: 'Ferido de Orgulho: considerado Ferido enquanto PV atual < PV máximo.',
      },
    ],
    'warriorof-regret': [
      {
        minLevel: 6,
        text: 'Transe da Morte: a 0 PV, pode gastar 1 Ponto de Foco — imune a Inconsciente; falha crítica de morte conta como 1.',
      },
    ],
    'oathof-pestilence': [
      {
        minLevel: 20,
        text: 'Portador da Peste (forma): imune a veneno/Envenenado; resistência necrótica; PV máx. não pode ser reduzido.',
      },
    ],
    'oathof-slaughter': [
      {
        minLevel: 3,
        text: 'Massacre Frenético: com frenesi ativo — vantagem em salv. contra Enfeitiçado, Amedrontado e Atordoado.',
      },
    ],
    'oathof-zeal': [
      {
        minLevel: 7,
        text: 'Aura de Clareza: você e aliados imunes a Cegueira na Aura de Proteção.',
      },
    ],
    'green-reaper': [
      {
        minLevel: 7,
        text: 'Controle de Veneno: resistência a veneno; vantagem em salvaguardas contra Envenenado.',
      },
    ],
    'primordial-archer': [
      {
        minLevel: 7,
        text: 'Tece os Elementos: resistência a ácido, frio, fogo, relâmpago ou trovão (escolha até descanso longo).',
      },
    ],
    'vermin-lord': [
      {
        minLevel: 7,
        text: 'Sujeira e Fortitude: imune a Envenenado; resistência a dano de veneno.',
      },
    ],
    'highway-rider': [
      {
        minLevel: 3,
        text: 'Gatilho Rápido: vantagem em Iniciativa; Reação para atirar antes de agir no combate.',
      },
    ],
    'misfortune-bringer': [
      {
        minLevel: 3,
        text: 'Olho Maligno: com alvo amaldiçoado, Ataque Furtivo mesmo sem vantagem (se não tiver desvantagem).',
      },
    ],
    'sanguine-thief': [
      {
        minLevel: 3,
        text: 'Conjuração: magias de mago + Sangromancia (lista preparada; INT). Dados de Sangromancia (Poder Roubado) no lugar de DV em magias de sangue.',
      },
      {
        minLevel: 3,
        text: 'Roubar Sangue: Ataque Furtivo pode restaurar 1 Dado de Sangromancia; se Ferido, recupera 1 Dado de Vida.',
      },
    ],
    'apocalypse-sorcery': [
      {
        minLevel: 6,
        text: 'Testemunhar o Fim: com Feitiçaria Inata ativa — resistência a força; imune a Amedrontado.',
      },
    ],
    'haunted-sorcery': [
      {
        minLevel: 6,
        text: 'Palidez Mortífera: resistência a dano necrótico; magias de feiticeiro podem causar necrótico.',
      },
    ],
    'wretched-bloodline-sorcery': [
      {
        minLevel: 3,
        text: 'Maldição Herdada (escolha): Colossal +1 PV/nível; Noturno visão 36 m no escuro; Flagelo — penalidades sociais variadas.',
      },
    ],
    'the-coven': [
      {
        minLevel: 6,
        text: 'Visagem Horripilante: máscara de medo — criaturas com desvantagem na salv. se puderem ver você.',
      },
    ],
    'the-first-vampire-patron': [
      {
        minLevel: 3,
        text: 'Predador Noturno: visão no escuro 18 m (+18 m se já tiver).',
      },
      {
        minLevel: 14,
        text: 'Noite Eterna: resistência a dano necrótico; não envelhece.',
      },
    ],
    'the-parasite-patron': [
      {
        minLevel: 3,
        text: 'Forma Aprimorada (1×/DL): pode escolher +PV máx. = nível de Bruxo, visão no escuro, velocidade, etc.',
      },
    ],
    daemonologist: [
      {
        minLevel: 10,
        text: 'Sifão Aprimorado: com sifão de Arquidaemons — resistência necrótica; com Arqueanjo — resistência radiante.',
      },
    ],
    'plague-doctor': [
      {
        minLevel: 10,
        text: 'Inale Isso: imune a Envenenado; após dano necrótico ou de veneno, ganha PV temporários = dano recebido.',
      },
    ],
    sangromancer: [
      {
        minLevel: 6,
        text: 'Vigor Sanguíneo: +PV máx. por nível (ver PV na ficha); ao conjurar sangromancia com espaço, recupera PV = nível do espaço.',
      },
    ],
  };

export const GH_CLASS_COMBAT_NOTES: Record<
  string,
  SubclassCombatNoteEntry[]
> = {
  'monster-hunter': [
    {
      minLevel: 9,
      text: 'Defesa Erudita: em salvaguardas forçadas por tipos do Grimório, pode usar salvaguarda de Inteligência.',
    },
    {
      minLevel: 14,
      text: 'Senso do Covil: vantagem e resistência a ações de covil/região e Ações Lendárias de tipos no Grimório.',
    },
  ],
};
