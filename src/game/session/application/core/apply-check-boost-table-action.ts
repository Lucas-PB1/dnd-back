import { BadRequestException } from '@nestjs/common';
import { rollDie } from '@game/dice/domain/dice';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

/**
 * Mente Tática / boosts de teste: rola 1d10; gasta o pool só se check+dc virarem sucesso
 * (ou sempre, se o contexto de teste não for informado).
 */
export async function applyCheckBoostTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  actionName: string;
  checkTotal?: number;
  dc?: number;
  note?: string | null;
  dieFaces?: number;
}): Promise<TableActionResponseDto> {
  const faces = input.dieFaces ?? 10;
  const roll = rollDie(faces);
  const hasCheckContext =
    typeof input.checkTotal === 'number' && typeof input.dc === 'number';

  if (hasCheckContext) {
    const newTotal = input.checkTotal! + roll;
    const success = newTotal >= input.dc!;
    let state = await input.state.buildResponse(input.character);
    let resourceSpent = false;
    if (success) {
      state = (
        await input.state.useClassResource(
          input.character,
          input.resourceSlug,
          1,
        )
      ).state;
      resourceSpent = true;
    }
    return {
      state,
      actionName: input.actionName,
      expression: `1d${faces}`,
      roll,
      total: newTotal,
      resourceSpent,
      note: success
        ? input.note?.trim() ||
          `${input.actionName}: ${input.checkTotal} + ${roll} = ${newTotal} vs ${input.dc}; sucesso, dado gasto`
        : `${input.actionName}: ${input.checkTotal} + ${roll} = ${newTotal} vs ${input.dc}; ainda falhou, dado preservado`,
    };
  }

  try {
    const spent = await input.state.useClassResource(
      input.character,
      input.resourceSlug,
      1,
    );
    return {
      state: spent.state,
      actionName: input.actionName,
      expression: `1d${faces}`,
      roll,
      total: roll,
      resourceSpent: true,
      note:
        input.note?.trim() ||
        `${input.actionName}: +${roll} (1d${faces}). Some ao teste; se ainda falhar, devolva o uso.`,
    };
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend resource',
    );
  }
}
