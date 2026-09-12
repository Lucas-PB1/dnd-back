import { parseInstanceProperties } from './roll-artifact-instance';
import type { ArtifactInstanceProperties } from './artifact-instance.types';

export function clearArtifactRandomForReroll(
  instanceProperties: unknown,
): ArtifactInstanceProperties {
  const parsed = parseInstanceProperties(instanceProperties) ?? {};
  const next: ArtifactInstanceProperties = { ...parsed };
  delete next.artifactRandom;
  delete next.abilityPenalties;
  return next;
}
