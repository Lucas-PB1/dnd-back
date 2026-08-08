import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassSummaryResponseDto {
  @ApiProperty({ example: 'fighter' })
  slug!: string;

  @ApiProperty({ example: 'Guerreiro' })
  name!: string;

  @ApiPropertyOptional()
  editionSlug!: string | null;
}
