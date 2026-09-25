import { DataSource } from 'typeorm';
import { BadRequestException } from '@nestjs/common';
import {
  isBeastEligibleForWildShape,
  WILD_SHAPE_BASE_CR_BANDS,
  type WildShapeCrBand,
} from '@game/combat/domain/druid/wild-shape-eligibility';
import { FEATURE_SCHEDULE_KEYS } from '@game/combat/domain/feature-schedule';

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
    { unlock_level: number; feature_key: string; value_num: number }[]
  >(
    `SELECT s.unlock_level, s.feature_key, s.value_num
     FROM rpg.phb_class_feature_schedule s
     JOIN rpg.phb_class c ON c.id = s.class_id
     WHERE c.slug = 'druid'
       AND s.feature_key IN ($1, $2)
     ORDER BY s.unlock_level ASC`,
    [
      FEATURE_SCHEDULE_KEYS.wildShapeCrMax,
      FEATURE_SCHEDULE_KEYS.wildShapeAllowFly,
    ],
  );
  if (rows.length === 0) {
    return [...WILD_SHAPE_BASE_CR_BANDS];
  }

  const byLevel = new Map<number, { crMax?: number; allowFly?: boolean }>();
  for (const row of rows) {
    const level = Number(row.unlock_level);
    let band = byLevel.get(level);
    if (!band) {
      band = {};
      byLevel.set(level, band);
    }
    if (row.feature_key === FEATURE_SCHEDULE_KEYS.wildShapeCrMax) {
      band.crMax = Number(row.value_num);
    } else if (row.feature_key === FEATURE_SCHEDULE_KEYS.wildShapeAllowFly) {
      band.allowFly = Number(row.value_num) > 0;
    }
  }

  const out: WildShapeCrBand[] = [];
  let lastCr = WILD_SHAPE_BASE_CR_BANDS[0]?.crMax ?? 0.25;
  let lastFly = false;
  for (const minLevel of [...byLevel.keys()].sort((a, b) => a - b)) {
    const band = byLevel.get(minLevel)!;
    if (band.crMax != null) lastCr = band.crMax;
    if (band.allowFly != null) lastFly = band.allowFly;
    if (band.crMax != null) {
      out.push({ minLevel, crMax: lastCr, allowFly: lastFly });
    } else if (out.length > 0) {
      out[out.length - 1] = { ...out[out.length - 1], allowFly: lastFly };
    }
  }

  return out.length > 0 ? out : [...WILD_SHAPE_BASE_CR_BANDS];
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
              SELECT 1 FROM rpg.phb_stat_block_speed s
              WHERE s.creature_template_slug = t.slug AND s.movement_kind = 'fly'
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
              SELECT 1 FROM rpg.phb_stat_block_speed s
              WHERE s.creature_template_slug = t.slug AND s.movement_kind = 'fly'
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
