import { BadRequestException } from '@nestjs/common';
import { In } from 'typeorm';
import { validateSpellListAccess } from './validate-spell-list-access';

describe('validateSpellListAccess', () => {
  let classSpellsRepo: { find: jest.Mock; findOne: jest.Mock };
  let subclassSpellsRepo: { find: jest.Mock; findOne: jest.Mock };
  const ctx = {
    classSlug: 'wizard',
    subclassSlug: 'evoker',
    level: 3,
    backgroundSlug: 'sage',
    speciesSlug: 'human',
  };

  beforeEach(() => {
    classSpellsRepo = { find: jest.fn().mockResolvedValue([]), findOne: jest.fn() };
    subclassSpellsRepo = { find: jest.fn().mockResolvedValue([]), findOne: jest.fn() };
  });

  async function run(
    spells: { spellSlug: string }[],
    opts: {
      featGranted?: string[];
      speciesGranted?: string[];
      spellListClassSlug?: string;
      maxSpellLevel?: number;
    } = {},
  ): Promise<void> {
    await validateSpellListAccess(
      classSpellsRepo as never,
      subclassSpellsRepo as never,
      spells as never,
      ctx as never,
      new Set(opts.featGranted ?? []),
      new Set(opts.speciesGranted ?? []),
      opts.spellListClassSlug ?? 'wizard',
      opts.maxSpellLevel ?? 2,
    );
  }

  it('skips feat and species granted spells', async () => {
    await run([{ spellSlug: 'fire-bolt' }], { featGranted: ['fire-bolt'] });
    await run([{ spellSlug: 'light' }], { speciesGranted: ['light'] });
    expect(classSpellsRepo.find).not.toHaveBeenCalled();
  });

  it('accepts spell on list class when list equals class', async () => {
    classSpellsRepo.find.mockResolvedValue([
      { classSlug: 'wizard', spellSlug: 'magic-missile', spellLevel: 1 },
    ]);
    await expect(run([{ spellSlug: 'magic-missile' }])).resolves.toBeUndefined();
    expect(classSpellsRepo.find).toHaveBeenCalledTimes(1);
  });

  it('also checks character class when spell list differs', async () => {
    classSpellsRepo.find.mockResolvedValue([
      { classSlug: 'wizard', spellSlug: 'cure-wounds', spellLevel: 1 },
    ]);
    await run([{ spellSlug: 'cure-wounds' }], { spellListClassSlug: 'cleric' });
    expect(classSpellsRepo.find).toHaveBeenCalledWith({
      where: {
        classSlug: In(['cleric', 'wizard']),
        spellSlug: In(['cure-wounds']),
      },
    });
  });

  it('accepts subclass-only spells', async () => {
    classSpellsRepo.find.mockResolvedValue([]);
    subclassSpellsRepo.find.mockResolvedValue([
      { spellSlug: 'chromatic-orb', terrainSlug: null },
    ]);
    await expect(run([{ spellSlug: 'chromatic-orb' }])).resolves.toBeUndefined();
  });

  it('accepts magical secrets extra class lists', async () => {
    classSpellsRepo.find.mockResolvedValue([
      { classSlug: 'cleric', spellSlug: 'cura-ferimentos', spellLevel: 2 },
    ]);
    await validateSpellListAccess(
      classSpellsRepo as never,
      subclassSpellsRepo as never,
      [{ spellSlug: 'cura-ferimentos' }] as never,
      { ...ctx, classSlug: 'bard', subclassSlug: null, level: 10 } as never,
      new Set(),
      new Set(),
      'bard',
      5,
      new Set(),
      ['cleric'],
    );
    expect(classSpellsRepo.find).toHaveBeenCalledWith({
      where: {
        classSlug: In(['bard', 'cleric']),
        spellSlug: In(['cura-ferimentos']),
      },
    });
  });

  it('rejects unknown spells', async () => {
    classSpellsRepo.find.mockResolvedValue([]);
    subclassSpellsRepo.find.mockResolvedValue([]);
    await expect(run([{ spellSlug: 'wish' }])).rejects.toThrow(BadRequestException);
  });

  it('rejects spells above max circle unless subclass-granted', async () => {
    classSpellsRepo.find.mockResolvedValue([
      { classSlug: 'wizard', spellSlug: 'fireball', spellLevel: 5 },
    ]);
    subclassSpellsRepo.find.mockResolvedValue([]);
    await expect(run([{ spellSlug: 'fireball' }])).rejects.toThrow(/exceeds max circle/i);

    classSpellsRepo.find.mockResolvedValue([
      { classSlug: 'wizard', spellSlug: 'fireball', spellLevel: 5 },
    ]);
    subclassSpellsRepo.find.mockResolvedValue([
      { spellSlug: 'fireball', terrainSlug: null },
    ]);
    await expect(run([{ spellSlug: 'fireball' }])).resolves.toBeUndefined();
  });

  it('loads membership in one batch for many spells', async () => {
    classSpellsRepo.find.mockResolvedValue([
      { classSlug: 'wizard', spellSlug: 'a', spellLevel: 1 },
      { classSlug: 'wizard', spellSlug: 'b', spellLevel: 1 },
    ]);
    await run([{ spellSlug: 'a' }, { spellSlug: 'b' }]);
    expect(classSpellsRepo.find).toHaveBeenCalledTimes(1);
    expect(subclassSpellsRepo.find).toHaveBeenCalledTimes(1);
  });
});
