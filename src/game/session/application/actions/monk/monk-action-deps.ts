import { monkFocusSaveDc } from '@game/combat/domain/monk';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseMonkTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const FOCUS_RESOURCE_SLUG = 'focusPoints';

export type MonkActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type MonkTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseMonkTableActionDto };

export async function spendFocus(
  deps: MonkActionDeps,
  character: PlayerCharacter,
  amount: number,
): Promise<TableActionResponseDto['state']> {
  const result = await deps.state.useClassResource(
    character,
    FOCUS_RESOURCE_SLUG,
    amount,
  );
  return result.state;
}

export async function focusDc(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const pb = await deps.domain.getProficiencyBonus(character.level);
  return monkFocusSaveDc({
    wisdomModifier: abilityModifier(character.abilityScores.sabedoria),
    proficiencyBonus: pb,
  });
}
