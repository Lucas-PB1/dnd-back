import { ForbiddenException, NotFoundException } from '@nestjs/common';
import type { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { Campaign } from '../campaign.entity';
import type { CampaignCharacter } from '../campaign-character.entity';
import type { CampaignMember } from '../campaign-member.entity';
import {
  findCharactersByIds,
  linkCharacter,
  listCampaignRefsByCharacterIds,
  listLinkedCharacters,
  unlinkCharacter,
  type CampaignCharacterLinksDeps,
} from './campaign-character-links';

type Repo = {
  findOne: jest.Mock;
  find: jest.Mock;
  save: jest.Mock;
  create: jest.Mock;
  remove: jest.Mock;
};

function repo(): Repo {
  return {
    findOne: jest.fn(),
    find: jest.fn(),
    save: jest.fn(),
    create: jest.fn((x) => x),
    remove: jest.fn(),
  };
}

function member(overrides: Partial<CampaignMember> = {}): CampaignMember {
  return {
    id: 'm1',
    campaignId: 'c1',
    userId: 'u1',
    role: 'player',
    joinedAt: new Date('2026-01-01'),
    ...overrides,
  };
}

function link(overrides: Partial<CampaignCharacter> = {}): CampaignCharacter {
  return {
    id: 'l1',
    campaignId: 'c1',
    characterId: 'ch1',
    linkedBy: 'u1',
    linkedAt: new Date('2026-01-01'),
    ...overrides,
  };
}

describe('campaign-character-links', () => {
  let campaigns: Repo;
  let members: Repo;
  let links: Repo;
  let characterRows: Repo;
  let characters: { findOwnedOrFail: jest.Mock };
  let deps: CampaignCharacterLinksDeps;

  beforeEach(() => {
    campaigns = repo();
    members = repo();
    links = repo();
    characterRows = repo();
    characters = { findOwnedOrFail: jest.fn() };
    deps = {
      campaigns: campaigns as never,
      members: members as never,
      links: links as never,
      characterRows: characterRows as never,
      characters: characters as unknown as CharacterRepository,
    };
    jest.clearAllMocks();
  });

  describe('linkCharacter', () => {
    it('creates link when character is owned and not yet linked', async () => {
      const owned = { id: 'ch1' } as PlayerCharacter;
      const saved = link();
      members.findOne.mockResolvedValue(member());
      characters.findOwnedOrFail.mockResolvedValue(owned);
      links.findOne.mockResolvedValue(null);
      links.save.mockResolvedValue(saved);

      await expect(linkCharacter(deps, 'c1', 'u1', 'ch1')).resolves.toBe(saved);
      expect(links.create).toHaveBeenCalledWith({
        campaignId: 'c1',
        characterId: 'ch1',
        linkedBy: 'u1',
      });
    });

    it('returns existing link without saving again', async () => {
      const existing = link();
      members.findOne.mockResolvedValue(member());
      characters.findOwnedOrFail.mockResolvedValue({ id: 'ch1' });
      links.findOne.mockResolvedValue(existing);

      await expect(linkCharacter(deps, 'c1', 'u1', 'ch1')).resolves.toBe(existing);
      expect(links.save).not.toHaveBeenCalled();
    });
  });

  describe('unlinkCharacter', () => {
    it('throws when link is missing', async () => {
      members.findOne.mockResolvedValue(member());
      links.findOne.mockResolvedValue(null);
      await expect(unlinkCharacter(deps, 'c1', 'u1', 'ch1')).rejects.toBeInstanceOf(
        NotFoundException,
      );
    });

    it('allows owner to unlink their character', async () => {
      const row = link();
      members.findOne.mockResolvedValue(member());
      links.findOne.mockResolvedValue(row);
      characterRows.findOne.mockResolvedValue({ id: 'ch1', userId: 'u1' });

      await unlinkCharacter(deps, 'c1', 'u1', 'ch1');
      expect(links.remove).toHaveBeenCalledWith(row);
    });

    it('allows dm to unlink any character', async () => {
      const row = link({ linkedBy: 'u-other' });
      members.findOne.mockResolvedValue(member({ role: 'dm' }));
      links.findOne.mockResolvedValue(row);
      characterRows.findOne.mockResolvedValue(null);

      await unlinkCharacter(deps, 'c1', 'u-dm', 'ch1');
      expect(links.remove).toHaveBeenCalledWith(row);
    });

    it('forbids unlink when user lacks permission', async () => {
      members.findOne.mockResolvedValue(member({ userId: 'u2', role: 'player' }));
      links.findOne.mockResolvedValue(link({ linkedBy: 'u-other' }));
      characterRows.findOne.mockResolvedValue(null);

      await expect(unlinkCharacter(deps, 'c1', 'u2', 'ch1')).rejects.toBeInstanceOf(
        ForbiddenException,
      );
    });
  });

  describe('listLinkedCharacters', () => {
    it('returns links ordered by linkedAt', async () => {
      const rows = [link()];
      links.find.mockResolvedValue(rows);
      await expect(listLinkedCharacters(deps, 'c1')).resolves.toBe(rows);
    });
  });

  describe('findCharactersByIds', () => {
    it('returns empty array for empty ids', async () => {
      await expect(findCharactersByIds(deps, [])).resolves.toEqual([]);
      expect(characterRows.find).not.toHaveBeenCalled();
    });

    it('loads characters by id', async () => {
      const rows = [{ id: 'ch1' }];
      characterRows.find.mockResolvedValue(rows);
      await expect(findCharactersByIds(deps, ['ch1'])).resolves.toBe(rows);
    });
  });

  describe('listCampaignRefsByCharacterIds', () => {
    it('returns empty map for empty input', async () => {
      const result = await listCampaignRefsByCharacterIds(
        {
          links: links as never,
          campaigns: campaigns as never,
          members: members as never,
        },
        [],
        'u1',
      );
      expect(result.size).toBe(0);
    });

    it('groups campaign refs by character id', async () => {
      links.find.mockResolvedValue([
        link({ characterId: 'ch1', campaignId: 'c1' }),
        link({ characterId: 'ch1', campaignId: 'c2' }),
      ]);
      campaigns.find.mockResolvedValue([
        {
          id: 'c1',
          name: 'One',
          allowPlayerSkipPayment: true,
        } as Campaign,
        {
          id: 'c2',
          name: 'Two',
          allowPlayerSkipPayment: false,
        } as Campaign,
      ]);
      members.find.mockResolvedValue([
        { campaignId: 'c1', role: 'player' },
        { campaignId: 'c2', role: 'dm' },
      ]);

      const result = await listCampaignRefsByCharacterIds(
        {
          links: links as never,
          campaigns: campaigns as never,
          members: members as never,
        },
        ['ch1'],
        'u1',
      );
      expect(result.get('ch1')).toEqual([
        {
          id: 'c1',
          name: 'One',
          allowPlayerSkipPayment: true,
          myRole: 'player',
        },
        {
          id: 'c2',
          name: 'Two',
          allowPlayerSkipPayment: false,
          myRole: 'dm',
        },
      ]);
    });
  });
});
