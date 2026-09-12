import { DataSource } from 'typeorm';
import {
  PhbSpellSpirit,
  PhbSpellSpiritVariant,
} from '@entities/spirit/phb-spell-spirit.entity';

export type SpellSpiritProfile = {
  spellSlug: string;
  actorKind: 'mount' | 'companion';
  replacePolicy: 'replace_same_spell';
  flySpeedMinSlot: number | null;
};

export type SpellSpiritVariantRow = {
  variantKey: string;
  templateSlug: string;
  label: string;
};

export async function loadSpellSpiritProfile(
  dataSource: DataSource,
  spellSlug: string,
): Promise<SpellSpiritProfile | null> {
  const row = await dataSource.getRepository(PhbSpellSpirit).findOne({
    where: { spellSlug },
  });
  if (!row) return null;
  return {
    spellSlug: row.spellSlug,
    actorKind: row.actorKind,
    replacePolicy: row.replacePolicy,
    flySpeedMinSlot: row.flySpeedMinSlot,
  };
}

export async function loadSpellSpiritVariants(
  dataSource: DataSource,
  spellSlug: string,
): Promise<SpellSpiritVariantRow[]> {
  const rows = await dataSource.getRepository(PhbSpellSpiritVariant).find({
    where: { spellSlug },
    order: { id: 'ASC' },
  });
  return rows.map((row) => ({
    variantKey: row.variantKey,
    templateSlug: row.templateSlug,
    label: row.label,
  }));
}
