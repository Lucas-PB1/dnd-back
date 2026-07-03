import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AlignmentResponseDto {
  @ApiProperty({ example: 'lawful-good' })
  slug!: string;

  @ApiProperty({ example: 'Ordeiro e Bom' })
  name!: string;

  @ApiPropertyOptional({ example: 'OB' })
  abbreviation!: string | null;

  @ApiPropertyOptional()
  description!: string | null;
}
