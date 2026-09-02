import { DataSource } from 'typeorm';
import type {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  CharacterTransformationDto,
  ClassOptionDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '@game/sheet/dto/character-sheet.dto';

export type CharacterSheetLoadDeps = {
  dataSource: DataSource;
};

export type SheetBundleBoostJson = {
  abilitySlug: string;
  label: string;
  bonus: number;
  scoreMax: number;
  fromLevel: number;
};

export type SheetBundleJson = {
  classSkillSlugs?: string[] | null;
  speciesChoices?: SpeciesChoiceDto[] | null;
  heritageChoices?: SpeciesChoiceDto[] | null;
  transformation?: CharacterTransformationDto | null;
  subclassOptions?: SubclassOptionDto[] | null;
  classOptions?: ClassOptionDto[] | null;
  characterFeats?: CharacterFeatDto[] | null;
  featOptions?: FeatOptionDto[] | null;
  characterSpells?: CharacterSpellDto[] | null;
  equipment?: Array<{
    source: 'class' | 'background';
    packageSlug: string;
    itemSlug?: string | null;
    quantity: number;
    sortOrder: number;
  }> | null;
  languageSlugs?: string[] | null;
  backgroundSkillSlugs?: string[] | null;
  proficiencyBonus?: number | null;
  classAbilityBoosts?: SheetBundleBoostJson[] | null;
  speciesSize?: string | null;
};
