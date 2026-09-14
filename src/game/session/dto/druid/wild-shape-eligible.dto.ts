import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class WildShapeEligibleBeastDto {
  @ApiProperty({ example: 'gato' })
  slug!: string;

  @ApiProperty({ example: 'Gato' })
  name!: string;

  @ApiPropertyOptional({ example: '0', nullable: true })
  challengeRating!: string | null;

  @ApiPropertyOptional({ example: 12, nullable: true })
  armorClass!: number | null;

  @ApiProperty({ example: false })
  hasFlySpeed!: boolean;

  @ApiProperty({
    example: true,
    description: 'Já está nas formas conhecidas da ficha',
  })
  known!: boolean;
}

export class WildShapeEligibleListResponseDto {
  @ApiProperty({ example: 4 })
  maxKnownForms!: number;

  @ApiProperty({ example: ['gato', 'coruja'], type: [String] })
  knownSlugs!: string[];

  @ApiProperty({ example: true })
  formSwapAvailable!: boolean;

  @ApiProperty({ type: [WildShapeEligibleBeastDto] })
  beasts!: WildShapeEligibleBeastDto[];
}
