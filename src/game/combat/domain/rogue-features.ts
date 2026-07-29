import { psiEnergyDiceSchedule } from './fighter-features';

export const ROGUE_SUBCLASS_SLUGS = [
  'soulknife',
  'assassin',
  'thief',
  'arcane-trickster',
  'arachnoid-stalker',
] as const;

export type RogueSubclassSlug = (typeof ROGUE_SUBCLASS_SLUGS)[number];

export type CunningStrikeEffectSlug =
  | 'poison'
  | 'withdraw'
  | 'trip'
  | 'hidden-attack'
  | 'daze'
  | 'knock-out'
  | 'obscure'
  | 'paralyze';

export type CunningStrikeEffect = {
  slug: CunningStrikeEffectSlug;
  name: string;
  cost: number;
  unlockLevel: number;
  saveAbility?: 'constitution' | 'dexterity';
  subclassSlug?: 'arachnoid-stalker' | 'thief';
  note: string;
};

export const CUNNING_STRIKE_EFFECTS: readonly CunningStrikeEffect[] = [
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
    note:
      'O ataque não encerra Invisível de Esconder se terminar atrás de cobertura adequada.',
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

export function isRogueClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'rogue';
}

/** Dados de Ataque Furtivo: 1d6 no nível 1 e +1d6 a cada nível ímpar. */
export function sneakAttackDiceCount(level: number): number {
  return Math.max(0, Math.ceil(level / 2));
}

/** O Perseguidor Aracnídeo pode trocar os d6 por d8 de dano Venenoso. */
export function sneakAttackDieFaces(
  subclassSlug?: string | null,
  usePoisonousStrike = false,
): 6 | 8 {
  return subclassSlug === 'arachnoid-stalker' && usePoisonousStrike ? 8 : 6;
}

export function sneakAttackDiceExpression(input: {
  level: number;
  subclassSlug?: string | null;
  usePoisonousStrike?: boolean;
}): string {
  return `${sneakAttackDiceCount(input.level)}d${sneakAttackDieFaces(
    input.subclassSlug,
    input.usePoisonousStrike,
  )}`;
}

export function cunningStrikeSaveDc(input: {
  dexterityModifier: number;
  proficiencyBonus: number;
}): number {
  return 8 + input.dexterityModifier + input.proficiencyBonus;
}

export function findCunningStrikeEffect(
  slug: string,
): CunningStrikeEffect | undefined {
  return CUNNING_STRIKE_EFFECTS.find((effect) => effect.slug === slug);
}

export function availableCunningStrikeEffects(input: {
  level: number;
  subclassSlug?: string | null;
}): CunningStrikeEffect[] {
  return CUNNING_STRIKE_EFFECTS.filter(
    (effect) =>
      input.level >= effect.unlockLevel &&
      (!effect.subclassSlug || effect.subclassSlug === input.subclassSlug),
  );
}

export function validateCunningStrikeSelection(input: {
  level: number;
  effectSlugs: readonly string[];
  subclassSlug?: string | null;
}): {
  effects: CunningStrikeEffect[];
  diceCost: number;
  remainingSneakAttackDice: number;
} {
  const maximumEffects = input.level >= 11 ? 2 : 1;
  if (input.effectSlugs.length > maximumEffects) {
    throw new Error(
      `Rogue level ${input.level} can apply at most ${maximumEffects} Cunning Strike effect(s)`,
    );
  }

  const effects = input.effectSlugs.map((slug) => {
    const effect = findCunningStrikeEffect(slug);
    if (!effect) {
      throw new Error(`Unknown Cunning Strike effect '${slug}'`);
    }
    if (input.level < effect.unlockLevel) {
      throw new Error(
        `${effect.name} requires Rogue level ${effect.unlockLevel}+`,
      );
    }
    if (
      effect.subclassSlug !== undefined &&
      effect.subclassSlug !== input.subclassSlug
    ) {
      throw new Error(
        `${effect.name} requires Rogue subclass ${effect.subclassSlug}`,
      );
    }
    return effect;
  });

  const diceCost = effects.reduce((total, effect) => total + effect.cost, 0);
  const sneakAttackDice = sneakAttackDiceCount(input.level);
  if (diceCost > sneakAttackDice) {
    throw new Error(
      `Cunning Strike costs ${diceCost} dice, but Sneak Attack has only ${sneakAttackDice}`,
    );
  }

  return {
    effects,
    diceCost,
    remainingSneakAttackDice: sneakAttackDice - diceCost,
  };
}

export function hasSlipperyMind(level: number): boolean {
  return level >= 15;
}

/** Soulknife usa a mesma progressão de dados psiônicos do Psi Warrior. */
export function soulknifePsiDiceSchedule(level: number): {
  faces: number;
  count: number;
} | null {
  return psiEnergyDiceSchedule(level);
}

