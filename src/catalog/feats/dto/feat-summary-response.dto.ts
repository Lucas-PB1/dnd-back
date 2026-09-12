import { ApiProperty } from '@nestjs/swagger';


export class FeatSummaryResponseDto {
  @ApiProperty({ example: 'alert' })
  slug!: string;

  @ApiProperty({ example: 'Alerta' })
  name!: string;

  @ApiProperty({ example: 'origin' })
  categorySlug!: string;
}
