import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import {
  joinByInviteCode,
  listMembers,
  removeMember,
  requireMember,
  requireRole,
  updateMemberRole,
  type CampaignMembershipDeps,
} from './campaign-membership';

describe('campaign-membership', () => {
  let deps: CampaignMembershipDeps;
  let members: {
    findOne: jest.Mock;
    find: jest.Mock;
    save: jest.Mock;
    create: jest.Mock;
    count: jest.Mock;
    remove: jest.Mock;
  };
  let campaigns: { findOne: jest.Mock };

  beforeEach(() => {
    members = {
      findOne: jest.fn(),
      find: jest.fn(),
      save: jest.fn(async (row) => row),
      create: jest.fn((row) => row),
      count: jest.fn(),
      remove: jest.fn(),
    };
    campaigns = { findOne: jest.fn() };
    deps = {
      members: members as never,
      campaigns: campaigns as never,
    };
  });

  it('requireMember / requireRole', async () => {
    members.findOne.mockResolvedValue(null);
    await expect(requireMember(deps, 'c1', 'u1')).rejects.toBeInstanceOf(
      ForbiddenException,
    );
    members.findOne.mockResolvedValue({ role: 'player', userId: 'u1' });
    await expect(
      requireRole(deps, 'c1', 'u1', ['dm']),
    ).rejects.toBeInstanceOf(ForbiddenException);
    await expect(
      requireRole(deps, 'c1', 'u1', ['player']),
    ).resolves.toMatchObject({ role: 'player' });
  });

  it('joinByInviteCode', async () => {
    await expect(
      joinByInviteCode(deps, 'u1', 'ABC', 'dm'),
    ).rejects.toBeInstanceOf(BadRequestException);
    campaigns.findOne.mockResolvedValue(null);
    await expect(
      joinByInviteCode(deps, 'u1', 'abc'),
    ).rejects.toBeInstanceOf(NotFoundException);

    const campaign = { id: 'c1', inviteCode: 'ABC' };
    campaigns.findOne.mockResolvedValue(campaign);
    members.findOne.mockResolvedValue({ userId: 'u1', role: 'player' });
    await expect(joinByInviteCode(deps, 'u1', 'abc')).resolves.toEqual({
      campaign,
      membership: { userId: 'u1', role: 'player' },
    });

    members.findOne.mockResolvedValue(null);
    await expect(joinByInviteCode(deps, 'u2', 'abc', 'assistant')).resolves.toEqual(
      {
        campaign,
        membership: { campaignId: 'c1', userId: 'u2', role: 'assistant' },
      },
    );
  });

  it('listMembers / updateMemberRole / removeMember', async () => {
    members.find.mockResolvedValue([{ userId: 'u1' }]);
    await expect(listMembers(deps, 'c1')).resolves.toEqual([{ userId: 'u1' }]);

    members.findOne
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm1' })
      .mockResolvedValueOnce(null);
    await expect(
      updateMemberRole(deps, 'c1', 'dm1', 'u2', 'player'),
    ).rejects.toBeInstanceOf(NotFoundException);

    members.findOne
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm1' })
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm2' });
    members.count.mockResolvedValue(1);
    await expect(
      updateMemberRole(deps, 'c1', 'dm1', 'dm2', 'player'),
    ).rejects.toBeInstanceOf(BadRequestException);

    members.findOne
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm1' })
      .mockResolvedValueOnce({ role: 'player', userId: 'u2' });
    await expect(
      updateMemberRole(deps, 'c1', 'dm1', 'u2', 'assistant'),
    ).resolves.toMatchObject({ role: 'assistant' });

    members.findOne.mockResolvedValue({ role: 'player', userId: 'u1' });
    await expect(removeMember(deps, 'c1', 'u1', 'u2')).rejects.toBeInstanceOf(
      ForbiddenException,
    );

    members.findOne
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm1' })
      .mockResolvedValueOnce(null);
    await expect(removeMember(deps, 'c1', 'dm1', 'u2')).rejects.toBeInstanceOf(
      NotFoundException,
    );

    members.findOne
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm1' })
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm2' });
    members.count.mockResolvedValue(1);
    await expect(removeMember(deps, 'c1', 'dm1', 'dm2')).rejects.toBeInstanceOf(
      BadRequestException,
    );

    members.findOne
      .mockResolvedValueOnce({ role: 'dm', userId: 'dm1' })
      .mockResolvedValueOnce({ role: 'player', userId: 'u2' });
    await expect(removeMember(deps, 'c1', 'dm1', 'u2')).resolves.toBeUndefined();
  });
});
