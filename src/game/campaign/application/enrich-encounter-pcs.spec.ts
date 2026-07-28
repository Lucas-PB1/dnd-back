import { Repository } from 'typeorm';
import { EnrichEncounterPcs } from './enrich-encounter-pcs';
import type { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedArmorClass } from '../../combat/application/resolve-equipped-armor-class';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import type { PlayerCharacterState } from '../../session/infrastructure/player-character-state.entity';

function character(overrides: Partial<PlayerCharacter> = {}): PlayerCharacter {
  return {
    id: 'char1',
    userId: 'u1',
    name: 'Aria',
    level: 5,
    classSlug: 'fighter',
    subclassSlug: 'champion',
    speciesSlug: 'human',
    backgroundSlug: 'soldier',
    abilityScores: {
      forca: 16,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 8,
    },
    hitPointsCurrent: 38,
    hitPointsMax: 44,
  } as PlayerCharacter;
}

describe('EnrichEncounterPcs', () => {
  let enricher: EnrichEncounterPcs;
  let sheets: jest.Mocked<Pick<CharacterSheetRepository, 'loadMany'>>;
  let armorClass: jest.Mocked<Pick<ResolveEquippedArmorClass, 'resolve'>>;
  let states: jest.Mocked<Pick<Repository<PlayerCharacterState>, 'find'>>;

  beforeEach(() => {
    sheets = {
      loadMany: jest.fn().mockResolvedValue(
        new Map([
          [
            'char1',
            {
              characterFeats: [{ featSlug: 'alert' }, { featSlug: 'tough' }],
            },
          ],
        ]),
      ),
    };
    armorClass = {
      resolve: jest.fn().mockResolvedValue({ armorClass: 18 }),
    };
    states = {
      find: jest.fn().mockResolvedValue([
        {
          characterId: 'char1',
          conditions: ['poisoned'],
          inspiration: true,
        } as PlayerCharacterState,
      ]),
    };
    enricher = new EnrichEncounterPcs(
      sheets as unknown as CharacterSheetRepository,
      armorClass as unknown as ResolveEquippedArmorClass,
      states as unknown as Repository<PlayerCharacterState>,
    );
  });

  it('returns empty map when no characters', async () => {
    const result = await enricher.enrich([]);
    expect(result.size).toBe(0);
    expect(sheets.loadMany).not.toHaveBeenCalled();
  });

  it('enriches PCs with sheet feats, AC, HP and state', async () => {
    const pc = character();
    const result = await enricher.enrich([pc]);

    expect(sheets.loadMany).toHaveBeenCalledWith(
      ['char1'],
      new Map([['char1', 'soldier']]),
    );
    expect(states.find).toHaveBeenCalled();
    expect(armorClass.resolve).toHaveBeenCalledWith(
      'char1',
      pc.abilityScores,
      {
        classSlug: 'fighter',
        subclassSlug: 'champion',
        featSlugs: ['alert', 'tough'],
      },
    );
    expect(result.get('char1')).toEqual({
      level: 5,
      armorClass: 18,
      hpCurrent: 38,
      hpMax: 44,
      featSlugs: ['alert', 'tough'],
      conditions: ['poisoned'],
      inspiration: true,
    });
  });

  it('defaults conditions and inspiration when state row is missing', async () => {
    states.find.mockResolvedValue([]);
    sheets.loadMany.mockResolvedValue(
      new Map([['char1', { characterFeats: [] }]]) as never,
    );

    const result = await enricher.enrich([character()]);
    expect(result.get('char1')).toMatchObject({
      conditions: [],
      inspiration: false,
      featSlugs: [],
    });
  });
});
