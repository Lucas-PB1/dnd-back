import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../entities/views/v-subclass-spell-slots.entity';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../sheet/application/character-spell-lookup';
import { PhbCondition } from './phb-condition.entity';
import { PlayerCharacterState } from './player-character-state.entity';
import { CharacterStateRepository } from './character-state.repository';

describe('CharacterStateRepository', () => {
  let repository: CharacterStateRepository;
  let stateRepo: {
    findOne: jest.Mock;
    create: jest.Mock;
    save: jest.Mock;
  };

  beforeEach(() => {
    stateRepo = {
      findOne: jest.fn(),
      create: jest.fn((row) => row),
      save: jest.fn(async (row) => row),
    };

    repository = new CharacterStateRepository(
      stateRepo as unknown as Repository<PlayerCharacterState>,
      {} as Repository<VClassSpellSlots>,
      {} as Repository<VSubclassSpellSlots>,
      {} as Repository<PhbCondition>,
      {} as CatalogLookupService,
      {} as CharacterRepository,
      {} as CharacterSpellLookup,
      {} as never,
      {} as never,
      {
        load: async () => ({
          gunslingerManeuvers: [],
          battleMasterManeuvers: [],
          cunningStrikeEffects: [],
          tableActions: [],
          personaMaskSlugs: [],
          beastborneAspectBenefits: [],
          dungeoneerSlayerLabels: [],
          precautionSpells: [],
        }),
      } as never,
      {} as DataSource,
    );
  });

  describe('findOrCreate', () => {
    it('returns existing state row', async () => {
      const existing = {
        characterId: 'char-1',
        spellSlotsUsed: {},
        resourcesUsed: { rage: 1 },
        grantedSpellUses: {},
        highElfCantripSwapAvailable: false,
        conditions: [],
        tempHp: 0,
        concentratingOn: null,
        hitDiceCurrent: 3,
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        inspiration: false,
        firearmChambers: {},
        rageActive: false,
        recklessActive: false,
        personaMasks: [],
        bestialAspectLevel: 0,
      } as PlayerCharacterState;
      stateRepo.findOne.mockResolvedValue(existing);

      await expect(repository.findOrCreate('char-1', 3)).resolves.toBe(existing);
      expect(stateRepo.create).not.toHaveBeenCalled();
      expect(stateRepo.save).not.toHaveBeenCalled();
    });

    it('creates default state when missing', async () => {
      stateRepo.findOne.mockResolvedValue(null);

      const row = await repository.findOrCreate('char-1', 5);

      expect(stateRepo.create).toHaveBeenCalledWith(
        expect.objectContaining({
          characterId: 'char-1',
          hitDiceCurrent: 5,
          resourcesUsed: {},
          conditions: [],
        }),
      );
      expect(stateRepo.save).toHaveBeenCalledWith(row);
      expect(row.resourcesUsed).toEqual({});
    });

    it('normalizes missing resourcesUsed on existing row', async () => {
      const existing = {
        characterId: 'char-1',
        spellSlotsUsed: {},
        resourcesUsed: undefined,
        conditions: [],
        tempHp: 0,
        concentratingOn: null,
        hitDiceCurrent: 1,
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        inspiration: false,
      } as unknown as PlayerCharacterState;
      stateRepo.findOne.mockResolvedValue(existing);

      const row = await repository.findOrCreate('char-1');

      expect(row.resourcesUsed).toEqual({});
    });
  });

  describe('syncHitDiceOnLevelChange', () => {
    it('grants hit dice on level up and saves', async () => {
      const existing = {
        characterId: 'char-1',
        spellSlotsUsed: {},
        resourcesUsed: {},
        grantedSpellUses: {},
        highElfCantripSwapAvailable: false,
        conditions: [],
        tempHp: 0,
        concentratingOn: null,
        hitDiceCurrent: 4,
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        inspiration: false,
        firearmChambers: {},
        rageActive: false,
        recklessActive: false,
        personaMasks: [],
        bestialAspectLevel: 0,
      } as PlayerCharacterState;
      stateRepo.findOne.mockResolvedValue(existing);

      await repository.syncHitDiceOnLevelChange('char-1', 4, 6);

      expect(existing.hitDiceCurrent).toBe(6);
      expect(stateRepo.save).toHaveBeenCalledWith(existing);
    });
  });
});
