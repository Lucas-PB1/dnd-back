import {
  barbarianCombatNotes,
  fastMovementBonusMeters,
} from './barbarian';
import {
  attacksPerAction as fighterAttacksPerAction,
  fighterCombatNotes,
  isFighterClass,
} from './fighter';
import { rogueCombatNotes } from './rogue';
import {
  isMonkClass,
  monkAttacksPerAction,
  monkCombatNotes,
  unarmoredMovementBonusMeters,
} from './monk';
import {
  isPaladinClass,
  paladinAttacksPerAction,
  paladinCombatNotes,
} from './paladin';
import {
  isRangerClass,
  rangerAttacksPerAction,
  rangerCombatNotes,
  rangerSpeedBonusMeters,
} from './ranger';
import { clericCombatNotes } from './cleric';
import { bardCombatNotes } from './bard';
import { sorcererCombatNotes } from './sorcerer';
import { warlockCombatNotes } from './warlock';
import { druidCombatNotes } from './druid';
import { wizardCombatNotes } from './wizard';
import { gunslingerCombatNotes } from './gunslinger';

export type ClassCombatContribution = {
  notes: string[];
  attacksPerAction: number;
  speedBonusMeters: number;
};

type ClassCombatInput = {
  classSlug: string;
  subclassSlug: string | null;
  level: number;
};

/**
 * Agrega contribuições explícitas de cada classe.
 * Cada pasta de classe (`fighter/`, `rogue/`, …) permanece dona das regras via `index.ts`; este módulo só combina.
 */
export function aggregateClassCombatContributions(
  input: ClassCombatInput,
): ClassCombatContribution {
  const { classSlug, subclassSlug, level } = input;

  const notes = [
    ...barbarianCombatNotes({ classSlug, level }),
    ...fighterCombatNotes({ classSlug, subclassSlug, level }),
    ...rogueCombatNotes({ classSlug, subclassSlug, level }),
    ...monkCombatNotes({ classSlug, subclassSlug, level }),
    ...paladinCombatNotes({ classSlug, subclassSlug, level }),
    ...rangerCombatNotes({ classSlug, subclassSlug, level }),
    ...clericCombatNotes({ classSlug, subclassSlug, level }),
    ...bardCombatNotes({ classSlug, subclassSlug, level }),
    ...sorcererCombatNotes({ classSlug, subclassSlug, level }),
    ...warlockCombatNotes({ classSlug, subclassSlug, level }),
    ...druidCombatNotes({ classSlug, subclassSlug, level }),
    ...wizardCombatNotes({ classSlug, subclassSlug, level }),
    ...gunslingerCombatNotes({ classSlug, subclassSlug, level }),
  ];

  const speedBonusMeters =
    fastMovementBonusMeters({ classSlug, level }) +
    unarmoredMovementBonusMeters({ classSlug, level }) +
    rangerSpeedBonusMeters({ classSlug, level });

  return {
    notes,
    attacksPerAction: resolveAttacksPerAction(classSlug, level),
    speedBonusMeters,
  };
}

function resolveAttacksPerAction(classSlug: string, level: number): number {
  if (isFighterClass(classSlug)) {
    return fighterAttacksPerAction(level);
  }
  if (isMonkClass(classSlug)) {
    return monkAttacksPerAction(level);
  }
  if (isPaladinClass(classSlug)) {
    return paladinAttacksPerAction(level);
  }
  if (isRangerClass(classSlug)) {
    return rangerAttacksPerAction(level);
  }
  return 1;
}
