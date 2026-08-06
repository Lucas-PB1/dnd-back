/**
 * Manobras do Pistoleiro (Valdas) — tipos e lookups.
 * Catálogo: `rpg.phb_gunslinger_maneuver` / `v_phb_gunslinger_maneuver`.
 */

export type ManeuverEffectKind =
  | 'temp_hp'
  | 'miss_damage'
  | 'ac_bonus'
  | 'ability_check_bonus'
  | 'descriptive'
  | 'reload_move';

export type GunslingerManeuver = {
  slug: string;
  name: string;
  description: string;
  effectKind: ManeuverEffectKind;
  riskCost: number;
  fromLevel: number;
  /** Subclasse que concede (omitido = classe base). */
  subclassSlug?: string;
};

export function listGunslingerManeuvers(
  catalog: readonly GunslingerManeuver[],
  input: { level: number; subclassSlug?: string | null },
): GunslingerManeuver[] {
  return catalog.filter((maneuver) => {
    if (input.level < maneuver.fromLevel) return false;
    if (maneuver.subclassSlug && maneuver.subclassSlug !== input.subclassSlug) {
      return false;
    }
    return true;
  });
}

export function findGunslingerManeuver(
  catalog: readonly GunslingerManeuver[],
  slug: string,
): GunslingerManeuver | undefined {
  return catalog.find((maneuver) => maneuver.slug === slug);
}
