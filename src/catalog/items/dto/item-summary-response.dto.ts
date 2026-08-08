import { ApiProperty } from '@nestjs/swagger';

export class ItemSummaryResponseDto {
  @ApiProperty({ example: 'longsword' })
  slug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  name!: string;

  @ApiProperty({ example: 'weapon' })
  itemType!: string;
}