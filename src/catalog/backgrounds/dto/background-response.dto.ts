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
}
