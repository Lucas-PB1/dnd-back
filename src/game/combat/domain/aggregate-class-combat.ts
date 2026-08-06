import {
  barbarianCombatNotes,
  fastMovementBonusMeters,
} from './barbarian-rage';
import {
  attacksPerAction as fighterAttacksPerAction,
  fighterCombatNotes,
  isFighterClass,
} from './fighter-features';
import { rogueCombatNotes } from './rogue-features';
import {
  isMonkClass,
  monkAttacksPerAction,
  monkCombatNotes,
  unarmoredMovementBonusMeters,
} from './monk-features';
import {
  isPaladinClass,
  paladinAttacksPerAction,
  paladinCombatNotes,
} from './paladin-features';
import {
  isRangerClass,
  rangerAttacksPerAction,
  rangerCombatNotes,
  rangerSpeedBonusMeters,
} from './ranger-features';
import { clericCombatNotes } from './cleric-features';
import { bardCombatNotes } from './bard-features';
import { sorcererCombatNotes } from './sorcerer-features';
import { warlockCombatNotes } from './warlock-features';
import { druidCombatNotes } from './druid-features';
import { wizardCombatNotes } from './wizard-features';
import { gunslingerCombatNotes } from './gunslinger-features';

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
 * Cada *-features.ts permanece dono das regras; este módulo só combina.
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
