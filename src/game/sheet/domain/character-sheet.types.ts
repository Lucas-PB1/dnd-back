import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '../dto/character-sheet.dto';

export interface CharacterSheetData {
  classSkillSlugs: string[];
  speciesChoices: SpeciesChoiceDto[];
  subclassOptions: SubclassOptionDto[];
  characterFeats: CharacterFeatDto[];
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
  characterFeats: [],
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
  characterFeats?: CharacterFeatDto[];
  featOptions?: FeatOptionDto[];
  characterSpells?: CharacterSpellDto[];
  equipment?: CharacterEquipmentDto[];
  languageSlugs?: string[];
  abilityGenerationMethodSlug?: string;
}
