import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AbilityGenerationPointBuyDto {
  @ApiProperty({ example: 27 })
  budget!: number;

  @ApiProperty({ example: 8 })
  minScore!: number;

  @ApiProperty({ example: 15 })
  maxScore!: number;

  @ApiProperty({
    example: {
      '8': 0,
      '9': 1,
      '10': 2,
      '11': 3,
      '12': 4,
      '13': 5,
      '14': 7,
      '15': 9,
    },
  })
  costByScore!: Record<string, number>;
}

export class AbilityGenerationMethodResponseDto {
  @ApiProperty({ example: 'standard-array' })
  slug!: string;

  @ApiProperty({ example: 'Conjunto Padrão' })
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiPropertyOptional({
    type: [Number],
    example: [15, 14, 13, 12, 10, 8],
    nullable: true,
  })
  pool?: number[] | null;

  @ApiPropertyOptional({ type: AbilityGenerationPointBuyDto, nullable: true })
  pointBuy?: AbilityGenerationPointBuyDto | null;

  @ApiPropertyOptional({ example: 72, nullable: true })
  rollTotalMin?: number | null;

  @ApiPropertyOptional({ example: 80, nullable: true })
  rollTotalMax?: number | null;

  @ApiPropertyOptional({ example: 3, nullable: true })
  rollOptionCount?: number | null;
}
