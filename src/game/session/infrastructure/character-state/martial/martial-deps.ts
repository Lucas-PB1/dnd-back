import { DataSource, Repository } from 'typeorm';
import type { CombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';

export type MartialSessionDeps = {
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  characters: CharacterRepository;
  findOrCreate: (
    characterId: string,
    level: number,
  ) => Promise<PlayerCharacterState>;
  buildResponse: BuildResponse;
  loadMechanicalCatalog: () => Promise<CombatMechanicalCatalog>;
};

export type { PlayerCharacter };
