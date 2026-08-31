import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateIf,
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

  @ApiPropertyOptional({ example: 'dwarf' })
  @ValidateIf((dto: CreateCharacterDto) => !dto.heritageSlug?.trim())
  @IsString()
  @IsNotEmpty()
  speciesSlug?: string;

  @ApiPropertyOptional({ example: 'gh-dwarf' })
  @ValidateIf((dto: CreateCharacterDto) => !dto.speciesSlug?.trim())
  @IsString()
  @IsNotEmpty()
  heritageSlug?: string;

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

  @ApiPropertyOptional({
    enum: ['plus2plus1', 'plus1x3'],
    default: 'plus2plus1',
    description: 'Distribuição do bônus do antecedente: +2/+1 ou +1 em três atributos',
  })
  @IsOptional()
  @IsIn(['plus2plus1', 'plus1x3'])
  backgroundAbilityBoostMode?: 'plus2plus1' | 'plus1x3';

  @ApiPropertyOptional({
    example: 'sabedoria',
    description: 'Atributo +2 (obrigatório quando mode = plus2plus1)',
  })
  @ValidateIf(
    (dto: CreateCharacterDto) =>
      (dto.backgroundAbilityBoostMode ?? 'plus2plus1') === 'plus2plus1',
  )
  @IsString()
  @IsNotEmpty()
  backgroundAbilityBoostPlus2Slug?: string;

  @ApiPropertyOptional({
    example: 'carisma',
    description: 'Atributo +1 (obrigatório quando mode = plus2plus1)',
  })
  @ValidateIf(
    (dto: CreateCharacterDto) =>
      (dto.backgroundAbilityBoostMode ?? 'plus2plus1') === 'plus2plus1',
  )
  @IsString()
  @IsNotEmpty()
  backgroundAbilityBoostPlus1Slug?: string;

  @ApiPropertyOptional({
    example: ['sabedoria', 'carisma', 'inteligencia'],
    description: 'Três atributos +1 (obrigatório quando mode = plus1x3)',
  })
  @ValidateIf(
    (dto: CreateCharacterDto) => dto.backgroundAbilityBoostMode === 'plus1x3',
  )
  @IsArray()
  @ArrayMinSize(3)
  @ArrayMaxSize(3)
  @IsString({ each: true })
  backgroundAbilityBoostPlus1Slugs?: string[];

  @ApiPropertyOptional({
    example: 'ferramentas-de-carpinteiro',
    description: 'Obrigatório quando o antecedente exige escolha de ferramenta',
  })
  @IsOptional()
  @IsString()
  backgroundToolItemSlug?: string;
}