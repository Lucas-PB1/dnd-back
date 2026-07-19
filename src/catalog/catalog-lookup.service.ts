import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { assertUnique, requireCatalog } from '../common/assert';
import { requireFound } from '../common/require-found';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';
import { VPhbClassSkillChoice } from '../entities/views/v-phb-class-skill-choice.entity';
import { VPhbFeat } from '../entities/views/v-phb-feat.entity';
import { PhbLanguage } from '../entities/phb-language.entity';
import { PhbAbilityGenerationMethod } from '../entities/phb-ability-generation-method.entity';
import { PhbItem } from '../entities/phb-item.entity';
import { VPhbSpell } from '../entities/views/v-phb-spell.entity';

@Injectable()
export class CatalogLookupService {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
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
  ) {}

  async findClassOrFail(classSlug: string): Promise<VPhbClass> {
    return requireFound(
      await this.classesRepo.findOne({ where: { classSlug } }),
      `Class '${classSlug}' not found`,
    );
  }

  async findSpeciesOrFail(speciesSlug: string): Promise<PhbSpecies> {
    return requireFound(
      await this.speciesRepo.findOne({ where: { slug: speciesSlug } }),
      `Species '${speciesSlug}' not found`,
    );
  }

  async findBackgroundOrFail(backgroundSlug: string): Promise<VPhbBackground> {
    return requireFound(
      await this.backgroundsRepo.findOne({ where: { backgroundSlug } }),
      `Background '${backgroundSlug}' not found`,
    );
  }

  async findSubclassOrFail(subclassSlug: string): Promise<VPhbSubclass> {
    return requireFound(
      await this.subclassesRepo.findOne({ where: { subclassSlug } }),
      `Subclass '${subclassSlug}' not found`,
    );
  }

  async findFeatOrFail(featSlug: string): Promise<VPhbFeat> {
    return requireFound(
      await this.featsRepo.findOne({ where: { featSlug } }),
      `Feat '${featSlug}' not found`,
    );
  }

  async findSpellOrFail(spellSlug: string): Promise<VPhbSpell> {
    return requireFound(
      await this.spellsRepo.findOne({ where: { slug: spellSlug } }),
      `Spell '${spellSlug}' not found in catalog`,
    );
  }

  async findItemOrFail(itemSlug: string): Promise<PhbItem> {
    return requireFound(
      await this.itemsRepo.findOne({ where: { slug: itemSlug } }),
      `Item '${itemSlug}' not found`,
    );
  }

  async assertClassSlug(classSlug: string): Promise<void> {
    requireCatalog(
      await this.classesRepo.findOne({ where: { classSlug } }),
      `Class '${classSlug}' not found in catalog`,
    );
  }

  async assertSpeciesSlug(speciesSlug: string): Promise<void> {
    requireCatalog(
      await this.speciesRepo.findOne({ where: { slug: speciesSlug } }),
      `Species '${speciesSlug}' not found in catalog`,
    );
  }

  async assertBackgroundSlug(backgroundSlug: string): Promise<void> {
    requireCatalog(
      await this.backgroundsRepo.findOne({ where: { backgroundSlug } }),
      `Background '${backgroundSlug}' not found in catalog`,
    );
  }

  async assertAlignmentSlug(alignmentSlug: string): Promise<void> {
    requireCatalog(
      await this.alignmentsRepo.findOne({ where: { slug: alignmentSlug } }),
      `Alignment '${alignmentSlug}' not found in catalog`,
    );
  }

  async assertFeatInCatalog(featSlug: string): Promise<VPhbFeat> {
    return requireCatalog(
      await this.featsRepo.findOne({ where: { featSlug } }),
      `Feat '${featSlug}' not found in catalog`,
    );
  }

  async assertLanguageSlug(slug: string): Promise<void> {
    requireCatalog(
      await this.languagesRepo.findOne({ where: { slug } }),
      `Language '${slug}' not found in catalog`,
    );
  }

  async assertAbilityGenerationMethodSlug(slug: string): Promise<void> {
    requireCatalog(
      await this.abilityMethodsRepo.findOne({ where: { slug } }),
      `Ability generation method '${slug}' not found in catalog`,
    );
  }

  async assertItemInCatalog(itemSlug: string): Promise<PhbItem> {
    return requireCatalog(
      await this.itemsRepo.findOne({ where: { slug: itemSlug } }),
      `Item '${itemSlug}' not found in catalog`,
    );
  }

  async assertSpellInCatalog(spellSlug: string): Promise<VPhbSpell> {
    return requireCatalog(
      await this.spellsRepo.findOne({ where: { slug: spellSlug } }),
      `Spell '${spellSlug}' not found in catalog`,
    );
  }

  async assertSubclassForClass(subclassSlug: string, classSlug: string): Promise<void> {
    requireCatalog(
      await this.subclassesRepo.findOne({ where: { subclassSlug, classSlug } }),
      `Subclass '${subclassSlug}' is not valid for class '${classSlug}'`,
    );
  }

  async validateCharacterCatalogRefs(input: {
    classSlug: string;
    speciesSlug: string;
    backgroundSlug: string;
    subclassSlug?: string | null;
    alignmentSlug?: string | null;
  }): Promise<void> {
    await Promise.all([
      this.assertClassSlug(input.classSlug),
      this.assertSpeciesSlug(input.speciesSlug),
      this.assertBackgroundSlug(input.backgroundSlug),
    ]);

    if (input.subclassSlug) {
      await this.assertSubclassForClass(input.subclassSlug, input.classSlug);
    }

    if (input.alignmentSlug) {
      await this.assertAlignmentSlug(input.alignmentSlug);
    }
  }

  async validateClassSkillChoices(classSlug: string, skillSlugs: string[]): Promise<void> {
    const phbClass = await this.findClassOrFail(classSlug);
    const expected = phbClass.skillChoiceCount ?? 0;

    if (skillSlugs.length !== expected) {
      throw new BadRequestException(
        `Class '${classSlug}' requires exactly ${expected} skill choice(s), got ${skillSlugs.length}`,
      );
    }

    if (expected === 0) return;

    assertUnique(skillSlugs, 'Duplicate skill choices are not allowed');

    const poolRows = await this.classSkillChoiceRepo.find({ where: { classSlug } });
    const pool = new Set(poolRows.map((row) => row.skillSlug));

    for (const slug of skillSlugs) {
      if (!pool.has(slug)) {
        throw new BadRequestException(
          `Skill '${slug}' is not in the choice pool for class '${classSlug}'`,
        );
      }
    }
  }
}
