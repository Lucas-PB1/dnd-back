jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn(),
}));

jest.mock('./stroke-of-luck', () => ({
  applyStrokeOfLuckIfRequested: jest.fn(async ({ result }) => result),
}));

jest.mock('@game/sheet/infrastructure/load-class-ability-boosts', () => ({
  resolveEffectiveAbilityScores: jest.fn(
    async (_ds, _classSlug, _level, scores) => scores,
  ),
}));

import { executeRollInitiative } from './roll-initiative';
import { loadAccessibleCharacter } from './roll-weapon-context';
import {
  asRollDep,
  mockResourceSpender,
} from './roll-damage.spec.helpers';

describe('executeRollInitiative', () => {
  const sheetLoad = jest.fn().mockResolvedValue({
    characterFeats: [{ featSlug: 'alert' }],
    heritageChoices: [],
    speciesChoices: [],
  });
  const base = {
    access: asRollDep({}),
    sheet: asRollDep({ load: sheetLoad }),
    domain: asRollDep({
      getProficiencyBonus: jest.fn().mockResolvedValue(2),
    }),
    dataSource: asRollDep({}),
    effectCatalog: asRollDep({
      load: jest.fn().mockResolvedValue([
        {
          id: '1',
          kind: 'initiative_pb',
          ownerKind: 'feat',
          ownerId: '1',
          ownerSlug: 'alert',
          trigger: 'passive',
          unlockLevel: 1,
          sortOrder: 0,
          minTraitTakes: 1,
          actionSlug: null,
          resourceSlug: null,
          label: null,
          spell: null,
          castEconomy: null,
          numeric: null,
          note: null,
          resource: null,
          combatMod: null,
          proficiency: null,
          purchaseDiscount: null,
          damageDie: null,
        },
      ]),
    }),
    resourceSpender: mockResourceSpender(),
    userId: 'u1',
    characterId: 'c1',
    dto: {},
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('includes alert PB and champion advantage', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValue({
      id: 'c1',
      classSlug: 'fighter',
      subclassSlug: 'champion',
      level: 5,
      abilityScores: {
        forca: 10,
        destreza: 14,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    });
    const result = await executeRollInitiative(base);
    expect(result.kind).toBe('initiative');
    expect(result.modifier).toBe(4);
    expect(result.mode).toBe('advantage');
    expect(result.note).toContain('Alerta');
    expect(result.note).toContain('Atleta Extraordinário');
  });

  it('adds gloom stalker wisdom bonus', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValue({
      id: 'c1',
      classSlug: 'ranger',
      subclassSlug: 'gloom-stalker',
      level: 5,
      abilityScores: {
        forca: 10,
        destreza: 14,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 14,
        carisma: 10,
      },
    });
    const result = await executeRollInitiative({
      ...base,
      sheet: asRollDep({
        load: jest.fn().mockResolvedValue({
          characterFeats: [],
          heritageChoices: [],
          speciesChoices: [],
        }),
      }),
    });
    expect(result.modifier).toBe(4);
    expect(result.note).toContain('Emboscador das Sombras');
  });
});
