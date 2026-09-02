import type { SubclassCombatNoteEntry } from '../types';

/** Monge, paladino, ranger, ladino, feiticeiro, bruxo, mago. */
export const NOTES_BATCH_B: Record<string, SubclassCombatNoteEntry[]> = {
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
