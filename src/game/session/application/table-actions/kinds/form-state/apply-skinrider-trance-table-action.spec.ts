import { BadRequestException } from '@nestjs/common';
import { applySkinriderTranceTableAction } from './apply-skinrider-trance-table-action';

function makeCharacter(overrides: Record<string, unknown> = {}) {
  return {
    id: 'barb-1',
    classSlug: 'barbarian',
    subclassSlug: 'pathofthe-primal-spirit',
    level: 10,
    abilityScores: { constituicao: 16 },
    ...overrides,
  } as never;
}

describe('applySkinriderTranceTableAction', () => {
  const setSkinriderTrance = jest.fn();
  const useClassResource = jest.fn();
  const buildResponse = jest.fn();

  const state = {
    setSkinriderTrance,
    useClassResource,
    buildResponse,
  } as never;

  beforeEach(() => {
    jest.clearAllMocks();
    setSkinriderTrance.mockImplementation(async (_c, input) => ({
      skinriderTranceActive: input.active,
      skinriderActorId: input.actorId ?? null,
      companions: [],
    }));
    useClassResource.mockResolvedValue({ state: {} });
  });

  it('enters trance linking the living companion actor', async () => {
    buildResponse.mockResolvedValue({
      skinriderTranceActive: false,
      companions: [
        {
          actorId: 'actor-wolf',
          name: 'Guardião',
          defeated: false,
        },
      ],
    });

    const result = await applySkinriderTranceTableAction({
      state,
      character: makeCharacter(),
      actionSlug: 'skinrider-s-trance',
    });

    expect(useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'skinrider-trance',
      1,
    );
    expect(setSkinriderTrance).toHaveBeenCalledWith(expect.anything(), {
      active: true,
      actorId: 'actor-wolf',
    });
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('actor-wolf');
  });

  it('rejects enter without a living companion', async () => {
    buildResponse.mockResolvedValue({
      skinriderTranceActive: false,
      companions: [{ actorId: 'x', name: 'Morto', defeated: true }],
    });

    await expect(
      applySkinriderTranceTableAction({
        state,
        character: makeCharacter(),
        actionSlug: 'skinrider-s-trance',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('ends an active trance', async () => {
    buildResponse.mockResolvedValue({
      skinriderTranceActive: true,
      skinriderActorId: 'actor-wolf',
      companions: [],
    });

    const result = await applySkinriderTranceTableAction({
      state,
      character: makeCharacter(),
      actionSlug: 'skinrider-s-trance-end',
    });

    expect(setSkinriderTrance).toHaveBeenCalledWith(expect.anything(), {
      active: false,
      actorId: null,
    });
    expect(result.resourceSpent).toBe(false);
  });
});
