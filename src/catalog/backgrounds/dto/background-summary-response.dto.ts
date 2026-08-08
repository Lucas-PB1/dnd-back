import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class BackgroundSummaryResponseDto {
  @ApiProperty({ example: 'acolyte' })
  slug!: string;

  @ApiProperty({ example: 'Acólito' })
  name!: string;

  @ApiPropertyOptional()
  editionSlug!: string | null;
}
