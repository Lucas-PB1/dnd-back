import { BadRequestException, NotFoundException } from '@nestjs/common';
import { CatalogLookupService } from './catalog-lookup.service';

type Repo = { findOne: jest.Mock; find: jest.Mock };

function repo(): Repo {
  return { findOne: jest.fn(), find: jest.fn() };
}

describe('CatalogLookupService', () => {
  let service: CatalogLookupService;
  let classesRepo: Repo;
  let speciesRepo: Repo;
  let backgroundsRepo: Repo;
  let subclassesRepo: Repo;
  let alignmentsRepo: Repo;
  let classSkillChoiceRepo: Repo;
  let featsRepo: Repo;
  let languagesRepo: Repo;
  let abilityMethodsRepo: Repo;
  let itemsRepo: Repo;
  let spellsRepo: Repo;
  let skillsRepo: Repo;

  beforeEach(() => {
    classesRepo = repo();
    speciesRepo = repo();
    backgroundsRepo = repo();
    subclassesRepo = repo();
    alignmentsRepo = repo();
    classSkillChoiceRepo = repo();
    featsRepo = repo();
    languagesRepo = repo();
    abilityMethodsRepo = repo();
    itemsRepo = repo();
    spellsRepo = repo();
    skillsRepo = repo();

    service = new CatalogLookupService(
      classesRepo as never,
      speciesRepo as never,
      backgroundsRepo as never,
      subclassesRepo as never,
      alignmentsRepo as never,
      classSkillChoiceRepo as never,
      featsRepo as never,
      languagesRepo as never,
      abilityMethodsRepo as never,
      itemsRepo as never,
      spellsRepo as never,
      skillsRepo as never,
    );
  });

  it('find*OrFail returns row or NotFound', async () => {
    classesRepo.findOne.mockResolvedValue({ classSlug: 'fighter' });
    await expect(service.findClassOrFail('fighter')).resolves.toEqual({
      classSlug: 'fighter',
    });
    classesRepo.findOne.mockResolvedValue(null);
    await expect(service.findClassOrFail('x')).rejects.toBeInstanceOf(
      NotFoundException,
    );

    speciesRepo.findOne.mockResolvedValue({ slug: 'human' });
    await expect(service.findSpeciesOrFail('human')).resolves.toEqual({
      slug: 'human',
    });
    backgroundsRepo.findOne.mockResolvedValue({ backgroundSlug: 'acolyte' });
    await expect(service.findBackgroundOrFail('acolyte')).resolves.toEqual({
      backgroundSlug: 'acolyte',
    });
    subclassesRepo.findOne.mockResolvedValue({ subclassSlug: 'champion' });
    await expect(service.findSubclassOrFail('champion')).resolves.toEqual({
      subclassSlug: 'champion',
    });
    featsRepo.findOne.mockResolvedValue({ featSlug: 'alert' });
    await expect(service.findFeatOrFail('alert')).resolves.toEqual({
      featSlug: 'alert',
    });
    spellsRepo.findOne.mockResolvedValue({ slug: 'luz' });
    await expect(service.findSpellOrFail('luz')).resolves.toEqual({
      slug: 'luz',
    });
    itemsRepo.findOne.mockResolvedValue({ slug: 'longsword' });
    await expect(service.findItemOrFail('longsword')).resolves.toEqual({
      slug: 'longsword',
    });
  });

  it('assert*Slug methods reject missing catalog rows', async () => {
    classesRepo.findOne.mockResolvedValue(null);
    await expect(service.assertClassSlug('x')).rejects.toBeInstanceOf(
      BadRequestException,
    );
    speciesRepo.findOne.mockResolvedValue({ slug: 'elf' });
    await expect(service.assertSpeciesSlug('elf')).resolves.toBeUndefined();
    backgroundsRepo.findOne.mockResolvedValue(null);
    await expect(service.assertBackgroundSlug('x')).rejects.toBeInstanceOf(
      BadRequestException,
    );
    alignmentsRepo.findOne.mockResolvedValue(null);
    await expect(service.assertAlignmentSlug('x')).rejects.toBeInstanceOf(
      BadRequestException,
    );
    languagesRepo.findOne.mockResolvedValue({ slug: 'common' });
    await expect(service.assertLanguageSlug('common')).resolves.toBeUndefined();
    abilityMethodsRepo.findOne.mockResolvedValue(null);
    await expect(
      service.assertAbilityGenerationMethodSlug('x'),
    ).rejects.toBeInstanceOf(BadRequestException);
    skillsRepo.findOne.mockResolvedValue(null);
    await expect(service.assertSkillInCatalog('x')).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('assertFeatInCatalog / item / spell return rows', async () => {
    featsRepo.findOne.mockResolvedValue({ featSlug: 'alert' });
    await expect(service.assertFeatInCatalog('alert')).resolves.toEqual({
      featSlug: 'alert',
    });
    itemsRepo.findOne.mockResolvedValue({ slug: 'shield' });
    await expect(service.assertItemInCatalog('shield')).resolves.toEqual({
      slug: 'shield',
    });
    spellsRepo.findOne.mockResolvedValue({ slug: 'luz' });
    await expect(service.assertSpellInCatalog('luz')).resolves.toEqual({
      slug: 'luz',
    });
  });

  it('findEpicBoonFeatSlugs returns set', async () => {
    featsRepo.find.mockResolvedValue([
      { featSlug: 'boon-a' },
      { featSlug: 'boon-b' },
    ]);
    await expect(service.findEpicBoonFeatSlugs()).resolves.toEqual(
      new Set(['boon-a', 'boon-b']),
    );
  });

  it('assertSubclassForClass checks pair', async () => {
    subclassesRepo.findOne.mockResolvedValue(null);
    await expect(
      service.assertSubclassForClass('champion', 'wizard'),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('validateCharacterCatalogRefs checks optional fields', async () => {
    classesRepo.findOne.mockResolvedValue({ classSlug: 'fighter' });
    speciesRepo.findOne.mockResolvedValue({ slug: 'human' });
    backgroundsRepo.findOne.mockResolvedValue({ backgroundSlug: 'acolyte' });
    subclassesRepo.findOne.mockResolvedValue({ subclassSlug: 'champion' });
    alignmentsRepo.findOne.mockResolvedValue({ slug: 'lawful-good' });
    await expect(
      service.validateCharacterCatalogRefs({
        classSlug: 'fighter',
        speciesSlug: 'human',
        backgroundSlug: 'acolyte',
        subclassSlug: 'champion',
        alignmentSlug: 'lawful-good',
      }),
    ).resolves.toBeUndefined();
  });

  it('validateClassSkillChoices enforces count, uniqueness, pool and any', async () => {
    classesRepo.findOne.mockResolvedValue({
      classSlug: 'fighter',
      skillChoiceCount: 2,
      skillChoiceFrom: 'list',
    });
    await expect(
      service.validateClassSkillChoices('fighter', ['athletics']),
    ).rejects.toBeInstanceOf(BadRequestException);

    classSkillChoiceRepo.find.mockResolvedValue([
      { skillSlug: 'athletics' },
      { skillSlug: 'perception' },
    ]);
    await expect(
      service.validateClassSkillChoices('fighter', ['athletics', 'stealth']),
    ).rejects.toBeInstanceOf(BadRequestException);
    await expect(
      service.validateClassSkillChoices('fighter', [
        'athletics',
        'perception',
      ]),
    ).resolves.toBeUndefined();
    await expect(
      service.validateClassSkillChoices('fighter', [
        'athletics',
        'athletics',
      ]),
    ).rejects.toBeInstanceOf(BadRequestException);

    classesRepo.findOne.mockResolvedValue({
      classSlug: 'bard',
      skillChoiceCount: 1,
      skillChoiceFrom: 'any',
    });
    skillsRepo.findOne.mockResolvedValue({ slug: 'performance' });
    await expect(
      service.validateClassSkillChoices('bard', ['performance']),
    ).resolves.toBeUndefined();

    classesRepo.findOne.mockResolvedValue({
      classSlug: 'barbarian',
      skillChoiceCount: 0,
      skillChoiceFrom: 'list',
    });
    await expect(
      service.validateClassSkillChoices('barbarian', []),
    ).resolves.toBeUndefined();
  });
});
