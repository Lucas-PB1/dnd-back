import { ApiProperty } from '@nestjs/swagger';

export class HeritageSummaryResponseDto {
  @ApiProperty({ example: 'gh-dwarf' })
  slug!: string;

  @ApiProperty({ example: 'Anão' })
  name!: string;

  @ApiProperty({ example: 'grim-hollow-players-guide-2024-en' })
  editionSlug!: string;
}
