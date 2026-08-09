import { DataSource, Repository } from 'typeorm';
import { EnrichEncounterPcs } from './enrich-encounter-pcs';
import * as featSlugsLoader from '@game/sheet/infrastructure/load-feat-slugs-by-character-ids';
import type { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';

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
    ...overrides,
  } as PlayerCharacter;
}

describe('EnrichEncounterPcs', () => {
  let enricher: EnrichEncounterPcs;
  let armorClass: jest.Mocked<Pick<ResolveEquippedArmorClass, 'resolve'>>;
  let states: jest.Mocked<Pick<Repository<PlayerCharacterState>, 'find'>>;
  let loadFeatSlugs: jest.SpyInstance;

  beforeEach(() => {
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
    loadFeatSlugs = jest
      .spyOn(featSlugsLoader, 'loadFeatSlugsByCharacterIds')
      .mockResolvedValue(
        new Map([['char1', ['alert', 'tough']]]),
      );
    enricher = new EnrichEncounterPcs(
      {} as DataSource,
      armorClass as unknown as ResolveEquippedArmorClass,
      states as unknown as Repository<PlayerCharacterState>,
    );
  });

  afterEach(() => {
    loadFeatSlugs.mockRestore();
  });

  it('returns empty map when no characters', async () => {
    const result = await enricher.enrich([]);
    expect(result.size).toBe(0);
    expect(loadFeatSlugs).not.toHaveBeenCalled();
  });

  it('enriches PCs with feat slugs, AC, HP and state', async () => {
    const pc = character();
    const result = await enricher.enrich([pc]);

    expect(loadFeatSlugs).toHaveBeenCalledWith({}, ['char1']);
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
    loadFeatSlugs.mockResolvedValue(new Map([['char1', []]]));

    const result = await enricher.enrich([character()]);
    expect(result.get('char1')).toMatchObject({
      conditions: [],
      inspiration: false,
      featSlugs: [],
    });
  });
});
