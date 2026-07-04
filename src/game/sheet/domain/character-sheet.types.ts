import {
  CharacterEquipmentDto,
  CharacterSpellDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '../dto/character-sheet.dto';

export interface CharacterSheetData {
  classSkillSlugs: string[];
  speciesChoices: SpeciesChoiceDto[];
  subclassOptions: SubclassOptionDto[];
  featSlugs: string[];
  featOptions: FeatOptionDto[];
  characterSpells: CharacterSpellDto[];
  equipment: CharacterEquipmentDto[];
  languageSlugs: string[];
  abilityGenerationMethodSlug: string | null;
  backgroundSkillSlugs: string[];
}

export const EMPTY_SHEET_DATA: CharacterSheetData = {
  classSkillSlugs: [],
  speciesChoices: [],
  subclassOptions: [],
  featSlugs: [],
  featOptions: [],
  characterSpells: [],
  equipment: [],
  languageSlugs: [],
  abilityGenerationMethodSlug: null,
  backgroundSkillSlugs: [],
};

export interface CharacterSheetInput {
  classSkillSlugs?: string[];
  speciesChoices?: SpeciesChoiceDto[];
  subclassOptions?: SubclassOptionDto[];
  featSlugs?: string[];
  featOptions?: FeatOptionDto[];
  characterSpells?: CharacterSpellDto[];
  equipment?: CharacterEquipmentDto[];
  languageSlugs?: string[];
  abilityGenerationMethodSlug?: string;
}
