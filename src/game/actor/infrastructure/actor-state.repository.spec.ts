import { ActorStateRepository } from './actor-state.repository';
import type { GameActor } from './game-actor.entity';

describe('ActorStateRepository.patch montaria', () => {
  const stateRepo = {
    findOne: jest.fn().mockResolvedValue({
      actorId: 'a1',
      conditions: [],
      tempHp: 0,
      concentratingOn: null,
      innateSpellUses: {},
    }),
    create: jest.fn((row) => row),
    save: jest.fn(async (row) => row),
  };
  const conditions = {};
  const pcStates = {
    findOne: jest.fn().mockResolvedValue({
      characterId: 'pc-1',
      boardedActorId: 'a1',
    }),
    save: jest.fn(async (row) => row),
  };
  const catalogLookup = {};
  const repo = new ActorStateRepository(
    stateRepo as never,
    conditions as never,
    pcStates as never,
    catalogLookup as never,
  );
  const actorRepo = {
    save: jest.fn(async (row) => row),
    remove: jest.fn(async () => undefined),
  };

  it('desmonta ao zerar PV', async () => {
    const actor = {
      id: 'a1',
      parentCharacterId: 'pc-1',
      templateSlug: 'cavalo-de-montaria',
      hitPointsCurrent: 8,
      hitPointsMax: 13,
      armorClass: 10,
      abilityScores: {
        forca: 10,
        destreza: 10,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    } as GameActor;
    await repo.patch(actor, { hitPointsCurrent: 0 }, actorRepo as never);
    expect(pcStates.save).toHaveBeenCalledWith(
      expect.objectContaining({ boardedActorId: null }),
    );
    expect(actorRepo.remove).not.toHaveBeenCalled();
  });

  it('despawna Montaria Fantasmagórica ao sofrer dano', async () => {
    const actor = {
      id: 'a1',
      parentCharacterId: 'pc-1',
      templateSlug: 'montaria-fantasmagorica',
      hitPointsCurrent: 13,
      hitPointsMax: 13,
      armorClass: 10,
      abilityScores: {
        forca: 10,
        destreza: 10,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    } as GameActor;
    await repo.patch(actor, { hitPointsCurrent: 12 }, actorRepo as never);
    expect(actorRepo.remove).toHaveBeenCalledWith(actor);
  });
});
