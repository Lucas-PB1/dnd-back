import { applyHealHitPoints } from './apply-heal-hit-points';

describe('applyHealHitPoints', () => {
  it('cura o PC e compartilha Vínculo Vital quando o repositório expõe shareVitalBondHeal', async () => {
    const character = {
      id: 'pc-1',
      hitPointsCurrent: 10,
      hitPointsMax: 20,
    };
    const shareVitalBondHeal = jest.fn().mockResolvedValue(undefined);
    const stateRepo = {
      applyCurrentHitPoints: jest.fn(async (_c, hp) => {
        character.hitPointsCurrent = hp;
        return { hitPointsCurrent: hp, boardedActorId: 'mount-1' };
      }),
      buildResponse: jest.fn(async () => ({ hitPointsCurrent: 16 })),
      shareVitalBondHeal,
    };

    const result = await applyHealHitPoints(
      stateRepo as never,
      character as never,
      6,
    );
    expect(result.healed).toBe(6);
    expect(shareVitalBondHeal).toHaveBeenCalledWith('pc-1', 6);
  });

  it('não compartilha em mocks sem shareVitalBondHeal', async () => {
    const character = {
      id: 'pc-1',
      hitPointsCurrent: 10,
      hitPointsMax: 20,
    };
    const stateRepo = {
      applyCurrentHitPoints: jest.fn(async () => ({ hitPointsCurrent: 12 })),
      buildResponse: jest.fn(),
    };
    await applyHealHitPoints(stateRepo as never, character as never, 2);
    expect(stateRepo.applyCurrentHitPoints).toHaveBeenCalled();
  });
});
