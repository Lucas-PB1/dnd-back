import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpeciesSummaryResponseDto {
  @ApiProperty({ example: 'elf' })
  slug!: string;

  @ApiProperty({ example: 'Elfo' })
  name!: string;

  @ApiProperty({ example: 'phb-2024-pt' })
  editionSlug!: string;

  @ApiPropertyOptional({
    example: 'dwarf',
    description: 'Base species slug when this is a variant (source_meta.variantOf)',
  })
  variantOf!: string | null;
}
