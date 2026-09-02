import type {
  ArtifactRandomQuota,
  ArtifactInstanceProperties,
  CatalogSentience,
} from '../artifact-instance.types';

export function parseArtifactRandomQuota(
  properties: Record<string, unknown> | null | undefined,
): ArtifactRandomQuota | null {
  const raw = properties?.artifactRandomQuota;
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null;
  const source = raw as Record<string, unknown>;
  const quota: ArtifactRandomQuota = {
    minorBeneficial: Number(source.minorBeneficial ?? 0) || 0,
    majorBeneficial: Number(source.majorBeneficial ?? 0) || 0,
    minorDetrimental: Number(source.minorDetrimental ?? 0) || 0,
    majorDetrimental: Number(source.majorDetrimental ?? 0) || 0,
  };
  if (
    quota.minorBeneficial +
      quota.majorBeneficial +
      quota.minorDetrimental +
      quota.majorDetrimental ===
    0
  ) {
    return null;
  }
  return quota;
}

export function parseCatalogSentience(
  properties: Record<string, unknown> | null | undefined,
): CatalogSentience | null {
  const raw = properties?.sentience;
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null;
  return raw as CatalogSentience;
}

export function parseInstanceProperties(
  value: unknown,
): ArtifactInstanceProperties | null {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return null;
  return value as ArtifactInstanceProperties;
}

export function needsArtifactInstanceRoll(
  catalogProperties: Record<string, unknown> | null | undefined,
  instanceProperties: unknown,
): boolean {
  const quota = parseArtifactRandomQuota(catalogProperties);
  const catalogSentience = parseCatalogSentience(catalogProperties);
  if (!quota && !catalogSentience) return false;
  const instance = parseInstanceProperties(instanceProperties) ?? {};
  if (quota && !instance.artifactRandom) return true;
  if (catalogSentience && !instance.sentience) return true;
  return false;
}
