import { pickCombatSurfaceCastCommand } from './pick-combat-surface-cast-command';

describe('pickCombatSurfaceCastCommand', () => {
  it('forwards wand charge cast (Magic Missile wand)', () => {
    const cmd = pickCombatSurfaceCastCommand({
      spellSlug: 'misseis-magicos',
      itemCastResourceSlug: 'varinhaMisseisCharges',
      itemCastSpendAmount: 2,
    });
    expect(cmd).toEqual({
      spellSlug: 'misseis-magicos',
      slotLevel: undefined,
      itemCastResourceSlug: 'varinhaMisseisCharges',
      itemCastSpendAmount: 2,
      itemCastItemSlug: undefined,
      spiritVariantKey: undefined,
      spiritCount: undefined,
    });
  });

  it('forwards Invocar Fera variant', () => {
    const cmd = pickCombatSurfaceCastCommand({
      spellSlug: 'invocar-fera',
      slotLevel: 2,
      spiritVariantKey: 'terra',
    });
    expect(cmd.spiritVariantKey).toBe('terra');
    expect(cmd.spellSlug).toBe('invocar-fera');
  });

  it('forwards free item cast without charge pool', () => {
    const cmd = pickCombatSurfaceCastCommand({
      spellSlug: 'invisibilidade',
      itemCastItemSlug: 'anel-de-invisibilidade',
    });
    expect(cmd.itemCastItemSlug).toBe('anel-de-invisibilidade');
    expect(cmd.itemCastResourceSlug).toBeUndefined();
  });
});
