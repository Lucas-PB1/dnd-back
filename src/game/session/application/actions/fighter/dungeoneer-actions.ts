import { BadRequestException } from '@nestjs/common';
import { findDungeoneerPrecautionSpell } from '@game/combat/domain/fighter-table-actions';
import type {
  FighterTableActionResponseDto,
  UseDungeonPrecautionDto,
} from '@game/session/dto/character-state.dto';
import type { FighterActionDeps } from './fighter-action-deps';

export async function useDungeonPrecautionAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
  dto: UseDungeonPrecautionDto,
): Promise<FighterTableActionResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  const catalog = await deps.mechanicalCatalog.load();
  const spell = findDungeoneerPrecautionSpell(
    catalog.precautionSpells,
    dto.spellSlug,
  );
  if (
    character.classSlug !== 'fighter' ||
    character.subclassSlug !== 'dungeoneer' ||
    character.level < 7 ||
    !spell
  ) {
    throw new BadRequestException('Dungeon Precaution is not available');
  }
  const spent = await deps.state.useClassResource(
    character,
    'dungeon-precautions',
    1,
  );
  return {
    state: spent.state,
    actionName: spell.name,
    resourceSpent: true,
    note: `Precauções na Masmorra: conjure ${spell.name} sem gastar espaço de magia; escolha INT, SAB ou CAR como atributo de conjuração.`,
  };
}
