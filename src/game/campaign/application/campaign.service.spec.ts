import { CampaignService } from './campaign.service';
import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { Campaign } from '../infrastructure/campaign.entity';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';

const iso = '2026-01-01T00:00:00.000Z';

function campaign(overrides: Partial<Campaign> = {}): Campaign {
  return {
    id: 'c1',
    name: 'Campaign',
    description: 'Desc',
    inviteCode: 'CODE1234',
    createdBy: 'u1',
    createdAt: new Date(iso),
    updatedAt: new Date('2026-01-02T00:00:00.000Z'),
    ...overrides,
  };
}

function member(overrides: Partial<CampaignMember> = {}): CampaignMember {
  return {
    id: 'm1',
    campaignId: 'c1',
    userId: 'u1',
    role: 'dm',
    joinedAt: new Date(iso),
    ...overrides,
  };
}

describe('CampaignService', () => {
  let repo: jest.Mocked<CampaignRepository>;
  let service: CampaignService;

  beforeEach(() => {
    repo = {
      createCampaign: jest.fn(),
      listForUser: jest.fn(),
      requireMember: jest.fn(),
      findCampaignOrFail: jest.fn(),
      listMembers: jest.fn(),
      listLinkedCharacters: jest.fn(),
      findCharactersByIds: jest.fn(),
      updateCampaign: jest.fn(),
      deleteCampaign: jest.fn(),
      joinByInviteCode: jest.fn(),
      updateMemberRole: jest.fn(),
      removeMember: jest.fn(),
      linkCharacter: jest.fn(),
      unlinkCharacter: jest.fn(),
      rotateInviteCode: jest.fn(),
      listCampaignRefsByCharacterIds: jest.fn(),
    } as unknown as jest.Mocked<CampaignRepository>;
    service = new CampaignService(repo);
  });

  it('create and list map repository rows to summaries', async () => {
    const c = campaign();
    repo.createCampaign.mockResolvedValue({ campaign: c, membership: member() });
    repo.listForUser.mockResolvedValue([{ campaign: c, role: 'player' }]);

    await expect(
      service.create('u1', { name: 'Campaign', description: 'Desc' }),
    ).resolves.toMatchObject({ id: 'c1', myRole: 'dm', inviteCode: 'CODE1234' });

    const rows = await service.list('u1');
    expect(rows[0]).toMatchObject({ id: 'c1', myRole: 'player' });
  });

  it('getDetail aggregates members and characters with fallbacks', async () => {
    const m = member({ role: 'assistant' });
    const linkAt = new Date('2026-01-03T00:00:00.000Z');
    repo.requireMember.mockResolvedValue(m);
    repo.findCampaignOrFail.mockResolvedValue(campaign());
    repo.listMembers.mockResolvedValue([m]);
    repo.listLinkedCharacters.mockResolvedValue([
      { id: 'l1', campaignId: 'c1', characterId: 'ch1', linkedBy: 'u1', linkedAt: linkAt },
      { id: 'l2', campaignId: 'c1', characterId: 'gone', linkedBy: 'u1', linkedAt: linkAt },
    ]);
    repo.findCharactersByIds.mockResolvedValue([
      { id: 'ch1', name: 'Hero', level: 3, classSlug: 'fighter', speciesSlug: 'human' } as never,
    ]);

    const detail = await service.getDetail('u1', 'c1');
    expect(detail).toMatchObject({
      myRole: 'assistant',
      members: [{ userId: 'u1', role: 'assistant' }],
    });
    expect(detail.characters[0]).toMatchObject({
      characterId: 'ch1',
      name: 'Hero',
      level: 3,
    });
    expect(detail.characters[1]).toMatchObject({
      characterId: 'gone',
      name: '(removido)',
      level: 0,
    });
  });

  it('update, join and rotateInvite return summaries', async () => {
    repo.updateCampaign.mockResolvedValue(campaign({ name: 'Renamed' }));
    repo.requireMember.mockResolvedValue(member({ role: 'dm' }));
    repo.joinByInviteCode.mockResolvedValue({
      campaign: campaign(),
      membership: member({ role: 'player' }),
    });
    repo.rotateInviteCode.mockResolvedValue(campaign({ inviteCode: 'NEW12345' }));

    expect((await service.update('u1', 'c1', { name: 'Renamed' })).name).toBe('Renamed');
    expect((await service.join('u2', { inviteCode: 'code' })).myRole).toBe('player');
    expect((await service.rotateInvite('u1', 'c1')).inviteCode).toBe('NEW12345');
  });

  it('updateMemberRole serializes member dto', async () => {
    const updated = member({ userId: 'u2', role: 'assistant' });
    repo.updateMemberRole.mockResolvedValue(updated);
    await expect(
      service.updateMemberRole('u1', 'c1', 'u2', { role: 'assistant' }),
    ).resolves.toEqual({
      userId: 'u2',
      role: 'assistant',
      joinedAt: iso,
    });
  });

  it('linkCharacter maps linked character dto', async () => {
    repo.linkCharacter.mockResolvedValue({
      id: 'l1',
      campaignId: 'c1',
      characterId: 'ch1',
      linkedBy: 'u1',
      linkedAt: new Date('2026-01-04T00:00:00.000Z'),
    });
    repo.findCharactersByIds.mockResolvedValue([
      { id: 'ch1', name: 'Rogue', level: 5, classSlug: 'rogue', speciesSlug: 'elf' } as never,
    ]);

    await expect(
      service.linkCharacter('u1', 'c1', { characterId: 'ch1' }),
    ).resolves.toMatchObject({ characterId: 'ch1', name: 'Rogue', level: 5 });
  });

  it('remove, unlink and listCampaignRefs delegate to repository', async () => {
    const map = new Map([['ch1', [{ id: 'c1', name: 'One' }]]]);
    repo.listCampaignRefsByCharacterIds.mockResolvedValue(map);

    await service.remove('u1', 'c1');
    await service.unlinkCharacter('u1', 'c1', 'ch1');
    await expect(service.listCampaignRefsByCharacterIds(['ch1'])).resolves.toBe(map);

    expect(repo.deleteCampaign).toHaveBeenCalledWith('c1', 'u1');
    expect(repo.unlinkCharacter).toHaveBeenCalledWith('c1', 'u1', 'ch1');
  });
});
