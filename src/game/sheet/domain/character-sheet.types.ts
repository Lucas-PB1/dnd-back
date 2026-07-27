import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  ClassOptionDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '../dto/character-sheet.dto';

export interface CharacterSheetData {
  classSkillSlugs: string[];
  speciesChoices: SpeciesChoiceDto[];
  subclassOptions: SubclassOptionDto[];
  classOptions: ClassOptionDto[];
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
  classOptions: [],
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
  classOptions?: ClassOptionDto[];
  characterFeats?: CharacterFeatDto[];
  featOptions?: FeatOptionDto[];
  characterSpells?: CharacterSpellDto[];
  equipment?: CharacterEquipmentDto[];
  languageSlugs?: string[];
  abilityGenerationMethodSlug?: string;
}
