import {
  applyLongRestResourceRecovery,
  applyResourceSpend,
  applyShortRestResourceRecovery,
  resolveClassResourceMaxima,
  resourcesRemaining,
  type AbilityMods,
  type ClassResourceMax,
  type ClassResourceScheduleRow,
} from './class-resources';

describe('class-resources', () => {
  const mods: AbilityMods = {
    forca: 3,
    destreza: 2,
    constituicao: 2,
    inteligencia: 0,
    sabedoria: 1,
    carisma: 3,
  };

  const rageRows: ClassResourceScheduleRow[] = [
    {
      resourceSlug: 'rage',
      resourceName: 'Fúria',
      unlockLevel: 1,
      maxFormula: 'fixed',
      fixedMax: 2,
      recoverOneOnShort: true,
      recoverAllOnShort: false,
      recoverAllOnLong: true,
    },
    {
      resourceSlug: 'rage',
      resourceName: 'Fúria',
      unlockLevel: 3,
      maxFormula: 'fixed',
      fixedMax: 3,
      recoverOneOnShort: true,
      recoverAllOnShort: false,
      recoverAllOnLong: true,
    },
  ];

  it('picks the highest unlocked fixed max', () => {
    const [rage] = resolveClassResourceMaxima({
      rows: rageRows,
      level: 5,
      proficiencyBonus: 3,
      abilityModifiers: mods,
    });
    expect(rage?.max).toBe(3);
  });

  it('uses channel divinity from progression when provided', () => {
    const rows: ClassResourceScheduleRow[] = [
      {
        resourceSlug: 'channelDivinity',
        resourceName: 'Canalizar Divindade',
        unlockLevel: 2,
        maxFormula: 'fixed',
        fixedMax: 0,
        recoverOneOnShort: true,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
    ];
    const [channel] = resolveClassResourceMaxima({
      rows,
      level: 5,
      proficiencyBonus: 3,
      abilityModifiers: mods,
      channelDivinityFromProgression: 2,
    });
    expect(channel?.max).toBe(2);
  });

  it('applies charisma_mod with minimum 1', () => {
    const rows: ClassResourceScheduleRow[] = [
      {
        resourceSlug: 'bardicInspiration',
        resourceName: 'Inspiração de Bardo',
        unlockLevel: 1,
        maxFormula: 'charisma_mod',
        fixedMax: null,
        recoverOneOnShort: false,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
    ];
    const [bardic] = resolveClassResourceMaxima({
      rows,
      level: 1,
      proficiencyBonus: 2,
      abilityModifiers: { ...mods, carisma: -1 },
    });
    expect(bardic?.max).toBe(1);
  });

  it('resolves second wind from fixed table (PHB 2024)', () => {
    const rows: ClassResourceScheduleRow[] = [
      {
        resourceSlug: 'secondWind',
        resourceName: 'Recuperar Fôlego',
        unlockLevel: 1,
        maxFormula: 'fixed',
        fixedMax: 2,
        recoverOneOnShort: true,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
      {
        resourceSlug: 'secondWind',
        resourceName: 'Recuperar Fôlego',
        unlockLevel: 4,
        maxFormula: 'fixed',
        fixedMax: 3,
        recoverOneOnShort: true,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
    ];
    const [secondWind] = resolveClassResourceMaxima({
      rows,
      level: 5,
      proficiencyBonus: 3,
      abilityModifiers: mods,
    });
    expect(secondWind?.max).toBe(3);
  });

  it('resolves superiority and psi energy dice counts', () => {
    const rows: ClassResourceScheduleRow[] = [
      {
        resourceSlug: 'superiority-dice',
        resourceName: 'Superioridade',
        unlockLevel: 3,
        maxFormula: 'superiority_dice_count',
        fixedMax: null,
        recoverOneOnShort: false,
        recoverAllOnShort: true,
        recoverAllOnLong: true,
      },
      {
        resourceSlug: 'psi-energy-dice',
        resourceName: 'Psi',
        unlockLevel: 3,
        maxFormula: 'psi_energy_dice_count',
        fixedMax: null,
        recoverOneOnShort: true,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
    ];
    const resolved = resolveClassResourceMaxima({
      rows,
      level: 7,
      proficiencyBonus: 3,
      abilityModifiers: mods,
    });
    expect(resolved.find((r) => r.slug === 'superiority-dice')?.max).toBe(5);
    expect(resolved.find((r) => r.slug === 'psi-energy-dice')?.max).toBe(6);
  });

  it('resolves level and level_plus_one formulas', () => {
    const rows: ClassResourceScheduleRow[] = [
      {
        resourceSlug: 'wildShape',
        resourceName: 'Forma Selvagem',
        unlockLevel: 2,
        maxFormula: 'level',
        fixedMax: null,
        recoverOneOnShort: false,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
      {
        resourceSlug: 'arcaneRecovery',
        resourceName: 'Recuperação Arcana',
        unlockLevel: 1,
        maxFormula: 'level_plus_one',
        fixedMax: null,
        recoverOneOnShort: false,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
    ];
    const maxima = resolveClassResourceMaxima({
      rows,
      level: 5,
      proficiencyBonus: 3,
      abilityModifiers: mods,
    });
    expect(maxima.find((r) => r.slug === 'wildShape')?.max).toBe(5);
    expect(maxima.find((r) => r.slug === 'arcaneRecovery')?.max).toBe(6);
  });

  it('throws when spending beyond resource max', () => {
    expect(() => applyResourceSpend({}, 'rage', 2, 3)).toThrow(
      /No remaining uses of resource 'rage'/,
    );
  });

  it('spends and recovers resources on short/long rest', () => {
    const resources: ClassResourceMax[] = [
      {
        slug: 'rage',
        name: 'Fúria',
        max: 3,
        recoverOneOnShort: true,
        recoverAllOnShort: false,
        recoverAllOnLong: true,
      },
      {
        slug: 'actionSurge',
        name: 'Surto de Ação',
        max: 1,
        recoverOneOnShort: false,
        recoverAllOnShort: true,
        recoverAllOnLong: true,
      },
    ];
    let used = applyResourceSpend({}, 'rage', 3);
    used = applyResourceSpend(used, 'rage', 3);
    used = applyResourceSpend(used, 'actionSurge', 1);
    used = applyShortRestResourceRecovery(used, resources);
    expect(used).toEqual({ rage: 1 });
    used = applyLongRestResourceRecovery(used, resources);
    expect(used).toEqual({});
    expect(resourcesRemaining({ rage: 3 }, { rage: 1 })).toEqual({ rage: 2 });
  });
});
