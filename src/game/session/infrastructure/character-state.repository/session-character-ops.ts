import type { CatalogLookupService } from '@catalog/catalog-lookup.service';
import type { DataSource, Repository } from 'typeorm';
import type { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import type { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import type { LoadEffectCatalog } from '@game/effects';
import type { CharacterStateResponseDto } from '../../dto/core/character-state-response.dto';
import { buildCharacterStateResponse } from '../character-state/core/build-response';
import { applyStarryFormState } from '../character-state/druid/starry-form-mutations';
import type { PlayerCharacterState } from '../player-character-state.entity';
import type {
  CharacterStateFindOrCreate,
  CharacterStateRepoPorts,
} from './build-deps';

type SessionCharacterPorts = Pick<
  CharacterStateRepoPorts,
  'stateRepo' | 'characters' | 'findOrCreate' | 'buildResponse'
>;

type BuildResponsePorts = {
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  effectCatalog: LoadEffectCatalog;
  findOrCreate: CharacterStateFindOrCreate;
};

export async function buildResponseOp(
  ports: BuildResponsePorts,
  character: PlayerCharacter,
  stateRow?: PlayerCharacterState,
): Promise<CharacterStateResponseDto> {
  const state =
    stateRow ?? (await ports.findOrCreate(character.id, character.level));
  return buildCharacterStateResponse({
    character,
    state,
    stateRepo: ports.stateRepo,
    classSlots: ports.classSlots,
    subclassSlots: ports.subclassSlots,
    catalogLookup: ports.catalogLookup,
    dataSource: ports.dataSource,
    sheetRepository: ports.sheetRepository,
    grantedSpellCatalog: ports.grantedSpellCatalog,
    effectCatalog: ports.effectCatalog,
  });
}

export async function getResourcesUsedEntry(
  ports: Pick<SessionCharacterPorts, 'findOrCreate'>,
  character: PlayerCharacter,
  key: string,
): Promise<number> {
  const state = await ports.findOrCreate(character.id, character.level);
  return state.resourcesUsed?.[key] ?? 0;
}

export async function setResourcesUsedEntry(
  ports: Pick<SessionCharacterPorts, 'stateRepo' | 'findOrCreate'>,
  character: PlayerCharacter,
  key: string,
  value: number,
): Promise<void> {
  const state = await ports.findOrCreate(character.id, character.level);
  state.resourcesUsed = { ...(state.resourcesUsed ?? {}), [key]: value };
  await ports.stateRepo.save(state);
}

export async function getInspiration(
  ports: Pick<SessionCharacterPorts, 'findOrCreate'>,
  character: PlayerCharacter,
): Promise<boolean> {
  const state = await ports.findOrCreate(character.id, character.level);
  return Boolean(state.inspiration);
}

export async function setInspiration(
  ports: Pick<SessionCharacterPorts, 'stateRepo' | 'findOrCreate'>,
  character: PlayerCharacter,
  value: boolean,
): Promise<void> {
  const state = await ports.findOrCreate(character.id, character.level);
  state.inspiration = value;
  await ports.stateRepo.save(state);
}

export async function clearResourcesUsedEntryByCharacterId(
  ports: Pick<SessionCharacterPorts, 'stateRepo' | 'findOrCreate'>,
  characterId: string,
  key: string,
): Promise<void> {
  if (!characterId) return;
  const state = await ports.findOrCreate(characterId);
  const used = { ...(state.resourcesUsed ?? {}) };
  if (!(key in used)) return;
  delete used[key];
  state.resourcesUsed = used;
  await ports.stateRepo.save(state);
}

/** Persiste PV atuais (dano/cura de table-action) e devolve o state completo. */
export async function applyCurrentHitPointsOp(
  ports: SessionCharacterPorts,
  character: PlayerCharacter,
  hitPointsCurrent: number,
): Promise<CharacterStateResponseDto> {
  const max = character.hitPointsMax;
  const capped =
    max == null
      ? Math.max(0, hitPointsCurrent)
      : Math.min(max, Math.max(0, hitPointsCurrent));
  character.hitPointsCurrent = capped;
  await ports.characters.save(character);
  return ports.buildResponse(character);
}

export async function setMissileMageArmedFlagsOp(
  ports: SessionCharacterPorts,
  character: PlayerCharacter,
  flags: {
    missileShieldArmed?: boolean;
    gigaMissileArmed?: boolean;
  },
): Promise<PlayerCharacterState> {
  const state = await ports.findOrCreate(character.id, character.level);
  if (flags.missileShieldArmed !== undefined) {
    state.missileShieldArmed = flags.missileShieldArmed;
  }
  if (flags.gigaMissileArmed !== undefined) {
    state.gigaMissileArmed = flags.gigaMissileArmed;
  }
  return ports.stateRepo.save(state);
}

export async function setStarryFormOp(
  ports: SessionCharacterPorts,
  character: PlayerCharacter,
  input: {
    active: boolean;
    constellation?: 'archer' | 'chalice' | 'dragon' | null;
  },
): Promise<CharacterStateResponseDto> {
  const state = await ports.findOrCreate(character.id, character.level);
  return applyStarryFormState({
    character,
    state,
    active: input.active,
    constellation: input.constellation,
    stateRepo: ports.stateRepo,
    buildResponse: ports.buildResponse,
  });
}
