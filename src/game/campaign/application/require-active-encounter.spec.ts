import { BadRequestException } from '@nestjs/common';
import { requireActiveEncounter } from './require-active-encounter';
import type { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';

describe('requireActiveEncounter', () => {
  const encounters = {
    findEncounterInCampaignOrFail: jest.fn(),
  } as unknown as CampaignEncounterRepository;

  const activeEncounter: CampaignEncounter = {
    id: 'e1',
    campaignId: 'c1',
    name: 'Fight',
    status: 'active',
    round: 1,
    currentTurnIndex: 0,
    playersCanView: true,
    creatureHpVisibility: 'percent',
    createdBy: 'u1',
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('returns encounter when status is active', async () => {
    encounters.findEncounterInCampaignOrFail = jest
      .fn()
      .mockResolvedValue(activeEncounter);

    await expect(
      requireActiveEncounter(encounters, 'c1', 'e1'),
    ).resolves.toBe(activeEncounter);
  });

  it('throws BadRequestException when encounter is closed', async () => {
    encounters.findEncounterInCampaignOrFail = jest.fn().mockResolvedValue({
      ...activeEncounter,
      status: 'closed',
    });

    await expect(
      requireActiveEncounter(encounters, 'c1', 'e1'),
    ).rejects.toThrow(BadRequestException);
  });
});
