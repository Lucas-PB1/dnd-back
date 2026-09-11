import type { CatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export function isTableActionEffectApplicable(
  effect: CatalogEffect,
  character: PlayerCharacter,
): boolean {
  if (effect.unlockLevel > character.level) return false;
  if (effect.ownerKind === 'subclass') {
    return (
      effect.ownerSlug != null &&
      effect.ownerSlug === character.subclassSlug
    );
  }
  return true;
}
