import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '@game/sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { LoadEffectCatalog } from '@game/effects';
import { SyncSpellSpiritHandler } from '@game/spirit/application/sync-spell-spirit.handler';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { grantHitDiceOnLevelUp } from '@game/session/domain/hit-dice-rest';
import {
  CastSpellDto,
  PatchCharacterStateDto,
  RestResponseDto,
} from '@game/session/dto/core/session-commands.dto';
import {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import { PhbCondition } from '@game/session/infrastructure/phb-condition.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';
import { applyPatchState } from '../core/patch-state';
import { applyLongRestState, applyShortRestState } from '../rest/rest';
import { applyCastSpell } from '../spell/cast-spell';
import type { SyncSpellSpiritResult } from '@game/spirit/application/sync-spell-spirit.handler';

export type CoreSessionDeps = {
  stateRepo: Repository<PlayerCharacterState>;
  conditions: Repository<PhbCondition>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  catalogLookup: CatalogLookupService;
  characters: CharacterRepository;
  spellLookup: CharacterSpellLookup;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  effectCatalog: LoadEffectCatalog;
  dataSource: import('typeorm').DataSource;
  syncSpellSpirit: SyncSpellSpiritHandler;
  findOrCreate: (characterId: string, level: number) => Promise<PlayerCharacterState>;
  buildResponse: BuildResponse;
};

export async function patchStateOp(
  deps: CoreSessionDeps,
  character: PlayerCharacter,
  dto: PatchCharacterStateDto,
): Promise<CharacterStateResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyPatchState({
    character,
    state,
    dto,
    stateRepo: deps.stateRepo,
    conditions: deps.conditions,
    catalogLookup: deps.catalogLookup,
    buildResponse: deps.buildResponse,
  });
}

export async function castSpellOp(
  deps: CoreSessionDeps,
  character: PlayerCharacter,
  dto: CastSpellDto,
): Promise<{
  slotLevelUsed: number | null;
  note: string | null;
  spellSaveDcOverride: number | null;
  spellAttackBonusOverride: number | null;
  spirit: SyncSpellSpiritResult | null;
  state: CharacterStateResponseDto;
}> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyCastSpell({
    character,
    state,
    dto,
    stateRepo: deps.stateRepo,
    classSlots: deps.classSlots,
    subclassSlots: deps.subclassSlots,
    catalogLookup: deps.catalogLookup,
    spellLookup: deps.spellLookup,
    sheetRepository: deps.sheetRepository,
    grantedSpellCatalog: deps.grantedSpellCatalog,
    effectCatalog: deps.effectCatalog,
    dataSource: deps.dataSource,
    syncSpellSpirit: deps.syncSpellSpirit,
    buildResponse: deps.buildResponse,
  });
}

export async function applyLongRestOp(
  deps: CoreSessionDeps,
  character: PlayerCharacter,
): Promise<RestResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyLongRestState({
    character,
    state,
    stateRepo: deps.stateRepo,
    characters: deps.characters,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function applyShortRestOp(
  deps: CoreSessionDeps,
  character: PlayerCharacter,
  hitDiceSpent = 0,
): Promise<RestResponseDto> {
  const state = await deps.findOrCreate(character.id, character.level);
  return applyShortRestState({
    character,
    state,
    hitDiceSpent,
    stateRepo: deps.stateRepo,
    characters: deps.characters,
    catalogLookup: deps.catalogLookup,
    dataSource: deps.dataSource,
    buildResponse: deps.buildResponse,
  });
}

export async function syncHitDiceOnLevelChangeOp(
  deps: Pick<CoreSessionDeps, 'stateRepo' | 'findOrCreate'>,
  characterId: string,
  previousLevel: number,
  newLevel: number,
): Promise<void> {
  const state = await deps.findOrCreate(characterId, previousLevel);
  state.hitDiceCurrent = grantHitDiceOnLevelUp(
    state.hitDiceCurrent,
    previousLevel,
    newLevel,
  );
  await deps.stateRepo.save(state);
}
