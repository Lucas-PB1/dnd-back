import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  CharacterTransformationDto,
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
  transformation: CharacterTransformationDto | null;
  subclassOptions: SubclassOptionDto[];
  classOptions: ClassOptionDto[];
  characterFeats: CharacterFeatDto[];
  featOptions: FeatOptionDto[];
  characterSpells: CharacterSpellDto[];
  equipment: CharacterEquipmentDto[];
  languageSlugs: string[];
  abilityGenerationMethodSlug: string | null;
  backgroundSkillSlugs: string[];
  proficiencyBonus?: number | null;
  classAbilityBoosts?: ClassAbilityBoostRow[];
  speciesSize?: string | null;
}

export const EMPTY_SHEET_DATA: CharacterSheetData = {
  classSkillSlugs: [],
  speciesChoices: [],
  heritageChoices: [],
  transformation: null,
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
  transformation?: CharacterTransformationDto | null;
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
