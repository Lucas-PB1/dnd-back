import { DataSource } from 'typeorm';
import {
  PhbCreatureScaleByLevel,
  PhbCreatureScaleBySlot,
} from '@entities/template/phb-creature-scale.entity';

export async function loadScaleByLevel(
  dataSource: DataSource,
  templateSlug: string,
): Promise<PhbCreatureScaleByLevel | null> {
  return dataSource.getRepository(PhbCreatureScaleByLevel).findOne({
    where: { templateSlug },
  });
}

export async function loadScaleBySlot(
  dataSource: DataSource,
  templateSlug: string,
): Promise<PhbCreatureScaleBySlot | null> {
  return dataSource.getRepository(PhbCreatureScaleBySlot).findOne({
    where: { templateSlug },
  });
}
