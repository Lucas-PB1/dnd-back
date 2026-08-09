import { BadRequestException } from '@nestjs/common';
import { resolvePsiWarriorTableAction } from '@game/combat/domain/fighter';
import { psiEnergyDieFaces } from '@game/combat/domain/fighter';
import { rollDie } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type {
  FighterTableActionResponseDto,
  UsePsiWarriorActionDto,
} from '@game/session/dto';
import type { FighterActionDeps } from './fighter-action-deps';

export async function usePsiWarriorAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
  dto: UsePsiWarriorActionDto,
): Promise<FighterTableActionResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  if (
    character.classSlug !== 'fighter' ||
    character.subclassSlug !== 'psi-warrior'
  ) {
    throw new BadRequestException('Psi Warrior action is not available');
  }

  const dieFaces = psiEnergyDieFaces(character.level);
  const dieRoll =
    dto.actionSlug === 'protective-field' && dieFaces != null
      ? rollDie(dieFaces)
      : undefined;
  try {
    const catalog = await deps.mechanicalCatalog.load();
    const result = resolvePsiWarriorTableAction({
      catalog: catalog.tableActions,
      actionSlug: dto.actionSlug,
      level: character.level,
      intelligenceModifier: abilityModifier(
        character.abilityScores.inteligencia,
      ),
      dieRoll,
      usePsiDie: dto.usePsiDie,
    });
    if (!result.resourceSlug) {
      throw new Error(`${result.actionName} has no resource configured`);
    }
    const spent = await deps.state.useClassResource(
      character,
      result.resourceSlug,
      1,
    );
    return {
      state: spent.state,
      actionName: result.actionName,
      expression: result.expression,
      roll: result.roll,
      total: result.total,
      saveDc: result.saveDc,
      resourceSpent: true,
      note: result.note,
    };
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot use Psi Warrior action',
    );
  }
}
