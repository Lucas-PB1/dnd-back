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
};
