import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../../../sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '../../../../sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '../../../../spellcasting/application/load-granted-spell-catalog';
import { VClassSpellSlots } from '../../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../../entities/views/v-subclass-spell-slots.entity';
import { grantHitDiceOnLevelUp } from '../../../domain/hit-dice-rest';
import {
  CastSpellDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  RestResponseDto,
} from '../../../dto/character-state.dto';
import { PhbCondition } from '../../phb-condition.entity';
import { PlayerCharacterState } from '../../player-character-state.entity';
import type { BuildResponse } from '../core/mutation-types';
import { applyPatchState } from '../core/patch-state';
import { applyLongRestState, applyShortRestState } from '../rest/rest';
import { applyCastSpell } from '../spell/cast-spell';

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
  dataSource: import('typeorm').DataSource;
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
): Promise<{ slotLevelUsed: number | null; state: CharacterStateResponseDto }> {
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
