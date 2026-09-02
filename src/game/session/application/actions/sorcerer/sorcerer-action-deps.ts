import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseSorcererTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const SORCERY_POINTS_SLUG = 'sorceryPoints';

export type SorcererActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type SorcererTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseSorcererTableActionDto };

export async function spendPoints(
  deps: SorcererActionDeps,
  character: PlayerCharacter,
  amount: number,
): Promise<TableActionResponseDto['state']> {
  try {
    const result = await deps.state.useClassResource(
      character,
      SORCERY_POINTS_SLUG,
      amount,
    );
    return result.state;
  } catch {
    const result = await deps.state.useClassResource(
      character,
      'sorcery-points',
      amount,
    );
    return result.state;
  }
}
