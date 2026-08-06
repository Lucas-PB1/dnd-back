import type { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseDruidTableActionDto,
} from '../../../dto/character-state.dto';
import { CharacterStateRepository } from '../../../infrastructure/character-state.repository';

export const WILD_SHAPE_SLUG = 'wildShape';

export type DruidActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type DruidTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseDruidTableActionDto };

export async function spendWildShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<TableActionResponseDto['state']> {
  try {
    const result = await deps.state.useClassResource(
      character,
      WILD_SHAPE_SLUG,
      1,
    );
    return result.state;
  } catch {
    const result = await deps.state.useClassResource(
      character,
      'wild-shape',
      1,
    );
    return result.state;
  }
}

export async function recoverWildShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<TableActionResponseDto['state']> {
  try {
    return await deps.state.recoverClassResource(
      character,
      WILD_SHAPE_SLUG,
      1,
    );
  } catch {
    return await deps.state.recoverClassResource(character, 'wild-shape', 1);
  }
}
