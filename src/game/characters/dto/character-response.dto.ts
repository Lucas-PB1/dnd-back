import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min, ValidateNested } from 'class-validator';

export class AbilityScoresDto {
  @ApiProperty({ example: 15 })
  @IsInt()
  @Min(1)
  @Max(30)
  forca!: number;

  @ApiProperty({ example: 14 })
  @IsInt()
  @Min(1)
  @Max(30)
  destreza!: number;

  @ApiProperty({ example: 13 })
  @IsInt()
  @Min(1)
  @Max(30)
  constituicao!: number;

  @ApiProperty({ example: 10 })
  @IsInt()
  @Min(1)
  @Max(30)
  inteligencia!: number;

  @ApiProperty({ example: 12 })
  @IsInt()
  @Min(1)
  @Max(30)
  sabedoria!: number;

  @ApiProperty({ example: 8 })
  @IsInt()
  @Min(1)
  @Max(30)
  carisma!: number;
}

export class CharacterResponseDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Thorin' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiProperty({ example: 'dwarf' })
  speciesSlug!: string;

  @ApiProperty({ example: 'acolyte' })
  backgroundSlug!: string;

  @ApiPropertyOptional({ example: 'champion' })
  subclassSlug!: string | null;

  @ApiPropertyOptional({ example: 'lawful-good' })
  alignmentSlug!: string | null;

  @ApiProperty({ type: AbilityScoresDto })
  abilityScores!: AbilityScoresDto;

  @ApiPropertyOptional()
  hitPointsMax!: number | null;

  @ApiPropertyOptional()
  hitPointsCurrent!: number | null;

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;
}