export function rogueCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isRogueClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const notes = [
    `Ataque Furtivo: ${sneakAttackDiceExpression({
      level,
      subclassSlug: input.subclassSlug,
    })} uma vez por turno`,
  ];

  addBaseRogueNotes(notes, level);
  addRogueSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseRogueNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Ação Ardilosa: Correr, Desengajar ou Esconder como Ação Bônus',
    );
  }
  if (level >= 3) {
    notes.push(
      'Mira Firme: vantagem no próximo ataque, sem movimento no turno',
    );
  }
  if (level >= 5) {
    notes.push(
      'Golpe Astuto: sacrifique dados de Ataque Furtivo para aplicar efeitos',
    );
    notes.push(
      'Esquiva Sobrenatural: use a Reação para reduzir pela metade o dano do ataque',
    );
  }
  if (level >= 7) {
    notes.push(
      'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha causa metade',
    );
    notes.push(
      'Talento Confiável: resultados 9 ou menos viram 10 em testes com proficiência',
    );
  }
  if (level >= 11) {
    notes.push(
      'Golpe Astuto Aprimorado: aplique até dois efeitos, pagando ambos os custos',
    );
  }
  if (level >= 14) {
    notes.push('Golpes Sujos: Aturdir, Nocaute e Obscurecer disponíveis');
  }
  if (hasSlipperyMind(level)) {
    notes.push(
      'Mente Escorregadia: proficiência em salvaguardas de Sabedoria e Carisma',
    );
  }
  if (level >= 18) {
    notes.push(
      'Elusivo: ataques não têm Vantagem contra você enquanto não Incapacitado',
    );
  }
  if (level >= 20) {
    notes.push('Golpe de Sorte: transforme um Teste de D20 que falhou em 20');
  }
}

function addRogueSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (subclassSlug === 'soulknife') addSoulknifeNotes(notes, level);
  if (subclassSlug === 'assassin') addAssassinNotes(notes, level);
  if (subclassSlug === 'thief') addThiefNotes(notes, level);
  if (subclassSlug === 'arcane-trickster') addArcaneTricksterNotes(notes, level);
  if (subclassSlug === 'arachnoid-stalker') {
    addArachnoidStalkerNotes(notes, level);
  }
}

function addSoulknifeNotes(notes: string[], level: number): void {
  const schedule = soulknifePsiDiceSchedule(level);
  if (schedule) {
    notes.push(
      `Adaga Espiritual: ${schedule.count} Dados de Energia (d${schedule.faces})`,
    );
    notes.push(
      'Lâminas Psíquicas: 1d6 Psíquico; segunda lâmina 1d4 como Ação Bônus',
    );
  }
  if (level >= 9) {
    notes.push('Lâminas da Alma: Golpes Teleguiados e Teleporte Psíquico');
  }
  if (level >= 13) notes.push('Véu Psíquico: Invisível por até 1 hora');
  if (level >= 17) notes.push('Rasgar Mente: salvaguarda de Sabedoria ou Atordoado');
}

function addAssassinNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Assassinar: Vantagem na Iniciativa e Golpe Surpreendente');
  }
  if (level >= 9) {
    notes.push(
      'Especialista em Infiltração: Mimetismo Magistral e Mira Móvel',
    );
  }
  if (level >= 13) {
    notes.push(
      'Armas Venenosas: Envenenar causa 2d6 Venenoso adicional em falha',
    );
  }
  if (level >= 17) {
    notes.push('Golpe Mortal: salvaguarda de Constituição ou dobre o dano');
  }
}

function addThiefNotes(notes: string[], level: number): void {
  if (level >= 3) notes.push('Ladrão: Mão Leve e Andarilho de Telhados');
  if (level >= 9) {
    notes.push(
      'Furtividade Suprema: Ataque Escondido custa 1 dado de Ataque Furtivo',
    );
  }
  if (level >= 13) {
    notes.push(
      'Usar Dispositivo Mágico: quatro sintonizações e uso de pergaminhos',
    );
  }
  if (level >= 17) notes.push('Reflexos de Ladrão: dois turnos na primeira rodada');
}

function addArcaneTricksterNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Trapaceiro Arcano: conjuração de Mago (INT) e Mãos Mágicas Ligeiras',
    );
  }
  if (level >= 9) {
    notes.push(
      'Emboscada Mágica: salvaguardas contra magia têm Desvantagem',
    );
  }
  if (level >= 13) {
    notes.push(
      'Trapaceiro Versátil: Golpe Astuto também afeta alvo junto à Mão Mágica',
    );
  }
  if (level >= 17) {
    notes.push('Ladrão de Magias: negue e roube uma magia com sua Reação');
  }
}

function addArachnoidStalkerNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Golpe Venenoso: Ataque Furtivo pode causar d8s de dano Venenoso',
    );
    notes.push('Correia: teias para movimento, objetos, corda ou a magia Teia');
  }
  if (level >= 9) {
    notes.push(
      'Rastejando na Parede: escalada em paredes e tetos com mãos livres',
    );
  }
  if (level >= 13) {
    notes.push(
      'Sentido de Aranha: Esquiva Sobrenatural contra dano de salvaguarda',
    );
  }
  if (level >= 17) {
    notes.push(
      'Veneno Paralítico: Paralisar custa 4 dados de Ataque Furtivo',
    );
  }
}
