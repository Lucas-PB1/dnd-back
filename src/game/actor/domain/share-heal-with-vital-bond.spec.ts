import { shareHealWithVitalBondMount } from './share-heal-with-vital-bond';
import type { GameActor } from '../infrastructure/game-actor.entity';

function mount(partial: Partial<GameActor>): GameActor {
  return {
    actorKind: 'mount',
    templateSlug: 'montaria-sobrenatural-celestial',
    hitPointsCurrent: 10,
    hitPointsMax: 25,
    ...partial,
  } as GameActor;
}

describe('shareHealWithVitalBondMount', () => {
  it('cura a montaria sobrenatural embarcada no mesmo valor', async () => {
    const actor = mount({});
    const actors = {
      findOne: jest.fn().mockResolvedValue(actor),
      save: jest.fn().mockResolvedValue(actor),
    };
    await expect(
      shareHealWithVitalBondMount(actors, 'mount-1', 8),
    ).resolves.toBe(8);
    expect(actor.hitPointsCurrent).toBe(18);
    expect(actors.save).toHaveBeenCalledWith(actor);
  });

  it('ignora cavalo comum e actor ausente', async () => {
    const horse = mount({ templateSlug: 'cavalo-de-montaria' });
    const actors = {
      findOne: jest.fn().mockResolvedValue(horse),
      save: jest.fn(),
    };
    await expect(
      shareHealWithVitalBondMount(actors, 'mount-1', 8),
    ).resolves.toBe(0);
    expect(actors.save).not.toHaveBeenCalled();
    await expect(shareHealWithVitalBondMount(actors, null, 8)).resolves.toBe(
      0,
    );
  });
});
