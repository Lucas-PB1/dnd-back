import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export type CharacterResourceSpender = {
  spendClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount?: number,
  ): Promise<void>;
  consumeSpellSlotLevel(
    character: PlayerCharacter,
    slotLevel: number,
  ): Promise<void>;
  getResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
  ): Promise<number>;
  setResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
    value: number,
  ): Promise<void>;
  clearResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
  ): Promise<void>;
  getInspiration(character: PlayerCharacter): Promise<boolean>;
  setInspiration(character: PlayerCharacter, value: boolean): Promise<void>;
};
