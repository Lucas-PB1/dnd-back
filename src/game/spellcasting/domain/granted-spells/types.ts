import type {
  CharacterFeatDto,
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';

export type CharacterSpellSource = 'class' | 'subclass' | 'feat' | 'species';

/** Linha do catálogo `v_phb_species_granted_spell`. */
export type SpeciesGrantedSpellRow = {
  speciesSlug: string;
  choiceKind: string | null;
  choiceSlug: string | null;
  unlockLevel: number;
  spellSlug: string;
};

/** Linha do catálogo `v_phb_feat_granted_spell`. */
export type FeatGrantedSpellRow = {
  featSlug: string;
  spellSlug: string;
};

/** Magia always_prepared com nível de desbloqueio (classe ou subclasse). */
export type UnlockLevelGrantedSpellRow = {
  unlockLevel: number;
  spellSlug: string;
  terrainSlug?: string | null;
};

/** Magia fixa de subclasse (ex. Finger Guns do Spellslinger). */
export type SubclassGrantedSpellRow = UnlockLevelGrantedSpellRow;

/** Magia always_prepared de característica de classe (S023). */
export type ClassGrantedSpellRow = UnlockLevelGrantedSpellRow;

export type GrantedSpellMergeContext = {
  featOptions?: readonly FeatOptionDto[];
  characterFeats?: readonly CharacterFeatDto[];
  previousFeatOptions?: readonly FeatOptionDto[];
  previousCharacterFeats?: readonly CharacterFeatDto[];
  speciesSlug?: string;
  speciesChoices?: readonly SpeciesChoiceDto[];
  level?: number;
  previousSpeciesSlug?: string;
  previousSpeciesChoices?: readonly SpeciesChoiceDto[];
  previousLevel?: number;
  /** Catálogo de magias fixas de talento (`v_phb_feat_granted_spell`). */
  featFixedSpells?: readonly FeatGrantedSpellRow[];
  /** Catálogo de magias de espécie (`v_phb_species_granted_spell`). */
  speciesCatalog?: readonly SpeciesGrantedSpellRow[];
  /** Magias always_prepared da subclasse (Finger Guns etc.). */
  subclassGrantedSpells?: readonly SubclassGrantedSpellRow[];
  previousSubclassGrantedSpells?: readonly SubclassGrantedSpellRow[];
  /** Magias always_prepared de classe (Marca do Predador, Destruição Divina, …). */
  classGrantedSpells?: readonly ClassGrantedSpellRow[];
  previousClassGrantedSpells?: readonly ClassGrantedSpellRow[];
  /** Concessões extras (ex. free_cast de Invocações Místicas, Descobertas Mágicas). */
  extraGrantedSpellSlugs?: ReadonlySet<string>;
  previousExtraGrantedSpellSlugs?: ReadonlySet<string>;
  subclassSlug?: string | null;
  subclassOptions?: readonly { optionKey: string; valueId: string }[];
};
