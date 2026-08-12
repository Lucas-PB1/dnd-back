import {
  PreviewGrantedSpellsDto,
} from '../dto/preview-granted-spells.dto';
import { PreviewGrantedSpellsHandler } from './preview-granted-spells.handler';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';

describe('PreviewGrantedSpellsHandler', () => {
  const resolveSubclassOptionGrants = {
    resolveExtraGrantedSlugs: jest.fn().mockResolvedValue(new Set<string>()),
  };

  beforeEach(() => {
    resolveSubclassOptionGrants.resolveExtraGrantedSlugs.mockResolvedValue(
      new Set<string>(),
    );
  });

  it('merges species/feat grants and annotates sources', async () => {
    const catalog: jest.Mocked<Pick<LoadGrantedSpellCatalog, 'loadMergeCatalog'>> = {
      loadMergeCatalog: jest.fn().mockResolvedValue({
        speciesCatalog: [
          {
            speciesSlug: 'elf',
            choiceKind: 'elf_lineage',
            choiceSlug: 'drow',
            unlockLevel: 1,
            spellSlug: 'luzes-dancantes',
          },
        ],
        featFixedSpells: [],
        subclassGrantedSpells: [],
        classGrantedSpells: [],
      }),
    };
    const handler = new PreviewGrantedSpellsHandler(
      catalog as never,
      resolveSubclassOptionGrants as never,
    );
    const result = await handler.execute({
      speciesSlug: 'elf',
      level: 1,
      speciesChoices: [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }],
      characterSpells: [{ spellSlug: 'alarme', listType: 'prepared' }],
      featOptions: [
        {
          featSlug: 'magic-initiate',
          optionKey: 'cantrip1',
          valueId: 'fire-bolt',
        },
      ],
      characterFeats: [{ featSlug: 'magic-initiate', instanceIndex: 0 }],
    } as PreviewGrantedSpellsDto);

    expect(result.characterSpells.map((s) => s.spellSlug).sort()).toEqual([
      'alarme',
      'fire-bolt',
      'luzes-dancantes',
    ]);
    expect(result.grantedOnly.every((s) => s.listType === 'always_prepared')).toBe(
      true,
    );
    expect(
      result.grantedOnly.find((s) => s.spellSlug === 'luzes-dancantes')?.source,
    ).toBe('species');
    expect(
      result.grantedOnly.find((s) => s.spellSlug === 'fire-bolt')?.source,
    ).toBe('feat');
  });

  it('includes class always_prepared grants in grantedOnly', async () => {
    const catalog: jest.Mocked<Pick<LoadGrantedSpellCatalog, 'loadMergeCatalog'>> = {
      loadMergeCatalog: jest.fn().mockResolvedValue({
        speciesCatalog: [],
        featFixedSpells: [],
        subclassGrantedSpells: [],
        classGrantedSpells: [
          { unlockLevel: 1, spellSlug: 'marca-do-predador' },
        ],
      }),
    };
    const handler = new PreviewGrantedSpellsHandler(
      catalog as never,
      resolveSubclassOptionGrants as never,
    );
    const result = await handler.execute({
      speciesSlug: 'human',
      classSlug: 'ranger',
      level: 1,
      characterSpells: [{ spellSlug: 'curar-ferimentos', listType: 'prepared' }],
    } as PreviewGrantedSpellsDto);

    expect(result.grantedOnly.map((s) => s.spellSlug)).toEqual([
      'marca-do-predador',
    ]);
    expect(result.characterSpells.map((s) => s.spellSlug).sort()).toEqual([
      'curar-ferimentos',
      'marca-do-predador',
    ]);
  });
});
