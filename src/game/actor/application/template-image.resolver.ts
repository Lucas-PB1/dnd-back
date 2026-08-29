import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import { PhbVehicleTemplate } from '@entities/phb-vehicle-template.entity';

@Injectable()
export class TemplateImageResolver {
  constructor(
    @InjectRepository(PhbCreatureTemplate)
    private readonly creatureTemplates: Repository<PhbCreatureTemplate>,
    @InjectRepository(PhbVehicleTemplate)
    private readonly vehicleTemplates: Repository<PhbVehicleTemplate>,
  ) {}

  async resolve(templateSlug: string | null): Promise<string | null> {
    if (!templateSlug?.trim()) return null;
    const slug = templateSlug.trim();

    const creature = await this.creatureTemplates.findOne({
      where: { slug },
      select: { imageUrl: true },
    });
    if (creature?.imageUrl) return creature.imageUrl;

    const vehicle = await this.vehicleTemplates.findOne({
      where: { slug },
      select: { imageUrl: true },
    });
    return vehicle?.imageUrl ?? null;
  }
}
