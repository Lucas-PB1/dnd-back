import { BadRequestException } from '@nestjs/common';
import {
  listBattleMasterManeuvers,
  resolveBattleMasterTableRoll,
  superiorityDieFaces,
} from '@game/combat/domain/fighter';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { rollDie } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyTemporaryHitPoints } from './apply-temporary-hit-points';

export async function applyCatalogManeuverTableAction(input: {
  state: CharacterStateRepository;
  sheet: CharacterSheetRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  character: PlayerCharacter;
  maneuverSlug: string;
  useRelentless?: boolean;
  proficiencyBonus: number;
}): Promise<TableActionResponseDto> {
  const { character } = input;
  if (
    character.classSlug !== 'fighter' ||
    character.subclassSlug !== 'battle-master'
  ) {
    throw new BadRequestException('Battle Master maneuver is not available');
  }
  if (!input.maneuverSlug) {
    throw new BadRequestException('maneuverSlug é obrigatório');
  }

  const catalog = await input.mechanicalCatalog.load();
  const maneuvers = listBattleMasterManeuvers(catalog.battleMasterManeuvers);
  const sheet = await input.sheet.load(
    character.id,
    character.backgroundSlug,
  );
  const selected = new Set(
    sheet.subclassOptions
      .filter((option) => option.optionKey.startsWith('maneuver'))
      .map((option) => option.valueId),
  );
  const available =
    selected.size === 0
      ? maneuvers
      : maneuvers.filter((maneuver) => selected.has(maneuver.slug));
  if (!available.some((maneuver) => maneuver.slug === input.maneuverSlug)) {
    throw new BadRequestException(
      `Maneuver '${input.maneuverSlug}' is not selected by this character`,
    );
  }

  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const dieFaces = input.useRelentless
    ? 8
    : superiorityDieFaces(character.level, bands);
  if (dieFaces == null) {
    throw new BadRequestException('Superiority Die is not available');
  }
  const dieRoll = rollDie(dieFaces);

  let state = await input.state.buildResponse(character);
  if (!input.useRelentless) {
    state = (
      await input.state.useClassResource(character, 'superiority-dice', 1)
    ).state;
  }

  try {
    const result = resolveBattleMasterTableRoll({
      catalog: catalog.battleMasterManeuvers,
      maneuverSlug: input.maneuverSlug,
      level: character.level,
      proficiencyBonus: input.proficiencyBonus,
      strengthModifier: abilityModifier(character.abilityScores.forca),
      dexterityModifier: abilityModifier(character.abilityScores.destreza),
      charismaModifier: abilityModifier(character.abilityScores.carisma),
      dieRoll,
      useRelentless: input.useRelentless,
      bands,
    });

    let note = result.note;
    if (result.maneuver.slug === 'rally' && result.effectValue > 0) {
      state = await applyTemporaryHitPoints(
        input.state,
        character,
        result.effectValue,
      );
      note = `${result.note} PV temp. aplicados neste PC (${result.effectValue}). Aliado: ajuste na mesa.`;
    }

    return {
      state,
      actionName: result.maneuver.name,
      expression: result.expression,
      roll: result.roll,
      total: result.effectValue,
      saveDc: result.saveDc,
      resourceSpent: result.resourceSpent,
      note,
    };
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot use maneuver',
    );
  }
}
