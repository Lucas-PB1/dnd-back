import { BadRequestException, NotFoundException } from '@nestjs/common';
import type { ObjectLiteral, Repository } from 'typeorm';
import { CatalogLookupService } from './catalog-lookup.service';

type RepoMocks = {
  findOne: jest.Mock;
  find: jest.Mock;
};

function mockRepo(): RepoMocks {
  return { findOne: jest.fn(), find: jest.fn() };
}

function asMockRepo<T extends ObjectLiteral>(mocks: RepoMocks): Repository<T> {
  return mocks as unknown as Repository<T>;
}

describe('CatalogLookupService', () => {
  let service: CatalogLookupService;
  let classesRepo: RepoMocks;
  let speciesRepo: RepoMocks;
  let heritageRepo: RepoMocks;
  let backgroundsRepo: RepoMocks;
  let subclassesRepo: RepoMocks;
  let alignmentsRepo: RepoMocks;
  let classSkillChoiceRepo: RepoMocks;
  let featsRepo: RepoMocks;
  let languagesRepo: RepoMocks;
  let abilityMethodsRepo: RepoMocks;
  let itemsRepo: RepoMocks;
  let spellsRepo: RepoMocks;
  let skillsRepo: RepoMocks;
  let creatureTemplatesRepo: RepoMocks;
  let vehicleTemplatesRepo: RepoMocks;

  beforeEach(() => {
    classesRepo = mockRepo();
    speciesRepo = mockRepo();
    heritageRepo = mockRepo();
    backgroundsRepo = mockRepo();
    subclassesRepo = mockRepo();
    alignmentsRepo = mockRepo();
    classSkillChoiceRepo = mockRepo();
    featsRepo = mockRepo();
    languagesRepo = mockRepo();
    abilityMethodsRepo = mockRepo();
    itemsRepo = mockRepo();
    spellsRepo = mockRepo();
    skillsRepo = mockRepo();
    creatureTemplatesRepo = mockRepo();
    vehicleTemplatesRepo = mockRepo();

    service = new CatalogLookupService(
      asMockRepo(classesRepo),
      asMockRepo(speciesRepo),
      asMockRepo(heritageRepo),
      asMockRepo(backgroundsRepo),
      asMockRepo(subclassesRepo),
      asMockRepo(alignmentsRepo),
      asMockRepo(classSkillChoiceRepo),
      asMockRepo(featsRepo),
      asMockRepo(languagesRepo),
      asMockRepo(abilityMethodsRepo),
      asMockRepo(itemsRepo),
      asMockRepo(spellsRepo),
      asMockRepo(skillsRepo),
      asMockRepo(creatureTemplatesRepo),
      asMockRepo(vehicleTemplatesRepo),
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
    languagesRepo.findOne.mockResolvedValue({ slug: 'common' });
    await expect(service.findLanguageOrFail('common')).resolves.toEqual({
      slug: 'common',
    });
    languagesRepo.findOne.mockResolvedValue(null);
    await expect(service.findLanguageOrFail('x')).rejects.toBeInstanceOf(
      NotFoundException,
    );
    skillsRepo.findOne.mockResolvedValue({ slug: 'athletics' });
    await expect(service.findSkillOrFail('athletics')).resolves.toEqual({
      slug: 'athletics',
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

  it('assertFeatInCatalog / item / spell / language return rows', async () => {
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
    languagesRepo.findOne.mockResolvedValue({ slug: 'elvish' });
    await expect(service.assertLanguageInCatalog('elvish')).resolves.toEqual({
      slug: 'elvish',
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

  it('resolveTransportActorKind distingue vehicle vs mount', async () => {
    vehicleTemplatesRepo.findOne.mockResolvedValue({ slug: 'carruagem' });
    await expect(service.resolveTransportActorKind('carruagem')).resolves.toBe(
      'vehicle',
    );

    vehicleTemplatesRepo.findOne.mockResolvedValue(null);
    creatureTemplatesRepo.findOne.mockResolvedValue({ slug: 'cavalo' });
    await expect(service.resolveTransportActorKind('cavalo')).resolves.toBe(
      'mount',
    );

    creatureTemplatesRepo.findOne.mockResolvedValue(null);
    await expect(service.resolveTransportActorKind('x')).rejects.toBeInstanceOf(
      NotFoundException,
    );
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
