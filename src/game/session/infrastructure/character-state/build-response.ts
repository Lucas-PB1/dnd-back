import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { CharacterStateResponseDto } from '../../dto/character-state.dto';
import { PlayerCharacterState } from '../player-character-state.entity';
import { buildClassResourceState } from './class-resources';
import { clampHitDiceToLevel } from './hit-dice';
import { computeRemaining, loadMaxSlots } from './spell-slots';

export async function buildCharacterStateResponse(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    stateRepo,
    classSlots,
    subclassSlots,
    catalogLookup,
    dataSource,
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
  };
}
