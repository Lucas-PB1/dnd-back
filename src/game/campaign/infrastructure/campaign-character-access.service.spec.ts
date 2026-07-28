import { CampaignCharacterAccessService } from './campaign-character-access.service';

describe('CampaignCharacterAccessService', () => {
  let links: { find: jest.Mock };
  let members: { find: jest.Mock; findOne: jest.Mock };
  let service: CampaignCharacterAccessService;

  beforeEach(() => {
    links = { find: jest.fn() };
    members = { find: jest.fn(), findOne: jest.fn() };
    service = new CampaignCharacterAccessService(links as never, members as never);
  });

  describe('hasAccess', () => {
    it('returns false for own mode', async () => {
      await expect(service.hasAccess('u', 'ch', 'own')).resolves.toBe(false);
      expect(links.find).not.toHaveBeenCalled();
    });

    it('returns false when character has no campaign links', async () => {
      links.find.mockResolvedValue([]);
      await expect(service.hasAccess('u', 'ch', 'read')).resolves.toBe(false);
    });

    it('returns false when user is not a member', async () => {
      links.find.mockResolvedValue([{ campaignId: 'c1' }]);
      members.find.mockResolvedValue([]);
      await expect(service.hasAccess('u', 'ch', 'read')).resolves.toBe(false);
    });

    it('allows any member for read', async () => {
      links.find.mockResolvedValue([{ campaignId: 'c1' }]);
      members.find.mockResolvedValue([{ role: 'player' }]);
      await expect(service.hasAccess('u', 'ch', 'read')).resolves.toBe(true);
    });

    it('allows dm/assistant for write and denies player', async () => {
      links.find.mockResolvedValue([{ campaignId: 'c1' }]);
      members.find.mockResolvedValue([{ role: 'player' }]);
      await expect(service.hasAccess('u', 'ch', 'write')).resolves.toBe(false);
      members.find.mockResolvedValue([{ role: 'dm' }]);
      await expect(service.hasAccess('u', 'ch', 'write')).resolves.toBe(true);
      members.find.mockResolvedValue([{ role: 'assistant' }]);
      await expect(service.hasAccess('u', 'ch', 'write')).resolves.toBe(true);
    });
  });

  describe('findMemberRole', () => {
    it('returns role or null', async () => {
      members.findOne.mockResolvedValue({ role: 'dm' });
      await expect(service.findMemberRole('c1', 'u')).resolves.toBe('dm');
      members.findOne.mockResolvedValue(null);
      await expect(service.findMemberRole('c1', 'u')).resolves.toBeNull();
    });
  });
});
