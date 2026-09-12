import { BadRequestException } from '@nestjs/common';
import { BLOOD_HOUND_STRIKE_OPTIONS } from '@game/combat/domain/__fixtures__/mechanical-catalog/strike-options.fixtures';
import { applyStrikeSelfCostTableAction } from './apply-strike-self-cost-table-action';
import { asDep } from '@common/testing/as-dep';

describe('applyStrikeSelfCostTableAction', () => {
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

  function makeDeps(overrides?: { optionValueId?: string; level?: number }) {
    const level = overrides?.level ?? character.level;
    const pc = { ...character, level };
    return {
      character: pc,
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
          strikeOptions: BLOOD_HOUND_STRIKE_OPTIONS,
          featureGatesBySubclassSlug: new Map([
            [
              'blood-hound',
              new Map([
                ['blood-armament', 7],
                ['blood-explosion', 7],
                ['blood-lower-cost', 10],
                ['blood-symphony', 15],
              ]),
            ],
          ]),
          featureGatesByClassSlug: new Map(),
        }),
      },
    };
  }

  it('spends resource, applies necrotic cost and L15 heal', async () => {
    const deps = makeDeps();
    const rngSpy = jest.spyOn(Math, 'random').mockReturnValue(0);

    const result = await applyStrikeSelfCostTableAction({
      state: asDep(deps.state),
      sheet: asDep(deps.sheet),
      mechanicalCatalog: asDep(deps.mechanicalCatalog),
      character: asDep(deps.character),
      optionSlug: 'hunting-strike',
    });

    rngSpy.mockRestore();

    expect(deps.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'blood-strike',
      1,
    );
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
      applyStrikeSelfCostTableAction({
        state: asDep(deps.state),
        sheet: asDep(deps.sheet),
        mechanicalCatalog: asDep(deps.mechanicalCatalog),
        character: asDep(deps.character),
        optionSlug: 'not-a-strike',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects option the character does not know', async () => {
    const deps = makeDeps({ optionValueId: 'hunting-strike' });
    await expect(
      applyStrikeSelfCostTableAction({
        state: asDep(deps.state),
        sheet: asDep(deps.sheet),
        mechanicalCatalog: asDep(deps.mechanicalCatalog),
        character: asDep(deps.character),
        optionSlug: 'exiling-strike',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
