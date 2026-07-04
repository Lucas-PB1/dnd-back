import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ItemResponseDto {
  @ApiProperty({ example: 'longsword' })
  slug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  name!: string;

  @ApiProperty({ example: 'weapon' })
  itemType!: string;

  @ApiPropertyOptional({ example: '15 PO' })
  costText!: string | null;

  @ApiPropertyOptional({ example: '1,5 kg' })
  weight!: string | null;
}
