import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { LoadEffectCatalog } from '@game/effects';
import {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { buildClassResourceState } from '../resources/class-resources';
import { clampHitDiceToLevel } from '../resources/hit-dice';
import { computeRemaining, loadMaxSlots } from '../resources/spell-slots';
import { buildGrantedSpellCastOptions } from './build-response/granted-spell-cast-options';

export async function buildCharacterStateResponse(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  effectCatalog: LoadEffectCatalog;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    stateRepo,
    classSlots,
    subclassSlots,
    catalogLookup,
    dataSource,
    sheetRepository,
    grantedSpellCatalog,
    effectCatalog,
  } = input;

  await clampHitDiceToLevel(stateRepo, state, character.level);
  const spellSlotsMax = await loadMaxSlots(
    classSlots,
    subclassSlots,
    character.classSlug,
    character.level,
    character.subclassSlug,
  );
  const spellSlotsUsed = state.spellSlotsUsed ?? {};
  const phbClass = await catalogLookup.findClassOrFail(character.classSlug);
  const classResources = await buildClassResourceState(
    dataSource,
    character,
    state,
  );
  const grantedSpellUses = state.grantedSpellUses ?? {};
  const grantedSpellCastOptions = await buildGrantedSpellCastOptions(
    character,
    grantedSpellUses,
    sheetRepository,
    grantedSpellCatalog,
    dataSource,
    effectCatalog,
  );

  return {
    spellSlotsMax,
    spellSlotsUsed,
    spellSlotsRemaining: computeRemaining(spellSlotsMax, spellSlotsUsed),
    classResources,
    concentratingOn: state.concentratingOn,
    conditions: state.conditions ?? [],
    tempHp: state.tempHp,
    hitPointsCurrent: character.hitPointsCurrent,
    hitPointsMax: character.hitPointsMax,
    hitDiceCurrent: state.hitDiceCurrent,
    hitDiceMax: character.level,
    hitDie: phbClass.hitDie,
    deathSaveSuccesses: state.deathSaveSuccesses ?? 0,
    deathSaveFailures: state.deathSaveFailures ?? 0,
    inspiration: state.inspiration ?? false,
    grantedSpellUses,
    highElfCantripSwapAvailable: state.highElfCantripSwapAvailable ?? false,
    grantedSpellCastOptions,
    firearmChambers: state.firearmChambers ?? {},
    rageActive: state.rageActive ?? false,
    recklessActive: state.recklessActive ?? false,
    personaMasks: state.personaMasks ?? [],
    bestialAspectLevel: state.bestialAspectLevel ?? 0,
    missileShieldArmed: state.missileShieldArmed ?? false,
    gigaMissileArmed: state.gigaMissileArmed ?? false,
    starryFormActive: state.starryFormActive ?? false,
    stellarConstellation: state.stellarConstellation ?? null,
    aberrantMutationActive: state.aberrantMutationActive ?? null,
    boardedActorId: state.boardedActorId ?? null,
  };
}
