import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class HeritageResponseDto {
  @ApiProperty({ example: 'gh-dwarf' })
  slug!: string;

  @ApiProperty({ example: 'Anão' })
  name!: string;

  @ApiProperty({ example: 'common', enum: ['common', 'rare', 'eldritch'] })
  category!: string;

  @ApiPropertyOptional({ example: 'Herança comum' })
  tagline!: string | null;

  @ApiPropertyOptional()
  summary!: string | null;

  @ApiProperty({ example: 'Humanoide' })
  creatureType!: string;

  @ApiProperty({ example: 'Médio ou Pequeno (escolha na criação)' })
  sizeRule!: string;

  @ApiProperty({ example: '9 m' })
  speedRule!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty({ example: true })
  allowsSpeedTrade!: boolean;

  @ApiProperty({ example: true })
  allowsSizeChoice!: boolean;

  @ApiPropertyOptional({
    example: 'grim-hollow-players-guide-2024-en',
    description: 'Rulebook edition slug (from source_meta or default)',
  })
  editionSlug!: string | null;

  @ApiPropertyOptional({ example: '/catalog/heritages/dwarf.png' })
  imageUrl!: string | null;
}
