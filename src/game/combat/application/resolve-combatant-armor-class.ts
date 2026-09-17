import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export type CombatantRef = {
  kind: 'pc' | 'actor';
  characterId?: string | null;
  actorId?: string | null;
};

export async function resolveCombatantArmorClass(input: {
  loadPc: (characterId: string) => Promise<PlayerCharacter | null>;
  resolvePcArmorClass: (character: PlayerCharacter) => Promise<number>;
  actors: Repository<GameActor>;
  target: CombatantRef;
}): Promise<number> {
  if (input.target.kind === 'pc' && input.target.characterId) {
    const character = await input.loadPc(input.target.characterId);
    if (!character) {
      throw new BadRequestException('Target character not found');
    }
    return input.resolvePcArmorClass(character);
  }
  if (!input.target.actorId) {
    throw new BadRequestException('Target combatant is missing linked actor');
  }
  const actor = await input.actors.findOne({
    where: { id: input.target.actorId },
  });
  if (actor?.armorClass == null) {
    throw new BadRequestException('Target has no armor class');
  }
  return actor.armorClass;
}
