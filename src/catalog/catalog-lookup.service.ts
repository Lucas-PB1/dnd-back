import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';

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
  ) {}

  async findClassOrFail(classSlug: string): Promise<VPhbClass> {
    const row = await this.classesRepo.findOne({ where: { classSlug } });
    if (!row) {
      throw new NotFoundException(`Class '${classSlug}' not found`);
    }
    return row;
  }

  async findSpeciesOrFail(speciesSlug: string): Promise<PhbSpecies> {
    const row = await this.speciesRepo.findOne({ where: { slug: speciesSlug } });
    if (!row) {
      throw new NotFoundException(`Species '${speciesSlug}' not found`);
    }
    return row;
  }

  async findBackgroundOrFail(backgroundSlug: string): Promise<VPhbBackground> {
    const row = await this.backgroundsRepo.findOne({ where: { backgroundSlug } });
    if (!row) {
      throw new NotFoundException(`Background '${backgroundSlug}' not found`);
    }
    return row;
  }

  async assertClassSlug(classSlug: string): Promise<void> {
    const exists = await this.classesRepo.findOne({ where: { classSlug } });
    if (!exists) {
      throw new BadRequestException(`Class '${classSlug}' not found in catalog`);
    }
  }

  async assertSpeciesSlug(speciesSlug: string): Promise<void> {
    const exists = await this.speciesRepo.findOne({ where: { slug: speciesSlug } });
    if (!exists) {
      throw new BadRequestException(`Species '${speciesSlug}' not found in catalog`);
    }
  }

  async assertBackgroundSlug(backgroundSlug: string): Promise<void> {
    const exists = await this.backgroundsRepo.findOne({ where: { backgroundSlug } });
    if (!exists) {
      throw new BadRequestException(`Background '${backgroundSlug}' not found in catalog`);
    }
  }

  async assertAlignmentSlug(alignmentSlug: string): Promise<void> {
    const exists = await this.alignmentsRepo.findOne({ where: { slug: alignmentSlug } });
    if (!exists) {
      throw new BadRequestException(`Alignment '${alignmentSlug}' not found in catalog`);
    }
  }

  async assertSubclassForClass(subclassSlug: string, classSlug: string): Promise<void> {
    const row = await this.subclassesRepo.findOne({ where: { subclassSlug, classSlug } });
    if (!row) {
      throw new BadRequestException(
        `Subclass '${subclassSlug}' is not valid for class '${classSlug}'`,
      );
    }
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
}
