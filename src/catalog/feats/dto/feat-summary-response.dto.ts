import { ApiProperty } from '@nestjs/swagger';

/** Listagem leve (`fields=summary`) — labels sem benefits. */
export class FeatSummaryResponseDto {
  @ApiProperty({ example: 'alert' })
  slug!: string;

  @ApiProperty({ example: 'Alerta' })
  name!: string;

  @ApiProperty({ example: 'origin' })
  categorySlug!: string;
}
