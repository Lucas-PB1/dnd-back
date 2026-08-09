import { BadRequestException } from '@nestjs/common';
import { listBattleMasterManeuvers } from '@game/combat/domain/fighter';
import { resolveBattleMasterTableRoll } from '@game/combat/domain/fighter';
import { superiorityDieFaces } from '@game/combat/domain/fighter';
import { rollDie } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type {
  FighterTableActionResponseDto,
  UseBattleMasterManeuverDto,
} from '@game/session/dto';
import type { FighterActionDeps } from './fighter-action-deps';

export async function listBattleMasterManeuversAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
) {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'read',
  );
  if (
    character.classSlug !== 'fighter' ||
    character.subclassSlug !== 'battle-master' ||
    character.level < 3
  ) {
    return [];
  }
  const catalog = await deps.mechanicalCatalog.load();
  const maneuvers = listBattleMasterManeuvers(catalog.battleMasterManeuvers);
  const sheet = await deps.sheet.load(
    character.id,
    character.backgroundSlug,
  );
  const selected = new Set(
    sheet.subclassOptions
      .filter((option) => option.optionKey.startsWith('maneuver'))
      .map((option) => option.valueId),
  );
  return selected.size === 0
    ? maneuvers
    : maneuvers.filter((maneuver) => selected.has(maneuver.slug));
}

export async function useBattleMasterManeuverAction(
  deps: FighterActionDeps,
  userId: string,
  characterId: string,
  dto: UseBattleMasterManeuverDto,
): Promise<FighterTableActionResponseDto> {
  const character = await deps.access.findAccessibleOrFail(
    userId,
    characterId,
    'write',
  );
  if (
    character.classSlug !== 'fighter' ||
    character.subclassSlug !== 'battle-master'
  ) {
    throw new BadRequestException('Battle Master maneuver is not available');
  }

  const available = await listBattleMasterManeuversAction(
    deps,
    userId,
    characterId,
  );
  if (!available.some((maneuver) => maneuver.slug === dto.maneuverSlug)) {
    throw new BadRequestException(
      `Maneuver '${dto.maneuverSlug}' is not selected by this character`,
    );
  }

  const dieFaces = dto.useRelentless
    ? 8
    : superiorityDieFaces(character.level);
  if (dieFaces == null) {
    throw new BadRequestException('Superiority Die is not available');
  }
  const dieRoll = rollDie(dieFaces);
  const proficiencyBonus = await deps.domain.getProficiencyBonus(
    character.level,
  );

  let state = await deps.state.buildResponse(character);
  if (!dto.useRelentless) {
    state = (
      await deps.state.useClassResource(character, 'superiority-dice', 1)
    ).state;
  }

  try {
    const catalog = await deps.mechanicalCatalog.load();
    const result = resolveBattleMasterTableRoll({
      catalog: catalog.battleMasterManeuvers,
      maneuverSlug: dto.maneuverSlug,
      level: character.level,
      proficiencyBonus,
      strengthModifier: abilityModifier(character.abilityScores.forca),
      dexterityModifier: abilityModifier(character.abilityScores.destreza),
      charismaModifier: abilityModifier(character.abilityScores.carisma),
      dieRoll,
      useRelentless: dto.useRelentless,
    });
    return {
      state,
      actionName: result.maneuver.name,
      expression: result.expression,
      roll: result.roll,
      total: result.effectValue,
      saveDc: result.saveDc,
      resourceSpent: result.resourceSpent,
      note: result.note,
    };
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot use maneuver',
    );
  }
}
