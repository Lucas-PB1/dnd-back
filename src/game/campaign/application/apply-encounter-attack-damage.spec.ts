import { BadRequestException } from '@nestjs/common';
import { applyEncounterAttackDamage } from './apply-encounter-attack-damage';
import { combatantFixture as combatant } from '@common/testing/combatant.fixture';

describe('applyEncounterAttackDamage', () => {
  it('skips when damage is zero', async () => {
    const campaigns = { findCharactersByIds: jest.fn() };
    await applyEncounterAttackDamage({
      campaigns: campaigns as never,
      characterState: {} as never,
      actorState: {} as never,
      actors: { findOne: jest.fn() } as never,
      target: combatant({ kind: 'pc', characterId: 'c1', actorId: null }),
      damage: 0,
    });
    expect(campaigns.findCharactersByIds).not.toHaveBeenCalled();
  });

  it('applies temp HP then current HP on a PC', async () => {
    const character = { id: 'c1', hitPointsCurrent: 20 };
    const campaigns = {
      findCharactersByIds: jest.fn().mockResolvedValue([character]),
    };
    const characterState = {
      buildResponse: jest.fn().mockResolvedValue({ tempHp: 4 }),
      patch: jest.fn().mockResolvedValue({}),
      applyCurrentHitPoints: jest.fn().mockResolvedValue({}),
    };
    await applyEncounterAttackDamage({
      campaigns: campaigns as never,
      characterState: characterState as never,
      actorState: {} as never,
      actors: { findOne: jest.fn() } as never,
      target: combatant({
        id: 't1',
        kind: 'pc',
        characterId: 'c1',
        actorId: null,
      }),
      damage: 10,
    });
    expect(characterState.patch).toHaveBeenCalledWith(character, { tempHp: 0 });
    expect(characterState.applyCurrentHitPoints).toHaveBeenCalledWith(
      character,
      14,
    );
  });

  it('patches actor HP and temp HP', async () => {
    const actor = { id: 'actor1', hitPointsCurrent: 12 };
    const actors = { findOne: jest.fn().mockResolvedValue(actor) };
    const actorState = {
      ensureState: jest.fn().mockResolvedValue({ tempHp: 2 }),
      patch: jest.fn().mockResolvedValue({}),
    };
    await applyEncounterAttackDamage({
      campaigns: { findCharactersByIds: jest.fn() } as never,
      characterState: {} as never,
      actorState: actorState as never,
      actors: actors as never,
      target: combatant({ id: 't1', kind: 'actor', actorId: 'actor1' }),
      damage: 5,
    });
    expect(actorState.patch).toHaveBeenCalledWith(
      actor,
      { tempHp: 0, hitPointsCurrent: 9 },
      actors,
    );
  });

  it('rejects a missing PC target', async () => {
    await expect(
      applyEncounterAttackDamage({
        campaigns: {
          findCharactersByIds: jest.fn().mockResolvedValue([]),
        } as never,
        characterState: {} as never,
        actorState: {} as never,
        actors: { findOne: jest.fn() } as never,
        target: combatant({
          kind: 'pc',
          characterId: 'missing',
          actorId: null,
        }),
        damage: 3,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
