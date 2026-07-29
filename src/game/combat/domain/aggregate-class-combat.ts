import {
  barbarianCombatNotes,
  fastMovementBonusMeters,
} from '../domain/barbarian-rage';
import {
  attacksPerAction as fighterAttacksPerAction,
  fighterCombatNotes,
  isFighterClass,
} from '../domain/fighter-features';
import { rogueCombatNotes } from '../domain/rogue-features';
import {
  isMonkClass,
  monkAttacksPerAction,
  monkCombatNotes,
  unarmoredMovementBonusMeters,
} from '../domain/monk-features';
import {
  isPaladinClass,
  paladinAttacksPerAction,
  paladinCombatNotes,
} from '../domain/paladin-features';
import {
  isRangerClass,
  rangerAttacksPerAction,
  rangerCombatNotes,
  rangerSpeedBonusMeters,
} from '../domain/ranger-features';

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
