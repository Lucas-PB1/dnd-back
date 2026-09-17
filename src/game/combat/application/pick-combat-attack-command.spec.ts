import { pickCombatAttackCommand } from './pick-combat-attack-command';

describe('pickCombatAttackCommand', () => {
  it('keeps smite and extra-damage flags', () => {
    const cmd = pickCombatAttackCommand({
      attackerCombatantId: 'ignore-me',
      targetCombatantId: 'also-ignore',
      mode: 'melee',
      divineSmite: true,
      smiteSlotLevel: 2,
      smiteVsUndeadOrFiend: true,
      eldritchSmite: true,
      huntersMark: true,
      colossusSlayer: true,
      dreadfulStrikes: true,
      dreadAmbusher: true,
      savageAttacker: true,
      chargerStrike: true,
    });
    expect(cmd).toEqual({
      advantage: undefined,
      itemSlug: undefined,
      mode: 'melee',
      actionId: undefined,
      spentInspiration: undefined,
      automatic: undefined,
      studiedAttack: undefined,
      doorKick: undefined,
      steadyAim: undefined,
      strokeOfLuck: undefined,
      assassinate: undefined,
      preciseHunter: undefined,
      brutalStrike: undefined,
      targetCover: undefined,
      longRange: undefined,
      meleeWithRanged: undefined,
      graze: undefined,
      sneakAttack: undefined,
      cunningStrikeEffects: undefined,
      divineSmite: true,
      smiteSlotLevel: 2,
      smiteVsUndeadOrFiend: true,
      eldritchSmite: true,
      huntersMark: true,
      colossusSlayer: true,
      dreadfulStrikes: true,
      dreadAmbusher: true,
      divineStrike: undefined,
      savageAttacker: true,
      chargerStrike: true,
      poisonousSneak: undefined,
      assassinSurprise: undefined,
      psiStrike: undefined,
      monsterSlayer: undefined,
      divineFury: undefined,
      quickStrike: undefined,
    });
    expect(cmd).not.toHaveProperty('attackerCombatantId');
  });

  it('forwards attack-roll modifiers', () => {
    const cmd = pickCombatAttackCommand({
      advantage: 'advantage',
      automatic: true,
      studiedAttack: true,
      preciseHunter: true,
      targetCover: 'half',
      longRange: true,
      meleeWithRanged: true,
    });
    expect(cmd.advantage).toBe('advantage');
    expect(cmd.automatic).toBe(true);
    expect(cmd.studiedAttack).toBe(true);
    expect(cmd.preciseHunter).toBe(true);
    expect(cmd.targetCover).toBe('half');
    expect(cmd.longRange).toBe(true);
    expect(cmd.meleeWithRanged).toBe(true);
  });
});
