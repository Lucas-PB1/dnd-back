import { BadRequestException } from '@nestjs/common';
import { applyCastSpell } from './cast-spell';
import { resolveClassResources } from '../resources/class-resources';

jest.mock('../resources/class-resources', () => ({
  resolveClassResources: jest.fn(),
  loadActiveItemSlugs: jest.fn(),
}));

import { loadActiveItemSlugs } from '../resources/class-resources';

const resolveClassResourcesMock = resolveClassResources as jest.MockedFunction<
  typeof resolveClassResources
>;
const loadActiveItemSlugsMock = loadActiveItemSlugs as jest.MockedFunction<
  typeof loadActiveItemSlugs
>;

describe('applyCastSpell', () => {
  const character = {
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: null as string | null,
    level: 3,
    speciesSlug: 'elf',
    backgroundSlug: 'soldier',
    abilityScores: { inteligencia: 10 },
  };

  let state: {
    grantedSpellUses: Record<string, number>;
    spellSlotsUsed: Record<string, number>;
    resourcesUsed: Record<string, number>;
    concentratingOn: string | null;
    missileShieldArmed: boolean;
    gigaMissileArmed: boolean;
  };
  let spellLookup: { hasSpell: jest.Mock };
  let catalogLookup: { findSpellOrFail: jest.Mock };
  let sheetRepository: { load: jest.Mock };
  let grantedSpellCatalog: { loadMergeCatalog: jest.Mock };
  let classSlots: { findOne: jest.Mock };
  let subclassSlots: { findOne: jest.Mock };
  let stateRepo: { save: jest.Mock };
  let buildResponse: jest.Mock;

  beforeEach(() => {
    state = {
      grantedSpellUses: {},
      spellSlotsUsed: {},
      resourcesUsed: {},
      concentratingOn: null,
      missileShieldArmed: false,
      gigaMissileArmed: false,
    };
    spellLookup = { hasSpell: jest.fn().mockResolvedValue(true) };
    catalogLookup = {
      findSpellOrFail: jest.fn().mockResolvedValue({
        level: 2,
        concentration: false,
      }),
    };
    sheetRepository = {
      load: jest.fn().mockResolvedValue({
        characterFeats: [],
        featOptions: [],
        speciesChoices: [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }],
        characterSpells: [
          { spellSlug: 'fogo-das-fadas', listType: 'always_prepared' },
        ],
        classOptions: [],
      }),
    };
    grantedSpellCatalog = {
      loadMergeCatalog: jest.fn().mockResolvedValue({
        speciesCatalog: [
          {
            speciesSlug: 'elf',
            choiceKind: 'elf_lineage',
            choiceSlug: 'drow',
            unlockLevel: 3,
            spellSlug: 'fogo-das-fadas',
          },
        ],
        featFixedSpells: [],
      }),
    };
    classSlots = { findOne: jest.fn().mockResolvedValue(null) };
    subclassSlots = { findOne: jest.fn().mockResolvedValue(null) };
    stateRepo = { save: jest.fn().mockResolvedValue(state) };
    buildResponse = jest.fn().mockResolvedValue({ ok: true });
    resolveClassResourcesMock.mockReset();
    resolveClassResourcesMock.mockResolvedValue([]);
    loadActiveItemSlugsMock.mockReset();
    loadActiveItemSlugsMock.mockResolvedValue([]);
  });

  async function cast(
    dto: {
      spellSlug: string;
      useFreeCast?: boolean;
      freeCastResourceSlug?: string;
      itemCastResourceSlug?: string;
      itemCastSpendAmount?: number;
      slotLevel?: number;
    },
    characterOverride?: Record<string, unknown>,
    dataSourceOverride?: { query: jest.Mock },
  ) {
    return applyCastSpell({
      character: { ...character, ...(characterOverride ?? {}) } as never,
      state: state as never,
      dto: dto as never,
      stateRepo: stateRepo as never,
      classSlots: classSlots as never,
      subclassSlots: subclassSlots as never,
      catalogLookup: catalogLookup as never,
      spellLookup: spellLookup as never,
      sheetRepository: sheetRepository as never,
      grantedSpellCatalog: grantedSpellCatalog as never,
      dataSource: (dataSourceOverride ?? { query: jest.fn() }) as never,
      buildResponse,
    });
  }

  it('casts via item charges without knowing the spell', async () => {
    spellLookup.hasSpell.mockResolvedValue(false);
    catalogLookup.findSpellOrFail.mockResolvedValue({
      level: 1,
      concentration: false,
    });
    loadActiveItemSlugsMock.mockResolvedValue(['varinha-de-misseis-magicos']);
    resolveClassResourcesMock.mockResolvedValue([
      { slug: 'varinhaMisseisCharges', name: 'Cargas', max: 7 },
    ] as never);
    const query = jest
      .fn()
      .mockResolvedValueOnce([
        {
          action_id: 'item-varinha-de-misseis-magicos-2',
          item_slug: 'varinha-de-misseis-magicos',
          spell_slug: 'misseis-magicos',
          resource_slug: 'varinhaMisseisCharges',
          spend_amount: 2,
        },
      ])
      .mockResolvedValueOnce([]);

    const result = await cast(
      {
        spellSlug: 'misseis-magicos',
        itemCastResourceSlug: 'varinhaMisseisCharges',
        itemCastSpendAmount: 2,
      },
      undefined,
      { query },
    );

    expect(result.slotLevelUsed).toBe(2);
    expect(state.resourcesUsed.varinhaMisseisCharges).toBe(2);
    expect(result.note).toMatch(/carga/i);
  });

  it('consumes free cast without spending slot', async () => {
    const result = await cast({
      spellSlug: 'fogo-das-fadas',
      useFreeCast: true,
    });
    expect(result.slotLevelUsed).toBeNull();
    expect(state.grantedSpellUses['fogo-das-fadas']).toBe(1);
  });

  it('rejects second free cast before long rest', async () => {
    state.grantedSpellUses = { 'fogo-das-fadas': 1 };
    await expect(
      cast({ spellSlug: 'fogo-das-fadas', useFreeCast: true }),
    ).rejects.toThrow(/No free cast remaining/i);
  });

  it('rejects free cast for non-granted economy', async () => {
    catalogLookup.findSpellOrFail.mockResolvedValue({
      level: 1,
      concentration: false,
    });
    sheetRepository.load.mockResolvedValue({
      characterFeats: [],
      featOptions: [],
      speciesChoices: [],
      characterSpells: [{ spellSlug: 'alarme', listType: 'prepared' }],
    });
    grantedSpellCatalog.loadMergeCatalog.mockResolvedValue({
      speciesCatalog: [],
      featFixedSpells: [],
    });
    await expect(
      cast({ spellSlug: 'alarme', useFreeCast: true }),
    ).rejects.toThrow(BadRequestException);
  });

  describe('magic-missile-mage free cast', () => {
    const mage = {
      classSlug: 'wizard',
      subclassSlug: 'magic-missile-mage',
      level: 14,
      abilityScores: { inteligencia: 18 },
    };

    beforeEach(() => {
      catalogLookup.findSpellOrFail.mockResolvedValue({
        level: 1,
        concentration: false,
      });
      resolveClassResourcesMock.mockResolvedValue([
        { slug: 'magic-missile-free', name: 'Mísseis Gratuitos', max: 4 },
        { slug: 'missile-shield', name: 'Escudo', max: 1 },
        { slug: 'giga-missile', name: 'Giga', max: 1 },
      ] as never);
    });

    it('spends magic-missile-free and returns dart note', async () => {
      const result = await cast(
        {
          spellSlug: 'misseis-magicos',
          freeCastResourceSlug: 'magic-missile-free',
        },
        mage,
      );
      expect(result.slotLevelUsed).toBeNull();
      expect(state.resourcesUsed['magic-missile-free']).toBe(1);
      expect(result.note).toMatch(/7 dardo/i);
      expect(result.note).toMatch(/uso gratuito/i);
    });

    it('rejects free cast without remaining uses', async () => {
      state.resourcesUsed = { 'magic-missile-free': 4 };
      await expect(
        cast(
          {
            spellSlug: 'misseis-magicos',
            freeCastResourceSlug: 'magic-missile-free',
          },
          mage,
        ),
      ).rejects.toThrow(BadRequestException);
    });

    it('applies armed shield and giga then clears flags', async () => {
      state.missileShieldArmed = true;
      state.gigaMissileArmed = true;
      const result = await cast(
        {
          spellSlug: 'misseis-magicos',
          freeCastResourceSlug: 'magic-missile-free',
        },
        mage,
      );
      expect(state.missileShieldArmed).toBe(false);
      expect(state.gigaMissileArmed).toBe(false);
      expect(state.resourcesUsed['missile-shield']).toBe(1);
      expect(state.resourcesUsed['giga-missile']).toBe(1);
      expect(result.note).toMatch(/Escudo de Mísseis/i);
      expect(result.note).toMatch(/Giga-Míssil/i);
    });
  });

  describe('spell mastery', () => {
    it('casts mastery spell without spending a slot', async () => {
      sheetRepository.load.mockResolvedValue({
        characterFeats: [],
        featOptions: [],
        speciesChoices: [],
        characterSpells: [
          { spellSlug: 'alarme', listType: 'prepared' },
        ],
        classOptions: [
          { optionKey: 'spellMastery1', valueId: 'alarme' },
        ],
      });
      catalogLookup.findSpellOrFail.mockResolvedValue({
        level: 1,
        concentration: false,
      });
      classSlots.findOne.mockResolvedValue({
        level1: 4,
        level2: 3,
      });

      const result = await cast(
        { spellSlug: 'alarme', slotLevel: 1 },
        { classSlug: 'wizard', level: 18, subclassSlug: null },
      );

      expect(result.slotLevelUsed).toBeNull();
      expect(state.spellSlotsUsed).toEqual({});
      expect(result.note).toMatch(/Dominância/i);
    });
  });

  describe('warlock eldritch free cast', () => {
    const warlock = {
      classSlug: 'warlock',
      subclassSlug: 'fiend',
      level: 5,
      abilityScores: { carisma: 18 },
    };

    const catalogRows = [
      {
        slug: 'armor-of-shadows',
        name: 'Armadura de Sombras',
        min_level: 1,
        requires_pact_slug: null,
        requires_invocation_slug: null,
        repeatable: false,
        kind: 'free_cast',
        granted_spell_slug: 'armadura-arcana',
      },
      {
        slug: 'gift-of-the-depths',
        name: 'Presente das Profundezas',
        min_level: 5,
        requires_pact_slug: null,
        requires_invocation_slug: null,
        repeatable: false,
        kind: 'free_cast',
        granted_spell_slug: 'respirar-na-agua',
      },
      {
        slug: 'agonizing-blast',
        name: 'Explosão Agonizante',
        min_level: 2,
        requires_pact_slug: null,
        requires_invocation_slug: null,
        repeatable: false,
        kind: 'passive',
        granted_spell_slug: null,
      },
    ];

    beforeEach(() => {
      catalogLookup.findSpellOrFail.mockResolvedValue({
        level: 1,
        concentration: false,
      });
      sheetRepository.load.mockResolvedValue({
        characterFeats: [],
        featOptions: [],
        speciesChoices: [],
        characterSpells: [],
        classOptions: [
          {
            optionKey: 'eldritch-invocation',
            valueId: 'armor-of-shadows',
            instanceIndex: 0,
          },
          {
            optionKey: 'eldritch-invocation',
            valueId: 'gift-of-the-depths',
            instanceIndex: 1,
          },
          {
            optionKey: 'eldritch-invocation',
            valueId: 'agonizing-blast',
            instanceIndex: 2,
          },
          {
            optionKey: 'eldritch-invocation-cantrip',
            valueId: 'rajada-mistica',
            instanceIndex: 2,
          },
        ],
      });
    });

    async function castWarlock(dto: {
      spellSlug: string;
      useFreeCast?: boolean;
      slotLevel?: number;
    }) {
      return applyCastSpell({
        character: { ...character, ...warlock } as never,
        state: state as never,
        dto: dto as never,
        stateRepo: stateRepo as never,
        classSlots: classSlots as never,
        subclassSlots: subclassSlots as never,
        catalogLookup: catalogLookup as never,
        spellLookup: spellLookup as never,
        sheetRepository: sheetRepository as never,
        grantedSpellCatalog: grantedSpellCatalog as never,
        dataSource: {
          query: jest.fn().mockResolvedValue(catalogRows),
        } as never,
        buildResponse,
      });
    }

    it('casts armor-of-shadows grant at will without slot', async () => {
      spellLookup.hasSpell.mockResolvedValue(false);
      const result = await castWarlock({ spellSlug: 'armadura-arcana' });
      expect(result.slotLevelUsed).toBeNull();
      expect(result.note).toMatch(/Armadura de Sombras/i);
      expect(state.spellSlotsUsed).toEqual({});
    });

    it('consumes gift-of-the-depths once per long rest', async () => {
      spellLookup.hasSpell.mockResolvedValue(true);
      const result = await castWarlock({ spellSlug: 'respirar-na-agua' });
      expect(result.slotLevelUsed).toBeNull();
      expect(state.grantedSpellUses['respirar-na-agua']).toBe(1);

      classSlots.findOne.mockResolvedValue({ level1: 0, level2: 0, level3: 2 });
      await expect(
        castWarlock({ spellSlug: 'respirar-na-agua' }),
      ).rejects.toThrow(BadRequestException);
    });

    it('annotates cantrip casts with agonizing blast only when bound', async () => {
      catalogLookup.findSpellOrFail.mockResolvedValue({
        level: 0,
        concentration: false,
      });
      spellLookup.hasSpell.mockResolvedValue(true);
      const result = await castWarlock({ spellSlug: 'rajada-mistica' });
      expect(result.note).toMatch(/Explosão Agonizante/i);

      const other = await castWarlock({ spellSlug: 'toque-gelido' });
      expect(other.note ?? '').not.toMatch(/Explosão Agonizante/i);
    });
  });
});
