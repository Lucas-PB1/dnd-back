jest.mock('../../domain/invite-code', () => ({
  generateCampaignInviteCode: jest.fn(() => 'NEWCODE1'),
}));

import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { generateCampaignInviteCode } from '../../domain/invite-code';
import type { Campaign } from '../campaign.entity';
import type { CampaignMember } from '../campaign-member.entity';
import {
  createCampaign,
  deleteCampaign,
  findCampaignOrFail,
  listForUser,
  rotateInviteCode,
  updateCampaign,
  type CampaignCrudDeps,
} from './campaign-crud';

const mockGenerateCode = generateCampaignInviteCode as jest.MockedFunction<
  typeof generateCampaignInviteCode
>;

type Repo = {
  findOne: jest.Mock;
  find: jest.Mock;
  save: jest.Mock;
  create: jest.Mock;
  remove: jest.Mock;
  exist: jest.Mock;
};

function repo(): Repo {
  return {
    findOne: jest.fn(),
    find: jest.fn(),
    save: jest.fn(),
    create: jest.fn((x) => x),
    remove: jest.fn(),
    exist: jest.fn(),
  };
}

function campaign(overrides: Partial<Campaign> = {}): Campaign {
  return {
    id: 'c1',
    name: 'Campaign',
    description: 'Desc',
    inviteCode: 'OLDCODE1',
    createdBy: 'u1',
    createdAt: new Date('2026-01-01'),
    updatedAt: new Date('2026-01-02'),
    ...overrides,
  };
}

function member(overrides: Partial<CampaignMember> = {}): CampaignMember {
  return {
    id: 'm1',
    campaignId: 'c1',
    userId: 'u1',
    role: 'dm',
    joinedAt: new Date('2026-01-01'),
    ...overrides,
  };
}

describe('campaign-crud', () => {
  let campaigns: Repo;
  let members: Repo;
  let deps: CampaignCrudDeps;

  beforeEach(() => {
    campaigns = repo();
    members = repo();
    deps = { campaigns: campaigns as never, members: members as never };
    mockGenerateCode.mockReturnValue('NEWCODE1');
    campaigns.exist.mockResolvedValue(false);
    jest.clearAllMocks();
    mockGenerateCode.mockReturnValue('NEWCODE1');
    campaigns.exist.mockResolvedValue(false);
  });

  describe('createCampaign', () => {
    it('creates campaign with trimmed fields and dm membership', async () => {
      const savedCampaign = campaign({ name: 'My Game', description: 'Notes' });
      const savedMember = member();
      campaigns.save.mockResolvedValue(savedCampaign);
      members.save.mockResolvedValue(savedMember);

      const result = await createCampaign(deps, {
        userId: 'u1',
        name: '  My Game  ',
        description: '  Notes  ',
      });

      expect(result).toEqual({ campaign: savedCampaign, membership: savedMember });
      expect(campaigns.create).toHaveBeenCalledWith({
        name: 'My Game',
        description: 'Notes',
        inviteCode: 'NEWCODE1',
        createdBy: 'u1',
      });
      expect(members.create).toHaveBeenCalledWith({
        campaignId: savedCampaign.id,
        userId: 'u1',
        role: 'dm',
      });
    });
  });

  describe('listForUser', () => {
    it('returns empty array when user has no memberships', async () => {
      members.find.mockResolvedValue([]);
      await expect(listForUser(deps, 'u1')).resolves.toEqual([]);
    });

    it('maps campaigns with user roles', async () => {
      const memberships = [
        member({ campaignId: 'c1', role: 'dm' }),
        member({ campaignId: 'c2', role: 'player', userId: 'u1' }),
      ];
      const rows = [
        campaign({ id: 'c1', name: 'One' }),
        campaign({ id: 'c2', name: 'Two' }),
      ];
      members.find.mockResolvedValue(memberships);
      campaigns.find.mockResolvedValue(rows);

      await expect(listForUser(deps, 'u1')).resolves.toEqual([
        { campaign: rows[0], role: 'dm' },
        { campaign: rows[1], role: 'player' },
      ]);
    });
  });

  describe('findCampaignOrFail', () => {
    it('returns campaign when found', async () => {
      const row = campaign();
      campaigns.findOne.mockResolvedValue(row);
      await expect(findCampaignOrFail(deps, 'c1')).resolves.toBe(row);
    });

    it('throws NotFoundException when missing', async () => {
      campaigns.findOne.mockResolvedValue(null);
      await expect(findCampaignOrFail(deps, 'x')).rejects.toBeInstanceOf(
        NotFoundException,
      );
    });
  });

  describe('updateCampaign', () => {
    it('updates name and description for dm', async () => {
      const dm = member({ role: 'dm' });
      const row = campaign();
      members.findOne.mockResolvedValue(dm);
      campaigns.findOne.mockResolvedValue(row);
      campaigns.save.mockImplementation(async (c) => c);

      const result = await updateCampaign(deps, 'c1', 'u1', {
        name: '  Renamed  ',
        description: '  ',
      });
      expect(result.name).toBe('Renamed');
      expect(result.description).toBeNull();
    });

    it('rejects update from non-dm', async () => {
      members.findOne.mockResolvedValue(member({ role: 'player' }));
      await expect(
        updateCampaign(deps, 'c1', 'u1', { name: 'X' }),
      ).rejects.toBeInstanceOf(ForbiddenException);
    });
  });

  describe('deleteCampaign', () => {
    it('removes campaign when actor is dm', async () => {
      const row = campaign();
      members.findOne.mockResolvedValue(member({ role: 'dm' }));
      campaigns.findOne.mockResolvedValue(row);
      await deleteCampaign(deps, 'c1', 'u1');
      expect(campaigns.remove).toHaveBeenCalledWith(row);
    });
  });

  describe('rotateInviteCode', () => {
    it('assigns a new unique invite code', async () => {
      const row = campaign();
      members.findOne.mockResolvedValue(member({ role: 'dm' }));
      campaigns.findOne.mockResolvedValue(row);
      campaigns.save.mockImplementation(async (c) => c);

      const result = await rotateInviteCode(deps, 'c1', 'u1');
      expect(result.inviteCode).toBe('NEWCODE1');
      expect(mockGenerateCode).toHaveBeenCalled();
    });
  });
});
