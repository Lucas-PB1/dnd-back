import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsArray,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Max,
  Min,
  ValidateNested,
} from 'class-validator';
import {
  CharacterFeatDto,
  CharacterSpellDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '@game/sheet/dto/character-sheet.dto';

export class PreviewGrantedSpellsDto {
  @ApiProperty({ example: 'elf' })
  @IsString()
  @IsNotEmpty()
  speciesSlug!: string;

  @ApiPropertyOptional({ example: 1, minimum: 1, maximum: 20, default: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(20)
  level?: number;

  @ApiPropertyOptional({ example: 'evoker' })
  @IsOptional()
  @IsString()
  subclassSlug?: string | null;

  @ApiPropertyOptional({ example: 'ranger' })
  @IsOptional()
  @IsString()
  classSlug?: string | null;

  @ApiPropertyOptional({ type: [SpeciesChoiceDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SpeciesChoiceDto)
  speciesChoices?: SpeciesChoiceDto[];

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

  @ApiPropertyOptional({
    type: [CharacterSpellDto],
    description: 'Magias já escolhidas (classe/subclasse); granted são mescladas',
  })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CharacterSpellDto)
  characterSpells?: CharacterSpellDto[];

  @ApiPropertyOptional({ type: [SubclassOptionDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SubclassOptionDto)
  subclassOptions?: SubclassOptionDto[];
}

export class PreviewGrantedSpellsResponseDto {
  @ApiProperty({ type: [CharacterSpellDto] })
  characterSpells!: CharacterSpellDto[];

  @ApiProperty({
    type: [CharacterSpellDto],
    description: 'Somente magias always_prepared concedidas (feat/species/subclass/class)',
  })
  grantedOnly!: CharacterSpellDto[];
}
