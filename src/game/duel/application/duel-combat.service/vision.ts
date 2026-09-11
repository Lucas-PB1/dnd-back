import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { AdvantageMode } from '@game/dice/domain/dice';
import {
  characterSeesInMagicalDarkness,
  resolveDuelAttackVisionMode,
} from '../../domain/duel-combat-gates';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';

export type VisionDeps = {
  sheet: CharacterSheetRepository;
};

export async function seesMagicalDarkness(
  deps: VisionDeps,
  characterId: string,
): Promise<boolean> {
  const sheet = await deps.sheet.load(characterId);
  return characterSeesInMagicalDarkness({
    classOptions: sheet.classOptions,
  });
}

export async function resolveAttackAdvantage(
  deps: VisionDeps,
  duel: Duel,
  attacker: DuelMember,
  defender: DuelMember,
): Promise<AdvantageMode> {
  const [attackerSees, defenderSees] = await Promise.all([
    seesMagicalDarkness(deps, attacker.characterId),
    seesMagicalDarkness(deps, defender.characterId),
  ]);
  return resolveDuelAttackVisionMode({
    arenaEffects: duel.arenaEffects,
    attackerSeesMagicalDarkness: attackerSees,
    defenderSeesMagicalDarkness: defenderSees,
  });
}
