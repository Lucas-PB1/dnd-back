import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyCombatHpDamage } from '../domain/apply-combat-hp-damage';

export type CombatHpTarget = {
  kind: 'pc' | 'actor';
  characterId?: string | null;
  actorId?: string | null;
};

export async function applyCombatantHpDamage(input: {
  loadCharacter: (characterId: string) => Promise<PlayerCharacter | null>;
  characterState: CharacterStateRepository;
  actorState: ActorStateRepository;
  actors: Repository<GameActor>;
  target: CombatHpTarget;
  damage: number;
}): Promise<void> {
  if (input.damage <= 0) return;

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
    return;
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
}
