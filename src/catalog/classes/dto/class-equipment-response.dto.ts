import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassEquipmentResponseDto {
  @ApiProperty({ example: 'a' })
  packageSlug!: string;

  @ApiProperty({ example: 'A' })
  packageLabel!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;

  @ApiPropertyOptional({ example: 'longsword' })
  itemSlug!: string | null;

  @ApiPropertyOptional({ example: 'Espada longa' })
  itemName!: string | null;

  @ApiPropertyOptional({ example: 1 })
  quantity!: number | null;

  @ApiPropertyOptional()
  choiceText!: string | null;

  @ApiPropertyOptional({ example: 10, description: 'Gold (GP) when item is gold instead of gear' })
  goldAmount!: number | null;
}
