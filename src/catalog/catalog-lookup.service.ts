import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { PhbHeritage } from '../entities/phb-heritage.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';
import { VPhbClassSkillChoice } from '../entities/views/v-phb-class-skill-choice.entity';
import { VPhbFeat } from '../entities/views/v-phb-feat.entity';
import { PhbLanguage } from '../entities/phb-language.entity';
import { PhbAbilityGenerationMethod } from '../entities/phb-ability-generation-method.entity';
import { PhbItem } from '../entities/phb-item.entity';
import { VPhbSpell } from '../entities/views/v-phb-spell.entity';
import { PhbSkill } from '../entities/phb-skill.entity';
import * as assets from './catalog-lookup-assets';
import * as feats from './catalog-lookup-feats';
import * as origins from './catalog-lookup-origins';
import {
  assertPlayableSpeciesSlug as assertPlayableSpecies,
  assertSpeciesIsPlayable,
} from './catalog-lookup-species';
import * as skills from './catalog-lookup-skills';

/**
 * SSOT de “existe este slug?” para escrita de ficha / inventário / sessão.
 * `find*OrFail` → 404; `assert*` / `assert*InCatalog` → 400.
 */
@Injectable()
export class CatalogLookupService {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
    @InjectRepository(PhbHeritage)
    private readonly heritageRepo: Repository<PhbHeritage>,
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
    @InjectRepository(PhbAlignment)
    private readonly alignmentsRepo: Repository<PhbAlignment>,
    @InjectRepository(VPhbClassSkillChoice)
    private readonly classSkillChoiceRepo: Repository<VPhbClassSkillChoice>,
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    @InjectRepository(PhbAbilityGenerationMethod)
    private readonly abilityMethodsRepo: Repository<PhbAbilityGenerationMethod>,
    @InjectRepository(PhbItem)
    private readonly itemsRepo: Repository<PhbItem>,
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    @InjectRepository(PhbSkill)
    private readonly skillsRepo: Repository<PhbSkill>,
  ) {}

  findClassOrFail(classSlug: string) {
    return origins.findClassOrFail(this.classesRepo, classSlug);
  }

  findSpeciesOrFail(speciesSlug: string) {
    return origins.findSpeciesOrFail(this.speciesRepo, speciesSlug);
  }

  findHeritageOrFail(heritageSlug: string) {
    return origins.findHeritageOrFail(this.heritageRepo, heritageSlug);
  }

  assertHeritageSlug(heritageSlug: string) {
    return origins.assertHeritageSlug(this.heritageRepo, heritageSlug);
  }

  async findPlayableSpeciesOrFail(speciesSlug: string): Promise<PhbSpecies> {
    const row = await this.findSpeciesOrFail(speciesSlug);
    assertSpeciesIsPlayable(row, speciesSlug);
    return row;
  }

  findBackgroundOrFail(backgroundSlug: string) {
    return origins.findBackgroundOrFail(this.backgroundsRepo, backgroundSlug);
  }

  findSubclassOrFail(subclassSlug: string) {
    return origins.findSubclassOrFail(this.subclassesRepo, subclassSlug);
  }

  findFeatOrFail(featSlug: string) {
    return feats.findFeatOrFail(this.featsRepo, featSlug);
  }

  findSpellOrFail(spellSlug: string) {
    return assets.findSpellOrFail(this.spellsRepo, spellSlug);
  }

  findItemOrFail(itemSlug: string) {
    return assets.findItemOrFail(this.itemsRepo, itemSlug);
  }

  assertClassSlug(classSlug: string) {
    return origins.assertClassSlug(this.classesRepo, classSlug);
  }

  assertSpeciesSlug(speciesSlug: string) {
    return this.assertPlayableSpeciesSlug(speciesSlug);
  }

  assertPlayableSpeciesSlug(speciesSlug: string) {
    return assertPlayableSpecies(this.speciesRepo, speciesSlug);
  }

  assertBackgroundSlug(backgroundSlug: string) {
    return origins.assertBackgroundSlug(this.backgroundsRepo, backgroundSlug);
  }

  assertAlignmentSlug(alignmentSlug: string) {
    return origins.assertAlignmentSlug(this.alignmentsRepo, alignmentSlug);
  }

  assertFeatInCatalog(featSlug: string) {
    return feats.assertFeatInCatalog(this.featsRepo, featSlug);
  }

  findEpicBoonFeatSlugs() {
    return feats.findEpicBoonFeatSlugs(this.featsRepo);
  }

  async assertLanguageSlug(slug: string): Promise<void> {
    await this.assertLanguageInCatalog(slug);
  }

  findLanguageOrFail(slug: string) {
    return assets.findLanguageOrFail(this.languagesRepo, slug);
  }

  assertLanguageInCatalog(slug: string) {
    return assets.assertLanguageInCatalog(this.languagesRepo, slug);
  }

  findSkillOrFail(slug: string) {
    return assets.findSkillOrFail(this.skillsRepo, slug);
  }

  assertAbilityGenerationMethodSlug(slug: string) {
    return assets.assertAbilityGenerationMethodSlug(this.abilityMethodsRepo, slug);
  }

  assertItemInCatalog(itemSlug: string) {
    return assets.assertItemInCatalog(this.itemsRepo, itemSlug);
  }

  assertSpellInCatalog(spellSlug: string) {
    return assets.assertSpellInCatalog(this.spellsRepo, spellSlug);
  }

  assertSkillInCatalog(skillSlug: string) {
    return skills.assertSkillInCatalog(this.skillsRepo, skillSlug);
  }

  assertSubclassForClass(subclassSlug: string, classSlug: string) {
    return origins.assertSubclassForClass(
      this.subclassesRepo,
      subclassSlug,
      classSlug,
    );
  }

  validateCharacterCatalogRefs(input: {
    classSlug: string;
    speciesSlug?: string | null;
    heritageSlug?: string | null;
    backgroundSlug: string;
    subclassSlug?: string | null;
    alignmentSlug?: string | null;
  }) {
    return origins.validateCharacterCatalogRefs({
      ...input,
      assertClassSlug: (slug) => this.assertClassSlug(slug),
      assertBackgroundSlug: (slug) => this.assertBackgroundSlug(slug),
      assertHeritageSlug: (slug) => this.assertHeritageSlug(slug),
      assertSpeciesSlug: (slug) => this.assertSpeciesSlug(slug),
      assertSubclassForClass: (sub, cls) => this.assertSubclassForClass(sub, cls),
      assertAlignmentSlug: (slug) => this.assertAlignmentSlug(slug),
    });
  }

  validateClassSkillChoices(classSlug: string, skillSlugs: string[]) {
    return skills.validateClassSkillChoices({
      classSlug,
      skillSlugs,
      findClassOrFail: (slug) => this.findClassOrFail(slug),
      classSkillChoiceRepo: this.classSkillChoiceRepo,
      skillsRepo: this.skillsRepo,
    });
  }
}
