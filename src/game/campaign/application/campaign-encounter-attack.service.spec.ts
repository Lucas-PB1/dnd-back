import { CampaignEncounterAttackService } from './campaign-encounter-attack.service';
import { rollD20Check } from '@game/dice/domain/dice';
import { combatantFixture as combatant } from '@common/testing/combatant.fixture';
import { asDep } from '@common/testing/as-dep';

jest.mock('@game/dice/domain/dice', () => ({
  ...jest.requireActual('@game/dice/domain/dice'),
  rollD20Check: jest.fn(),
}));

const mockRollD20Check = rollD20Check as jest.MockedFunction<typeof rollD20Check>;

describe('CampaignEncounterAttackService', () => {
  const encounter = {
    id: 'e1',
    campaignId: 'c1',
    status: 'active',
    playersCanView: true,
  };
  const loaded = { id: 'e1', combatants: [] };

  function buildService(overrides: {
    attacker?: ReturnType<typeof combatant>;
    target?: ReturnType<typeof combatant>;
    actor?: { armorClass: number; hitPointsCurrent: number; id: string };
  }) {
    const attacker = overrides.attacker ?? combatant({ id: 'atk', kind: 'actor', actorId: 'actor-atk' });
    const target = overrides.target ?? combatant({
      id: 'tgt',
      kind: 'pc',
      characterId: 'char-t',
      actorId: null,
    });
    const campaigns = {
      requireMember: jest.fn().mockResolvedValue({ role: 'dm', userId: 'u1' }),
      findCharactersByIds: jest.fn().mockResolvedValue([
        { id: 'char-t', hitPointsCurrent: 20, abilityScores: {} },
      ]),
    };
    const encounters = {
      findEncounterInCampaignOrFail: jest.fn().mockResolvedValue(encounter),
      findCombatantByIdOrFail: jest
        .fn()
        .mockImplementation(async (_eid: string, id: string) =>
          id === attacker.id ? attacker : target,
        ),
    };
    const loadDto = { load: jest.fn().mockResolvedValue(loaded) };
    const rolls = { rollAttack: jest.fn(), rollDamage: jest.fn() };
    const characterState = {
      buildResponse: jest.fn().mockResolvedValue({ tempHp: 0 }),
      patch: jest.fn(),
      applyCurrentHitPoints: jest.fn(),
    };
    const actorState = {
      ensureState: jest.fn().mockResolvedValue({ tempHp: 0 }),
      patch: jest.fn(),
    };
    const enrichPcs = {
      enrich: jest.fn().mockResolvedValue(
        new Map([['char-t', { armorClass: 15 }]]),
      ),
    };
    const actor = overrides.actor ?? {
      id: 'actor-atk',
      armorClass: 13,
      hitPointsCurrent: 7,
    };
    const actors = {
      findOne: jest.fn().mockResolvedValue(actor),
    };
    const actorActions = {
      find: jest.fn().mockResolvedValue([
        {
          id: 'act1',
          name: 'Scimitar',
          attackBonus: 4,
          damageExpression: '1d6+2',
        },
      ]),
      findOne: jest.fn(),
    };
    const inventoryItems = { find: jest.fn().mockResolvedValue([{ itemSlug: 'longsword' }]) };

    const service = new CampaignEncounterAttackService(
      asDep(campaigns),
      asDep(encounters),
      asDep(loadDto),
      asDep(rolls),
      asDep(characterState),
      asDep(actorState),
      asDep(enrichPcs),
      asDep(actors),
      asDep(actorActions),
      asDep(inventoryItems),
    );
    return { service, characterState, rolls, loadDto };
  }

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('applies damage to a PC when an actor attack hits', async () => {
    mockRollD20Check.mockReturnValue({
      expression: '1d20+4',
      total: 18,
      modifier: 4,
      mode: 'normal',
      d20: { count: 1, sides: 20, rolls: [14], kept: [14] },
    });
    const { service, characterState, loadDto } = buildService({});
    const result = await service.resolve('u1', 'c1', 'e1', {
      attackerCombatantId: 'atk',
      targetCombatantId: 'tgt',
    });
    expect(result.hit).toBe(true);
    expect(result.critical).toBe(false);
    expect(characterState.applyCurrentHitPoints).toHaveBeenCalled();
    expect(loadDto.load).toHaveBeenCalled();
  });

  it('does not apply damage on a miss', async () => {
    mockRollD20Check.mockReturnValue({
      expression: '1d20+4',
      total: 8,
      modifier: 4,
      mode: 'normal',
      d20: { count: 1, sides: 20, rolls: [4], kept: [4] },
    });
    const { service, characterState } = buildService({});
    const result = await service.resolve('u1', 'c1', 'e1', {
      attackerCombatantId: 'atk',
      targetCombatantId: 'tgt',
    });
    expect(result.hit).toBe(false);
    expect(result.damageTotal).toBeNull();
    expect(characterState.applyCurrentHitPoints).not.toHaveBeenCalled();
  });
});
