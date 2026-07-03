import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class BackgroundEquipmentResponseDto {
  @ApiProperty({ example: 'a' })
  packageSlug!: string;

  @ApiProperty({ example: 'A' })
  packageLabel!: string;

  @ApiPropertyOptional({ example: 50 })
  packageGold!: number | null;

  @ApiProperty({ example: 1 })
  sortOrder!: number;

  @ApiPropertyOptional({ example: 'holy-symbol' })
  itemSlug!: string | null;

  @ApiPropertyOptional()
  itemName!: string | null;

  @ApiPropertyOptional({ example: 1 })
  quantity!: number | null;

  @ApiPropertyOptional()
  choiceText!: string | null;
}
