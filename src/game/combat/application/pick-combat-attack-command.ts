import type { CombatAttackCommand } from './roll-combat-attack';

/** Extrai só campos de `CombatAttackCommand` (ignora IDs HTTP de skirmish/encontro). */
export function pickCombatAttackCommand(
  dto: Partial<CombatAttackCommand> | Record<string, unknown>,
): CombatAttackCommand {
  const src = dto as Partial<CombatAttackCommand>;
  return {
    advantage: src.advantage,
    itemSlug: src.itemSlug,
    mode: src.mode,
    actionId: src.actionId,
    spentInspiration: src.spentInspiration,
    automatic: src.automatic,
    studiedAttack: src.studiedAttack,
    doorKick: src.doorKick,
    steadyAim: src.steadyAim,
    strokeOfLuck: src.strokeOfLuck,
    assassinate: src.assassinate,
    preciseHunter: src.preciseHunter,
    brutalStrike: src.brutalStrike,
    targetCover: src.targetCover,
    longRange: src.longRange,
    meleeWithRanged: src.meleeWithRanged,
    graze: src.graze,
    sneakAttack: src.sneakAttack,
    cunningStrikeEffects: src.cunningStrikeEffects,
    divineSmite: src.divineSmite,
    smiteSlotLevel: src.smiteSlotLevel,
    smiteVsUndeadOrFiend: src.smiteVsUndeadOrFiend,
    eldritchSmite: src.eldritchSmite,
    huntersMark: src.huntersMark,
    colossusSlayer: src.colossusSlayer,
    dreadfulStrikes: src.dreadfulStrikes,
    dreadAmbusher: src.dreadAmbusher,
    divineStrike: src.divineStrike,
    savageAttacker: src.savageAttacker,
    chargerStrike: src.chargerStrike,
    poisonousSneak: src.poisonousSneak,
    assassinSurprise: src.assassinSurprise,
    psiStrike: src.psiStrike,
    monsterSlayer: src.monsterSlayer,
    divineFury: src.divineFury,
    quickStrike: src.quickStrike,
  };
}
