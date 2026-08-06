import {
  buildClassResourceState,
  loadClassProgressionSnapshot,
  loadClassResourceSchedule,
  resolveClassResources,
} from './class-resources';
import { DEFAULT_ABILITY_SCORES } from '../../../../shared/infrastructure/player-character.entity';

describe('character-state/class-resources', () => {
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
  });

  describe('loadClassProgressionSnapshot', () => {
    it('returns null when row missing', async () => {
      dataSource.query.mockResolvedValue([]);
      await expect(
        loadClassProgressionSnapshot(dataSource as never, 'fighter', 1),
      ).resolves.toBeNull();
    });

    it('maps proficiency and channel divinity', async () => {
      dataSource.query.mockResolvedValue([
        { proficiency_bonus: 3, channel_divinity: 2 },
      ]);
      await expect(
        loadClassProgressionSnapshot(dataSource as never, 'cleric', 5),
      ).resolves.toEqual({ proficiencyBonus: 3, channelDivinity: 2 });
    });
  });

  describe('loadClassResourceSchedule', () => {
    it('maps db rows to schedule shape', async () => {
      dataSource.query.mockResolvedValue([
        {
          resource_slug: 'rage',
          resource_name: 'Fúria',
          unlock_level: 1,
          max_formula: 'fixed',
          fixed_max: 2,
          recover_one_on_short: false,
          recover_all_on_short: false,
          recover_all_on_long: true,
        },
      ]);
      await expect(
        loadClassResourceSchedule(dataSource as never, 'barbarian'),
      ).resolves.toEqual([
        {
          resourceSlug: 'rage',
          resourceName: 'Fúria',
          unlockLevel: 1,
          maxFormula: 'fixed',
          fixedMax: 2,
          recoverOneOnShort: false,
          recoverAllOnShort: false,
          recoverAllOnLong: true,
        },
      ]);
    });
  });

  describe('resolveClassResources + buildClassResourceState', () => {
    const scheduleRows = [
      {
        resource_slug: 'risk',
        resource_name: 'Risco',
        unlock_level: 1,
        max_formula: 'proficiency_bonus',
        fixed_max: null,
        recover_one_on_short: false,
        recover_all_on_short: true,
        recover_all_on_long: true,
      },
      {
        resource_slug: 'rage',
        resource_name: 'Fúria',
        unlock_level: 1,
        max_formula: 'fixed',
        fixed_max: 3,
        recover_one_on_short: false,
        recover_all_on_short: false,
        recover_all_on_long: true,
      },
    ];

    it('builds remaining and risk die extras', async () => {
      dataSource.query.mockImplementation(async (sql: string) => {
        if (String(sql).includes('phb_class_resource')) return scheduleRows;
        if (String(sql).includes('v_phb_class_progression')) {
          return [{ proficiency_bonus: 2, channel_divinity: null }];
        }
        return [];
      });

      const character = {
        classSlug: 'barbarian',
        level: 3,
        abilityScores: DEFAULT_ABILITY_SCORES,
      } as never;

      const resources = await resolveClassResources(dataSource as never, character);
      expect(resources.some((r) => r.slug === 'risk')).toBe(true);

      const state = await buildClassResourceState(
        dataSource as never,
        character,
        { resourcesUsed: { rage: 1, risk: 5 } } as never,
      );
      const rage = state.find((r) => r.slug === 'rage');
      const risk = state.find((r) => r.slug === 'risk');
      expect(rage).toMatchObject({ used: 1, remaining: expect.any(Number) });
      expect(risk).toMatchObject({
        dieFaces: expect.any(Number),
        dieLabel: expect.any(String),
      });
      expect(risk!.remaining).toBeGreaterThanOrEqual(0);
    });

    it('defaults proficiency when progression missing', async () => {
      dataSource.query.mockResolvedValue([]);
      const resources = await resolveClassResources(dataSource as never, {
        classSlug: 'fighter',
        level: 1,
        abilityScores: DEFAULT_ABILITY_SCORES,
      } as never);
      expect(resources).toEqual([]);
    });
  });
});
