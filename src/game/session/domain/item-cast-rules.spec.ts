import {
  buildItemCastTreasureNotes,
  parseItemCastProperties,
  pickItemCastSlotRule,
} from './item-cast-rules';

describe('item-cast-rules', () => {
  it('parses properties including slot rules', () => {
    expect(
      parseItemCastProperties({
        spellSaveDc: 18,
        spellAttackBonus: 10,
        requiresComponents: true,
        useCasterAbility: true,
        itemCastSlotRule: { mode: 'charge-upcast' },
        itemCastSlotRules: {
          ondaGloboUse: { mode: 'fixed', slotLevel: 9 },
        },
      }),
    ).toEqual({
      spellSaveDc: 18,
      spellAttackBonus: 10,
      requiresComponents: true,
      useCasterAbility: true,
      itemCastSlotRule: { mode: 'charge-upcast' },
      itemCastSlotRules: {
        ondaGloboUse: { mode: 'fixed', slotLevel: 9 },
      },
    });
  });

  it('picks resource rule over item rule', () => {
    const parsed = parseItemCastProperties({
      itemCastSlotRule: { mode: 'charge-upcast' },
      itemCastSlotRules: {
        ondaGloboUse: { mode: 'fixed', slotLevel: 9 },
      },
    });
    expect(pickItemCastSlotRule(parsed, 'ondaGloboUse')).toEqual({
      mode: 'fixed',
      slotLevel: 9,
    });
    expect(pickItemCastSlotRule(parsed, 'other')).toEqual({
      mode: 'charge-upcast',
    });
  });

  it('builds Treasure notes without components and with DC', () => {
    const notes = buildItemCastTreasureNotes({
      spellRequiresConcentration: true,
      requiresComponents: false,
      spellSaveDc: 15,
      spellAttackBonus: 7,
      casterHasSpellcastingAbility: false,
      useCasterAbility: true,
    });
    expect(notes.spellSaveDcOverride).toBe(15);
    expect(notes.spellAttackBonusOverride).toBe(7);
    expect(notes.lines.some((l) => l.includes('sem componentes'))).toBe(true);
    expect(notes.lines.some((l) => l.includes('concentração'))).toBe(true);
    expect(notes.lines.some((l) => l.includes('+0 + PB'))).toBe(true);
    expect(notes.lines.some((l) => l.includes('CD 15'))).toBe(true);
  });

  it('skips +0+PB note when item does not use caster ability', () => {
    const notes = buildItemCastTreasureNotes({
      spellRequiresConcentration: false,
      spellSaveDc: 18,
      casterHasSpellcastingAbility: false,
      useCasterAbility: false,
    });
    expect(notes.lines.some((l) => l.includes('+0 + PB'))).toBe(false);
  });
});
