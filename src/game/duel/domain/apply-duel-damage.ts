import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { hitPointsOf } from '../application/to-dto';

export type AppliedDuelDamage = {
  damageTotal: number;
  absorbedByTempHp: number;
  hitPointsBefore: number;
  hitPointsAfter: number;
  tempHpBefore: number;
  tempHpAfter: number;
};

/** Consome PV temp. antes dos PV atuais (5e). */
export async function applyDuelDamageToTarget(input: {
  state: CharacterStateRepository;
  target: PlayerCharacter;
  damage: number;
}): Promise<AppliedDuelDamage> {
  const damageTotal = Math.max(0, input.damage);
  const stateBefore = await input.state.buildResponse(input.target);
  const tempHpBefore = stateBefore.tempHp ?? 0;
  const absorbedByTempHp = Math.min(tempHpBefore, damageTotal);
  const remaining = damageTotal - absorbedByTempHp;
  const tempHpAfter = tempHpBefore - absorbedByTempHp;

  if (absorbedByTempHp > 0) {
    await input.state.patch(input.target, { tempHp: tempHpAfter });
  }

  const hitPointsBefore = hitPointsOf(input.target).current;
  const hitPointsAfter = Math.max(0, hitPointsBefore - remaining);
  if (remaining > 0 || hitPointsAfter !== hitPointsBefore) {
    await input.state.applyCurrentHitPoints(input.target, hitPointsAfter);
  }

  return {
    damageTotal,
    absorbedByTempHp,
    hitPointsBefore,
    hitPointsAfter,
    tempHpBefore,
    tempHpAfter,
  };
}
