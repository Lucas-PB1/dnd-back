import { Injectable } from '@nestjs/common';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
import { SpeciesResponseDto } from './dto/species-response.dto';
import { SpeciesTraitResponseDto } from './dto/species-trait-response.dto';
import { SpeciesTraitChoiceResponseDto } from './dto/species-trait-choice-response.dto';

@Injectable()
export class SpeciesMapper {
  toDto(row: PhbSpecies): SpeciesResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      creatureType: row.creatureType,
      size: row.size,
      speed: row.speed,
      description: row.description,
    };
  }

  toTraitDto(row: PhbSpeciesTrait): SpeciesTraitResponseDto {
    return {
      name: row.name,
      description: row.description,
      choiceKind: row.choiceKind,
    };
  }

  toTraitChoiceDto(row: VPhbSpeciesTraitChoices): SpeciesTraitChoiceResponseDto {
    return {
      traitName: row.traitName,
      choiceKind: row.choiceKind,
      choiceSlug: row.choiceSlug,
      choiceName: row.choiceName,
      level1Benefit: row.level1Benefit,
      spellLevel3Slug: row.spellLevel3Slug,
      spellLevel5Slug: row.spellLevel5Slug,
      damageType: row.damageType,
    };
  }
}
