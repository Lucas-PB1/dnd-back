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

export class ClassOptionDto {
  @ApiProperty({ example: 'expertiseSkill1' })
  @IsString()
  @IsNotEmpty()
  optionKey!: string;

  @ApiProperty({ example: 'stealth' })
  @IsString()
  @IsNotEmpty()
  valueId!: string;

  @ApiPropertyOptional({
    example: 0,
    default: 0,
    description: 'Índice quando a mesma optionKey se repete (ex.: invocações)',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  instanceIndex?: number;
}

export class CharacterTransformationDto {
  @ApiProperty({ example: 'gh-transformation-vampire' })
  @IsString()
  @IsNotEmpty()
  slug!: string;

  @ApiProperty({ example: 2, minimum: 1, maximum: 4 })
  @IsInt()
  @Min(1)
  @Max(4)
  stage!: number;

  @ApiProperty({ type: [SpeciesChoiceDto] })
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SpeciesChoiceDto)
  choices!: SpeciesChoiceDto[];
}
