import type { DataSource } from 'typeorm';
import type {
  Cap6StageMode,
  Cap6TransformationRule,
} from '@game/sheet/domain/transformation/cap6-choice-rules/types';

const STAGE_MODES = new Set<Cap6StageMode>([
  'auto_all',
  'pick1',
  'pick2',
  'fixed_plus_pick1',
  'auto_single',
]);

function asStageMode(raw: string): Cap6StageMode {
  if (!STAGE_MODES.has(raw as Cap6StageMode)) {
    throw new Error(`Unknown transformation_stage_mode '${raw}'`);
  }
  return raw as Cap6StageMode;
}

export async function loadTransformationChoiceRule(
  dataSource: DataSource,
  transformationSlug: string,
): Promise<Cap6TransformationRule | null> {
  const slug = transformationSlug.trim();
  if (!slug) return null;

  const stages = await dataSource.query<
    Array<{
      stage: number;
      mode: string;
      stage_rule_id: string;
    }>
  >(
    `SELECT r.stage, r.mode::text AS mode, r.id::text AS stage_rule_id
     FROM rpg.phb_transformation_stage_rule r
     JOIN rpg.phb_feat f ON f.id = r.feat_id
     WHERE f.slug = $1
     ORDER BY r.stage`,
    [slug],
  );
  if (stages.length === 0) return null;

  const stageRuleIds = stages.map((s) => s.stage_rule_id);
  const autos = await dataSource.query<
    Array<{ stage_rule_id: string; boon_id: string; sort_order: number }>
  >(
    `SELECT stage_rule_id::text AS stage_rule_id, boon_id, sort_order
     FROM rpg.phb_transformation_stage_auto_boon
     WHERE stage_rule_id = ANY($1::bigint[])
     ORDER BY sort_order, boon_id`,
    [stageRuleIds],
  );
  const picks = await dataSource.query<
    Array<{ stage_rule_id: string; pick_key: string; sort_order: number }>
  >(
    `SELECT stage_rule_id::text AS stage_rule_id, pick_key, sort_order
     FROM rpg.phb_transformation_stage_pick_key
     WHERE stage_rule_id = ANY($1::bigint[])
     ORDER BY sort_order, pick_key`,
    [stageRuleIds],
  );

  const autosByRule = new Map<string, string[]>();
  for (const row of autos) {
    const list = autosByRule.get(row.stage_rule_id) ?? [];
    list.push(row.boon_id);
    autosByRule.set(row.stage_rule_id, list);
  }
  const picksByRule = new Map<string, string[]>();
  for (const row of picks) {
    const list = picksByRule.get(row.stage_rule_id) ?? [];
    list.push(row.pick_key);
    picksByRule.set(row.stage_rule_id, list);
  }

  const stageMap: Cap6TransformationRule['stages'] = {};
  for (const row of stages) {
    stageMap[String(row.stage)] = {
      mode: asStageMode(row.mode),
      autoBoons: autosByRule.get(row.stage_rule_id) ?? [],
      pickKeys: picksByRule.get(row.stage_rule_id) ?? [],
    };
  }

  const subs = await dataSource.query<
    Array<{
      option_key: string;
      from_stage: number;
      when_choice_key: string | null;
      when_choice_value: string | null;
    }>
  >(
    `SELECT s.option_key, s.from_stage, s.when_choice_key, s.when_choice_value
     FROM rpg.phb_transformation_sub_option s
     JOIN rpg.phb_feat f ON f.id = s.feat_id
     WHERE f.slug = $1
     ORDER BY s.from_stage, s.option_key`,
    [slug],
  );

  const matches = await dataSource.query<
    Array<{
      match_id: string;
      later_key: string;
      earlier_key: string;
    }>
  >(
    `SELECT m.id::text AS match_id, m.later_key, m.earlier_key
     FROM rpg.phb_transformation_require_match m
     JOIN rpg.phb_feat f ON f.id = m.feat_id
     WHERE f.slug = $1
     ORDER BY m.id`,
    [slug],
  );

  const matchIds = matches.map((m) => m.match_id);
  const pairs =
    matchIds.length === 0
      ? []
      : await dataSource.query<
          Array<{
            match_id: string;
            earlier_value: string;
            later_value: string;
          }>
        >(
          `SELECT match_id::text AS match_id, earlier_value, later_value
           FROM rpg.phb_transformation_require_match_pair
           WHERE match_id = ANY($1::bigint[])
           ORDER BY earlier_value`,
          [matchIds],
        );

  const pairsByMatch = new Map<string, Record<string, string>>();
  for (const row of pairs) {
    const map = pairsByMatch.get(row.match_id) ?? {};
    map[row.earlier_value] = row.later_value;
    pairsByMatch.set(row.match_id, map);
  }

  return {
    stages: stageMap,
    subOptions: subs.map((s) => ({
      key: s.option_key,
      fromStage: Number(s.from_stage),
      ...(s.when_choice_key && s.when_choice_value
        ? {
            whenChoice: {
              key: s.when_choice_key,
              value: s.when_choice_value,
            },
          }
        : {}),
      values: [],
    })),
    requireMatch: matches.map((m) => ({
      laterKey: m.later_key,
      earlierKey: m.earlier_key,
      pairs: pairsByMatch.get(m.match_id) ?? {},
    })),
  };
}
