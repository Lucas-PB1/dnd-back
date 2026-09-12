import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { requireCatalog } from '../common/assert';
import { requireFound } from '../common/require-found';
import { PhbCreatureTemplate } from '../entities/template/phb-creature-template.entity';
import { PhbVehicleTemplate } from '../entities/template/phb-vehicle-template.entity';

export async function findCreatureTemplateOrFail(
  repo: Repository<PhbCreatureTemplate>,
  slug: string,
): Promise<PhbCreatureTemplate> {
  return requireFound(
    await repo.findOne({ where: { slug } }),
    `Creature template '${slug}' not found in catalog`,
  );
}

export async function assertCreatureTemplateInCatalog(
  repo: Repository<PhbCreatureTemplate>,
  slug: string,
): Promise<PhbCreatureTemplate> {
  return requireCatalog(
    await repo.findOne({ where: { slug } }),
    `Creature template '${slug}' not found in catalog`,
  );
}

export async function findVehicleTemplateOrFail(
  repo: Repository<PhbVehicleTemplate>,
  slug: string,
): Promise<PhbVehicleTemplate> {
  return requireFound(
    await repo.findOne({ where: { slug } }),
    `Vehicle template '${slug}' not found in catalog`,
  );
}

export async function assertVehicleTemplateInCatalog(
  repo: Repository<PhbVehicleTemplate>,
  slug: string,
): Promise<PhbVehicleTemplate> {
  return requireCatalog(
    await repo.findOne({ where: { slug } }),
    `Vehicle template '${slug}' not found in catalog`,
  );
}

export async function resolveTransportActorKind(
  vehicleRepo: Repository<PhbVehicleTemplate>,
  creatureRepo: Repository<PhbCreatureTemplate>,
  templateSlug: string,
): Promise<'vehicle' | 'mount'> {
  const vehicle = await vehicleRepo.findOne({ where: { slug: templateSlug } });
  if (vehicle) return 'vehicle';

  const creature = await creatureRepo.findOne({ where: { slug: templateSlug } });
  if (creature) return 'mount';

  throw new NotFoundException(
    `Transport template '${templateSlug}' not found`,
  );
}
