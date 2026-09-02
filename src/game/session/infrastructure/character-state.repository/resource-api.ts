import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { UseClassResourceResponseDto } from '../../dto/core/session-commands.dto';
import type { ResourceSessionFacade } from '../character-state/resources/resource-session.facade';
import type { CharacterStateRepoPorts } from './build-deps';
import {
  clearResourcesUsedEntryByCharacterId,
  getResourcesUsedEntry,
  setResourcesUsedEntry,
} from './session-character-ops';

/**
 * Superfície CharacterResourceSpender + aliases de recurso/slot.
 * Separada do wiring Nest do repository.
 */
export abstract class CharacterStateResourceApi {
  abstract readonly resources: ResourceSessionFacade;
  protected abstract ports(): CharacterStateRepoPorts;

  useClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<UseClassResourceResponseDto> {
    return this.resources.useClassResource(character, resourceSlug, amount);
  }

  spendClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ) {
    return this.resources.spendClassResource(character, resourceSlug, amount);
  }

  consumeSpellSlotLevel(character: PlayerCharacter, slotLevel: number) {
    return this.resources.consumeSpellSlotLevel(character, slotLevel);
  }

  recoverSpellSlotLevel(character: PlayerCharacter, slotLevel: number) {
    return this.resources.recoverSpellSlotLevel(character, slotLevel);
  }

  recoverClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ) {
    return this.resources.recoverClassResource(
      character,
      resourceSlug,
      amount,
    );
  }

  getResourcesUsedEntry(character: PlayerCharacter, key: string) {
    return getResourcesUsedEntry(this.ports(), character, key);
  }

  setResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
    value: number,
  ) {
    return setResourcesUsedEntry(this.ports(), character, key, value);
  }

  async clearResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
  ): Promise<void> {
    await this.clearResourcesUsedEntryByCharacterId(character.id, key);
  }

  clearResourcesUsedEntryByCharacterId(characterId: string, key: string) {
    return clearResourcesUsedEntryByCharacterId(this.ports(), characterId, key);
  }
}
