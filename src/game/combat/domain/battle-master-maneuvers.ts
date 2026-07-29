/**
 * Manobras do Mestre da Batalha (PHB 2024) — efeitos numéricos / notas.
 */

export type BattleMasterManeuver = {
  slug: string;
  name: string;
  description: string;
  /** Quando o efeito se aplica. */
  timing: 'on_hit' | 'on_miss' | 'reaction' | 'bonus_action' | 'other';
  /** Se adiciona o dado ao dano do ataque. */
  addsToDamage: boolean;
  /** Se adiciona o dado à jogada de ataque (ex. Preciso). */
  addsToAttack: boolean;
};

export const BATTLE_MASTER_MANEUVERS: BattleMasterManeuver[] = [
  {
    slug: 'parry',
    name: 'Aparar',
    description:
      'Reação ao receber dano corpo a corpo: reduza o dano pelo Dado + FOR ou DES.',
    timing: 'reaction',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'menacing-attack',
    name: 'Ataque Ameaçador',
    description:
      'No acerto: +dado de dano; alvo faz salvaguarda de Sabedoria ou fica Amedrontado.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'sweeping-attack',
    name: 'Ataque de Varredura',
    description:
      'No acerto corpo a corpo: outra criatura a 1,5 m sofre dano igual ao dado.',
    timing: 'on_hit',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'lunging-attack',
    name: 'Ataque Estendido',
    description:
      'Ação Bônus: gaste o dado e Corra; se mover 1,5 m em linha reta antes do ataque, +dado no dano.',
    timing: 'bonus_action',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'distracting-attack',
    name: 'Ataque para Distrair',
    description:
      'No acerto: +dado de dano; próximo ataque de outro atacante tem Vantagem.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'precision-attack',
    name: 'Ataque Preciso',
    description: 'No erro: adicione o dado à jogada de ataque.',
    timing: 'on_miss',
    addsToDamage: false,
    addsToAttack: true,
  },
  {
    slug: 'trip-attack',
    name: 'Ataque Derrubador',
    description:
      'No acerto: +dado de dano; alvo Grande ou menor faz salvaguarda de Força ou fica Caído.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'pushing-attack',
    name: 'Ataque Empurrão',
    description:
      'No acerto: +dado de dano; alvo Grande ou menor faz salvaguarda de Força ou é empurrado 4,5 m.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'riposte',
    name: 'Repostagem',
    description:
      'Reação ao ser errado por ataque corpo a corpo: ataque com +dado no dano se acertar.',
    timing: 'reaction',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'rally',
    name: 'Reunir',
    description:
      'Ação Bônus: aliado ganha PV temporários iguais ao dado + modificador de Carisma.',
    timing: 'bonus_action',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'commanders-strike',
    name: 'Golpe do Comandante',
    description:
      'Ao atacar, abra mão de um ataque: aliado usa Reação para atacar com +dado no dano.',
    timing: 'other',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'maneuvering-attack',
    name: 'Ataque de Manobra',
    description:
      'No acerto: +dado de dano; aliado pode se mover metade do Deslocamento sem provocar AO.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'goading-attack',
    name: 'Ataque Provocador',
    description:
      'No acerto: +dado de dano; alvo faz salvaguarda de Sabedoria ou tem Desvantagem contra outros.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'feinting-attack',
    name: 'Ataque Fintado',
    description:
      'Ação Bônus: Vantagem no próximo ataque neste turno; +dado no dano se acertar.',
    timing: 'bonus_action',
    addsToDamage: true,
    addsToAttack: false,
  },
  {
    slug: 'evasive-footwork',
    name: 'Pés Escorregadios',
    description:
      'Ao se mover: +dado na CA até o fim do movimento.',
    timing: 'other',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'ambush',
    name: 'Emboscada',
    description: 'Ao fazer teste de Iniciativa ou Furtividade: +dado no teste.',
    timing: 'other',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'bait-and-switch',
    name: 'Isca e Troca',
    description:
      'Ao estar a 1,5 m de aliado voluntário: ambos se movem; você ou o aliado ganha +dado na CA.',
    timing: 'other',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'commanding-presence',
    name: 'Presença Comandante',
    description:
      'Ao falhar em Intimidação/Performance/Persuasão: +dado no teste.',
    timing: 'other',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'tactical-assessment',
    name: 'Avaliação Tática',
    description:
      'Ao falhar em História/Investigação/Insight: +dado no teste.',
    timing: 'other',
    addsToDamage: false,
    addsToAttack: false,
  },
  {
    slug: 'disarming-attack',
    name: 'Ataque Desarmador',
    description:
      'No acerto: +dado de dano; alvo faz salvaguarda de Força ou solta um objeto.',
    timing: 'on_hit',
    addsToDamage: true,
    addsToAttack: false,
  },
];

export function listBattleMasterManeuvers(): BattleMasterManeuver[] {
  return BATTLE_MASTER_MANEUVERS;
}

export function findBattleMasterManeuver(
  slug: string,
): BattleMasterManeuver | undefined {
  return BATTLE_MASTER_MANEUVERS.find((item) => item.slug === slug);
}

/** CD de manobra: 8 + PB + FOR ou DES (o maior). */
export function battleMasterSaveDc(input: {
  proficiencyBonus: number;
  strengthMod: number;
  dexterityMod: number;
}): number {
  return (
    8 +
    input.proficiencyBonus +
    Math.max(input.strengthMod, input.dexterityMod)
  );
}
