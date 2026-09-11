import {
  FIXTURE_CUNNING_STRIKE_EFFECTS,
  FIXTURE_DUNGEONEER_SLAYER_LABELS,
} from '@game/combat/domain/__fixtures__/mechanical-catalog';
import {
  FEATURE_SCHEDULE_FIXTURES_BY_CLASS,
  FEATURE_SCHEDULE_FIXTURES_BY_SUBCLASS,
} from '@game/combat/domain/feature-schedule.fixtures';
import type { RollDamageDto } from '@game/dice/dto/character-roll.dto';
import { executeRollDamage } from '../roll-damage';
import { asRollDep, mockEffectCatalog, mockResourceSpender } from './mocks';

export type RollDamageTestContext = {
  base: Omit<Parameters<typeof executeRollDamage>[0], 'dto'>;
  resourceSpender: ReturnType<typeof mockResourceSpender>;
  rollDamage: (dto: RollDamageDto) => ReturnType<typeof executeRollDamage>;
};

export function createRollDamageTestContext(): RollDamageTestContext {
  const resourceSpender = mockResourceSpender();
  const mechanicalCatalog = {
    load: async () => ({
      cunningStrikeEffects: FIXTURE_CUNNING_STRIKE_EFFECTS,
      dungeoneerSlayerLabels: FIXTURE_DUNGEONEER_SLAYER_LABELS,
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      tableActions: [],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
      featureGatesBySubclassSlug: new Map(),
      featureSchedulesByClassSlug: FEATURE_SCHEDULE_FIXTURES_BY_CLASS,
      featureSchedulesBySubclassSlug: FEATURE_SCHEDULE_FIXTURES_BY_SUBCLASS,
    }),
  };
  const base = {
    access: asRollDep({}),
    sheet: asRollDep({}),
    domain: asRollDep({ getProficiencyBonus: jest.fn().mockResolvedValue(3) }),
    weaponAttacks: asRollDep({}),
    permanentItemEffects: asRollDep({}),
    dataSource: asRollDep({}),
    resourceSpender,
    mechanicalCatalog: asRollDep(mechanicalCatalog),
    effectCatalog: mockEffectCatalog(),
    userId: 'u1',
    characterId: 'c1',
  } as Omit<Parameters<typeof executeRollDamage>[0], 'dto'>;
  return {
    base,
    resourceSpender,
    rollDamage: (dto) =>
      executeRollDamage({ ...base, dto } as Parameters<typeof executeRollDamage>[0]),
  };
}
