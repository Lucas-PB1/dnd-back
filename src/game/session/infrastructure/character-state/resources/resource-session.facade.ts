import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { UseClassResourceResponseDto } from '@game/session/dto';
import {
  consumeSpellSlotLevelOp,
  recoverClassResourceOp,
  recoverSpellSlotLevelOp,
  spendClassResourceOp,
  useClassResourceOp,
  type ResourceSessionDeps,
} from '../resources/resource-session-ops';

/** Agrupa ops de recurso/slot; deps via factory do repository. */
export class ResourceSessionFacade {
  constructor(private readonly getDeps: () => ResourceSessionDeps) {}

  useClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<UseClassResourceResponseDto> {
    return useClassResourceOp(this.getDeps(), character, resourceSlug, amount);
  }

  async spendClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<void> {
    await spendClassResourceOp(
      this.getDeps(),
      character,
      resourceSlug,
      amount,
    );
  }

  consumeSpellSlotLevel(character: PlayerCharacter, slotLevel: number) {
    return consumeSpellSlotLevelOp(this.getDeps(), character, slotLevel);
  }

  recoverSpellSlotLevel(character: PlayerCharacter, slotLevel: number) {
    return recoverSpellSlotLevelOp(this.getDeps(), character, slotLevel);
  }

  recoverClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ) {
    return recoverClassResourceOp(
      this.getDeps(),
      character,
      resourceSlug,
      amount,
    );
  }
}
