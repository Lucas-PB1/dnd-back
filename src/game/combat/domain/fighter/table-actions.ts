import {
  battleMasterSaveDc,
  findBattleMasterManeuver,
  type BattleMasterManeuver,
} from './battle-master-maneuvers';
import {
  findPrecautionSpell,
  type PrecautionSpell,
} from './dungeoneer-catalog';
import {
  psiEnergyDieFaces,
  superiorityDieFaces,
} from './features';
import {
  findSubclassTableAction,
  type SubclassTableAction,
} from '../catalog/subclass-table-action';

export const PSI_WARRIOR_ACTION_SLUGS = [
  'protective-field',
  'telekinetic-movement',
  'psychic-leap',
  'mental-guard',
  'energy-bulwark',
  'telekinetic-master',
] as const;

export type PsiWarriorActionSlug =
  (typeof PSI_WARRIOR_ACTION_SLUGS)[number];

type BattleMasterRollInput = {
  catalog: readonly BattleMasterManeuver[];
  maneuverSlug: string;
  level: number;
  proficiencyBonus: number;
  strengthModifier: number;
  dexterityModifier: number;
  charismaModifier: number;
  dieRoll: number;
  useRelentless?: boolean;
};

export function resolveBattleMasterTableRoll(input: BattleMasterRollInput) {
  const maneuver = findBattleMasterManeuver(input.catalog, input.maneuverSlug);
  if (!maneuver) {
    throw new Error(`Unknown Battle Master maneuver '${input.maneuverSlug}'`);
  }
  if (input.level < 3) {
    throw new Error('Battle Master maneuvers require Fighter level 3+');
  }
  if (input.useRelentless && input.level < 15) {
    throw new Error('Relentless requires Fighter level 15+');
  }

  const dieFaces = input.useRelentless
    ? 8
    : superiorityDieFaces(input.level);
  if (dieFaces == null) {
    throw new Error('Superiority Die is not available');
  }

  const saveDc = battleMasterSaveDc({
    proficiencyBonus: input.proficiencyBonus,
    strengthMod: input.strengthModifier,
    dexterityMod: input.dexterityModifier,
  });
  const abilityModifier =
    maneuver.slug === 'rally'
      ? input.charismaModifier
      : Math.max(input.strengthModifier, input.dexterityModifier);
  const effectValue =
    maneuver.slug === 'parry' || maneuver.slug === 'rally'
      ? Math.max(0, input.dieRoll + abilityModifier)
      : input.dieRoll;

  return {
    maneuver,
    dieFaces,
    expression:
      maneuver.slug === 'parry' || maneuver.slug === 'rally'
        ? `1d${dieFaces}${abilityModifier >= 0 ? '+' : ''}${abilityModifier}`
        : `1d${dieFaces}`,
    roll: input.dieRoll,
    effectValue,
    saveDc,
    resourceSpent: !input.useRelentless,
    note: buildManeuverNote(
      maneuver.slug,
      maneuver.name,
      effectValue,
      saveDc,
      maneuver.description,
      Boolean(input.useRelentless),
    ),
  };
}

function buildManeuverNote(
  slug: string,
  name: string,
  value: number,
  saveDc: number,
  description: string,
  relentless: boolean,
): string {
  const prefix = `${name}: ${relentless ? 'Implacável d8' : 'Dado de Superioridade'} = ${value}.`;
  if (slug === 'parry') return `${prefix} Reduza ${value} do dano.`;
  if (slug === 'rally') return `${prefix} Conceda ${value} PV temporários.`;
  if (slug === 'precision-attack') {
    return `${prefix} Some ${value} à jogada de ataque que errou.`;
  }
  return `${prefix} CD ${saveDc}, quando aplicável. ${description}`;
}

export function resolvePsiWarriorTableAction(input: {
  catalog: readonly SubclassTableAction[];
  actionSlug: PsiWarriorActionSlug;
  level: number;
  intelligenceModifier: number;
  dieRoll?: number;
  usePsiDie?: boolean;
}) {
  const action = findSubclassTableAction(
    input.catalog,
    'psi-warrior',
    input.actionSlug,
  );
  if (!action) {
    throw new Error(`Unknown Psi Warrior action '${input.actionSlug}'`);
  }
  if (input.level < action.unlockLevel) {
    throw new Error(
      `${action.name} requires Fighter level ${action.unlockLevel}+`,
    );
  }

  const dieFaces = psiEnergyDieFaces(input.level);
  const spendsPsi = action.alwaysSpendsPool || Boolean(input.usePsiDie);
  if (spendsPsi && dieFaces == null) {
    throw new Error('Psi Energy Die is not available');
  }

  const roll = action.rollsPoolDie ? input.dieRoll : undefined;
  const total =
    roll == null ? undefined : Math.max(0, roll + input.intelligenceModifier);
  return {
    actionName: action.name,
    unlockLevel: action.unlockLevel,
    resourceSlug: spendsPsi
      ? 'psi-energy-dice'
      : action.freeResourceSlug,
    dieFaces,
    expression:
      roll == null
        ? undefined
        : `1d${dieFaces}${input.intelligenceModifier >= 0 ? '+' : ''}${input.intelligenceModifier}`,
    roll,
    total,
    saveDc: undefined,
    note: buildPsiActionNote(input.actionSlug, action.name, total),
  };
}

function buildPsiActionNote(
  slug: PsiWarriorActionSlug,
  name: string,
  total?: number,
): string {
  if (slug === 'protective-field') {
    return `${name}: reduza ${total ?? 0} do dano recebido (Reação).`;
  }
  if (slug === 'telekinetic-movement') {
    return `${name}: mova o objeto solto ou criatura voluntária conforme a característica.`;
  }
  if (slug === 'psychic-leap') {
    return `${name}: Deslocamento de Voo igual ao dobro do seu Deslocamento até o fim do turno.`;
  }
  if (slug === 'mental-guard') {
    return `${name}: encerre em você todos os efeitos que causam Amedrontado ou Enfeitiçado.`;
  }
  if (slug === 'energy-bulwark') {
    return `${name}: conceda Cobertura Parcial por 1 minuto a até o modificador de INT em criaturas (mínimo 1).`;
  }
  return `${name}: conjure Telecinese sem espaço/componentes; INT é o atributo de conjuração.`;
}

export function findDungeoneerPrecautionSpell(
  catalog: readonly PrecautionSpell[],
  spellSlug: string,
) {
  return findPrecautionSpell(catalog, spellSlug);
}
