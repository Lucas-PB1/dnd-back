import {
  canUseUncannyDodge,
  resolveIncomingHit,
  SHIELD_AC_BONUS,
} from './resolve-incoming-hit';

describe('resolveIncomingHit', () => {
  const base = {
    attackTotal: 16,
    naturalD20: 12,
    targetAc: 14,
    provisionalHit: true,
    provisionalCritical: false,
    damageTotal: 10,
    reactionAvailable: true,
    uncannyEligible: true,
  };

  it('returns provisional result when no defense', () => {
    const r = resolveIncomingHit({ ...base, defense: null });
    expect(r.hit).toBe(true);
    expect(r.damageTotal).toBe(10);
    expect(r.reactionSpent).toBe(false);
    expect(r.defenseApplied).toBeNull();
  });

  it('ignores defense when reaction unavailable', () => {
    const r = resolveIncomingHit({
      ...base,
      reactionAvailable: false,
      defense: 'shield',
    });
    expect(r.hit).toBe(true);
    expect(r.damageTotal).toBe(10);
    expect(r.reactionSpent).toBe(false);
    expect(r.notes.join(' ')).toMatch(/Reação indisponível/i);
  });

  it('Shield +5 AC can turn hit into miss', () => {
    const r = resolveIncomingHit({
      ...base,
      attackTotal: 16,
      targetAc: 14,
      defense: 'shield',
    });
    // 14+5=19 > 16 → miss
    expect(r.hit).toBe(false);
    expect(r.damageTotal).toBeNull();
    expect(r.effectiveAc).toBe(14 + SHIELD_AC_BONUS);
    expect(r.reactionSpent).toBe(true);
    expect(r.spendShieldSlot).toBe(true);
    expect(r.defenseApplied).toBe('shield');
  });

  it('Shield keeps critical hit even if total < effective AC', () => {
    const r = resolveIncomingHit({
      ...base,
      attackTotal: 16,
      naturalD20: 20,
      provisionalCritical: true,
      targetAc: 14,
      defense: 'shield',
    });
    expect(r.hit).toBe(true);
    expect(r.critical).toBe(true);
    expect(r.damageTotal).toBe(10);
    expect(r.reactionSpent).toBe(true);
    expect(r.spendShieldSlot).toBe(true);
  });

  it('Uncanny Dodge halves damage', () => {
    const r = resolveIncomingHit({
      ...base,
      damageTotal: 11,
      defense: 'uncanny_dodge',
    });
    expect(r.hit).toBe(true);
    expect(r.damageTotal).toBe(5);
    expect(r.reactionSpent).toBe(true);
    expect(r.defenseApplied).toBe('uncanny_dodge');
    expect(r.spendShieldSlot).toBe(false);
  });

  it('Parry subtracts reduction from damage', () => {
    const r = resolveIncomingHit({
      ...base,
      damageTotal: 14,
      defense: 'parry',
      parryReduction: 9,
    });
    expect(r.hit).toBe(true);
    expect(r.damageTotal).toBe(5);
    expect(r.reactionSpent).toBe(true);
    expect(r.defenseApplied).toBe('parry');
    expect(r.notes.join(' ')).toMatch(/Aparar/i);
  });

  it('ignores Uncanny when not eligible', () => {
    const r = resolveIncomingHit({
      ...base,
      uncannyEligible: false,
      defense: 'uncanny_dodge',
    });
    expect(r.damageTotal).toBe(10);
    expect(r.reactionSpent).toBe(false);
  });

  it('does not spend reaction on a miss', () => {
    const r = resolveIncomingHit({
      ...base,
      provisionalHit: false,
      damageTotal: null,
      defense: 'shield',
    });
    expect(r.hit).toBe(false);
    expect(r.reactionSpent).toBe(false);
    expect(r.spendShieldSlot).toBe(false);
  });
});

describe('canUseUncannyDodge', () => {
  it('requires rogue level 5+', () => {
    expect(canUseUncannyDodge({ classSlug: 'rogue', level: 5 })).toBe(true);
    expect(canUseUncannyDodge({ classSlug: 'rogue', level: 4 })).toBe(false);
    expect(canUseUncannyDodge({ classSlug: 'fighter', level: 10 })).toBe(false);
  });
});
