jest.mock('./campaign/campaign-crud', () => ({
  createCampaign: jest.fn().mockResolvedValue({ campaign: { id: 'c1' }, membership: {} }),
  listForUser: jest.fn().mockResolvedValue([]),
  findCampaignOrFail: jest.fn().mockResolvedValue({ id: 'c1' }),
  updateCampaign: jest.fn().mockResolvedValue({ id: 'c1' }),
  deleteCampaign: jest.fn().mockResolvedValue(undefined),
  rotateInviteCode: jest.fn().mockResolvedValue({ id: 'c1', inviteCode: 'x' }),
}));

jest.mock('./campaign/campaign-membership', () => ({
  requireMember: jest.fn().mockResolvedValue({ role: 'dm' }),
  requireRole: jest.fn().mockResolvedValue({ role: 'dm' }),
  joinByInviteCode: jest.fn().mockResolvedValue({ campaign: {}, membership: {} }),
  listMembers: jest.fn().mockResolvedValue([]),
  updateMemberRole: jest.fn().mockResolvedValue({ role: 'player' }),
  removeMember: jest.fn().mockResolvedValue(undefined),
}));

jest.mock('./campaign/campaign-character-links', () => ({
  linkCharacter: jest.fn().mockResolvedValue({ characterId: 'ch1' }),
  unlinkCharacter: jest.fn().mockResolvedValue(undefined),
  listLinkedCharacters: jest.fn().mockResolvedValue([]),
  findCharactersByIds: jest.fn().mockResolvedValue([]),
  listCampaignRefsByCharacterIds: jest.fn().mockResolvedValue(new Map()),
}));

import { CampaignRepository } from './campaign.repository';
import * as crud from './campaign/campaign-crud';
import * as membership from './campaign/campaign-membership';
import * as links from './campaign/campaign-character-links';

describe('CampaignRepository', () => {
  let repo: CampaignRepository;

  beforeEach(() => {
    jest.clearAllMocks();
    repo = new CampaignRepository(
      {} as never,
      {} as never,
      {} as never,
      {} as never,
      {} as never,
    );
  });

  it('delegates CRUD methods', async () => {
    await repo.createCampaign({ userId: 'u', name: 'A' });
    await repo.listForUser('u');
    await repo.findCampaignOrFail('c1');
    await repo.updateCampaign('c1', 'u', { name: 'B' });
    await repo.deleteCampaign('c1', 'u');
    await repo.rotateInviteCode('c1', 'u');
    expect(crud.createCampaign).toHaveBeenCalled();
    expect(crud.listForUser).toHaveBeenCalled();
    expect(crud.findCampaignOrFail).toHaveBeenCalled();
    expect(crud.updateCampaign).toHaveBeenCalled();
    expect(crud.deleteCampaign).toHaveBeenCalled();
    expect(crud.rotateInviteCode).toHaveBeenCalled();
  });

  it('delegates membership methods', async () => {
    await repo.requireMember('c1', 'u');
    await repo.requireRole('c1', 'u', ['dm']);
    await repo.joinByInviteCode('u', 'INV');
    await repo.listMembers('c1');
    await repo.updateMemberRole('c1', 'u', 't', 'player');
    await repo.removeMember('c1', 'u', 't');
    expect(membership.requireMember).toHaveBeenCalled();
    expect(membership.requireRole).toHaveBeenCalled();
    expect(membership.joinByInviteCode).toHaveBeenCalled();
    expect(membership.listMembers).toHaveBeenCalled();
    expect(membership.updateMemberRole).toHaveBeenCalled();
    expect(membership.removeMember).toHaveBeenCalled();
  });

  it('delegates character link methods', async () => {
    await repo.linkCharacter('c1', 'u', 'ch1');
    await repo.unlinkCharacter('c1', 'u', 'ch1');
    await repo.listLinkedCharacters('c1');
    await repo.findCharactersByIds(['ch1']);
    await repo.listCampaignRefsByCharacterIds(['ch1'], 'u');
    expect(links.linkCharacter).toHaveBeenCalled();
    expect(links.unlinkCharacter).toHaveBeenCalled();
    expect(links.listLinkedCharacters).toHaveBeenCalled();
    expect(links.findCharactersByIds).toHaveBeenCalled();
    expect(links.listCampaignRefsByCharacterIds).toHaveBeenCalled();
  });
});
