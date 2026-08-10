import {
  applyWeaponCharmToAttack,
  charmNotes,
  parseWeaponCharm,
  type WeaponCharm,
  type WeaponCharmKind,
} from './weapon-charm';

describe('parseWeaponCharm', () => {
  it('returns null without weaponCharm', () => {
    expect(parseWeaponCharm(null)).toBeNull();
    expect(parseWeaponCharm({})).toBeNull();
    expect(parseWeaponCharm({ weaponCharm: { kind: 'unknown' } })).toBeNull();
  });

  it('parses blade bonuses and lightning override', () => {
    expect(
      parseWeaponCharm({
        weaponCharm: { kind: 'blade', attackBonus: 2, damageBonus: 2 },
      }),
    ).toEqual({ kind: 'blade', attackBonus: 2, damageBonus: 2 });

    expect(
      parseWeaponCharm({
        weaponCharm: {
          kind: 'lightning',
          damageTypeOverride: 'Elétrico',
          extraDamageDice: '1d6',
        },
      }),
    ).toEqual({
      kind: 'lightning',
      damageTypeOverride: 'Elétrico',
      extraDamageDice: '1d6',
    });
  });
});

describe('charmNotes', () => {
  it('returns sheet notes per kind', () => {
    expect(charmNotes('arrowhead')[0]).toContain('cobertura');
    expect(charmNotes('die')[0]).toContain('crítico');
    expect(charmNotes('blade')).toEqual([]);
  });
});

describe('applyWeaponCharmToAttack', () => {
  const baseAttack = {
    itemSlug: 'longsword',
    itemName: 'Espada Longa',
    mode: 'melee' as const,
    attackBonus: 5,
    abilitySlug: 'forca' as const,
    proficient: true,
    damageDice: '1d8',
    damageBonus: 3,
    damageType: 'Cortante',
    attackNote: 'corpo a corpo: FOR + PB',
    damageNote: '1d8 +3 (FOR)',
    role: 'main' as const,
    attackDisadvantage: false,
    omitsAbilityDamage: false,
    greatWeaponFighting: false,
    masteryActive: false,
    masterySlug: null,
    masteryName: null,
    nickUsesAttackAction: false,
    grazeOnMissDamage: null,
    isFirearm: false,
    critThreshold: 20,
    overkillExtraDice: null,
    reloadCapacity: null,
    hasRecoil: false,
    rageDamageBonus: 0,
    brutalStrikeDice: null,
    divineFuryDice: null,
    sneakAttackEligible: false,
    martialArtsDie: null,
    attachedCharmSlug: null,
    attachedCharmName: null,
    attachedCoverageSlug: null,
    attachedCoverageName: null,
  };

  const piece = (
    charm: WeaponCharm | null,
    extras: { slug?: string; name?: string; reload?: number | null } = {},
  ) => ({
    itemSlug: 'longsword',
    itemName: 'Espada Longa',
    category: 'martial',
    damage: '1d8',
    damageType: 'Cortante',
    versatileDamage: null,
    propertySlugs: [] as string[],
    equipmentSlot: 'main_hand',
    weaponCharm: charm,
    attachedCharmSlug: extras.slug ?? (charm ? 'weapon-charm-blade-1' : null),
    attachedCharmName: extras.name ?? (charm ? 'Encanto de Arma: Lâmina +1' : null),
    reloadCapacity: extras.reload ?? null,
  });

  it('applies blade attack and damage bonus only on that piece', () => {
    const charm: WeaponCharm = {
      kind: 'blade',
      attackBonus: 1,
      damageBonus: 1,
    };
    const next = applyWeaponCharmToAttack(piece(charm), { ...baseAttack });
    expect(next.attackBonus).toBe(6);
    expect(next.damageBonus).toBe(4);
    expect(next.attachedCharmName).toContain('Lâmina');
    expect(next.attackNote).toContain('encanto +1');
  });

  it('overrides damage type and adds lightning dice', () => {
    const charm: WeaponCharm = {
      kind: 'lightning',
      damageTypeOverride: 'Elétrico',
      extraDamageDice: '1d6',
    };
    const next = applyWeaponCharmToAttack(piece(charm, { slug: 'weapon-charm-lightning', name: 'Raio' }), {
      ...baseAttack,
    });
    expect(next.damageType).toBe('Elétrico');
    expect(next.damageDice).toBe('1d8+1d6');
  });

  it('clears reloadCapacity for quiver', () => {
    const charm: WeaponCharm = { kind: 'quiver' };
    const next = applyWeaponCharmToAttack(
      piece(charm, { slug: 'weapon-charm-quiver', name: 'Aljava', reload: 6 }),
      { ...baseAttack, reloadCapacity: 6, isFirearm: true },
    );
    expect(next.reloadCapacity).toBeNull();
    expect(next.attackNote).toContain('Recarga');
  });

  it('passes through when no charm', () => {
    const next = applyWeaponCharmToAttack(piece(null), { ...baseAttack });
    expect(next.attackBonus).toBe(5);
    expect(next.attachedCharmSlug).toBeNull();
  });
});

describe('WeaponCharmKind exhaustiveness', () => {
  it('covers all kinds in charmNotes', () => {
    const kinds: WeaponCharmKind[] = [
      'arrowhead',
      'blade',
      'die',
      'flame',
      'hook',
      'spear',
      'lightning',
      'quiver',
    ];
    for (const kind of kinds) {
      expect(Array.isArray(charmNotes(kind))).toBe(true);
    }
  });
});
