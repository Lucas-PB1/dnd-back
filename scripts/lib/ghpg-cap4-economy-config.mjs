/**
 * P0 — ações ativas GH Cap. 4 na aba Ações (mesa).
 * Textos PT de ghpg-cap4-feat-overrides-pt.mjs / cap4-feats-pt.
 *
 * @typedef {{
 *   actionId: string,
 *   featSlug: string,
 *   benefitKey: string,
 *   name: string,
 *   economy: 'action' | 'bonus' | 'reaction' | 'free',
 *   unlockLevel: number,
 *   resourceSlug?: string | null,
 *   tableAction?: string | null,
 *   alwaysSpendsResource?: boolean,
 *   summary: string,
 *   description: string,
 *   sortOrder: number,
 * }} Cap4EconomyActionDef
 */

/** @type {Cap4EconomyActionDef[]} */
export const CAP4_ECONOMY_P0 = [
  {
    actionId: 'feat-gh-triage-blood-and-bone',
    featSlug: 'triage-expert',
    benefitKey: 'Blood and Bone',
    name: 'Sangue e Osso',
    economy: 'action',
    unlockLevel: 1,
    summary: 'Utilizar + kit → cura com Dado de Vida',
    description:
      'Realizar a ação Utilizar e gastar o uso de um Kit de Curandeiro permite curar uma criatura a até 1,5 m de você. A criatura pode gastar e rolar um Dado de Vida e recuperar Pontos de Vida iguais à rolagem.',
    sortOrder: 500,
  },
  {
    actionId: 'feat-gh-fortune-fortitude',
    featSlug: 'fortuneofthe-thaumaturge',
    benefitKey: "Fortune's Fortitude",
    name: 'Fortitude da Fortuna',
    economy: 'free',
    unlockLevel: 1,
    resourceSlug: 'fortunes-fortitude',
    tableAction: 'spend-resource',
    alwaysSpendsResource: true,
    summary: 'Falhou no Teste D20 → gaste 1 uso, role DV e some',
    description:
      'Quando falha em um Teste D20, pode gastar e rolar um Dado de Vida, somando esse número ao resultado. Só pode fazer isso uma vez por Teste D20. PB usos; recupera no Descanso Longo.',
    sortOrder: 501,
  },
  {
    actionId: 'feat-gh-hold-the-ground',
    featSlug: 'free-sword-mercenarys-will',
    benefitKey: 'Hold the Ground',
    name: 'Manter Posição',
    economy: 'reaction',
    unlockLevel: 1,
    summary: 'Reação: reduz deslocamento forçado em até seu Deslocamento',
    description:
      'Quando for movido sem usar seu deslocamento por uma criatura, pode usar uma Reação para reduzir a distância em que foi movido em até seu Deslocamento.',
    sortOrder: 502,
  },
  {
    actionId: 'feat-gh-trick-shot',
    featSlug: 'blackpowder-pistol-expert',
    benefitKey: 'Trick Shot',
    name: 'Tiro Improvisado',
    economy: 'reaction',
    unlockLevel: 4,
    summary: 'Reação: ataque à distância com pistola após inimigo mover perto',
    description:
      'Imediatamente depois que uma criatura a até 1,5 m de você se mover, pode usar uma Reação para fazer um ataque à distância com uma Pistola de Pólvora Negra contra essa criatura.',
    sortOrder: 503,
  },
  {
    actionId: 'feat-gh-dodge-spells',
    featSlug: 'witch-hunter',
    benefitKey: 'Dodge Spells',
    name: 'Esquivar Magias',
    economy: 'reaction',
    unlockLevel: 4,
    summary: 'Reação: salvaguarda de Sabedoria vs magia só em você',
    description:
      'Pode usar uma Reação para evitar uma magia que tenha apenas você como alvo e não crie uma área de efeito. Faça uma salvaguarda de Sabedoria contra a CD de salvaguarda da magia do conjurador. Em um sucesso, a criatura deve escolher um novo alvo ou a magia é cancelada.',
    sortOrder: 504,
  },
  {
    actionId: 'feat-gh-lightning-dual-target',
    featSlug: 'lightning-caster',
    benefitKey: 'Dual Target',
    name: 'Alvo Duplo',
    economy: 'bonus',
    unlockLevel: 4,
    summary: 'AB: segundo alvo no truque de uma ação',
    description:
      'Quando conjura um truque com tempo de conjuração de uma ação que tem como alvo uma única criatura, pode usar uma Ação Bônus para escolher uma segunda criatura dentro do alcance do truque.',
    sortOrder: 505,
  },
  {
    actionId: 'feat-gh-lightning-immediate-response',
    featSlug: 'lightning-caster',
    benefitKey: 'Immediate Response',
    name: 'Resposta Imediata',
    economy: 'reaction',
    unlockLevel: 4,
    resourceSlug: 'lightning-immediate-response',
    tableAction: 'spend-resource',
    alwaysSpendsResource: true,
    summary: 'Reação: magia sem gastar espaço (1×/DL)',
    description:
      'Quando conjura uma magia como Reação, essa magia não gasta um espaço de magia. 1× até o próximo Descanso Longo.',
    sortOrder: 506,
  },
  {
    actionId: 'feat-gh-iron-gut-quick-recover',
    featSlug: 'iron-gut',
    benefitKey: 'Quick to Recover',
    name: 'Recuperação Rápida',
    economy: 'bonus',
    unlockLevel: 4,
    resourceSlug: 'iron-gut-quick-recover',
    tableAction: 'spend-resource',
    alwaysSpendsResource: true,
    summary: 'AB: gaste 1 DV + mod. Con → cura (1×/DC ou DL)',
    description:
      'Como Ação Bônus, pode gastar um de seus Dados de Vida, rolar o dado e somar seu modificador de Constituição, recuperando Pontos de Vida iguais ao total da rolagem. 1× até Descanso Curto ou Longo.',
    sortOrder: 507,
  },
  {
    actionId: 'feat-gh-insightful-study',
    featSlug: 'insightful-collector',
    benefitKey: 'Object Intuition',
    name: 'Intuição de Objeto',
    economy: 'action',
    unlockLevel: 1,
    summary: 'Estudar objeto mágico sem sintonizar',
    description:
      'Pode realizar a ação Estudar para examinar um objeto mágico e aprender suas propriedades e como usá-lo sem sintonizar com ele ou passar um Descanso Curto em contato físico com ele, mas não aprende nenhuma maldição que o item possa carregar.',
    sortOrder: 508,
  },
  {
    actionId: 'feat-gh-dual-shot',
    featSlug: 'dual-shot',
    benefitKey: 'Dual Shot',
    name: 'Disparo Duplo',
    economy: 'action',
    unlockLevel: 1,
    summary: 'Atacar: segundo alvo perto do primeiro (ambos com Desvantagem)',
    description:
      'Quando realiza a ação Atacar no seu turno e ataca com um arco ou besta, pode fazer um ataque extra como parte da mesma ação contra uma criatura que esteja a até 3 m do alvo original e dentro do alcance da arma. Se o fizer, ambos os ataques são feitos com Desvantagem.',
    sortOrder: 509,
  },
  {
    actionId: 'feat-gh-opportunist-exploit',
    featSlug: 'opportunist',
    benefitKey: 'Exploit Weakness',
    name: 'Explorar Fraqueza',
    economy: 'reaction',
    unlockLevel: 1,
    summary: 'Reação: +2 em ataque e dano',
    description:
      'Sempre que faz um ataque como parte de uma Reação, ganha +2 nas jogadas de ataque e de dano.',
    sortOrder: 510,
  },
];

