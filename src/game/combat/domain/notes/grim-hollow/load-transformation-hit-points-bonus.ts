import type { DataSource } from 'typeorm';
import { hitPointsBonus } from '@game/sheet/domain/stats/hit-points.calc';
import { choiceKindForOptionKey } from '@catalog/game-port';

type TransformationHpInput = {
  slug: string;
  choices?: readonly { choiceKind: string; choiceSlug: string }[];
};

type HpBonusRow = {
  flat_bonus: string | number;
  per_level_bonus: string | number;
  from_level: string | number;
  requires_option_key: string | null;
  requires_option_value: string | null;
};

/** Bônus de PV máx. de combat_mod da transformação Cap. 6 (gated por escolha). */
export async function loadTransformationHitPointsBonus(
  dataSource: DataSource,
  transformation: TransformationHpInput | null | undefined,
  level: number,
): Promise<number> {
  const slug = transformation?.slug?.trim();
  if (!slug) return 0;

  const rows = await dataSource.query<HpBonusRow[]>(
    `SELECT flat_bonus, per_level_bonus, from_level,
            requires_option_key, requires_option_value
     FROM rpg.mv_phb_hp_bonus_source
     WHERE source_kind = 'feat' AND source_slug = $1`,
    [slug],
  );

  const choices = transformation?.choices ?? [];
  const sources = rows
    .filter((row) => matchesOptionGate(row, choices))
    .map((row) => ({
      label: slug,
      flat: Number(row.flat_bonus) || 0,
      perLevel: Number(row.per_level_bonus) || 0,
      fromLevel: Number(row.from_level) || 1,
    }));

  return hitPointsBonus(level, sources);
}

function matchesOptionGate(
  row: HpBonusRow,
  choices: readonly { choiceKind: string; choiceSlug: string }[],
): boolean {
  if (!row.requires_option_key || !row.requires_option_value) return true;
  const choiceKind = choiceKindForOptionKey(row.requires_option_key);
  return choices.some(
    (choice) =>
      choice.choiceKind === choiceKind &&
      choice.choiceSlug === row.requires_option_value,
  );
}
