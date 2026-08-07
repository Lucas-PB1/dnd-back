import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { PhbCondition } from '../phb-condition.entity';
import { PlayerCharacterState } from '../player-character-state.entity';
import { applyPatchState, applyUseClassResource } from './mutations';
import { resolveClassResources } from './resources/class-resources';

jest.mock('./resources/class-resources', () => ({
  resolveClassResources: jest.fn(),
}));

const mockResolveClassResources = resolveClassResources as jest.MockedFunction<
  typeof resolveClassResources
>;

describe('mutations', () => {
  const character = { id: 'char1', classSlug: 'barbarian', level: 5 } as PlayerCharacter;
  const state = {
    characterId: 'char1',
    spellSlotsUsed: {},
    conditions: [],
    tempHp: 0,
    concentratingOn: null,
    hitDiceCurrent: 5,
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    inspiration: false,
    resourcesUsed: {},
    grantedSpellUses: {},
    highElfCantripSwapAvailable: false,
    firearmChambers: {},
    rageActive: false,
    recklessActive: false,
    personaMasks: [],
    bestialAspectLevel: 0,
    missileShieldArmed: false,
    gigaMissileArmed: false,
  } as PlayerCharacterState;

  const buildResponse = jest.fn().mockResolvedValue({ id: 'char1' });
  const stateRepo = {
    save: jest.fn().mockResolvedValue(state),
  } as unknown as Repository<PlayerCharacterState>;
  const conditions = {
    find: jest.fn().mockResolvedValue([{ slug: 'poisoned' }]),
  } as unknown as Repository<PhbCondition>;
  const catalogLookup = {
    assertSpellInCatalog: jest.fn(),
  } as unknown as CatalogLookupService;
  const dataSource = {} as DataSource;

  beforeEach(() => {
    jest.clearAllMocks();
    buildResponse.mockResolvedValue({ id: 'char1' });
    stateRepo.save = jest.fn().mockResolvedValue(state);
  });

  describe('applyPatchState', () => {
    it('updates conditions, temp hp and inspiration', async () => {
      await applyPatchState({
        character,
        state,
        dto: { conditions: ['poisoned'], tempHp: 5, inspiration: true },
        stateRepo,
        conditions,
        catalogLookup,
        buildResponse,
      });

      expect(state.conditions).toEqual(['poisoned']);
      expect(state.tempHp).toBe(5);
      expect(state.inspiration).toBe(true);
      expect(stateRepo.save).toHaveBeenCalledWith(state);
      expect(buildResponse).toHaveBeenCalledWith(character, state);
    });

    it('rejects unknown conditions', async () => {
      await expect(
        applyPatchState({
          character,
          state,
          dto: { conditions: ['fake'] },
          stateRepo,
          conditions,
          catalogLookup,
          buildResponse,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });

    it('sets concentration when spell is valid', async () => {
      catalogLookup.assertSpellInCatalog = jest
        .fn()
        .mockResolvedValue({ concentration: true });
      await applyPatchState({
        character,
        state,
        dto: { concentratingOn: 'bless' },
        stateRepo,
        conditions,
        catalogLookup,
        buildResponse,
      });
      expect(state.concentratingOn).toBe('bless');
    });

    it('rejects non-concentration spell', async () => {
      catalogLookup.assertSpellInCatalog = jest
        .fn()
        .mockResolvedValue({ concentration: false });
      await expect(
        applyPatchState({
          character,
          state,
          dto: { concentratingOn: 'fireball' },
          stateRepo,
          conditions,
          catalogLookup,
          buildResponse,
        }),
      ).rejects.toThrow(/not a concentration spell/);
    });
  });

  describe('applyUseClassResource', () => {
    it('spends resource and persists state', async () => {
      mockResolveClassResources.mockResolvedValue([
        {
          slug: 'rage',
          name: 'Rage',
          max: 3,
          recoverOneOnShort: false,
          recoverAllOnShort: false,
          recoverAllOnLong: true,
        },
      ]);
      await applyUseClassResource({
        character,
        state,
        resourceSlug: 'rage',
        amount: 1,
        stateRepo,
        dataSource,
        buildResponse,
      });
      expect(state.resourcesUsed).toEqual({ rage: 1 });
      expect(stateRepo.save).toHaveBeenCalledWith(state);
    });

    it('rejects unknown resource slug', async () => {
      mockResolveClassResources.mockResolvedValue([]);
      await expect(
        applyUseClassResource({
          character,
          state,
          resourceSlug: 'missing',
          amount: 1,
          stateRepo,
          dataSource,
          buildResponse,
        }),
      ).rejects.toThrow(/not available/);
    });

    it('wraps spend errors as BadRequest', async () => {
      mockResolveClassResources.mockResolvedValue([
        {
          slug: 'rage',
          name: 'Rage',
          max: 1,
          recoverOneOnShort: false,
          recoverAllOnShort: false,
          recoverAllOnLong: true,
        },
      ]);
      state.resourcesUsed = { rage: 1 };
      await expect(
        applyUseClassResource({
          character,
          state,
          resourceSlug: 'rage',
          amount: 1,
          stateRepo,
          dataSource,
          buildResponse,
        }),
      ).rejects.toBeInstanceOf(BadRequestException);
    });
  });
});
