export type { Rng } from './roll-instance/artifact-roll-rng';
export { rollD100 } from './roll-instance/artifact-roll-rng';
export type { PickSpellByLevel } from './roll-instance/materialize-rolled-effect';
export { materializeRolledEffect } from './roll-instance/materialize-rolled-effect';
export {
  parseArtifactRandomQuota,
  parseCatalogSentience,
  parseInstanceProperties,
  needsArtifactInstanceRoll,
} from './roll-instance/parse-artifact-instance';
export {
  rollArtifactRandomProperties,
  buildArtifactInstanceProperties,
} from './roll-instance/build-artifact-instance';
