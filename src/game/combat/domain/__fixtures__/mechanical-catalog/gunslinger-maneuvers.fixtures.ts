import type { ManeuverEffectKind, GunslingerManeuver } from '../../gunslinger/maneuvers';

export const FIXTURE_GUNSLINGER_MANEUVERS: readonly GunslingerManeuver[] = [
  {
    slug: 'bite-the-bullet',
    name: 'Morda a Bala',
    description:
      'Como Ação Bônus, gaste um Dado de Risco para ganhar PV Temporários iguais ao resultado do dado mais seu nível de Pistoleiro.',
    effectKind: 'temp_hp' satisfies ManeuverEffectKind,
    riskCost: 1,
    fromLevel: 2,
  },
  {
    slug: 'blindfire',
    name: 'Fogo cego',
    description:
      'Ação Bônus: gaste um Dado de Risco para ganhar Visão Cega de 9 m até o fim do turno.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 2,
  },
  {
    slug: 'evasive-roll',
    name: 'Rolamento Evasivo',
    description:
      'Ação Bônus: gaste um Dado de Risco para se mover até 4,5 m (sem OA / terreno difícil) e recarregar qualquer arma à distância que estiver segurando.',
    effectKind: 'reload_move',
    riskCost: 1,
    fromLevel: 2,
  },
  {
    slug: 'grazing-shot',
    name: 'Tiro Rasante',
    description:
      'Quando erra um ataque à distância com arma, gaste um Dado de Risco (sem ação) para causar dano igual ao dado + modificador de Destreza (mín. 1). 1×/turno.',
    effectKind: 'miss_damage',
    riskCost: 1,
    fromLevel: 2,
  },
  {
    slug: 'independent-spirit',
    name: 'Espírito Independente',
    description:
      'Quando falha em teste ou salvaguarda de INT/SAB/CAR, gaste um Dado de Risco para somá-lo ao teste. 1×/turno.',
    effectKind: 'ability_check_bonus',
    riskCost: 1,
    fromLevel: 2,
  },
  {
    slug: 'close-shave',
    name: 'Por um Triz',
    description:
      'Reação: quando um ataque o acerta, gaste um Dado de Risco e some o resultado à CA contra aquele ataque.',
    effectKind: 'ac_bonus',
    riskCost: 1,
    fromLevel: 2,
  },
  {
    slug: 'fan-the-hammer',
    name: 'Abrir o Leque',
    description:
      'Ação Bônus (Pistolero): ao Atacar com arma à distância sem Duas mãos, gaste 1 Dado de Risco para dois ataques extras com Desvantagem (mão livre; sem Automática).',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 3,
    subclassSlug: 'pistolero',
  },
  {
    slug: 'showdown',
    name: 'Confronto',
    description:
      'Na Iniciativa (Pistolero): gaste 1 Dado de Risco, saque uma arma à distância e ataque; some o dado ao dano. No 1º turno, o alvo tem Desvantagem em ataques contra outros.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 10,
    subclassSlug: 'pistolero',
  },
  {
    slug: 'eagle-eye',
    name: 'Olho de Águia',
    description:
      '1×/turno (Olho Morto): ao errar ataque à distância, gaste 1 Dado de Risco e some-o à jogada de ataque (pode virar acerto).',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 3,
    subclassSlug: 'deadeye',
  },
  {
    slug: 'liars-dice',
    name: 'Dados do Mentiroso',
    description:
      'Ação Bônus (Grande Apostador): ao causar dano com arma de longo alcance, gaste 1 Dado de Risco e declare o total em segredo.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 3,
    subclassSlug: 'high-roller',
  },
  {
    slug: 'parting-shot',
    name: 'Tiro de despedida',
    description:
      'Ao Correr, Desengajar ou Esquivar (Agente Secreto): gaste 1 Dado de Risco para um ataque à distância como Ação Bônus.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 3,
    subclassSlug: 'secret-agent',
  },
  {
    slug: 'magic-bullet',
    name: 'Bala Mágica',
    description:
      'Ação Bônus (Pistoleiro Arcano): substitua ataque mágico por ataque à distância com arma + Dado de Risco.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 14,
    subclassSlug: 'spellslinger',
  },
  {
    slug: 'ricochet',
    name: 'Ricochete',
    description:
      'Ação Bônus (Tiro de Trucagem): ao errar, gaste 1 Dado de Risco e rerrole o ataque somando o dado.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 3,
    subclassSlug: 'trick-shot',
  },
  {
    slug: 'skilled-deflection',
    name: 'Deflexão Hábil',
    description:
      'Reação (Tiro de Trucagem): conceda Por um Triz a um aliado a até 9 m.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 10,
    subclassSlug: 'trick-shot',
  },
  {
    slug: 'lay-down-the-law',
    name: 'Estabeleça a Lei',
    description:
      'Ação Bônus (Chapéu Branco): PV Temp. a aliado + Reação de tiro se ele for atingido.',
    effectKind: 'descriptive',
    riskCost: 1,
    fromLevel: 3,
    subclassSlug: 'white-hat',
  },
];
