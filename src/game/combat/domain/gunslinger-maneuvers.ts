/**
 * Manobras do Pistoleiro (Valdas) — catálogo de domínio.
 * Efeitos numéricos são aplicados pelo handler; narrativas só retornam o dado.
 */

export type ManeuverEffectKind =
  | 'temp_hp'
  | 'miss_damage'
  | 'ac_bonus'
  | 'ability_check_bonus'
  | 'descriptive'
  | 'reload_move';

export type GunslingerManeuver = {
  slug: string;
  name: string;
  description: string;
  effectKind: ManeuverEffectKind;
  riskCost: number;
  fromLevel: number;
  /** Subclasse que concede (omitido = classe base). */
  subclassSlug?: string;
};

export const GUNSLINGER_MANEUVERS: readonly GunslingerManeuver[] = [
  {
    slug: 'bite-the-bullet',
    name: 'Morda a Bala',
    description:
      'Como Ação Bônus, gaste um Dado de Risco para ganhar PV Temporários iguais ao resultado do dado mais seu nível de Pistoleiro.',
    effectKind: 'temp_hp',
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
];

export function listGunslingerManeuvers(input: {
  level: number;
  subclassSlug?: string | null;
}): GunslingerManeuver[] {
  return GUNSLINGER_MANEUVERS.filter((maneuver) => {
    if (input.level < maneuver.fromLevel) return false;
    if (maneuver.subclassSlug && maneuver.subclassSlug !== input.subclassSlug) {
      return false;
    }
    return true;
  });
}

export function findGunslingerManeuver(
  slug: string,
): GunslingerManeuver | undefined {
  return GUNSLINGER_MANEUVERS.find((maneuver) => maneuver.slug === slug);
}
