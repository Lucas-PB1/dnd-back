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
});
