import {
  FIXTURE_BATTLE_MASTER_MANEUVERS,
  FIXTURE_DUNGEONEER_PRECAUTION_SPELLS,
  FIXTURE_PSI_ACTIONS,
} from '@game/combat/domain/__fixtures__/mechanical-catalog.fixtures';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterStateResponseDto } from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { FighterActionsHandler } from './fighter-actions.handler';

describe('FighterActionsHandler tabletop actions', () => {
  const stateResponse = {} as CharacterStateResponseDto;
  const fighter = {
    id: 'fighter-id',
    classSlug: 'fighter',
    subclassSlug: 'battle-master',
    level: 15,
    backgroundSlug: 'soldier',
    abilityScores: {
      forca: 18,
      destreza: 14,
      constituicao: 14,
      inteligencia: 16,
      sabedoria: 10,
      carisma: 12,
    },
  } as PlayerCharacter;

  let access: jest.Mocked<
    Pick<PlayerCharacterAccessService, 'findAccessibleOrFail'>
  >;
  let state: jest.Mocked<
    Pick<CharacterStateRepository, 'buildResponse' | 'useClassResource'>
  >;
  let domain: jest.Mocked<
    Pick<CharacterDomainService, 'getProficiencyBonus'>
  >;
  let sheet: jest.Mocked<Pick<CharacterSheetRepository, 'load'>>;
  let handler: FighterActionsHandler;

  const mechanicalCatalog = {
    load: async () => ({
      gunslingerManeuvers: [],
      battleMasterManeuvers: [...FIXTURE_BATTLE_MASTER_MANEUVERS],
      cunningStrikeEffects: [],
      tableActions: [...FIXTURE_PSI_ACTIONS],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [],
      dungeoneerSlayerLabels: [],
      precautionSpells: [...FIXTURE_DUNGEONEER_PRECAUTION_SPELLS],
      economyActions: [],
      panelActions: [],
    }),
  };

  beforeEach(() => {
    access = {
      findAccessibleOrFail: jest.fn().mockResolvedValue(fighter),
    };
    state = {
      buildResponse: jest.fn().mockResolvedValue(stateResponse),
      useClassResource: jest.fn().mockResolvedValue({
        state: stateResponse,
        roll: null,
      }),
    };
    domain = {
      getProficiencyBonus: jest.fn().mockResolvedValue(5),
    };
    sheet = {
      load: jest.fn().mockResolvedValue({
        subclassOptions: [
          { optionKey: 'maneuver1', valueId: 'trip-attack' },
        ],
      }),
    };
    handler = new FighterActionsHandler(
      access as unknown as PlayerCharacterAccessService,
      state as unknown as CharacterStateRepository,
      domain as unknown as CharacterDomainService,
      sheet as unknown as CharacterSheetRepository,
      mechanicalCatalog as never,
    );
  });

  it('spends one Superiority Die for a selected maneuver', async () => {
    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'trip-attack',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      fighter,
      'superiority-dice',
      1,
    );
    expect(result.actionName).toBe('Ataque Derrubador');
    expect(result.saveDc).toBe(17);
    expect(result.resourceSpent).toBe(true);
  });

  it('uses Relentless without spending Superiority', async () => {
    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'use-maneuver',
      maneuverSlug: 'trip-attack',
      useRelentless: true,
    });

    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(result.resourceSpent).toBe(false);
    expect(result.expression).toBe('1d8');
  });

  it('spends Psi Energy for Protective Field', async () => {
    const psiWarrior = { ...fighter, subclassSlug: 'psi-warrior', level: 7 };
    access.findAccessibleOrFail.mockResolvedValue(psiWarrior);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'psi:protective-field',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      psiWarrior,
      'psi-energy-dice',
      1,
    );
    expect(result.actionName).toBe('Campo Protetor');
  });

  it('spends one Dungeon Precaution for an allowed spell', async () => {
    const dungeoneer = { ...fighter, subclassSlug: 'dungeoneer', level: 7 };
    access.findAccessibleOrFail.mockResolvedValue(dungeoneer);

    const result = await handler.useTableAction('user', fighter.id, {
      actionSlug: 'dungeon-precaution',
      spellSlug: 'detectar-magia',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      dungeoneer,
      'dungeon-precautions',
      1,
    );
    expect(result.note).toContain('Detectar Magia');
  });
});
