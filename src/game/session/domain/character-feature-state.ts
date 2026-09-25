/**
 * Per-feature runtime state stored sparsely in `player_character_state.feature_state`.
 * Keys absent from the JSON mean "default"; a new class/subclass power adds a key here, not a column.
 */
export type CharacterFeatureState = {
  highElfCantripSwapAvailable: boolean;
  firearmChambers: Record<string, number>;
  rageActive: boolean;
  recklessActive: boolean;
  sacredWeaponActive: boolean;
  personaMasks: string[];
  bestialAspectLevel: number;
  missileShieldArmed: boolean;
  gigaMissileArmed: boolean;
  starryFormActive: boolean;
  stellarConstellation: string | null;
  wildShapeActive: boolean;
  wildShapeTemplateSlug: string | null;
  wildShapeKnownSlugs: string[];
  wildShapeFormSwapAvailable: boolean;
  aberrantMutationActive: string | null;
  skinriderTranceActive: boolean;
};

export type CharacterFeatureKey = keyof CharacterFeatureState;

export type StoredCharacterFeatureState = Partial<CharacterFeatureState>;

const DEFAULTS: CharacterFeatureState = {
  highElfCantripSwapAvailable: false,
  firearmChambers: {},
  rageActive: false,
  recklessActive: false,
  sacredWeaponActive: false,
  personaMasks: [],
  bestialAspectLevel: 0,
  missileShieldArmed: false,
  gigaMissileArmed: false,
  starryFormActive: false,
  stellarConstellation: null,
  wildShapeActive: false,
  wildShapeTemplateSlug: null,
  wildShapeKnownSlugs: [],
  wildShapeFormSwapAvailable: true,
  aberrantMutationActive: null,
  skinriderTranceActive: false,
};

export const CHARACTER_FEATURE_KEYS = Object.keys(DEFAULTS) as CharacterFeatureKey[];

function cloneDefault<K extends CharacterFeatureKey>(key: K): CharacterFeatureState[K] {
  const value = DEFAULTS[key];
  if (Array.isArray(value)) return [...value] as CharacterFeatureState[K];
  if (value !== null && typeof value === 'object') {
    return { ...value } as CharacterFeatureState[K];
  }
  return value;
}

function isDefault<K extends CharacterFeatureKey>(
  key: K,
  value: CharacterFeatureState[K],
): boolean {
  const def = DEFAULTS[key];
  if (Array.isArray(def)) return Array.isArray(value) && value.length === 0;
  if (def !== null && typeof def === 'object') {
    return value !== null && typeof value === 'object' && Object.keys(value).length === 0;
  }
  return value === def;
}

export function readFeature<K extends CharacterFeatureKey>(
  stored: StoredCharacterFeatureState | null | undefined,
  key: K,
): CharacterFeatureState[K] {
  const value = stored?.[key];
  return isMissing(key, value) ? cloneDefault(key) : (value as CharacterFeatureState[K]);
}

function isMissing(key: CharacterFeatureKey, value: unknown): boolean {
  return value === undefined || (value === null && DEFAULTS[key] !== null);
}

/** Returns a new sparse map; default values are dropped from the JSON. */
export function writeFeature<K extends CharacterFeatureKey>(
  stored: StoredCharacterFeatureState | null | undefined,
  key: K,
  value: CharacterFeatureState[K] | null | undefined,
): StoredCharacterFeatureState {
  const next: StoredCharacterFeatureState = { ...(stored ?? {}) };
  if (isMissing(key, value) || isDefault(key, value as CharacterFeatureState[K])) {
    delete next[key];
  } else {
    next[key] = value as CharacterFeatureState[K];
  }
  return next;
}
