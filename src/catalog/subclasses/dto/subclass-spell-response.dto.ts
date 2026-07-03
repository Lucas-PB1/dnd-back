import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SubclassSpellResponseDto {
  @ApiProperty({ example: 3 })
  unlockLevel!: number;

  @ApiProperty({ example: 'curar-ferimentos' })
  slug!: string;

  @ApiProperty({ example: 'Curar Ferimentos' })
  name!: string;

  @ApiPropertyOptional({ example: 'coast' })
  terrainSlug!: string | null;

  @ApiPropertyOptional({ example: 'Costa' })
  terrainLabel!: string | null;
}
