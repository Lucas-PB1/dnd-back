import { BadRequestException } from '@nestjs/common';
import { LevelUpHandler } from './level-up.handler';
import { LevelUpPreviewQuery } from './level-up-preview.query';
import type { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import type { UpdateCharacterHandler } from '@game/sheet/application/update-character.handler';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { LevelUpService } from '../domain/level-up.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

const fighterProgression = [
  { level: 1, weaponMastery: 3 },
  { level: 4, weaponMastery: 4 },
];

function character(overrides: Partial<PlayerCharacter> = {}): PlayerCharacter {
  return {
    id: 'ch1',
    userId: 'u1',
    name: 'Aragorn',
    level: 3,
    classSlug: 'fighter',
    speciesSlug: 'human',
    backgroundSlug: 'soldier',
    subclassSlug: 'champion',
    alignmentSlug: null,
    abilityScores: {
      forca: 16,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 8,
    },
    hitPointsMax: 28,
    hitPointsCurrent: 28,
    abilityGenerationMethodSlug: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  } as PlayerCharacter;
}

describe('LevelUpPreviewQuery', () => {
  let repository: jest.Mocked<Pick<CharacterRepository, 'findAccessibleOrFail'>>;
  let levelUp: jest.Mocked<Pick<LevelUpService, 'buildPreview'>>;
  let query: LevelUpPreviewQuery;

  beforeEach(() => {
    repository = { findAccessibleOrFail: jest.fn() };
    levelUp = { buildPreview: jest.fn() };
    query = new LevelUpPreviewQuery(repository as never, levelUp as never);
  });

  it('loads character and delegates preview to LevelUpService', async () => {
    const pc = character();
    repository.findAccessibleOrFail.mockResolvedValue(pc);
    levelUp.buildPreview.mockResolvedValue({ currentLevel: 3, nextLevel: 4 } as never);

    await expect(query.execute('u1', 'ch1')).resolves.toMatchObject({
      currentLevel: 3,
      nextLevel: 4,
    });
    expect(repository.findAccessibleOrFail).toHaveBeenCalledWith('u1', 'ch1', 'read');
    expect(levelUp.buildPreview).toHaveBeenCalledWith(pc);
  });
});

describe('LevelUpHandler', () => {
  let repository: jest.Mocked<Pick<CharacterRepository, 'findAccessibleOrFail'>>;
  let updateCharacter: jest.Mocked<Pick<UpdateCharacterHandler, 'execute'>>;
  let characterState: jest.Mocked<Pick<CharacterStateRepository, 'syncHitDiceOnLevelChange'>>;
  let sheetRepository: jest.Mocked<Pick<CharacterSheetRepository, 'load'>>;
  let dataSource: { query: jest.Mock };
  let handler: LevelUpHandler;

  beforeEach(() => {
    repository = { findAccessibleOrFail: jest.fn() };
    updateCharacter = { execute: jest.fn() };
    characterState = { syncHitDiceOnLevelChange: jest.fn() };
    sheetRepository = { load: jest.fn() };
    dataSource = { query: jest.fn().mockResolvedValue(fighterProgression) };
    handler = new LevelUpHandler(
      repository as never,
      updateCharacter as never,
      characterState as never,
      sheetRepository as never,
      dataSource as never,
    );
  });

  it('apply level-up patches character and syncs hit dice', async () => {
    const pc = character();
    repository.findAccessibleOrFail.mockResolvedValue(pc);
    updateCharacter.execute.mockResolvedValue({ id: 'ch1', level: 4 } as never);

    const result = await handler.execute('u1', 'ch1', {
      classOptions: [{ optionKey: 'masteryWeapon4', valueId: 'longsword' }],
    });

    expect(updateCharacter.execute).toHaveBeenCalledWith('u1', 'ch1', {
      level: 4,
      subclassSlug: undefined,
      classSkillSlugs: undefined,
      speciesChoices: undefined,
      subclassOptions: undefined,
      classOptions: [{ optionKey: 'masteryWeapon4', valueId: 'longsword' }],
      characterFeats: undefined,
      featOptions: undefined,
      characterSpells: undefined,
      equipment: undefined,
      languageSlugs: undefined,
      abilityGenerationMethodSlug: undefined,
    });
    expect(characterState.syncHitDiceOnLevelChange).toHaveBeenCalledWith('ch1', 3, 4);
    expect(result).toMatchObject({ id: 'ch1', level: 4 });
  });

  it('rejects max level, missing mastery and ASI on wrong level', async () => {
    repository.findAccessibleOrFail.mockResolvedValue(character({ level: 20 }));
    await expect(handler.execute('u1', 'ch1', {})).rejects.toThrow(
      new BadRequestException('Character is already at maximum level'),
    );

    repository.findAccessibleOrFail.mockResolvedValue(character());
    sheetRepository.load.mockResolvedValue({ classOptions: [] } as never);
    await expect(handler.execute('u1', 'ch1', {})).rejects.toThrow(
      /unlocks weapon mastery choices: masteryWeapon4/,
    );

    repository.findAccessibleOrFail.mockResolvedValue(character({ classSlug: 'wizard', level: 2 }));
    await expect(
      handler.execute('u1', 'ch1', {
        asiDistributionMode: 'plus2',
        asiPrimaryAbilitySlug: 'inteligencia',
      }),
    ).rejects.toThrow(/Level 3 is not an ASI\/feat level/);
  });
});
