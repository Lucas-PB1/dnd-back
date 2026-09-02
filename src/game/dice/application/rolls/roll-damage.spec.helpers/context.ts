import {
  FIXTURE_CUNNING_STRIKE_EFFECTS,
  FIXTURE_DUNGEONEER_SLAYER_LABELS,
} from '@game/combat/domain/__fixtures__/mechanical-catalog';
import type { RollDamageDto } from '@game/dice/dto/character-roll.dto';
import { executeRollDamage } from '../roll-damage';
import { asRollDep } from './mocks';

export type RollDamageTestContext = {
  base: Omit<Parameters<typeof executeRollDamage>[0], 'dto'>;
  resourceSpender: {
    spendClassResource: jest.Mock;
    consumeSpellSlotLevel: jest.Mock;
  };
  rollDamage: (dto: RollDamageDto) => ReturnType<typeof executeRollDamage>;
};

export function createRollDamageTestContext(): RollDamageTestContext {
  const resourceSpender = {
    spendClassResource: jest.fn().mockResolvedValue(undefined),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    getResourcesUsedEntry: jest.fn().mockResolvedValue(0),
    setResourcesUsedEntry: jest.fn(),
    clearResourcesUsedEntry: jest.fn(),
  };
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
