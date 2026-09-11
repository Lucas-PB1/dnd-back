import {
  fastMovementBonusMeters,
} from './barbarian';
import {
  attacksPerAction as fighterAttacksPerAction,
  isFighterClass,
} from './fighter';
import {
  isMonkClass,
  monkAttacksPerAction,
  unarmoredMovementBonusMeters,
} from './monk';
import {
  isPaladinClass,
  paladinAttacksPerAction,
} from './paladin';
import {
  isRangerClass,
  rangerAttacksPerAction,
  rangerSpeedBonusMeters,
} from './ranger';
import { filterLevelCombatNotes } from './notes/level-combat-notes';
import type { LevelCombatNoteRow } from '../infrastructure/level-combat-note.queries';

export type ClassCombatContribution = {
  notes: string[];
  attacksPerAction: number;
  speedBonusMeters: number;
};

type ClassCombatInput = {
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  /** Notas de combate por nível do catálogo. */
  levelCombatNotes?: readonly LevelCombatNoteRow[];
};

/**
 * Agrega contribuições de classe.
 * Textos vêm só de `phb_level_combat_note`; números vivos (ataques, velocidade) do motor.
 */
export function aggregateClassCombatContributions(
  input: ClassCombatInput,
): ClassCombatContribution {
  const { classSlug, subclassSlug, level, levelCombatNotes = [] } = input;

  return {
    notes: [
      ...filterLevelCombatNotes(levelCombatNotes, 'subclass', subclassSlug, level),
      ...filterLevelCombatNotes(levelCombatNotes, 'class', classSlug, level),
    ],
    attacksPerAction: resolveAttacksPerAction(classSlug, level),
    speedBonusMeters:
      fastMovementBonusMeters({ classSlug, level }) +
      unarmoredMovementBonusMeters({ classSlug, level }) +
      rangerSpeedBonusMeters({ classSlug, level }),
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
