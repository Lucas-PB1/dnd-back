import {
  cunningStrikeSaveDc,
  soulknifePsiDiceSchedule,
} from '../rogue';
import {
  findSubclassTableAction,
  type SubclassTableAction,
} from '../catalog/subclass-table-action';

export const SOULKNIFE_ACTION_SLUGS = [
  'psi-bolstered-knack',
  'psychic-whispers',
  'guided-strike',
  'psychic-teleport',
  'psychic-veil',
  'rend-mind',
] as const;

export type SoulknifeActionSlug = (typeof SOULKNIFE_ACTION_SLUGS)[number];

export function resolveSoulknifeTableAction(input: {
  catalog: readonly SubclassTableAction[];
  actionSlug: SoulknifeActionSlug;
  level: number;
  dexterityModifier: number;
  proficiencyBonus: number;
  dieRoll?: number;
  usePsiDice?: boolean;
  succeededWithDie?: boolean;
}) {
  const action = findSubclassTableAction(
    input.catalog,
    'soulknife',
    input.actionSlug,
  );
  if (!action) {
    throw new Error(`Unknown Soulknife action '${input.actionSlug}'`);
  }
  if (input.level < action.unlockLevel) {
    throw new Error(
      `${action.name} requires Rogue level ${action.unlockLevel}+`,
    );
  }

  const schedule = soulknifePsiDiceSchedule(input.level);
  if (!schedule) {
    throw new Error('Soulknife Psi Energy Die is not available');
  }
  if (action.rollsPoolDie && input.dieRoll === undefined) {
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
    expression: action.rollsPoolDie ? `1d${schedule.faces}` : undefined,
    roll: input.dieRoll,
    saveDc,
    note: buildSoulknifeActionNote(input.actionSlug, input.dieRoll, saveDc),
  };
}

function resolvePsiDiceCost(
  action: SubclassTableAction,
  input: {
    usePsiDice?: boolean;
    succeededWithDie?: boolean;
  },
): number {
  if (action.alwaysPoolCost !== undefined) return action.alwaysPoolCost;
  if (action.spendsOnlyOnSuccess) return input.succeededWithDie ? 1 : 0;
  if (input.usePsiDice) return action.repeatPoolCost ?? 0;
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
  if (slug === 'guided-strike') {
    return `Golpes Teleguiados: some ${roll} ao ataque que errou; gaste o dado somente se acertar.`;
  }
  if (slug === 'psychic-teleport') {
    return `Teleporte Psíquico: teleporte-se até ${
      (roll ?? 0) * 3
    } metros como Ação Bônus.`;
  }
  if (slug === 'psychic-veil') {
    return 'Véu Psíquico: fique Invisível por 1 hora ou até causar dano ou forçar salvaguarda.';
  }
  return `Rasgar Mente: salvaguarda de Sabedoria CD ${saveDc}; em falha, Atordoado por até 1 minuto.`;
}
