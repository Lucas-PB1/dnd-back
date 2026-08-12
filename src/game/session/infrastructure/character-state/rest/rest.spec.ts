import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { applyLongRestState, applyShortRestState } from './rest';
import { resolveClassResources } from '../resources/class-resources';
import { clampHitDiceToLevel } from '../resources/hit-dice';

jest.mock('../resources/class-resources', () => ({
  resolveClassResources: jest.fn(),
}));
jest.mock('../resources/hit-dice', () => ({
  clampHitDiceToLevel: jest.fn(),
}));

const mockResolveClassResources = resolveClassResources as jest.MockedFunction<
  typeof resolveClassResources
>;
const mockClampHitDice = clampHitDiceToLevel as jest.MockedFunction<
  typeof clampHitDiceToLevel
>;

describe('rest', () => {
  const character = {
    id: 'char1',
    classSlug: 'fighter',
    level: 5,
    abilityScores: {
      forca: 16,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 8,
    },
    hitPointsCurrent: 20,
    hitPointsMax: 44,
  } as PlayerCharacter;

  const state = {
    characterId: 'char1',
    spellSlotsUsed: { '1': 2 },
    resourcesUsed: { secondWind: 1 },
    grantedSpellUses: { 'fogo-das-fadas': 1 },
    highElfCantripSwapAvailable: false,
    concentratingOn: 'bless',
    conditions: ['poisoned'],
    tempHp: 5,
    hitDiceCurrent: 2,
    deathSaveSuccesses: 1,
    deathSaveFailures: 2,
    inspiration: true,
    firearmChambers: {},
    rageActive: false,
    recklessActive: false,
    personaMasks: [],
    bestialAspectLevel: 0,
    missileShieldArmed: false,
    gigaMissileArmed: false,
    starryFormActive: false,
    stellarConstellation: null,
  } as PlayerCharacterState;

  const buildResponse = jest.fn().mockResolvedValue({ id: 'char1' });
  const stateRepo = {
    save: jest.fn().mockResolvedValue(state),
  } as unknown as Repository<PlayerCharacterState>;
  const characters = {
    save: jest.fn().mockResolvedValue(character),
  } as unknown as CharacterRepository;
  const catalogLookup = {
    findClassOrFail: jest.fn().mockResolvedValue({ hitDie: 'd10' }),
  } as unknown as CatalogLookupService;
  const dataSource = {} as DataSource;

  beforeEach(() => {
    jest.clearAllMocks();
    mockResolveClassResources.mockResolvedValue([
      {
        slug: 'secondWind',
        name: 'Second Wind',
        max: 1,
        recoverAllOnLong: true,
        recoverOneOnShort: false,
        recoverAllOnShort: false,
        recoverOnLongDice: null,
      },
    ] as never);
    mockClampHitDice.mockResolvedValue(undefined);
    buildResponse.mockResolvedValue({ id: 'char1' });
  });

  describe('applyLongRestState', () => {
    it('resets state, restores HP and returns long rest dto', async () => {
      state.bestialAspectLevel = 3;
      state.personaMasks = ['persona-mask-angel'];

      const result = await applyLongRestState({
        character,
        state,
        stateRepo,
        characters,
        dataSource,
        buildResponse,
      });

      expect(state.spellSlotsUsed).toEqual({});
      expect(state.grantedSpellUses).toEqual({});
      expect(state.highElfCantripSwapAvailable).toBe(true);
      expect(state.concentratingOn).toBeNull();
      expect(state.conditions).toEqual([]);
      expect(state.tempHp).toBe(0);
      expect(state.bestialAspectLevel).toBe(0);
      expect(state.personaMasks).toEqual(['persona-mask-angel']);
      expect(state.deathSaveSuccesses).toBe(0);
      expect(state.deathSaveFailures).toBe(0);
      expect(character.hitPointsCurrent).toBe(44);
      expect(stateRepo.save).toHaveBeenCalledWith(state);
      expect(characters.save).toHaveBeenCalledWith(character);
      expect(result).toEqual({ type: 'long', state: { id: 'char1' } });
    });
  });

  describe('applyShortRestState', () => {
    it('recovers short-rest resources without spending hit dice', async () => {
      const result = await applyShortRestState({
        character,
        state,
        hitDiceSpent: 0,
        stateRepo,
        characters,
        catalogLookup,
        dataSource,
        buildResponse,
      });

      expect(mockClampHitDice).toHaveBeenCalledWith(stateRepo, state, 5);
      expect(result).toEqual({
        type: 'short',
        state: { id: 'char1' },
        hitDiceSpent: 0,
        hitDiceRolls: [],
        hitPointsHealed: 0,
      });
    });

    it('spends hit dice and heals when requested', async () => {
      state.hitDiceCurrent = 3;
      character.hitPointsCurrent = 20;

      const result = await applyShortRestState({
        character,
        state,
        hitDiceSpent: 1,
        stateRepo,
        characters,
        catalogLookup,
        dataSource,
        buildResponse,
      });

      expect(catalogLookup.findClassOrFail).toHaveBeenCalledWith('fighter');
      expect(state.hitDiceCurrent).toBe(2);
      expect(character.hitPointsCurrent).toBeGreaterThan(20);
      expect(result.type).toBe('short');
      expect(result.hitDiceSpent).toBe(1);
      expect(result.hitPointsHealed).toBeGreaterThan(0);
    });

    it('rejects hit dice spend when HP is unset', async () => {
      await expect(
        applyShortRestState({
          character: { ...character, hitPointsMax: null } as PlayerCharacter,
          state,
          hitDiceSpent: 1,
          stateRepo,
          characters,
          catalogLookup,
          dataSource,
          buildResponse,
        }),
      ).rejects.toThrow(/hit points are not set/);
    });

    it('wraps invalid hit dice spend as BadRequest', async () => {
      state.hitDiceCurrent = 0;
      await expect(
        applyShortRestState({
          character,
          state,
          hitDiceSpent: 2,
          stateRepo,
          characters,
          catalogLookup,
          dataSource,
          buildResponse,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });
  });
});
