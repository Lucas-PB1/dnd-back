import { pickCombatSurfaceCastCommand } from '@game/combat/application/pick-combat-surface-cast-command';
import { spellCombatBonusesFromCast } from '@game/combat/application/spell-combat-bonuses-from-cast';
import { resolveCombatSpell } from '@game/combat/domain/resolve-combat-spell';
import type { SpellCombatRow } from '@game/combat/domain/resolve-combat-spell';

jest.mock('@game/dice/domain/dice', () => ({
  rollDie: jest.fn((sides: number) => sides),
  rollD20Check: jest.fn((bonus: number) => ({
    total: 10 + bonus,
    d20: { kept: [10], rolls: [10] },
  })),
}));

const mmRow: SpellCombatRow = {
  spellSlug: 'misseis-magicos',
  resolution: 'auto_damage',
  label: 'Mísseis Mágicos',
  damageDie: 4,
  flatPerDie: 1,
  autoUnitBase: 3,
  autoUnitPerSlotAboveBase: 1,
  diceCountBase: null,
  dicePerSlotAboveBase: null,
  spellLevel: 1,
  cantripScale: false,
  perDieAttack: false,
  includeSpellcastingMod: false,
  saveSuccessOutcome: null,
  saveAbilitySlug: null,
  conditionSlug: null,
  damageTypeSlug: null,
};

/**
 * PVE-6b: Varinha de Mísseis — gasta cargas → slot tipado → dano no combatente.
 */
describe('skirmish item charge → resolveCombatSpell (PVE-6b)', () => {
  it('Magic Missile wand spend 2 → 4 darts of damage', () => {
    const castCmd = pickCombatSurfaceCastCommand({
      spellSlug: 'misseis-magicos',
      itemCastResourceSlug: 'varinhaMisseisCharges',
      itemCastSpendAmount: 2,
    });
    expect(castCmd.itemCastResourceSlug).toBe('varinhaMisseisCharges');
    expect(castCmd.itemCastSpendAmount).toBe(2);

    // Mesa cast devolve slotLevelUsed = spend amount when charge-upcast.
    const slotLevelUsed = 2;
    const bonuses = spellCombatBonusesFromCast({
      spellAttackBonus: 5,
      spellSaveDc: 13,
      spellSaveDcOverride: null,
      spellAttackBonusOverride: null,
    });
    const resolved = resolveCombatSpell({
      row: mmRow,
      slotLevel: slotLevelUsed,
      characterLevel: 5,
      spellAttackBonus: bonuses.spellAttackBonus,
      spellSaveDc: bonuses.spellSaveDc,
      spellcastingAbilityMod: 3,
      targetAc: 12,
      targetSaveBonus: 0,
      advantage: 'normal',
      castNote: 'Item: conjurada com carga (varinhaMisseisCharges).',
    });
    expect(resolved.kind).toBe('auto_damage');
    if (resolved.kind === 'auto_damage') {
      expect(resolved.damage).toBe(4 * (4 + 1));
      expect(resolved.label).toContain('4');
    }
  });

  it('Lightning wand override CD feeds save_damage', () => {
    const bonuses = spellCombatBonusesFromCast({
      spellAttackBonus: 5,
      spellSaveDc: 13,
      spellSaveDcOverride: 15,
      spellAttackBonusOverride: null,
    });
    const row: SpellCombatRow = {
      ...mmRow,
      spellSlug: 'relampago',
      resolution: 'save_damage',
      label: 'Relâmpago',
      damageDie: 8,
      flatPerDie: 0,
      autoUnitBase: null,
      autoUnitPerSlotAboveBase: null,
      diceCountBase: 8,
      dicePerSlotAboveBase: 1,
      spellLevel: 3,
      saveSuccessOutcome: 'half',
      saveAbilitySlug: 'destreza',
    };
    const resolved = resolveCombatSpell({
      row,
      slotLevel: 4,
      characterLevel: 8,
      spellAttackBonus: bonuses.spellAttackBonus,
      spellSaveDc: bonuses.spellSaveDc,
      spellcastingAbilityMod: 0,
      targetAc: 10,
      targetSaveBonus: 0,
      advantage: 'normal',
    });
    expect(resolved.kind).toBe('save_damage');
    if (resolved.kind === 'save_damage') {
      expect(resolved.dc).toBe(15);
    }
  });
});
