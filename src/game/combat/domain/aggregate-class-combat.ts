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
import type { FeatureScheduleBand } from './feature-schedule';

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
  /** Schedules nível→valor (`phb_class_feature_schedule`). */
  featureSchedules: readonly FeatureScheduleBand[];
};

/**
 * Agrega contribuições de classe.
 * Textos: `phb_level_combat_note`. Números: schedule do catálogo quando presente.
 */
export function aggregateClassCombatContributions(
  input: ClassCombatInput,
): ClassCombatContribution {
  const {
    classSlug,
    subclassSlug,
    level,
    levelCombatNotes = [],
    featureSchedules,
  } = input;

  return {
    notes: [
      ...filterLevelCombatNotes(levelCombatNotes, 'subclass', subclassSlug, level),
      ...filterLevelCombatNotes(levelCombatNotes, 'class', classSlug, level),
    ],
    attacksPerAction: resolveAttacksPerAction(
      classSlug,
      level,
      featureSchedules,
    ),
    speedBonusMeters:
      fastMovementBonusMeters({ classSlug, level }) +
      unarmoredMovementBonusMeters({
        classSlug,
        level,
        featureSchedules,
      }) +
      rangerSpeedBonusMeters({ classSlug, level }),
  };
}

function resolveAttacksPerAction(
  classSlug: string,
  level: number,
  bands: readonly FeatureScheduleBand[],
): number {
  if (isFighterClass(classSlug)) {
    return fighterAttacksPerAction(level, bands);
  }
  if (isMonkClass(classSlug)) {
    return monkAttacksPerAction(level, bands);
  }
  if (isPaladinClass(classSlug)) {
    return paladinAttacksPerAction(level, bands);
  }
  if (isRangerClass(classSlug)) {
    return rangerAttacksPerAction(level, bands);
  }
  return 1;
}
