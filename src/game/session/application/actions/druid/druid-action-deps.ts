import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseDruidTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

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
  amount = 1,
): Promise<TableActionResponseDto['state']> {
  try {
    const result = await deps.state.useClassResource(
      character,
      WILD_SHAPE_SLUG,
      amount,
    );
    return result.state;
  } catch {
    const result = await deps.state.useClassResource(
      character,
      'wild-shape',
      amount,
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

export async function spendNamedResource(
  deps: DruidActionDeps,
  character: PlayerCharacter,
  resourceSlug: string,
  amount = 1,
): Promise<TableActionResponseDto['state']> {
  const result = await deps.state.useClassResource(
    character,
    resourceSlug,
    amount,
  );
  return result.state;
}

export async function recoverNamedResource(
  deps: DruidActionDeps,
  character: PlayerCharacter,
  resourceSlug: string,
  amount = 1,
): Promise<TableActionResponseDto['state']> {
  return deps.state.recoverClassResource(character, resourceSlug, amount);
}
