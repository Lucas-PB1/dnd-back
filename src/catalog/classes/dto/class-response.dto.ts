import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassResponseDto {
  @ApiProperty({ example: 'fighter' })
  slug!: string;

  @ApiProperty({ example: 'Guerreiro' })
  name!: string;

  @ApiProperty({ example: 'D10' })
  hitDie!: string;

  @ApiPropertyOptional({ example: 'Força ou Destreza' })
  primaryAbilityLabel!: string | null;

  @ApiPropertyOptional({ example: 'or' })
  primaryAbilityOperator!: string | null;

  @ApiPropertyOptional({ type: [String], example: ['forca', 'destreza'] })
  primaryAbilitySlugs!: string[];

  @ApiPropertyOptional()
  hpLevel1DieValue!: number | null;

  @ApiPropertyOptional()
  hpFixedPerLevel!: number | null;

  @ApiPropertyOptional()
  skillChoiceCount!: number | null;

  @ApiPropertyOptional()
  skillChoiceFrom!: string | null;

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;
}
