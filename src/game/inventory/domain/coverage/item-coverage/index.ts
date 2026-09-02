/** Cobertura DMG (`properties.kind = coverage`) — parse e matching. */

export {
  COVERAGE_APPLIES_TO,
  coverageBonusToEffects,
  coverageRequiresTierBonus,
  normalizeCoverageText,
  parseItemCoverage,
  type CoverageAppliesTo,
  type CoverageBaseContext,
  type ItemCoverage,
} from './parse';
export { isAmmunitionBase } from './ammunition';
export { coverageMatchesBase } from './match';
