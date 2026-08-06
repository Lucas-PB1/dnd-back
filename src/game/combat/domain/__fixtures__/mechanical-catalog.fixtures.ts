import type { ManeuverEffectKind, GunslingerManeuver } from '../gunslinger/maneuvers';
import type { BattleMasterManeuver } from '../fighter/battle-master-maneuvers';
import type { CunningStrikeEffect } from '../rogue/types';
import type { SubclassTableAction } from '../catalog/subclass-table-action';
import type { PrecautionSpell } from '../fighter/dungeoneer-catalog';

/** Fixtures espelhando seeds `combat/C00*` — só para testes unitários (sem DB). */

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
];

export const FIXTURE_BATTLE_MASTER_MANEUVERS: readonly BattleMasterManeuver[] = [
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
    description: 'Ao se mover: +dado na CA até o fim do movimento.',
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
    description: 'Ao falhar em História/Investigação/Insight: +dado no teste.',
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

export const FIXTURE_CUNNING_STRIKE_EFFECTS: readonly CunningStrikeEffect[] = [
  {
    slug: 'poison',
    name: 'Envenenar',
    cost: 1,
    unlockLevel: 5,
    saveAbility: 'constitution',
    note: 'Requer Kit de Veneno; em falha, Envenenado por 1 minuto.',
  },
  {
    slug: 'withdraw',
    name: 'Retirada',
    cost: 1,
    unlockLevel: 5,
    note: 'Mova-se até metade do Deslocamento sem provocar Ataques de Oportunidade.',
  },
  {
    slug: 'trip',
    name: 'Tropeço',
    cost: 1,
    unlockLevel: 5,
    saveAbility: 'dexterity',
    note: 'Alvo Grande ou menor fica Caído em uma falha.',
  },
  {
    slug: 'hidden-attack',
    name: 'Ataque Escondido',
    cost: 1,
    unlockLevel: 9,
    subclassSlug: 'thief',
    note: 'O ataque não encerra Invisível de Esconder se terminar atrás de cobertura adequada.',
  },
  {
    slug: 'daze',
    name: 'Aturdir',
    cost: 2,
    unlockLevel: 14,
    saveAbility: 'constitution',
    note: 'Em falha, no próximo turno o alvo só pode mover, agir ou usar Ação Bônus.',
  },
  {
    slug: 'knock-out',
    name: 'Nocaute',
    cost: 6,
    unlockLevel: 14,
    saveAbility: 'constitution',
    note: 'Em falha, Inconsciente por 1 minuto ou até sofrer dano.',
  },
  {
    slug: 'obscure',
    name: 'Obscurecer',
    cost: 3,
    unlockLevel: 14,
    saveAbility: 'dexterity',
    note: 'Em falha, Cego até o fim do próximo turno do alvo.',
  },
  {
    slug: 'paralyze',
    name: 'Paralisar',
    cost: 4,
    unlockLevel: 17,
    saveAbility: 'constitution',
    subclassSlug: 'arachnoid-stalker',
    note: 'Com Golpe Venenoso, o alvo fica Paralisado até o fim do seu próximo turno.',
  },
];

export const FIXTURE_PSI_ACTIONS: readonly SubclassTableAction[] = [
  {
    subclassSlug: 'psi-warrior',
    slug: 'protective-field',
    name: 'Campo Protetor',
    unlockLevel: 3,
    alwaysSpendsPool: true,
    rollsPoolDie: true,
    spendsOnlyOnSuccess: false,
  },
  {
    subclassSlug: 'psi-warrior',
    slug: 'telekinetic-movement',
    name: 'Movimento Telecinético',
    unlockLevel: 3,
    freeResourceSlug: 'telekinetic-movement',
    alwaysSpendsPool: false,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
  },
  {
    subclassSlug: 'psi-warrior',
    slug: 'psychic-leap',
    name: 'Salto com Impulsão Psíquica',
    unlockLevel: 7,
    freeResourceSlug: 'psychic-leap',
    alwaysSpendsPool: false,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
  },
  {
    subclassSlug: 'psi-warrior',
    slug: 'mental-guard',
    name: 'Resguardo Mental',
    unlockLevel: 10,
    alwaysSpendsPool: true,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
  },
  {
    subclassSlug: 'psi-warrior',
    slug: 'energy-bulwark',
    name: 'Baluarte de Energia',
    unlockLevel: 15,
    freeResourceSlug: 'energy-bulwark',
    alwaysSpendsPool: false,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
  },
  {
    subclassSlug: 'psi-warrior',
    slug: 'telekinetic-master',
    name: 'Mestre Telecinético',
    unlockLevel: 18,
    freeResourceSlug: 'telekinetic-master',
    alwaysSpendsPool: false,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
  },
];

export const FIXTURE_SOULKNIFE_ACTIONS: readonly SubclassTableAction[] = [
  {
    subclassSlug: 'soulknife',
    slug: 'psi-bolstered-knack',
    name: 'Aptidão Reforçada Psiquicamente',
    unlockLevel: 3,
    alwaysSpendsPool: false,
    rollsPoolDie: true,
    spendsOnlyOnSuccess: true,
  },
  {
    subclassSlug: 'soulknife',
    slug: 'psychic-whispers',
    name: 'Sussurros Psíquicos',
    unlockLevel: 3,
    freeResourceSlug: 'psychic-whispers',
    alwaysSpendsPool: false,
    rollsPoolDie: true,
    spendsOnlyOnSuccess: false,
    repeatPoolCost: 1,
  },
  {
    subclassSlug: 'soulknife',
    slug: 'homing-strikes',
    name: 'Golpes Teleguiados',
    unlockLevel: 9,
    alwaysSpendsPool: false,
    rollsPoolDie: true,
    spendsOnlyOnSuccess: true,
  },
  {
    subclassSlug: 'soulknife',
    slug: 'psychic-teleportation',
    name: 'Teleporte Psíquico',
    unlockLevel: 9,
    alwaysSpendsPool: false,
    rollsPoolDie: true,
    spendsOnlyOnSuccess: false,
    alwaysPoolCost: 1,
  },
  {
    subclassSlug: 'soulknife',
    slug: 'psychic-veil',
    name: 'Véu Psíquico',
    unlockLevel: 13,
    freeResourceSlug: 'psychic-veil',
    alwaysSpendsPool: false,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
    repeatPoolCost: 1,
  },
  {
    subclassSlug: 'soulknife',
    slug: 'rend-mind',
    name: 'Rasgar Mente',
    unlockLevel: 17,
    freeResourceSlug: 'rend-mind',
    alwaysSpendsPool: false,
    rollsPoolDie: false,
    spendsOnlyOnSuccess: false,
    repeatPoolCost: 3,
  },
];

export const FIXTURE_PERSONA_MASK_SLUGS = [
  'persona-mask-angel',
  'persona-mask-archmage',
  'persona-mask-devil',
  'persona-mask-dragon',
  'persona-mask-faceless',
  'persona-mask-gladiator',
  'persona-mask-hierophant',
  'persona-mask-jester',
  'persona-mask-noble',
] as const;

export const FIXTURE_BESTIAL_ASPECT_BENEFITS = [
  {
    level: 1,
    note: 'Carnificina: +2 nas jogadas de dano com armas e Ataques Desarmados.',
  },
  { level: 2, note: 'Movimento Rápido: Deslocamento +3 m.' },
  {
    level: 3,
    note: 'Frenesi Sangrento: Vantagem em ataques contra criaturas sem PV cheios.',
  },
  { level: 4, note: 'Pele Espessa: +2 CA se não empunhar Escudo.' },
  {
    level: 5,
    note: 'Retaliação: Reação para atacar corpo a corpo quem causar dano a ≤1,5 m.',
  },
] as const;

export const FIXTURE_DUNGEONEER_SLAYER_LABELS = [
  'Aberração',
  'Dragão',
  'Feérico',
  'Corruptor',
  'Monstruosidade',
  'Gosma',
  'Morto-vivo',
] as const;

export const FIXTURE_DUNGEONEER_PRECAUTION_SPELLS: readonly PrecautionSpell[] = [
  { slug: 'alarme', name: 'Alarme' },
  { slug: 'compreender-idiomas', name: 'Compreender Idiomas' },
  { slug: 'detectar-magia', name: 'Detectar Magia' },
  { slug: 'detectar-veneno-e-doenca', name: 'Detectar Veneno e Doença' },
  { slug: 'encontrar-armadilhas', name: 'Encontrar Armadilhas' },
  { slug: 'identificar', name: 'Identificar' },
  {
    slug: 'purificar-alimentos-e-bebidas',
    name: 'Purificar Alimentos e Bebidas',
  },
];
