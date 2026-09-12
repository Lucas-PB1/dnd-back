import type {
  CharacterFeatDto,
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';
import type { CatalogEffect } from '@game/effects';

export type CharacterSpellSource = 'class' | 'subclass' | 'feat' | 'species';

export type FeatGrantedSpellRow = {
  featSlug: string;
  spellSlug: string;
};

export type UnlockLevelGrantedSpellRow = {
  unlockLevel: number;
  spellSlug: string;
  terrainSlug?: string | null;
};

export type SubclassGrantedSpellRow = UnlockLevelGrantedSpellRow;

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
  featFixedSpells?: readonly FeatGrantedSpellRow[];
  speciesEffects?: readonly CatalogEffect[];
  previousSpeciesEffects?: readonly CatalogEffect[];
  subclassGrantedSpells?: readonly SubclassGrantedSpellRow[];
  previousSubclassGrantedSpells?: readonly SubclassGrantedSpellRow[];
  classGrantedSpells?: readonly ClassGrantedSpellRow[];
  previousClassGrantedSpells?: readonly ClassGrantedSpellRow[];
  extraGrantedSpellSlugs?: ReadonlySet<string>;
  previousExtraGrantedSpellSlugs?: ReadonlySet<string>;
  subclassSlug?: string | null;
  subclassOptions?: readonly { optionKey: string; valueId: string }[];
};
