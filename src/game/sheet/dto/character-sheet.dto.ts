import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsArray,
  ArrayUnique,
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';

export class SpeciesChoiceDto {
  @ApiProperty({ example: 'elf_lineage' })
  @IsString()
  @IsNotEmpty()
  choiceKind!: string;

  @ApiProperty({ example: 'drow' })
  @IsString()
  @IsNotEmpty()
  choiceSlug!: string;
}

export class SubclassOptionDto {
  @ApiProperty({ example: 'elemental_affinity' })
  @IsString()
  @IsNotEmpty()
  optionKey!: string;

  @ApiProperty({ example: 'fire' })
  @IsString()
  @IsNotEmpty()
  valueId!: string;
}

export class CharacterSpellDto {
  @ApiProperty({ example: 'fire-bolt' })
  @IsString()
  @IsNotEmpty()
  spellSlug!: string;

  @ApiProperty({ enum: ['known', 'prepared', 'always_prepared'] })
  @IsString()
  @IsIn(['known', 'prepared', 'always_prepared'])
  listType!: 'known' | 'prepared' | 'always_prepared';
}

export class CharacterEquipmentDto {
  @ApiProperty({ enum: ['class', 'background'] })
  @IsString()
  @IsIn(['class', 'background'])
  source!: 'class' | 'background';

  @ApiProperty({ example: 'a' })
  @IsString()
  @IsNotEmpty()
  packageSlug!: string;

  @ApiPropertyOptional({ example: 'longsword' })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({ example: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  quantity?: number;

  @ApiPropertyOptional({ example: 0 })
  @IsOptional()
  @IsInt()
  @Min(0)
  sortOrder?: number;
}

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

  @ApiPropertyOptional({ type: [SubclassOptionDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SubclassOptionDto)
  subclassOptions?: SubclassOptionDto[];

  @ApiPropertyOptional({ example: ['magic-initiate'] })
  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @IsString({ each: true })
  featSlugs?: string[];

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

export class CharacterSheetResponseDto {
  @ApiProperty({ type: [SpeciesChoiceDto] })
  speciesChoices!: SpeciesChoiceDto[];

  @ApiProperty({ type: [SubclassOptionDto] })
  subclassOptions!: SubclassOptionDto[];

  @ApiProperty({ example: ['magic-initiate'] })
  featSlugs!: string[];

  @ApiProperty({ type: [CharacterSpellDto] })
  characterSpells!: CharacterSpellDto[];

  @ApiProperty({ type: [CharacterEquipmentDto] })
  equipment!: CharacterEquipmentDto[];

  @ApiProperty({ example: ['common'] })
  languageSlugs!: string[];

  @ApiPropertyOptional({ example: 'standard-array' })
  abilityGenerationMethodSlug!: string | null;

  @ApiProperty({
    example: ['insight', 'religion'],
    description: 'Perícias fixas do antecedente (somente leitura, derivado do catálogo)',
  })
  backgroundSkillSlugs!: string[];
}
