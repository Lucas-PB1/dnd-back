import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import type { GunslingerManeuver } from '@game/combat/domain/gunslinger';
import {
  findGunslingerManeuver,
  listGunslingerManeuvers,
} from '@game/combat/domain/gunslinger';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { resolveManeuverEffect, rollRiskDie } from '@game/session/domain/maneuver-resolve';
import {
  CharacterStateResponseDto,
  UseManeuverResponseDto,
} from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { resolveClassResources } from '../resources/class-resources';
import type { BuildResponse } from '../core/mutation-types';

export async function applyUseManeuver(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  maneuverSlug: string;
  maneuvers: readonly GunslingerManeuver[];
  stateRepo: Repository<PlayerCharacterState>;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<UseManeuverResponseDto> {
  const {
    character,
    state,
    maneuverSlug,
    maneuvers,
    stateRepo,
    dataSource,
    buildResponse,
  } = input;

  if (character.classSlug !== 'gunslinger') {
    throw new BadRequestException('Maneuvers require the Gunslinger class');
  }

  const maneuver = findGunslingerManeuver(maneuvers, maneuverSlug);
  if (!maneuver) {
    throw new BadRequestException(`Unknown maneuver '${maneuverSlug}'`);
  }
  if (character.level < maneuver.fromLevel) {
    throw new BadRequestException(
      `Maneuver '${maneuverSlug}' unlocks at level ${maneuver.fromLevel}`,
    );
  }

  const resources = await resolveClassResources(dataSource, character);
  const risk = resources.find((item) => item.slug === 'risk');
  if (!risk) {
    throw new BadRequestException('Risk dice are not available yet');
  }

  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      'risk',
      risk.max,
      maneuver.riskCost,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend Risk',
    );
  }

  const riskRoll = rollRiskDie(character.level);
  if (!riskRoll) {
    throw new BadRequestException('Risk die is not available at this level');
  }

  const effect = resolveManeuverEffect({
    maneuver,
    riskRoll,
    gunslingerLevel: character.level,
    dexterityModifier: abilityModifier(character.abilityScores.destreza),
  });

  if (effect.tempHpGained != null) {
    state.tempHp = Math.max(state.tempHp ?? 0, effect.tempHpGained);
  }

  await stateRepo.save(state);
  return {
    state: await buildResponse(character, state),
    maneuverSlug: effect.maneuverSlug,
    maneuverName: effect.maneuverName,
    effectKind: effect.effectKind,
    riskRoll: effect.riskRoll,
    tempHpGained: effect.tempHpGained,
    missDamage: effect.missDamage,
    acBonus: effect.acBonus,
    checkBonus: effect.checkBonus,
    note: effect.note,
  };
}

export async function applyReloadFirearm(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  itemSlug: string;
  capacity: number;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const { character, state, itemSlug, capacity, stateRepo, buildResponse } =
    input;
  if (capacity < 1) {
    throw new BadRequestException(
      `Weapon '${itemSlug}' has no reload capacity`,
    );
  }
  state.firearmChambers = {
    ...(state.firearmChambers ?? {}),
    [itemSlug]: capacity,
  };
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export async function applyFireChamber(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  itemSlug: string;
  capacity: number;
  shots: number;
  stateRepo: Repository<PlayerCharacterState>;
  buildResponse: BuildResponse;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    itemSlug,
    capacity,
    shots,
    stateRepo,
    buildResponse,
  } = input;
  const chambers = { ...(state.firearmChambers ?? {}) };
  const current = chambers[itemSlug] ?? (capacity > 0 ? capacity : 0);
  if (current < shots) {
    throw new BadRequestException(
      `Chamber empty or insufficient shots on '${itemSlug}' (${current}/${capacity})`,
    );
  }
  chambers[itemSlug] = current - shots;
  state.firearmChambers = chambers;
  await stateRepo.save(state);
  return buildResponse(character, state);
}

export function listAvailableManeuvers(
  character: PlayerCharacter,
  maneuvers: readonly GunslingerManeuver[],
) {
  if (character.classSlug !== 'gunslinger') return [];
  return listGunslingerManeuvers(maneuvers, {
    level: character.level,
    subclassSlug: character.subclassSlug,
  });
}
