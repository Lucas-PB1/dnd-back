import type { DataSource, Repository } from 'typeorm';
import type { CatalogLookupService } from '@catalog/catalog-lookup.service';
import type { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import type { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import type { CharacterSpellLookup } from '@game/sheet/application/character-spell-lookup';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import type { LoadEffectCatalog } from '@game/effects';
import type { CharacterStateResponseDto } from '../../dto/core/character-state-response.dto';
import type { PhbCondition } from '../phb-condition.entity';
import type { PlayerCharacterState } from '../player-character-state.entity';
import type { CoreSessionDeps } from '../character-state/core/core-session-ops';
import type { MartialSessionDeps } from '../character-state/martial/martial-deps';
import type { ResourceSessionDeps } from '../character-state/resources/resource-session-ops';

export type CharacterStateBuildResponse = (
  character: PlayerCharacter,
  state?: PlayerCharacterState,
) => Promise<CharacterStateResponseDto>;

export type CharacterStateFindOrCreate = (
  characterId: string,
  level?: number,
) => Promise<PlayerCharacterState>;

/** Portas injetadas + callbacks do repository Nest. */
export type CharacterStateRepoPorts = {
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  conditions: Repository<PhbCondition>;
  catalogLookup: CatalogLookupService;
  characters: CharacterRepository;
  spellLookup: CharacterSpellLookup;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  effectCatalog: LoadEffectCatalog;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  dataSource: DataSource;
  findOrCreate: CharacterStateFindOrCreate;
  buildResponse: CharacterStateBuildResponse;
};

export function buildCoreDeps(ports: CharacterStateRepoPorts): CoreSessionDeps {
  return {
    stateRepo: ports.stateRepo,
    conditions: ports.conditions,
    classSlots: ports.classSlots,
    subclassSlots: ports.subclassSlots,
    catalogLookup: ports.catalogLookup,
    characters: ports.characters,
    spellLookup: ports.spellLookup,
    sheetRepository: ports.sheetRepository,
    grantedSpellCatalog: ports.grantedSpellCatalog,
    effectCatalog: ports.effectCatalog,
    dataSource: ports.dataSource,
    findOrCreate: ports.findOrCreate,
    buildResponse: ports.buildResponse,
  };
}

export function buildResourceDeps(
  ports: CharacterStateRepoPorts,
): ResourceSessionDeps {
  return {
    stateRepo: ports.stateRepo,
    classSlots: ports.classSlots,
    subclassSlots: ports.subclassSlots,
    dataSource: ports.dataSource,
    findOrCreate: ports.findOrCreate,
    buildResponse: ports.buildResponse,
  };
}

export function buildMartialDeps(
  ports: CharacterStateRepoPorts,
): MartialSessionDeps {
  return {
    stateRepo: ports.stateRepo,
    dataSource: ports.dataSource,
    characters: ports.characters,
    findOrCreate: ports.findOrCreate,
    buildResponse: ports.buildResponse,
    loadMechanicalCatalog: () => ports.mechanicalCatalog.load(),
  };
}
