import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { assertUnique, requireCatalog } from '../common/assert';
import { requireFound } from '../common/require-found';
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

  async findHeritageOrFail(heritageSlug: string): Promise<PhbHeritage> {
    return requireFound(
      await this.heritageRepo.findOne({ where: { slug: heritageSlug } }),
      `Heritage '${heritageSlug}' not found`,
    );
  }

  async assertHeritageSlug(heritageSlug: string): Promise<void> {
    requireCatalog(
      await this.heritageRepo.findOne({ where: { slug: heritageSlug } }),
      `Heritage '${heritageSlug}' not found in catalog`,
    );
  }

  async findPlayableSpeciesOrFail(speciesSlug: string): Promise<PhbSpecies> {
    const row = await this.findSpeciesOrFail(speciesSlug);
    if (isNonPlayableSpecies(row)) {
      throw new BadRequestException(
        `Species '${speciesSlug}' is not a playable species`,
      );
    }
    return row;
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
    await this.assertPlayableSpeciesSlug(speciesSlug);
  }

  async assertPlayableSpeciesSlug(speciesSlug: string): Promise<void> {
    const row = await this.speciesRepo.findOne({ where: { slug: speciesSlug } });
    const species = requireCatalog(
      row,
      `Species '${speciesSlug}' not found in catalog`,
    );
    if (isTraitPackageSpecies(species)) {
      throw new BadRequestException(
        `Species '${speciesSlug}' is not a playable species`,
      );
    }
    if (isCatalogOnlySpecies(species)) {
      throw new BadRequestException(
        `Species '${speciesSlug}' is catalog-only and not playable`,
      );
    }
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

  async findEpicBoonFeatSlugs(): Promise<Set<string>> {
    const rows = await this.featsRepo.find({
      where: { categorySlug: 'epic-boon' },
    });
    return new Set(rows.map((row) => row.featSlug));
  }

  async assertLanguageSlug(slug: string): Promise<void> {
    await this.findLanguageOrFail(slug);
  }

  async findLanguageOrFail(slug: string): Promise<PhbLanguage> {
    return requireCatalog(
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

  async assertSkillInCatalog(skillSlug: string): Promise<void> {
    requireCatalog(
      await this.skillsRepo.findOne({ where: { slug: skillSlug } }),
      `Skill '${skillSlug}' not found in catalog`,
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
    speciesSlug?: string | null;
    heritageSlug?: string | null;
    backgroundSlug: string;
    subclassSlug?: string | null;
    alignmentSlug?: string | null;
  }): Promise<void> {
    const originChecks: Promise<void>[] = [
      this.assertClassSlug(input.classSlug),
      this.assertBackgroundSlug(input.backgroundSlug),
    ];
    if (input.heritageSlug?.trim()) {
      originChecks.push(this.assertHeritageSlug(input.heritageSlug.trim()));
    } else if (input.speciesSlug?.trim()) {
      originChecks.push(this.assertSpeciesSlug(input.speciesSlug.trim()));
    } else {
      throw new BadRequestException('speciesSlug or heritageSlug is required');
    }
    await Promise.all(originChecks);

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

    // Bard (e similares): pool aberto — qualquer perícia do catálogo.
    if (phbClass.skillChoiceFrom === 'any') {
      for (const slug of skillSlugs) {
        await this.assertSkillInCatalog(slug);
      }
      return;
    }

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

function isTraitPackageSpecies(row: PhbSpecies): boolean {
  const raw = row.sourceMeta?.variantOf;
  return typeof raw === 'string' && raw.trim().length > 0;
}

function isCatalogOnlySpecies(row: PhbSpecies): boolean {
  const raw = row.sourceMeta?.catalogOnly;
  return raw === true || raw === 'true' || raw === 1 || raw === '1';
}

function isNonPlayableSpecies(row: PhbSpecies): boolean {
  return isTraitPackageSpecies(row) || isCatalogOnlySpecies(row);
}
