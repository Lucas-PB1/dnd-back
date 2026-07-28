import { BadRequestException } from '@nestjs/common';
import { applyCastSpell } from './cast-spell';

describe('applyCastSpell', () => {
  const character = {
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: null,
    level: 3,
    speciesSlug: 'elf',
    backgroundSlug: 'soldier',
  } as never;

  let state: {
    grantedSpellUses: Record<string, number>;
    spellSlotsUsed: Record<string, number>;
    concentratingOn: string | null;
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
      concentratingOn: null,
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
  });

  async function cast(dto: {
    spellSlug: string;
    useFreeCast?: boolean;
    slotLevel?: number;
  }) {
    return applyCastSpell({
      character,
      state: state as never,
      dto: dto as never,
      stateRepo: stateRepo as never,
      classSlots: classSlots as never,
      subclassSlots: subclassSlots as never,
      catalogLookup: catalogLookup as never,
      spellLookup: spellLookup as never,
      sheetRepository: sheetRepository as never,
      grantedSpellCatalog: grantedSpellCatalog as never,
      buildResponse,
    });
  }

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
});
