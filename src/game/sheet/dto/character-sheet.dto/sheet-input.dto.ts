import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayUnique,
  IsArray,
  IsOptional,
  IsString,
  ValidateIf,
  ValidateNested,
} from 'class-validator';
import {
  CharacterTransformationDto,
  ClassOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from './choices.dto';
import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  FeatOptionDto,
} from './feats-spells-equipment.dto';

export class CharacterSheetInputDto {
  @ApiPropertyOptional({
    example: ['athletics', 'perception'],
    description: 'Perícias escolhidas da pool da classe',
  })
  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @IsString({ each: true })
  classSkillSlugs?: string[];

  @ApiPropertyOptional({ type: [SpeciesChoiceDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SpeciesChoiceDto)
  speciesChoices?: SpeciesChoiceDto[];

  @ApiPropertyOptional({ type: [SpeciesChoiceDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SpeciesChoiceDto)
  heritageChoices?: SpeciesChoiceDto[];

  @ApiPropertyOptional({
    type: CharacterTransformationDto,
    nullable: true,
    description: 'Transformação GH Cap. 6; null remove. Não usar characterFeats.',
  })
  @IsOptional()
  @ValidateIf((_, value) => value !== null)
  @ValidateNested()
  @Type(() => CharacterTransformationDto)
  transformation?: CharacterTransformationDto | null;

  @ApiPropertyOptional({ type: [SubclassOptionDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SubclassOptionDto)
  subclassOptions?: SubclassOptionDto[];

  @ApiPropertyOptional({
    type: [ClassOptionDto],
    description: 'Escolhas de classe (Especialização etc.)',
  })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ClassOptionDto)
  classOptions?: ClassOptionDto[];

  @ApiPropertyOptional({ type: [CharacterFeatDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CharacterFeatDto)
  characterFeats?: CharacterFeatDto[];

  @ApiPropertyOptional({ type: [FeatOptionDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => FeatOptionDto)
  featOptions?: FeatOptionDto[];

  @ApiPropertyOptional({ type: [CharacterSpellDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CharacterSpellDto)
  characterSpells?: CharacterSpellDto[];

  @ApiPropertyOptional({ type: [CharacterEquipmentDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CharacterEquipmentDto)
  equipment?: CharacterEquipmentDto[];

  @ApiPropertyOptional({ example: ['common', 'elvish'] })
  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @IsString({ each: true })
  languageSlugs?: string[];

  @ApiPropertyOptional({ example: 'standard-array' })
  @IsOptional()
  @IsString()
  abilityGenerationMethodSlug?: string;
}
