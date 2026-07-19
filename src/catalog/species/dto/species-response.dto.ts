import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpeciesResponseDto {
  @ApiProperty({ example: 'elf' })
  slug!: string;

  @ApiProperty({ example: 'Elfo' })
  name!: string;

  @ApiPropertyOptional({ example: 'Filhos de Corellon e de Faéria' })
  tagline!: string | null;

  @ApiPropertyOptional({
    example: 'Longevidade, transe e magia moldada pelo ambiente.',
  })
  summary!: string | null;

  @ApiProperty({ example: 'Humanoide' })
  creatureType!: string;

  @ApiProperty({ example: 'Médio' })
  size!: string;

  @ApiProperty({ example: '9 m' })
  speed!: string;

  @ApiProperty()
  description!: string;
}
