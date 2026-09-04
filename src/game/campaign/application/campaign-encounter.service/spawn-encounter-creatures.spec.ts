import { assertAddEncounterCreatureDto, spawnEncounterCreatures } from './spawn-encounter-creatures';
import { BadRequestException } from '@nestjs/common';

describe('spawnEncounterCreatures', () => {
  const templates = {
    findOne: jest.fn(),
  };
  const actors = {
    create: jest.fn(),
    findOne: jest.fn(),
    save: jest.fn(async (row: unknown) => row),
  };
  const actorPersistence = {
    createWithChildren: jest.fn(),
    spawnFromTemplate: jest.fn(),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('requires manual fields without templateSlug', () => {
    expect(() => assertAddEncounterCreatureDto({})).toThrow(BadRequestException);
  });

  it('spawns multiple actors from template', async () => {
    templates.findOne.mockResolvedValue({ slug: 'goblin', name: 'Goblin' });
    actorPersistence.spawnFromTemplate
      .mockResolvedValueOnce('a1')
      .mockResolvedValueOnce('a2');
    actors.findOne
      .mockResolvedValueOnce({ id: 'a1', name: 'Goblin #1', initiativeModifier: 2 })
      .mockResolvedValueOnce({ id: 'a2', name: 'Goblin #2', initiativeModifier: 2 });

    const result = await spawnEncounterCreatures({
      actorPersistence: actorPersistence as never,
      actors: actors as never,
      templates: templates as never,
      userId: 'u1',
      campaignId: 'c1',
      dto: { templateSlug: 'goblin', count: 2 },
    });

    expect(result).toHaveLength(2);
    expect(actorPersistence.spawnFromTemplate).toHaveBeenCalledTimes(2);
  });
});
