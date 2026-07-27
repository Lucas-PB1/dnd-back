import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';

export class InventoryItemResponseDto {
  @ApiProperty({ example: 'longsword' })
  itemSlug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  itemName!: string;

  @ApiProperty({ example: 'weapon' })
  itemType!: string;

  @ApiProperty({ example: 1 })
  quantity!: number;

  @ApiProperty({ enum: ['equipped', 'backpack'] })
  location!: 'equipped' | 'backpack';

  @ApiPropertyOptional({ enum: ['armor', 'main_hand', 'off_hand', 'shield'] })
  equipmentSlot!: string | null;

  @ApiProperty({ example: false })
  attuned!: boolean;

  @ApiProperty({
    example: false,
    description: 'True when phb_item.properties.requiresAttunement',
  })
  requiresAttunement!: boolean;
}

export class CharacterInventoryResponseDto {
  @ApiProperty({ type: [InventoryItemResponseDto] })
  items!: InventoryItemResponseDto[];
}

export class AddInventoryItemDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  @IsNotEmpty()
  itemSlug!: string;

  @ApiPropertyOptional({ example: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  quantity?: number;
}

export class PatchInventoryItemDto {
  @ApiPropertyOptional({ enum: ['equipped', 'backpack'] })
  @IsOptional()
  @IsIn(['equipped', 'backpack'])
  location?: 'equipped' | 'backpack';

  @ApiPropertyOptional({ enum: ['armor', 'main_hand', 'off_hand', 'shield'] })
  @IsOptional()
  @IsIn(['armor', 'main_hand', 'off_hand', 'shield'])
  equipmentSlot?: 'armor' | 'main_hand' | 'off_hand' | 'shield';

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  @Min(1)
  quantity?: number;

  @ApiPropertyOptional({
    example: true,
    description: 'Sintonizar / dessintonizar (máx. 3; só itens que exigem sintonia)',
  })
  @IsOptional()
  @IsBoolean()
  attuned?: boolean;
}
