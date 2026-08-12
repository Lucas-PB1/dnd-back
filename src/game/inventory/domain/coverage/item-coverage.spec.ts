import {
  coverageBonusToEffects,
  coverageMatchesBase,
  coverageRequiresTierBonus,
  normalizeCoverageText,
  parseItemCoverage,
  type CoverageBaseContext,
  type ItemCoverage,
} from './item-coverage';

describe('parseItemCoverage', () => {
  it('returns null without kind coverage', () => {
    expect(parseItemCoverage(null)).toBeNull();
    expect(parseItemCoverage({})).toBeNull();
    expect(parseItemCoverage({ kind: 'unique' })).toBeNull();
  });

  it('parses appliesTo + appliesFilter', () => {
    expect(
      parseItemCoverage({
        kind: 'coverage',
        appliesTo: 'weapon',
        appliesFilter: 'Qualquer Simples ou Marcial',
      }),
    ).toEqual({
      appliesTo: 'weapon',
      appliesFilter: 'Qualquer Simples ou Marcial',
      requiresTierBonus: false,
    });
  });

  it('reads requiresTierBonus from properties', () => {
    expect(
      parseItemCoverage({
        kind: 'coverage',
        appliesTo: 'weapon',
        appliesFilter: 'Qualquer',
        requiresTierBonus: true,
      })?.requiresTierBonus,
    ).toBe(true);
  });

  it('treats masterwork coverage as requiring tier bonus', () => {
    const props = {
      kind: 'coverage',
      appliesTo: 'weapon',
      appliesFilter: 'Qualquer Simples ou Marcial',
      requiresTierBonus: true,
      masterwork: true,
    };
    expect(parseItemCoverage(props)?.requiresTierBonus).toBe(true);
    expect(coverageRequiresTierBonus(props)).toBe(true);
    expect(props.masterwork).toBe(true);
  });
});

describe('coverageMatchesBase', () => {
  const sword: CoverageBaseContext = {
    itemSlug: 'longsword',
    itemName: 'Espada Longa',
    itemType: 'weapon',
    weaponCategory: 'martial',
    subtypeLabel: 'Espada Longa',
  };

  const hide: CoverageBaseContext = {
    itemSlug: 'hide',
    itemName: 'Gibão de Peles',
    itemType: 'armor',
    armorCategorySlug: 'medium',
    subtypeLabel: 'Gibão de Peles',
  };

  const plate: CoverageBaseContext = {
    itemSlug: 'plate',
    itemName: 'Armadura de Placas',
    itemType: 'armor',
    armorCategorySlug: 'heavy',
    subtypeLabel: 'Armadura de Placas',
  };

  const shield: CoverageBaseContext = {
    itemSlug: 'shield',
    itemName: 'Escudo',
    itemType: 'armor',
    armorCategorySlug: 'shield',
  };

  it('matches qualquer simples/marcial', () => {
    const cov: ItemCoverage = {
      appliesTo: 'weapon',
      appliesFilter: 'Qualquer Simples ou Marcial',
      requiresTierBonus: false,
    };
    expect(coverageMatchesBase(cov, sword)).toBe(true);
  });

  it("matches allowlist by Portuguese name", () => {
    const cov: ItemCoverage = {
      appliesTo: 'weapon',
      appliesFilter: 'Cimitarra, Espada Longa, Rapieira',
      requiresTierBonus: false,
    };
    expect(coverageMatchesBase(cov, sword)).toBe(true);
  });

  it('matches shortbow and longbow for bow coverages', () => {
    const cov: ItemCoverage = {
      appliesTo: 'weapon',
      appliesFilter: 'Arco Curto ou Arco Longo',
      requiresTierBonus: false,
    };
    expect(
      coverageMatchesBase(cov, {
        itemSlug: 'shortbow',
        itemName: 'Arco Curto',
        itemType: 'weapon',
        weaponCategory: 'simple',
      }),
    ).toBe(true);
    expect(
      coverageMatchesBase(cov, {
        itemSlug: 'longbow',
        itemName: 'Arco Longo',
        itemType: 'weapon',
        weaponCategory: 'martial',
      }),
    ).toBe(true);
    expect(coverageMatchesBase(cov, sword)).toBe(false);
  });

  it('excludes hide from adamantine armor filter', () => {
    const cov: ItemCoverage = {
      appliesTo: 'armor',
      appliesFilter: 'Qualquer Média ou Pesada, Exceto Gibão de Peles',
      requiresTierBonus: false,
    };
    expect(coverageMatchesBase(cov, hide)).toBe(false);
    expect(coverageMatchesBase(cov, plate)).toBe(true);
  });

  it('matches shield appliesTo', () => {
    const cov: ItemCoverage = {
      appliesTo: 'shield',
      appliesFilter: 'Escudo',
      requiresTierBonus: false,
    };
    expect(coverageMatchesBase(cov, shield)).toBe(true);
    expect(coverageMatchesBase(cov, plate)).toBe(false);
  });

  it('matches ammunition gear and rejects containers', () => {
    const ammo: CoverageBaseContext = {
      itemSlug: 'municao',
      itemName: 'Munição',
      itemType: 'gear',
    };
    const arrows: CoverageBaseContext = {
      itemSlug: 'arrows',
      itemName: 'Flechas',
      itemType: 'gear',
    };
    const quiver: CoverageBaseContext = {
      itemSlug: 'aljava',
      itemName: 'Aljava',
      itemType: 'gear',
    };
    const cov: ItemCoverage = {
      appliesTo: 'ammunition',
      appliesFilter: 'Qualquer Munição',
      requiresTierBonus: false,
    };
    expect(coverageMatchesBase(cov, ammo)).toBe(true);
    expect(coverageMatchesBase(cov, arrows)).toBe(true);
    expect(coverageMatchesBase(cov, quiver)).toBe(false);
    expect(coverageMatchesBase(cov, sword)).toBe(false);
  });
});

describe('coverageBonusToEffects', () => {
  it('maps weapon tier to attack/damage', () => {
    expect(coverageBonusToEffects('weapon', 2)).toEqual({
      attackBonus: 2,
      damageBonus: 2,
    });
  });

  it('maps armor tier to ac', () => {
    expect(coverageBonusToEffects('armor', 1)).toEqual({ acBonus: 1 });
  });
});

describe('coverageRequiresTierBonus', () => {
  it('reads flag from properties', () => {
    expect(
      coverageRequiresTierBonus({
        kind: 'coverage',
        appliesTo: 'weapon',
        appliesFilter: 'x',
        requiresTierBonus: true,
      }),
    ).toBe(true);
    expect(
      coverageRequiresTierBonus({
        kind: 'coverage',
        appliesTo: 'weapon',
        appliesFilter: 'x',
      }),
    ).toBe(false);
  });
});

describe('normalizeCoverageText', () => {
  it('strips accents', () => {
    expect(normalizeCoverageText('Média')).toBe('media');
  });
});
