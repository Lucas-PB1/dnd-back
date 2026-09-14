import { DataSource } from 'typeorm';
import { BadRequestException } from '@nestjs/common';
import {
  isBeastEligibleForWildShape,
  parseChallengeRating,
  WILD_SHAPE_BASE_CR_BANDS,
  type WildShapeCrBand,
} from '@game/combat/domain/druid/wild-shape-eligibility';

export type WildShapeTemplateRow = {
  slug: string;
  name: string;
  creatureType: string;
  challengeRating: string | null;
  armorClass: number | null;
  hasFlySpeed: boolean;
};

export async function loadWildShapeCrBands(
  dataSource: DataSource,
): Promise<WildShapeCrBand[]> {
  const rows = await dataSource.query<
    { min_level: number; cr_max: string; allow_fly: boolean }[]
  >(
    `SELECT min_level, cr_max, allow_fly
     FROM rpg.phb_wild_shape_cr_band
     ORDER BY min_level ASC`,
  );
  if (rows.length === 0) {
    return [...WILD_SHAPE_BASE_CR_BANDS];
  }
  return rows.map((row) => {
    const crMax = parseChallengeRating(row.cr_max);
    if (crMax == null) {
      throw new BadRequestException(
        `phb_wild_shape_cr_band.cr_max inválido: ${row.cr_max}`,
      );
    }
    return {
      minLevel: row.min_level,
      crMax,
      allowFly: row.allow_fly,
    };
  });
}

export async function loadWildShapeTemplateRow(
  dataSource: DataSource,
  templateSlug: string,
): Promise<WildShapeTemplateRow | null> {
  const rows = await dataSource.query<
    {
      slug: string;
      name: string;
      creature_type: string;
      challenge_rating: string | null;
      armor_class: number | null;
      has_fly: boolean;
    }[]
  >(
    `SELECT t.slug, t.name, t.creature_type, t.challenge_rating, t.armor_class,
            EXISTS (
              SELECT 1 FROM rpg.phb_creature_template_speed s
              WHERE s.template_slug = t.slug AND s.movement_kind = 'fly'
            ) AS has_fly
     FROM rpg.phb_creature_template t
     WHERE t.slug = $1`,
    [templateSlug],
  );
  const row = rows[0];
  if (!row) return null;
  return {
    slug: row.slug,
    name: row.name,
    creatureType: row.creature_type,
    challengeRating: row.challenge_rating,
    armorClass: row.armor_class,
    hasFlySpeed: Boolean(row.has_fly),
  };
}

export async function assertWildShapeTemplateEligible(
  dataSource: DataSource,
  input: {
    templateSlug: string;
    level: number;
    moon?: boolean;
  },
): Promise<WildShapeTemplateRow> {
  const template = await loadWildShapeTemplateRow(
    dataSource,
    input.templateSlug,
  );
  if (!template) {
    throw new BadRequestException(
      `Template '${input.templateSlug}' não encontrado no catálogo`,
    );
  }
  const bands = await loadWildShapeCrBands(dataSource);
  const ok = isBeastEligibleForWildShape({
    creatureType: template.creatureType,
    challengeRating: template.challengeRating,
    hasFlySpeed: template.hasFlySpeed,
    level: input.level,
    moon: input.moon,
    bands,
  });
  if (!ok) {
    throw new BadRequestException(
      `Besta '${input.templateSlug}' não é elegível para Forma Selvagem neste nível` +
        (input.moon ? ' (Lua)' : ''),
    );
  }
  return template;
}

export async function listEligibleWildShapeBeasts(
  dataSource: DataSource,
  input: { level: number; moon?: boolean },
): Promise<WildShapeTemplateRow[]> {
  const bands = await loadWildShapeCrBands(dataSource);
  const rows = await dataSource.query<
    {
      slug: string;
      name: string;
      creature_type: string;
      challenge_rating: string | null;
      armor_class: number | null;
      has_fly: boolean;
    }[]
  >(
    `SELECT t.slug, t.name, t.creature_type, t.challenge_rating, t.armor_class,
            EXISTS (
              SELECT 1 FROM rpg.phb_creature_template_speed s
              WHERE s.template_slug = t.slug AND s.movement_kind = 'fly'
            ) AS has_fly
     FROM rpg.phb_creature_template t
     WHERE lower(t.creature_type) = 'beast'
     ORDER BY t.name ASC, t.slug ASC`,
  );
  return rows
    .map((row) => ({
      slug: row.slug,
      name: row.name,
      creatureType: row.creature_type,
      challengeRating: row.challenge_rating,
      armorClass: row.armor_class,
      hasFlySpeed: Boolean(row.has_fly),
    }))
    .filter((row) =>
      isBeastEligibleForWildShape({
        creatureType: row.creatureType,
        challengeRating: row.challengeRating,
        hasFlySpeed: row.hasFlySpeed,
        level: input.level,
        moon: input.moon,
        bands,
      }),
    );
}
