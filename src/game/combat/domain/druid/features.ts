export function isDruidClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'druid';
}

export function moonWildShapeTempHp(level: number): number {
  return 3 * level;
}

export {
  allowsWildShapeFly,
  baseWildShapeTempHp,
  isBeastEligibleForWildShape,
  maxWildShapeCr,
  moonWildShapeArmorClassFloor,
  parseChallengeRating,
  resolveWildShapeBand,
  WILD_SHAPE_BASE_CR_BANDS,
} from './wild-shape-eligibility';
export type { WildShapeCrBand } from './wild-shape-eligibility';

export function starryFormDice(level: number): string {
  return level >= 10 ? '2d8' : '1d8';
}
