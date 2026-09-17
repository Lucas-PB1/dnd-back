import { BadRequestException, ForbiddenException } from '@nestjs/common';
import { assertCanResolveEncounterAttack } from './encounter-attack-auth';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import { combatantFixture as combatant } from '@common/testing/combatant.fixture';

describe('assertCanResolveEncounterAttack', () => {
  const campaigns = {
    findCharactersByIds: jest.fn(),
  } as unknown as CampaignRepository;

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('allows dm to attack with any combatant', async () => {
    await expect(
      assertCanResolveEncounterAttack({
        campaigns,
        userId: 'u1',
        role: 'dm',
        attacker: combatant({ id: 'a', kind: 'actor' }),
        target: combatant({ id: 'b', kind: 'pc', characterId: 'c1' }),
      }),
    ).resolves.toBeUndefined();
  });

  it('rejects attacking the same combatant', async () => {
    const row = combatant({ id: 'same' });
    await expect(
      assertCanResolveEncounterAttack({
        campaigns,
        userId: 'u1',
        role: 'dm',
        attacker: row,
        target: row,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('allows a player attacking with their own PC', async () => {
    campaigns.findCharactersByIds = jest
      .fn()
      .mockResolvedValue([{ id: 'char1', userId: 'u1' }]);
    await expect(
      assertCanResolveEncounterAttack({
        campaigns,
        userId: 'u1',
        role: 'player',
        attacker: combatant({
          id: 'a',
          kind: 'pc',
          characterId: 'char1',
          actorId: null,
        }),
        target: combatant({ id: 'b' }),
      }),
    ).resolves.toBeUndefined();
  });

  it('forbids a player attacking with an actor or another PC', async () => {
    await expect(
      assertCanResolveEncounterAttack({
        campaigns,
        userId: 'u1',
        role: 'player',
        attacker: combatant({ id: 'a', kind: 'actor' }),
        target: combatant({ id: 'b' }),
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);

    campaigns.findCharactersByIds = jest
      .fn()
      .mockResolvedValue([{ id: 'char2', userId: 'other' }]);
    await expect(
      assertCanResolveEncounterAttack({
        campaigns,
        userId: 'u1',
        role: 'player',
        attacker: combatant({
          id: 'a',
          kind: 'pc',
          characterId: 'char2',
          actorId: null,
        }),
        target: combatant({ id: 'b' }),
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});
