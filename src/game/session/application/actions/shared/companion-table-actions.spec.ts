import { BadRequestException } from '@nestjs/common';
import { applyCompanionCommand } from './companion-table-actions';
import { loadCompanionTrackers } from '@game/companion/infrastructure/companion-tracker.queries';
import { loadCharacterSheet } from '@game/sheet/infrastructure/character-sheet/load-character-sheet';
import { loadCompanionProfileBySubclass } from '@game/companion/infrastructure/companion-profile.queries';
import { loadCompanionCommands } from '@game/companion/infrastructure/companion-command.queries';

jest.mock('@game/companion/infrastructure/companion-tracker.queries', () => ({
  loadCompanionTrackers: jest.fn(),
}));
jest.mock('@game/sheet/infrastructure/character-sheet/load-character-sheet', () => ({
  loadCharacterSheet: jest.fn().mockResolvedValue({ subclassOptions: {} }),
}));
jest.mock('@game/companion/infrastructure/companion-profile.queries', () => ({
  loadCompanionProfileBySubclass: jest.fn().mockResolvedValue(null),
  loadCompanionTemplateMaps: jest.fn().mockResolvedValue([]),
}));
jest.mock('@game/companion/infrastructure/companion-command.queries', () => ({
  loadCompanionCommands: jest.fn().mockResolvedValue(new Map()),
}));

const loadTrackers = loadCompanionTrackers as jest.MockedFunction<
  typeof loadCompanionTrackers
>;

describe('applyCompanionCommand', () => {
  const character = {
    id: 'pc-1',
    classSlug: 'ranger',
    subclassSlug: 'beast-master',
    level: 3,
    backgroundSlug: 'hermit',
  };
  const deps = {
    state: { buildResponse: jest.fn().mockResolvedValue({ companions: [] }) },
    dataSource: {},
    syncCompanion: { execute: jest.fn() },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    (loadCharacterSheet as jest.Mock).mockResolvedValue({ subclassOptions: {} });
    (loadCompanionProfileBySubclass as jest.Mock).mockResolvedValue(null);
    (loadCompanionCommands as jest.Mock).mockResolvedValue(new Map());
  });

  it('recusa comando sem companheiro invocado', async () => {
    loadTrackers.mockResolvedValue([]);
    await expect(
      applyCompanionCommand(
        deps as never,
        character as never,
        'beast-master',
        'beast-master',
        'Companheiro Primal',
        'help',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('recusa comando se a fera está derrotada', async () => {
    loadTrackers.mockResolvedValue([
      {
        actorId: 'c1',
        name: 'Fera',
        templateSlug: 'primal-companion-earth',
        hitPointsCurrent: 0,
        hitPointsMax: 20,
        armorClass: 13,
        defeated: true,
        conditions: [],
      },
    ]);
    await expect(
      applyCompanionCommand(
        deps as never,
        character as never,
        'beast-master',
        'beast-master',
        'Companheiro Primal',
        'help',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('declara comando na fera viva', async () => {
    loadTrackers.mockResolvedValue([
      {
        actorId: 'c1',
        name: 'Fera',
        templateSlug: 'primal-companion-earth',
        hitPointsCurrent: 12,
        hitPointsMax: 20,
        armorClass: 13,
        defeated: false,
        conditions: [],
      },
    ]);
    const result = await applyCompanionCommand(
      deps as never,
      character as never,
      'beast-master',
      'beast-master',
      'Companheiro Primal',
      'help',
    );
    expect(result.note).toMatch(/Companheiro/);
    expect(result.resourceSpent).toBe(false);
  });
});
