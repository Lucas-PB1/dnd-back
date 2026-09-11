import { DataSource } from 'typeorm';
import { PhbSpecies } from '@entities/phb-species.entity';
import { PhbSpeciesArmorPreset } from '@entities/phb-species-armor-preset.entity';
import { PhbOptionValue } from '@entities/phb-option.entity';
import type { SpeciesArmorPresetRow } from '../../domain/species/manikin-armor';

export async function loadSpeciesArmorPresets(
  dataSource: DataSource,
  speciesSlug: string | null | undefined,
): Promise<SpeciesArmorPresetRow[]> {
  if (!speciesSlug) return [];
  const species = await dataSource.getRepository(PhbSpecies).findOne({
    where: { slug: speciesSlug },
    select: ['id'],
  });
  if (!species) return [];
  const rows = await dataSource.getRepository(PhbSpeciesArmorPreset).find({
    where: { speciesId: species.id },
    order: { presetSlug: 'ASC' },
  });
  return rows.map((row) => ({
    presetSlug: row.presetSlug,
    label: row.label,
    baseAc: row.baseAc,
    abilityASlug: row.abilityASlug,
    abilityACap: row.abilityACap,
    abilityBSlug: row.abilityBSlug,
    abilityBCap: row.abilityBCap,
    pickMode: row.pickMode,
    countsAsWornArmor: row.countsAsWornArmor,
  }));
}

/** Mapa `optionKey:valueId` → damage_type slug EN. */
export async function loadSpeciesOptionDamageTypes(
  dataSource: DataSource,
  speciesSlug: string | null | undefined,
): Promise<ReadonlyMap<string, string>> {
  const map = new Map<string, string>();
  if (!speciesSlug) return map;
  const species = await dataSource.getRepository(PhbSpecies).findOne({
    where: { slug: speciesSlug },
    select: ['id'],
  });
  if (!species) return map;
  const rows = await dataSource.getRepository(PhbOptionValue).find({
    where: { scope: 'species', ownerId: species.id },
    select: ['optionKey', 'valueId', 'damageType'],
  });
  for (const row of rows) {
    const type = row.damageType?.trim();
    if (!type) continue;
    map.set(`${row.optionKey}:${row.valueId}`, type);
  }
  return map;
}
