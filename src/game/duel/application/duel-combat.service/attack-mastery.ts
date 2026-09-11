import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import type { LoadEffectCatalog } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { hasTacticalMaster } from '@game/combat/domain/fighter';
import { asArenaEffects } from '../../domain/arena-effects';
import {
  mapSaveAbilityToSheetSlug,
  resolveMasteryCombatEffects,
} from '../../domain/resolve-mastery-combat-effects';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';

export const TACTICAL_MASTER_OVERRIDES = new Set(['push', 'sap', 'slow']);

export type AttackMasteryDeps = {
  rolls: CharacterRollsService;
  effectCatalog: LoadEffectCatalog;
};

export function resolveActiveMasterySlug(
  weaponMasterySlug: string | null,
  override: 'push' | 'sap' | 'slow' | undefined,
  attackerPc: PlayerCharacter,
): string | null {
  if (
    override &&
    hasTacticalMaster(attackerPc.level) &&
    TACTICAL_MASTER_OVERRIDES.has(override)
  ) {
    return override;
  }
  return weaponMasterySlug;
}

export async function applyMasteryEffects(
  deps: AttackMasteryDeps,
  input: {
    duel: Duel;
    masterySlug: string;
    trigger: 'on_hit' | 'on_miss';
    attackAbilityMod: number;
    proficiencyBonus: number;
    attacker: DuelMember;
    defender: DuelMember;
    damaged: boolean;
  },
): Promise<string[]> {
  const effects = await deps.effectCatalog.load({
    ownerKind: 'weapon_mastery',
    ownerSlugs: [input.masterySlug],
  });
  if (effects.length === 0) return [];

  let defenderSaveTotal: number | null = null;
  const needsSave = effects.some(
    (e) => e.trigger === input.trigger && e.kind === 'feature_save',
  );
  if (needsSave && input.trigger === 'on_hit') {
    const saveEffect = effects.find(
      (e) => e.trigger === 'on_hit' && e.kind === 'feature_save',
    );
    const abilitySlug = mapSaveAbilityToSheetSlug(
      saveEffect?.save?.saveAbility ?? 'constitution',
    );
    const save = await deps.rolls.rollSavingThrow(
      input.defender.userId,
      input.defender.characterId,
      { abilitySlug },
    );
    defenderSaveTotal = save.total;
  }

  const result = resolveMasteryCombatEffects({
    effects,
    trigger: input.trigger,
    attackAbilityMod: input.attackAbilityMod,
    proficiencyBonus: input.proficiencyBonus,
    defenderSaveTotal,
    attackerMember: input.attacker,
    defenderMember: input.defender,
    arenaEffects: input.duel.arenaEffects,
    damaged: input.damaged,
  });
  input.duel.arenaEffects = asArenaEffects(result.arenaEffects);
  return result.logLines;
}
