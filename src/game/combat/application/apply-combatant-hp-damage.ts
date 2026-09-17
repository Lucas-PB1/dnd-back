import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { applyCombatHpDamage } from '../domain/apply-combat-hp-damage';
import {
  resolveConcentrationCheck,
  type ConcentrationCheckResult,
} from '../domain/resolve-concentration-check';

export type CombatHpTarget = {
  kind: 'pc' | 'actor';
  characterId?: string | null;
  actorId?: string | null;
};

export type ApplyCombatantHpDamageResult = {
  concentration: ConcentrationCheckResult;
};

const NO_CONCENTRATION: ConcentrationCheckResult = {
  attempted: false,
  broken: false,
  dc: 10,
  total: 0,
  spellSlug: null,
};

export async function applyCombatantHpDamage(input: {
  loadCharacter: (characterId: string) => Promise<PlayerCharacter | null>;
  characterState: CharacterStateRepository;
  actorState: ActorStateRepository;
  actors: Repository<GameActor>;
  target: CombatHpTarget;
  damage: number;
}): Promise<ApplyCombatantHpDamageResult> {
  if (input.damage <= 0) {
    return { concentration: NO_CONCENTRATION };
  }

  if (input.target.kind === 'pc' && input.target.characterId) {
    const character = await input.loadCharacter(input.target.characterId);
    if (!character) {
      throw new BadRequestException('Target character not found');
    }
    const stateBefore = await input.characterState.buildResponse(character);
    const split = applyCombatHpDamage({
      damage: input.damage,
      hitPointsCurrent: character.hitPointsCurrent ?? 0,
      tempHp: stateBefore.tempHp ?? 0,
    });
    if (split.tempHpAfter !== split.tempHpBefore) {
      await input.characterState.patch(character, { tempHp: split.tempHpAfter });
    }
    if (split.hitPointsAfter !== split.hitPointsBefore) {
      await input.characterState.applyCurrentHitPoints(
        character,
        split.hitPointsAfter,
      );
    }

    const mods = computeAbilityModifiers(character.abilityScores);
    const concentration = resolveConcentrationCheck({
      damageTaken: input.damage,
      constitutionModifier: mods.constituicao,
      concentratingOn: stateBefore.concentratingOn,
    });
    if (concentration.broken) {
      await input.characterState.patch(character, { concentratingOn: null });
    }
    return { concentration };
  }

  if (!input.target.actorId) {
    throw new BadRequestException('Target combatant is missing linked actor');
  }
  const actor = await input.actors.findOne({
    where: { id: input.target.actorId },
  });
  if (!actor) {
    throw new BadRequestException('Target actor not found');
  }
  const state = await input.actorState.ensureState(actor.id);
  const split = applyCombatHpDamage({
    damage: input.damage,
    hitPointsCurrent: actor.hitPointsCurrent ?? 0,
    tempHp: state.tempHp ?? 0,
  });
  await input.actorState.patch(
    actor,
    {
      tempHp: split.tempHpAfter,
      hitPointsCurrent: split.hitPointsAfter,
    },
    input.actors,
  );

  const mods = computeAbilityModifiers(actor.abilityScores);
  const concentration = resolveConcentrationCheck({
    damageTaken: input.damage,
    constitutionModifier: mods.constituicao,
    concentratingOn: state.concentratingOn,
  });
  if (concentration.broken) {
    await input.actorState.patch(
      actor,
      { concentratingOn: null },
      input.actors,
    );
  }
  return { concentration };
}
