import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpeciesResponseDto {
  @ApiProperty({ example: 'elf' })
  slug!: string;

  @ApiProperty({ example: 'Elfo' })
  name!: string;

  @ApiProperty({ example: 'Humanoide' })
  creatureType!: string;

  @ApiProperty({ example: 'Médio' })
  size!: string;

  @ApiProperty({ example: '9 m' })
  speed!: string;

  @ApiProperty()
  description!: string;
}
