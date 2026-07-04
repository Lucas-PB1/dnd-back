import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class BackgroundResponseDto {
  @ApiProperty({ example: 'acolyte' })
  slug!: string;

  @ApiProperty({ example: 'Acólito' })
  name!: string;

  @ApiPropertyOptional()
  equipmentGoldOption!: number | null;

  @ApiPropertyOptional({ type: [String] })
  abilityOptionSlugs!: string[];

  @ApiPropertyOptional({ type: [String] })
  abilityOptionNames!: string[];

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  sourceChapterTitle!: string | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiPropertyOptional({ example: 'magic-initiate' })
  originFeatSlug!: string | null;

  @ApiPropertyOptional({ example: 'Iniciado em Magia' })
  originFeatName!: string | null;

  @ApiPropertyOptional({ enum: ['fixed', 'choice'] })
  toolProficiencyKind!: string | null;

  @ApiPropertyOptional({ example: 'Ferramentas de Cartógrafo' })
  toolProficiencyDescription!: string | null;

  @ApiPropertyOptional({ example: 'ferramentas-de-cartografo' })
  toolItemSlug!: string | null;

  @ApiPropertyOptional({ example: 'Ferramentas de Cartógrafo' })
  toolItemName!: string | null;

  @ApiPropertyOptional({ example: 'artisan' })
  toolCategorySlug!: string | null;

  @ApiPropertyOptional({ example: 'Ferramentas de Artesão' })
  toolCategoryName!: string | null;
}