/** P1 — só lembrete em passivas (sem economy row). */
export const CAP4_ECONOMY_P1_SLUGS = [
  'convincing-inquisitor',
  'survivor',
  'nimble-physique',
  'syndicate-spy',
  'thrown-weapon-master',
  'mobile-combatant',
  'close-combat-artillerist',
  'flurry',
  'prone-defense',
];

/** @type {{ slug: string, name: string, featSlug: string, unlockLevel: number, maxFormula: 'proficiency_bonus' | 'fixed', fixedMax?: number, recoverAllOnShort?: boolean, recoverAllOnLong?: boolean }[]} */
export const CAP4_FEAT_RESOURCES = [
  {
    slug: 'fortunes-fortitude',
    name: 'Fortitude da Fortuna',
    featSlug: 'fortuneofthe-thaumaturge',
    unlockLevel: 1,
    maxFormula: 'proficiency_bonus',
    recoverAllOnLong: true,
  },
  {
    slug: 'lightning-immediate-response',
    name: 'Resposta Imediata',
    featSlug: 'lightning-caster',
    unlockLevel: 4,
    maxFormula: 'fixed',
    fixedMax: 1,
    recoverAllOnLong: true,
  },
  {
    slug: 'iron-gut-quick-recover',
    name: 'Recuperação Rápida',
    featSlug: 'iron-gut',
    unlockLevel: 4,
    maxFormula: 'fixed',
    fixedMax: 1,
    recoverAllOnShort: true,
    recoverAllOnLong: true,
  },
];
