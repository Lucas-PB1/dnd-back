import { FindCombatMechanicalCatalogQuery } from './find-combat-mechanical-catalog.query';

describe('FindCombatMechanicalCatalogQuery', () => {
  it('maps mechanical catalog to public response DTO', async () => {
    const mechanicalCatalog = {
      load: jest.fn().mockResolvedValue({
        gunslingerManeuvers: [],
        battleMasterManeuvers: [],
        cunningStrikeEffects: [
          {
            slug: 'poison',
            name: 'Envenenar',
            cost: 1,
            unlockLevel: 5,
            saveAbility: 'constitution',
            note: 'note',
          },
        ],
        tableActions: [],
        personaMasks: [{ slug: 'persona-mask-jester', name: 'Bobão' }],
        personaMaskSlugs: ['persona-mask-jester'],
        beastborneAspectBenefits: [],
        dungeoneerSlayerLabels: ['Aberração'],
        precautionSpells: [{ slug: 'alarme', name: 'Alarme' }],
        economyActions: [
          {
            id: 'fighter-second-wind',
            name: 'Recuperar Fôlego',
            economy: 'bonus',
            classSlug: 'fighter',
            minLevel: 1,
            tableAction: 'second-wind',
          },
        ],
        panelActions: [
          {
            panelKey: 'bard|grant-inspiration',
            classSlug: 'bard',
            slug: 'grant-inspiration',
            name: 'Conceder Inspiração',
            minLevel: 1,
            section: 'base',
            spendsFocus: false,
            sortOrder: 1,
          },
        ],
      }),
    };

    const query = new FindCombatMechanicalCatalogQuery(
      mechanicalCatalog as never,
    );
    const result = await query.execute();

    expect(result.personaMasks).toEqual([
      { slug: 'persona-mask-jester', name: 'Bobão' },
    ]);
    expect(result.cunningStrikeEffects[0]).toMatchObject({
      slug: 'poison',
      name: 'Envenenar',
      cost: 1,
      unlockLevel: 5,
    });
    expect(result.precautionSpells).toEqual([
      { slug: 'alarme', name: 'Alarme' },
    ]);
    expect(result.economyActions).toHaveLength(1);
    expect(result.panelActions[0].slug).toBe('grant-inspiration');
    expect(result).not.toHaveProperty('personaMaskSlugs');
  });

  it('filters catalog when classSlug is provided', async () => {
    const mechanicalCatalog = {
      load: jest.fn().mockResolvedValue({
        gunslingerManeuvers: [],
        battleMasterManeuvers: [],
        cunningStrikeEffects: [],
        tableActions: [],
        personaMasks: [{ slug: 'persona-mask-jester', name: 'Bobão' }],
        personaMaskSlugs: ['persona-mask-jester'],
        beastborneAspectBenefits: [],
        dungeoneerSlayerLabels: [],
        precautionSpells: [],
        economyActions: [
          {
            id: 'fighter-second-wind',
            name: 'Recuperar Fôlego',
            economy: 'bonus',
            classSlug: 'fighter',
            minLevel: 1,
            tableAction: 'second-wind',
          },
          {
            id: 'rogue-cunning-action',
            name: 'Ação Astuta',
            economy: 'bonus',
            classSlug: 'rogue',
            minLevel: 2,
            tableAction: 'cunning-action',
          },
        ],
        panelActions: [
          {
            panelKey: 'fighter|second-wind',
            classSlug: 'fighter',
            slug: 'second-wind',
            name: 'Recuperar Fôlego',
            minLevel: 1,
            section: 'base',
            spendsFocus: false,
            sortOrder: 1,
          },
          {
            panelKey: 'rogue|cunning-action',
            classSlug: 'rogue',
            slug: 'cunning-action',
            name: 'Ação Astuta',
            minLevel: 2,
            section: 'base',
            spendsFocus: false,
            sortOrder: 1,
          },
        ],
      }),
    };

    const query = new FindCombatMechanicalCatalogQuery(
      mechanicalCatalog as never,
    );
    const result = await query.execute({ classSlug: 'fighter' });

    expect(mechanicalCatalog.load).toHaveBeenCalledTimes(1);
    expect(result.economyActions).toHaveLength(1);
    expect(result.economyActions[0].classSlug).toBe('fighter');
    expect(result.panelActions).toHaveLength(1);
    expect(result.personaMasks).toEqual([]);
  });
});
