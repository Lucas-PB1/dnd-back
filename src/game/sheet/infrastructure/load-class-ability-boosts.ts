import type { DataSource } from 'typeorm';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  applyClassAbilityBoosts,
  type ClassAbilityBoostRow,
} from '../domain/stats/class-ability-boost';

type ClassAbilityBoostQueryRow = {
  ability_slug: string;
  label: string;
  bonus: number;
  score_max: number;
  from_level: number;
};

/**
 * Lê os aumentos permanentes de atributo por classe (`v_phb_class_ability_boost`)
 * para a classe informada. A regra de qual classe/nível concede o bônus vive no
 * banco; o teto próprio e o nível são aplicados por `applyClassAbilityBoosts`.
 */
export async function loadClassAbilityBoosts(
  dataSource: DataSource,
  classSlug: string | null | undefined,
): Promise<ClassAbilityBoostRow[]> {
  if (!classSlug) return [];
  const rows = await dataSource.query<ClassAbilityBoostQueryRow[]>(
    `SELECT ability_slug, label, bonus, score_max, from_level
     FROM rpg.v_phb_class_ability_boost
     WHERE class_slug = $1`,
    [classSlug],
  );
  return rows.map((row) => ({
    ability: row.ability_slug as keyof AbilityScores,
    label: row.label,
    bonus: Number(row.bonus),
    scoreMax: Number(row.score_max),
    fromLevel: Number(row.from_level),
  }));
}

/** Atributos base já com os aumentos permanentes de classe aplicados. */
export async function resolveEffectiveAbilityScores(
  dataSource: DataSource,
  classSlug: string | null | undefined,
  level: number,
  scores: AbilityScores,
): Promise<AbilityScores> {
  const rows = await loadClassAbilityBoosts(dataSource, classSlug);
  return applyClassAbilityBoosts(scores, level, rows).scores;
}
