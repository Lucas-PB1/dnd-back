import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpellSlotsMapDto {
  @ApiPropertyOptional({ example: 2, description: 'Slots de 1º círculo disponíveis no total' })
  '1'?: number;

  @ApiPropertyOptional({ example: 0 })
  '2'?: number;

  @ApiPropertyOptional({ example: 0 })
  '3'?: number;

  @ApiPropertyOptional({ example: 0 })
  '4'?: number;

  @ApiPropertyOptional({ example: 0 })
  '5'?: number;

  @ApiPropertyOptional({ example: 0 })
  '6'?: number;

  @ApiPropertyOptional({ example: 0 })
  '7'?: number;

  @ApiPropertyOptional({ example: 0 })
  '8'?: number;

  @ApiPropertyOptional({ example: 0 })
  '9'?: number;
}

export class ClassResourceStateDto {
  @ApiProperty({ example: 'rage' })
  slug!: string;

  @ApiProperty({ example: 'Fúria' })
  name!: string;

  @ApiProperty({ example: 3 })
  max!: number;

  @ApiProperty({ example: 1 })
  used!: number;

  @ApiProperty({ example: 2 })
  remaining!: number;

  @ApiPropertyOptional({
    example: 8,
    description: 'Faces do dado associado (ex. Risk d8/d10/d12); omitido se N/A',
  })
  dieFaces?: number | null;

  @ApiPropertyOptional({
    example: 'd8',
    description: 'Rótulo do dado (ex. d8); omitido se N/A',
  })
  dieLabel?: string | null;
}
