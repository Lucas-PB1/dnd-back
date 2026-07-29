import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FeatBenefitDto {
  @ApiPropertyOptional()
  name?: string;

  @ApiPropertyOptional()
  description?: string;
}

export class FeatAbilityPrerequisiteDto {
  @ApiProperty({ example: 'destreza' })
  abilitySlug!: string;

  @ApiProperty({ example: 13 })
  minimumScore!: number;
}

export class FeatResponseDto {
  @ApiProperty({ example: 'alert' })
  slug!: string;

  @ApiProperty({ example: 'Alerta' })
  name!: string;

  @ApiProperty({ example: 'origin' })
  categorySlug!: string;

  @ApiProperty({ example: 'Origem' })
  categoryName!: string;

  @ApiProperty({ example: 'Talento de Origem' })
  categoryTypeLabel!: string;

  @ApiProperty()
  repeatable!: boolean;

  @ApiPropertyOptional()
  prerequisite!: string | null;

  @ApiPropertyOptional({ example: 4 })
  minimumLevel!: number | null;

  @ApiProperty({ type: [FeatAbilityPrerequisiteDto] })
  abilityPrerequisites!: FeatAbilityPrerequisiteDto[];

  @ApiProperty()
  requiresSpellcasting!: boolean;

  @ApiPropertyOptional({ example: 'medium' })
  requiredArmorTrainingSlug!: string | null;

  @ApiProperty()
  requiresFightingStyle!: boolean;

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  sourceChapterTitle!: string | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiProperty({ type: [FeatBenefitDto] })
  benefits!: FeatBenefitDto[];
}
