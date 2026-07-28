import { BadRequestException } from '@nestjs/common';
import { validateSpellListAccess } from './validate-spell-list-access';

describe('validateSpellListAccess', () => {
  let classSpellsRepo: { findOne: jest.Mock };
  let subclassSpellsRepo: { findOne: jest.Mock };
  const ctx = {
    classSlug: 'wizard',
    subclassSlug: 'evoker',
    level: 3,
    backgroundSlug: 'sage',
    speciesSlug: 'human',
  };

  beforeEach(() => {
    classSpellsRepo = { findOne: jest.fn() };
    subclassSpellsRepo = { findOne: jest.fn() };
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
    expect(classSpellsRepo.findOne).not.toHaveBeenCalled();
  });

  it('accepts spell on list class when list equals class', async () => {
    classSpellsRepo.findOne.mockResolvedValue({ spellLevel: 1 });
    subclassSpellsRepo.findOne.mockResolvedValue(null);
    await expect(run([{ spellSlug: 'magic-missile' }])).resolves.toBeUndefined();
  });

  it('also checks character class when spell list differs', async () => {
    classSpellsRepo.findOne
      .mockResolvedValueOnce(null)
      .mockResolvedValueOnce({ spellLevel: 1 });
    subclassSpellsRepo.findOne.mockResolvedValue(null);
    await run([{ spellSlug: 'cure-wounds' }], { spellListClassSlug: 'cleric' });
    expect(classSpellsRepo.findOne).toHaveBeenCalledTimes(2);
  });

  it('accepts subclass-only spells', async () => {
    classSpellsRepo.findOne.mockResolvedValue(null);
    subclassSpellsRepo.findOne.mockResolvedValue({ spellSlug: 'chromatic-orb' });
    await expect(run([{ spellSlug: 'chromatic-orb' }])).resolves.toBeUndefined();
  });

  it('rejects unknown spells', async () => {
    classSpellsRepo.findOne.mockResolvedValue(null);
    subclassSpellsRepo.findOne.mockResolvedValue(null);
    await expect(run([{ spellSlug: 'wish' }])).rejects.toThrow(BadRequestException);
  });

  it('rejects spells above max circle unless subclass-granted', async () => {
    classSpellsRepo.findOne.mockResolvedValue({ spellLevel: 5 });
    subclassSpellsRepo.findOne.mockResolvedValue(null);
    await expect(run([{ spellSlug: 'fireball' }])).rejects.toThrow(/exceeds max circle/i);

    classSpellsRepo.findOne.mockResolvedValue({ spellLevel: 5 });
    subclassSpellsRepo.findOne.mockResolvedValue({ spellSlug: 'fireball' });
    await expect(run([{ spellSlug: 'fireball' }])).resolves.toBeUndefined();
  });
});
