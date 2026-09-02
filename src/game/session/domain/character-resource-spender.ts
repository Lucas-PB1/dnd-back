import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

/**
 * Porta usada pelas rolls para gastar recursos/slots sem SQL ad-hoc.
 * Implementada por CharacterStateRepository (findOrCreate + save).
 */
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
  /** Lê contador em resourcesUsed (ex.: locks órfãos fora do schedule). */
  getResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
  ): Promise<number>;
  /** Grava contador em resourcesUsed sem passar pelo schedule. */
  setResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
    value: number,
  ): Promise<void>;
  clearResourcesUsedEntry(
    character: PlayerCharacter,
    key: string,
  ): Promise<void>;
};
