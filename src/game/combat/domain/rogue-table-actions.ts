import {
  cunningStrikeSaveDc,
  soulknifePsiDiceSchedule,
} from './rogue-features';

export const SOULKNIFE_ACTION_SLUGS = [
  'psi-bolstered-knack',
  'psychic-whispers',
  'homing-strikes',
  'psychic-teleportation',
  'psychic-veil',
  'rend-mind',
] as const;

export type SoulknifeActionSlug = (typeof SOULKNIFE_ACTION_SLUGS)[number];

type SoulknifeActionDefinition = {
  name: string;
  unlockLevel: number;
  rollsPsiDie: boolean;
  repeatCost?: number;
  alwaysCostsPsi?: number;
  spendsOnlyOnSuccess?: boolean;
  freeResourceSlug?: string;
};

const SOULKNIFE_ACTIONS: Record<
  SoulknifeActionSlug,
  SoulknifeActionDefinition
> = {
  'psi-bolstered-knack': {
    name: 'Aptidão Reforçada Psiquicamente',
    unlockLevel: 3,
    rollsPsiDie: true,
    spendsOnlyOnSuccess: true,
  },
  'psychic-whispers': {
    name: 'Sussurros Psíquicos',
    unlockLevel: 3,
    rollsPsiDie: true,
    repeatCost: 1,
    freeResourceSlug: 'psychic-whispers',
  },
  'homing-strikes': {
    name: 'Golpes Teleguiados',
    unlockLevel: 9,
    rollsPsiDie: true,
    spendsOnlyOnSuccess: true,
  },
  'psychic-teleportation': {
    name: 'Teleporte Psíquico',
    unlockLevel: 9,
    rollsPsiDie: true,
    alwaysCostsPsi: 1,
  },
  'psychic-veil': {
    name: 'Véu Psíquico',
    unlockLevel: 13,
    rollsPsiDie: false,
    repeatCost: 1,
    freeResourceSlug: 'psychic-veil',
  },
  'rend-mind': {
    name: 'Rasgar Mente',
    unlockLevel: 17,
    rollsPsiDie: false,
    repeatCost: 3,
    freeResourceSlug: 'rend-mind',
  },
};

export function resolveSoulknifeTableAction(input: {
  actionSlug: SoulknifeActionSlug;
  level: number;
  dexterityModifier: number;
  proficiencyBonus: number;
  dieRoll?: number;
  usePsiDice?: boolean;
  succeededWithDie?: boolean;
}) {
  const action = SOULKNIFE_ACTIONS[input.actionSlug];
  if (input.level < action.unlockLevel) {
    throw new Error(
      `${action.name} requires Rogue level ${action.unlockLevel}+`,
    );
  }

  const schedule = soulknifePsiDiceSchedule(input.level);
  if (!schedule) {
    throw new Error('Soulknife Psi Energy Die is not available');
  }
  if (action.rollsPsiDie && input.dieRoll === undefined) {
    throw new Error(`${action.name} requires a Psi Energy Die roll`);
  }
  if (
    input.dieRoll !== undefined &&
    (input.dieRoll < 1 || input.dieRoll > schedule.faces)
  ) {
    throw new Error(
      `Psi Energy Die roll must be between 1 and ${schedule.faces}`,
    );
  }

  const psiDiceCost = resolvePsiDiceCost(action, input);
  const resourceSlug =
    psiDiceCost > 0 ? 'soulknife-psi-dice' : action.freeResourceSlug;
  const saveDc =
    input.actionSlug === 'rend-mind'
      ? cunningStrikeSaveDc(input)
      : undefined;

  return {
    actionName: action.name,
    unlockLevel: action.unlockLevel,
    resourceSlug,
    psiDiceCost,
    dieFaces: schedule.faces,
    expression: action.rollsPsiDie ? `1d${schedule.faces}` : undefined,
    roll: input.dieRoll,
    saveDc,
    note: buildSoulknifeActionNote(input.actionSlug, input.dieRoll, saveDc),
  };
}

function resolvePsiDiceCost(
  action: SoulknifeActionDefinition,
  input: {
    usePsiDice?: boolean;
    succeededWithDie?: boolean;
  },
): number {
  if (action.alwaysCostsPsi !== undefined) return action.alwaysCostsPsi;
  if (action.spendsOnlyOnSuccess) return input.succeededWithDie ? 1 : 0;
  if (input.usePsiDice) return action.repeatCost ?? 0;
  return 0;
}

function buildSoulknifeActionNote(
  slug: SoulknifeActionSlug,
  roll?: number,
  saveDc?: number,
): string {
  if (slug === 'psi-bolstered-knack') {
    return `Aptidão Reforçada Psiquicamente: some ${roll} ao teste; gaste o dado somente se obtiver sucesso.`;
  }
  if (slug === 'psychic-whispers') {
    return `Sussurros Psíquicos: comunicação telepática por ${roll} hora(s), em até 1,5 km.`;
  }
  if (slug === 'homing-strikes') {
    return `Golpes Teleguiados: some ${roll} ao ataque que errou; gaste o dado somente se acertar.`;
  }
  if (slug === 'psychic-teleportation') {
    return `Teleporte Psíquico: teleporte-se até ${
      (roll ?? 0) * 3
    } metros como Ação Bônus.`;
  }
  if (slug === 'psychic-veil') {
    return 'Véu Psíquico: fique Invisível por 1 hora ou até causar dano ou forçar salvaguarda.';
  }
  return `Rasgar Mente: salvaguarda de Sabedoria CD ${saveDc}; em falha, Atordoado por até 1 minuto.`;
}
