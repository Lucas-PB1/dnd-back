import { DataSource, Repository } from 'typeorm';
import type { CombatMechanicalCatalog } from '../../../../combat/application/load-combat-mechanical-catalog';
import { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../../../shared/infrastructure/character.repository';
import { PlayerCharacterState } from '../../player-character-state.entity';
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
