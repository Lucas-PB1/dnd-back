import {
  formatStrikeSelfCostNote,
  spendStrikeSelfCost,
} from './spend-strike-self-cost';
import { BLOOD_HOUND_STRIKE_OPTIONS } from '@game/combat/domain/__fixtures__/mechanical-catalog/strike-options.fixtures';
import { findStrikeOption } from '@game/combat/domain/strike-option';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

function baseCharacter(
  overrides: Partial<PlayerCharacter> = {},
): PlayerCharacter {
  return {
    id: 'c1',
    level: 5,
    hitPointsCurrent: 40,
    hitPointsMax: 40,
    abilityScores: {
      forca: 10,
      destreza: 10,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 10,
    },
    ...overrides,
  } as PlayerCharacter;
}

describe('spendStrikeSelfCost', () => {
  const hunting = findStrikeOption(
    BLOOD_HOUND_STRIKE_OPTIONS,
    'hunting-strike',
  )!;

  it('spends resource, applies necrotic cost, returns duel note shape', async () => {
    const character = baseCharacter();
    const useClassResource = jest.fn().mockResolvedValue(undefined);
    const applyCurrentHitPoints = jest.fn().mockResolvedValue(undefined);

    const result = await spendStrikeSelfCost({
      character,
      option: hunting,
      ports: { useClassResource, applyCurrentHitPoints },
      rng: () => 0,
    });

    expect(useClassResource).toHaveBeenCalledWith('blood-strike', 1);
    expect(result.costTotal).toBe(1);
    expect(result.heal).toBe(0);
    expect(result.hitPointsAfter).toBe(39);
    expect(applyCurrentHitPoints).toHaveBeenCalledWith(39);
    expect(formatStrikeSelfCostNote(result, 'duel')).toContain('Golpe da Caça');
  });

  it('heals on L15 symphony', async () => {
    const character = baseCharacter({ level: 15, hitPointsCurrent: 20 });
    const applyCurrentHitPoints = jest.fn().mockResolvedValue(undefined);

    const result = await spendStrikeSelfCost({
      character,
      option: hunting,
      ports: {
        useClassResource: async () => undefined,
        applyCurrentHitPoints,
      },
      rng: () => 0,
    });

    expect(result.heal).toBe(2);
    expect(result.hitPointsAfter).toBe(21);
    expect(formatStrikeSelfCostNote(result, 'table')).toContain(
      'Sinfonia de Sangue',
    );
  });

  it('rejects takeLower before L10', async () => {
    await expect(
      spendStrikeSelfCost({
        character: baseCharacter({ level: 9 }),
        option: hunting,
        takeLowerCost: true,
        ports: {
          useClassResource: async () => undefined,
          applyCurrentHitPoints: async () => undefined,
        },
      }),
    ).rejects.toThrow(/nível 10/);
  });
});
