jest.mock('../resources/class-resources', () => ({
  buildClassResourceState: jest.fn().mockResolvedValue([]),
}));
jest.mock('../resources/hit-dice', () => ({
  clampHitDiceToLevel: jest.fn().mockResolvedValue(undefined),
}));
jest.mock('../resources/spell-slots', () => ({
  loadMaxSlots: jest.fn().mockResolvedValue({ 1: 2 }),
  computeRemaining: jest.fn().mockReturnValue({ 1: 2 }),
}));
jest.mock('@game/combat/application/load-eldritch-invocation-effect-catalog', () => ({
  loadEldritchInvocationEffectCatalog: jest.fn().mockResolvedValue([
    {
      slug: 'mask-of-many-faces',
      name: 'Máscara de Muitas Faces',
      minLevel: 1,
      requiresPactSlug: null,
      requiresInvocationSlug: null,
      repeatable: false,
      kind: 'free_cast',
      grantedSpellSlug: 'disguise-self',
    },
  ]),
}));

import { DEFAULT_ABILITY_SCORES } from '@game/shared/infrastructure/player-character.entity';
import { buildCharacterStateResponse } from './build-response';

describe('buildCharacterStateResponse — granted spell sheet loads', () => {
  const baseState = {
    spellSlotsUsed: {},
    concentratingOn: null,
    conditions: [],
    tempHp: 0,
    hitDiceCurrent: 3,
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    inspiration: false,
    grantedSpellUses: {},
    highElfCantripSwapAvailable: false,
    firearmChambers: {},
    rageActive: false,
    recklessActive: false,
    personaMasks: [],
    bestialAspectLevel: 0,
    missileShieldArmed: false,
    gigaMissileArmed: false,
  };

  function makeDeps(classSlug: string) {
    const character = {
      id: 'ch1',
      classSlug,
      subclassSlug: null,
      speciesSlug: 'human',
      backgroundSlug: 'hermit',
      level: 5,
      hitPointsCurrent: 30,
      hitPointsMax: 30,
      abilityScores: DEFAULT_ABILITY_SCORES,
    };

    const sheetRepository = {
      loadGrantedSpellSlice: jest.fn().mockResolvedValue({
        speciesChoices: [],
        characterFeats: [],
        featOptions: [],
        characterSpells: [{ spellSlug: 'disguise-self', listType: 'known' }],
        classOptions: [
          {
            optionKey: 'eldritch-invocation',
            valueId: 'mask-of-many-faces',
            instanceIndex: 0,
          },
        ],
      }),
      load: jest.fn().mockResolvedValue({
        classOptions: [],
        characterSpells: [],
      }),
    };

    const grantedSpellCatalog = {
      loadMergeCatalog: jest.fn().mockResolvedValue({
        speciesCatalog: [],
        featFixedSpells: [],
      }),
    };

    const catalogLookup = {
      findClassOrFail: jest.fn().mockResolvedValue({ hitDie: '1d8' }),
    };

    return {
      character: character as never,
      state: { ...baseState, characterId: 'ch1' } as never,
      stateRepo: { save: jest.fn(), update: jest.fn() } as never,
      classSlots: { find: jest.fn() } as never,
      subclassSlots: { find: jest.fn() } as never,
      catalogLookup: catalogLookup as never,
      dataSource: { query: jest.fn() } as never,
      sheetRepository: sheetRepository as never,
      grantedSpellCatalog: grantedSpellCatalog as never,
      spies: { sheetRepository },
    };
  }

  it('warlock: uses granted slice classOptions and never calls full sheet load', async () => {
    const deps = makeDeps('warlock');
    const result = await buildCharacterStateResponse(deps);

    expect(deps.spies.sheetRepository.loadGrantedSpellSlice).toHaveBeenCalledTimes(
      1,
    );
    expect(deps.spies.sheetRepository.load).not.toHaveBeenCalled();
    expect(
      result.grantedSpellCastOptions.some((o) => o.spellSlug === 'disguise-self'),
    ).toBe(true);
  });

  it('non-warlock: also skips full sheet load', async () => {
    const deps = makeDeps('fighter');
    await buildCharacterStateResponse(deps);
    expect(deps.spies.sheetRepository.loadGrantedSpellSlice).toHaveBeenCalledTimes(
      1,
    );
    expect(deps.spies.sheetRepository.load).not.toHaveBeenCalled();
  });
});
