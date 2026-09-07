import { BadRequestException, ForbiddenException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { asDep } from '@common/testing/as-dep';
import { CampaignCharacter } from '@game/campaign/infrastructure/campaign-character.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { TransferInspirationHandler } from './transfer-inspiration.handler';

describe('TransferInspirationHandler', () => {
  const access = {
    findAccessibleOrFail: jest.fn(),
  };
  const state = {
    buildResponse: jest.fn(),
    patch: jest.fn(),
  };
  const campaignLinks = {
    find: jest.fn(),
    count: jest.fn(),
  };

  const handler = new TransferInspirationHandler(
    asDep<PlayerCharacterAccessService>(access),
    asDep<CharacterStateRepository>(state),
    asDep<Repository<CampaignCharacter>>(campaignLinks),
  );

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('transfere inspiração entre PCs do mesmo dono', async () => {
    access.findAccessibleOrFail
      .mockResolvedValueOnce({ id: 'a', userId: 'u1', name: 'A' })
      .mockResolvedValueOnce({ id: 'b', userId: 'u1', name: 'B' });
    state.buildResponse.mockResolvedValue({ inspiration: true });
    state.patch
      .mockResolvedValueOnce({ inspiration: false })
      .mockResolvedValueOnce({ inspiration: true });

    const result = await handler.execute('u1', 'a', {
      targetCharacterId: 'b',
    });

    expect(result.note).toContain('B');
    expect(state.patch).toHaveBeenNthCalledWith(1, expect.anything(), {
      inspiration: false,
    });
    expect(state.patch).toHaveBeenNthCalledWith(2, expect.anything(), {
      inspiration: true,
    });
  });

  it('recusa sem inspiração na origem', async () => {
    access.findAccessibleOrFail
      .mockResolvedValueOnce({ id: 'a', userId: 'u1', name: 'A' })
      .mockResolvedValueOnce({ id: 'b', userId: 'u1', name: 'B' });
    state.buildResponse.mockResolvedValue({ inspiration: false });

    await expect(
      handler.execute('u1', 'a', { targetCharacterId: 'b' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('recusa personagens sem vínculo', async () => {
    access.findAccessibleOrFail
      .mockResolvedValueOnce({ id: 'a', userId: 'u1', name: 'A' })
      .mockResolvedValueOnce({ id: 'b', userId: 'u2', name: 'B' });
    campaignLinks.find.mockResolvedValue([]);

    await expect(
      handler.execute('u1', 'a', { targetCharacterId: 'b' }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});
