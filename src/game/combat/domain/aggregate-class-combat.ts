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
import { warlockCombatNotes } from './warlock';
import { druidCombatNotes } from './druid';
import { wizardCombatNotes } from './wizard';
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
  /** Notas de combate por nível do catálogo (GH, Northlands, packs PHB). */
  levelCombatNotes?: readonly LevelCombatNoteRow[];
};

/**
 * Agrega contribuições explícitas de cada classe.
 * Textos estáticos por nível vêm de `phb_level_combat_note`; funções *CombatNotes
 * cobrem notas dinâmicas (dados, templates, estado).
 */
export function aggregateClassCombatContributions(
  input: ClassCombatInput,
): ClassCombatContribution {
  const { classSlug, subclassSlug, level, levelCombatNotes = [] } = input;

  const notes = [
    ...barbarianCombatNotes({ classSlug, subclassSlug, level }),
    ...fighterCombatNotes({ classSlug, subclassSlug, level }),
    ...rogueCombatNotes({ classSlug, subclassSlug, level }),
    ...monkCombatNotes({ classSlug, subclassSlug, level }),
    ...paladinCombatNotes({ classSlug, subclassSlug, level }),
    ...rangerCombatNotes({ classSlug, subclassSlug, level }),
    ...clericCombatNotes({ classSlug, subclassSlug, level }),
    ...bardCombatNotes({ classSlug, subclassSlug, level }),
    ...warlockCombatNotes({ classSlug, subclassSlug, level }),
    ...druidCombatNotes({ classSlug, subclassSlug, level }),
    ...wizardCombatNotes({ classSlug, subclassSlug, level }),
    ...filterLevelCombatNotes(levelCombatNotes, 'subclass', subclassSlug, level),
    ...filterLevelCombatNotes(levelCombatNotes, 'class', classSlug, level),
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
