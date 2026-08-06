import type {
  ActionSurgeResponseDto,
  SecondWindResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
} from '../../../dto/character-state.dto';
import type { FighterActionDeps } from './fighter-action-deps';

export async function useSecondWindAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
): Promise<SecondWindResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  return deps.state.martial.useSecondWind(character);
}

export async function useTacticalMindAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
  dto: TacticalMindDto = {},
): Promise<TacticalMindResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  return deps.state.martial.useTacticalMind(
    character,
    dto.checkTotal,
    dto.dc,
  );
}

export async function useActionSurgeAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
): Promise<ActionSurgeResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  return deps.state.martial.useActionSurge(character);
}
