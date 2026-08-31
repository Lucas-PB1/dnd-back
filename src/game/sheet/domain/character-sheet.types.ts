import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  ClassOptionDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '../dto/character-sheet.dto';
import type { ClassAbilityBoostRow } from './stats/class-ability-boost';

export interface CharacterSheetData {
  classSkillSlugs: string[];
  speciesChoices: SpeciesChoiceDto[];
  heritageChoices: SpeciesChoiceDto[];
  subclassOptions: SubclassOptionDto[];
  classOptions: ClassOptionDto[];
  characterFeats: CharacterFeatDto[];
  featOptions: FeatOptionDto[];
  characterSpells: CharacterSpellDto[];
  equipment: CharacterEquipmentDto[];
  languageSlugs: string[];
  abilityGenerationMethodSlug: string | null;
  backgroundSkillSlugs: string[];
  /** Preenchidos pelo RPC sheet bundle (P032+); omitidos em EMPTY. */
  proficiencyBonus?: number | null;
  classAbilityBoosts?: ClassAbilityBoostRow[];
  speciesSize?: string | null;
}

export const EMPTY_SHEET_DATA: CharacterSheetData = {
  classSkillSlugs: [],
  speciesChoices: [],
  heritageChoices: [],
  subclassOptions: [],
  classOptions: [],
  characterFeats: [],
  featOptions: [],
  characterSpells: [],
  equipment: [],
  languageSlugs: [],
  abilityGenerationMethodSlug: null,
  backgroundSkillSlugs: [],
};

/** Subconjunto da sheet para granted spell cast options no state. */
export type GrantedSpellSheetSlice = Pick<
  CharacterSheetData,
  | 'characterFeats'
  | 'featOptions'
  | 'speciesChoices'
  | 'heritageChoices'
  | 'characterSpells'
  | 'classOptions'
>;

export interface CharacterSheetInput {
  classSkillSlugs?: string[];
  speciesChoices?: SpeciesChoiceDto[];
  heritageChoices?: SpeciesChoiceDto[];
  subclassOptions?: SubclassOptionDto[];
  classOptions?: ClassOptionDto[];
  characterFeats?: CharacterFeatDto[];
  featOptions?: FeatOptionDto[];
  characterSpells?: CharacterSpellDto[];
  equipment?: CharacterEquipmentDto[];
  languageSlugs?: string[];
  abilityGenerationMethodSlug?: string;
}

export interface CharacterSheetContext {
  level: number;
  classSlug: string;
  speciesSlug: string | null;
  heritageSlug?: string | null;
  backgroundSlug: string;
  subclassSlug: string | null;
  characterFeats?: CharacterFeatDto[];
}
