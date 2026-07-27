import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AlignmentResponseDto {
  @ApiProperty({ example: 'lawful-good' })
  slug!: string;

  @ApiProperty({ example: 'Leal e Bom' })
  name!: string;

  @ApiPropertyOptional({ example: 'LB' })
  abbreviation!: string | null;

  @ApiPropertyOptional()
  description!: string | null;
}
