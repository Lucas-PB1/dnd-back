import { applyCombatantHpDamage } from './apply-combatant-hp-damage';

describe('applyCombatantHpDamage — damage type (PVE-6c)', () => {
  const characterState = {
    buildResponse: jest.fn().mockResolvedValue({ tempHp: 0, concentratingOn: null }),
    patch: jest.fn().mockResolvedValue(undefined),
    applyCurrentHitPoints: jest.fn().mockResolvedValue(undefined),
  };
  const actorState = {
    ensureState: jest.fn().mockResolvedValue({ tempHp: 0, concentratingOn: null }),
    patch: jest.fn().mockResolvedValue(undefined),
  };
  const actors = {
    findOne: jest.fn(),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('halves fire damage against resistance on actor', async () => {
    actors.findOne.mockResolvedValue({
      id: 'a1',
      templateSlug: 'azer-sentinela',
      hitPointsCurrent: 40,
      abilityScores: {
        forca: 10,
        destreza: 10,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    });
    const result = await applyCombatantHpDamage({
      loadCharacter: async () => null,
      characterState: characterState as never,
      actorState: actorState as never,
      actors: actors as never,
      target: { kind: 'actor', actorId: 'a1' },
      damage: 10,
      damageTypeSlug: 'fire',
      defenses: {
        immunities: [],
        resistances: ['fire'],
        vulnerabilities: [],
      },
    });
    expect(result.damageApplied).toBe(5);
    expect(result.damageModifier).toBe('resistance');
    expect(actorState.patch).toHaveBeenCalledWith(
      expect.anything(),
      expect.objectContaining({ hitPointsCurrent: 35 }),
      actors,
    );
  });

  it('zeros fire damage against immunity', async () => {
    actors.findOne.mockResolvedValue({
      id: 'a1',
      templateSlug: 'elemental-do-fogo',
      hitPointsCurrent: 40,
      abilityScores: {
        forca: 10,
        destreza: 10,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    });
    const result = await applyCombatantHpDamage({
      loadCharacter: async () => null,
      characterState: characterState as never,
      actorState: actorState as never,
      actors: actors as never,
      target: { kind: 'actor', actorId: 'a1' },
      damage: 22,
      damageTypeSlug: 'fire',
      defenses: {
        immunities: ['fire'],
        resistances: [],
        vulnerabilities: [],
      },
    });
    expect(result.damageApplied).toBe(0);
    expect(result.damageModifier).toBe('immunity');
    expect(actorState.patch).not.toHaveBeenCalled();
  });
});
