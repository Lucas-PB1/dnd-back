import type { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseSorcererTableActionDto,
} from '../../../dto/character-state.dto';
import { CharacterStateRepository } from '../../../infrastructure/character-state.repository';

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
