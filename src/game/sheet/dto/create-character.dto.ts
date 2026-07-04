import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { AbilityScoresDto } from './character-response.dto';
import { CharacterSheetInputDto } from './character-sheet.dto';

export class CreateCharacterDto extends CharacterSheetInputDto {
  @ApiProperty({ example: 'Thorin' })
  @IsString()
  @MinLength(1)
  @MaxLength(100)
  name!: string;

  @ApiProperty({ example: 'fighter' })
  @IsString()
  @IsNotEmpty()
  classSlug!: string;

  @ApiProperty({ example: 'dwarf' })
  @IsString()
  @IsNotEmpty()
  speciesSlug!: string;

  @ApiProperty({ example: 'acolyte' })
  @IsString()
  @IsNotEmpty()
  backgroundSlug!: string;

  @ApiPropertyOptional({ example: 'champion' })
  @IsOptional()
  @IsString()
  subclassSlug?: string;

  @ApiPropertyOptional({ example: 'lawful-good' })
  @IsOptional()
  @IsString()
  alignmentSlug?: string;

  @ApiPropertyOptional({ example: 1, minimum: 1, maximum: 20, default: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(20)
  level?: number;

  @ApiPropertyOptional({ type: AbilityScoresDto })
  @IsOptional()
  @ValidateNested()
  @Type(() => AbilityScoresDto)
  abilityScores?: AbilityScoresDto;

  @ApiPropertyOptional({ example: 12 })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsMax?: number;

  @ApiPropertyOptional({ example: 12 })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsCurrent?: number;

  @ApiProperty({
    example: 'sabedoria',
    description: 'Atributo que recebe +2 do antecedente (entre as opções do PHB)',
  })
  @IsString()
  @IsNotEmpty()
  backgroundAbilityBoostPlus2Slug!: string;

  @ApiProperty({
    example: 'carisma',
    description: 'Atributo que recebe +1 do antecedente (distinto do +2)',
  })
  @IsString()
  @IsNotEmpty()
  backgroundAbilityBoostPlus1Slug!: string;
}