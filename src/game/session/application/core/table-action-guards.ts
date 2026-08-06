import { BadRequestException } from '@nestjs/common';
import type { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';

export function assertCharacterLevel(
  character: PlayerCharacter,
  minimumLevel: number,
  classLabel: string,
  actionName: string,
): void {
  if (character.level < minimumLevel) {
    throw new BadRequestException(
      `${actionName} requires ${classLabel} level ${minimumLevel}`,
    );
  }
}

export function assertCharacterSubclass(
  character: PlayerCharacter,
  subclassSlug: string,
  subclassName: string,
): void {
  if (character.subclassSlug !== subclassSlug) {
    throw new BadRequestException(`${subclassName} action is not available`);
  }
}
