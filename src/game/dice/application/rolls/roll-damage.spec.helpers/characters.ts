import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { testScores } from './mocks';

export const CHARACTERS = {
  fighter: {
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: null,
    level: 5,
  },
  psiWarrior: {
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: 'psi-warrior',
    level: 7,
    abilityScores: testScores({ inteligencia: 16 }),
  },
  rogueThief: {
    id: 'c1',
    classSlug: 'rogue',
    subclassSlug: 'thief',
    level: 5,
    abilityScores: testScores({ forca: 8, destreza: 18 }),
  },
  rogueBasic: {
    id: 'c1',
    classSlug: 'rogue',
    subclassSlug: null,
    level: 5,
    abilityScores: testScores(),
  },
  assassin: {
    id: 'c1',
    classSlug: 'rogue',
    subclassSlug: 'assassin',
    level: 17,
    abilityScores: testScores({ forca: 8, destreza: 20 }),
  },
  paladinL11: {
    id: 'c1',
    classSlug: 'paladin',
    subclassSlug: 'devotion',
    level: 11,
    abilityScores: testScores({ carisma: 16 }),
  },
  paladinL10: {
    id: 'c1',
    classSlug: 'paladin',
    subclassSlug: 'devotion',
    level: 10,
    abilityScores: testScores({ carisma: 16 }),
  },
  paladinL5: {
    id: 'c1',
    classSlug: 'paladin',
    subclassSlug: 'devotion',
    level: 5,
    abilityScores: testScores({ carisma: 16 }),
  },
  gloomStalker: {
    id: 'c1',
    classSlug: 'ranger',
    subclassSlug: 'gloom-stalker',
    level: 3,
    abilityScores: testScores({ destreza: 16, sabedoria: 14 }),
  },
  warCleric: {
    id: 'c1',
    classSlug: 'cleric',
    subclassSlug: 'war',
    level: 14,
    abilityScores: testScores({ sabedoria: 18 }),
  },
} satisfies Record<string, Partial<PlayerCharacter> & Pick<PlayerCharacter, 'classSlug'>>;
