import { ApiProperty } from '@nestjs/swagger';

export class SpeciesSummaryResponseDto {
  @ApiProperty({ example: 'elf' })
  slug!: string;

  @ApiProperty({ example: 'Elfo' })
  name!: string;

  @ApiProperty({ example: 'phb-2024-pt' })
  editionSlug!: string;
}
