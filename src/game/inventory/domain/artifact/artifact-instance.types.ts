/** Quota de props aleatórias declarada em phb_item.properties.artifactRandomQuota. */
export type ArtifactRandomQuota = {
  minorBeneficial: number;
  majorBeneficial: number;
  minorDetrimental: number;
  majorDetrimental: number;
};

export type ArtifactRandomBucket =
  | 'minorBeneficial'
  | 'majorBeneficial'
  | 'minorDetrimental'
  | 'majorDetrimental';

export type ArtifactSpellEffect = {
  type: 'artifactSpell';
  spellLevel: number;
  spellSlug?: string;
  /** Gasto até o próximo descanso longo (MVP ≈ amanhecer). */
  spentUntilLongRest?: boolean;
  spellSaveDc?: number;
};

export type ArtifactRegenEffect = {
  type: 'artifactRegen';
  dice: string;
};

export type ArtifactAbilityPenaltyEffect = {
  type: 'abilityPenalty';
  amount: number;
  ability?: string;
};

export type ArtifactRandomEffect =
  | {
      type: 'permanentEffects';
      permanentEffects: Record<string, unknown>;
    }
  | {
      type: 'reminder';
      text: string;
    }
  | ArtifactSpellEffect
  | ArtifactRegenEffect
  | ArtifactAbilityPenaltyEffect;

export type ArtifactRandomTableRow = {
  kind:
    | 'minor_beneficial'
    | 'major_beneficial'
    | 'minor_detrimental'
    | 'major_detrimental';
  rollMin: number;
  rollMax: number;
  slug: string;
  summaryPt: string;
  effect: ArtifactRandomEffect | Record<string, unknown>;
};

export type RolledArtifactProperty = {
  slug: string;
  summaryPt: string;
  roll: number;
  effect: ArtifactRandomEffect | Record<string, unknown>;
};

export type ArtifactRandomRollResult = {
  rolledAt: string;
  minorBeneficial: RolledArtifactProperty[];
  majorBeneficial: RolledArtifactProperty[];
  minorDetrimental: RolledArtifactProperty[];
  majorDetrimental: RolledArtifactProperty[];
};

export type CatalogSentience = {
  alignment?: string;
  inteligencia?: number;
  sabedoria?: number;
  carisma?: number;
  senses?: string;
  communication?: string;
  languages?: string[];
  purpose?: string;
  purposeSummary?: string;
  [key: string]: unknown;
};

/** Penalidades one-shot (ex. major detrimental −2) até Restauração Maior. */
export type ArtifactAbilityPenalties = Partial<
  Record<
    | 'forca'
    | 'destreza'
    | 'constituicao'
    | 'inteligencia'
    | 'sabedoria'
    | 'carisma',
    number
  >
>;

export type ArtifactInstanceProperties = {
  artifactRandom?: ArtifactRandomRollResult;
  sentience?: CatalogSentience;
  /** Valores negativos (ex. forca: -2). Persistentes até Restauração Maior. */
  abilityPenalties?: ArtifactAbilityPenalties;
};

export type SentientTraitTableRow = {
  kind:
    | 'alignment'
    | 'communication'
    | 'senses'
    | 'special_purpose'
    | 'ability_scores';
  rollMin: number;
  rollMax: number;
  slug: string;
  summaryPt: string;
  payload: Record<string, unknown>;
};

export type RolledSentience = {
  alignment: string;
  alignmentSlug: string;
  communication: string;
  communicationSlug: string;
  senses: string;
  sensesSlug: string;
  purpose: string;
  purposeSlug: string;
  purposeSummary: string;
  inteligencia: number;
  sabedoria: number;
  carisma: number;
};

export const ARTIFACT_RANDOM_SPELL_SAVE_DC = 18;
export const ARTIFACT_ABILITY_FLOOR = 3;
