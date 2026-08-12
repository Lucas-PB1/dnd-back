import { BadRequestException } from '@nestjs/common';
import { useBloodStrikeAction } from './blood-hound-actions';
import type { FighterActionDeps } from './fighter-action-deps';

describe('useBloodStrikeAction', () => {
  const character = {
    id: 'char-1',
    level: 15,
    classSlug: 'fighter',
    subclassSlug: 'blood-hound',
    hitPointsCurrent: 40,
    hitPointsMax: 50,
    abilityScores: {
      forca: 10,
      destreza: 10,
      constituicao: 16,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 10,
    },
  };

  function makeDeps(overrides?: {
    optionValueId?: string;
    level?: number;
  }): FighterActionDeps {
    const level = overrides?.level ?? character.level;
    return {
      access: {
        findAccessibleOrFail: jest.fn().mockResolvedValue({
          ...character,
          level,
        }),
      },
      state: {
        useClassResource: jest.fn().mockResolvedValue({
          state: { resources: [] },
        }),
        applyCurrentHitPoints: jest
          .fn()
          .mockImplementation(async (_c, hp: number) => ({
            hitPointsCurrent: hp,
            resources: [],
          })),
      },
      domain: {} as FighterActionDeps['domain'],
      sheet: {
        load: jest.fn().mockResolvedValue({
          subclassOptions: [
            {
              optionKey: 'bloodStrike1',
              valueId: overrides?.optionValueId ?? 'hunting-strike',
            },
          ],
        }),
      },
      mechanicalCatalog: {
        load: jest.fn().mockResolvedValue({
          economyActions: [
            {
              classSlug: 'fighter',
              subclassSlug: 'blood-hound',
              tableAction: 'blood-strike',
              itemSlug: null,
              featSlug: null,
              name: 'Golpe de Sangue',
            },
          ],
        }),
      },
    } as unknown as FighterActionDeps;
  }

  it('spends resource, applies necrotic cost and L15 heal', async () => {
    const deps = makeDeps();
    const rngSpy = jest.spyOn(Math, 'random').mockReturnValue(0); // roll 1

    const result = await useBloodStrikeAction(deps, 'user', 'char-1', {
      optionSlug: 'hunting-strike',
    });

    rngSpy.mockRestore();

    expect(deps.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'blood-strike',
      1,
    );
    // cost 1 (1d4 min) then +3 CON heal → 40 - 1 + 3 = 42
    expect(deps.state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.anything(),
      42,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Custo de Sangue');
    expect(result.note).toContain('Sinfonia de Sangue');
  });

  it('rejects unknown option', async () => {
    const deps = makeDeps();
    await expect(
      useBloodStrikeAction(deps, 'user', 'char-1', {
        optionSlug: 'not-a-strike',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects option the character does not know', async () => {
    const deps = makeDeps({ optionValueId: 'hunting-strike' });
    await expect(
      useBloodStrikeAction(deps, 'user', 'char-1', {
        optionSlug: 'exiling-strike',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
