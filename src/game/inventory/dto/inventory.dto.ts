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

  @ApiPropertyOptional({
    enum: ['armor', 'main_hand', 'off_hand', 'shield', 'worn', 'carried'],
  })
  equipmentSlot!: string | null;

  @ApiProperty({ example: false })
  attuned!: boolean;

  @ApiProperty({
    example: false,
    description: 'Arma vinculada ao Pacto da Lâmina (Bruxo)',
  })
  isPactWeapon!: boolean;

  @ApiProperty({
    example: false,
    description: 'True when phb_item.properties.requiresAttunement',
  })
  requiresAttunement!: boolean;

  @ApiProperty({
    example: false,
    description:
      'True when equipped and (no attunement required or currently attuned)',
  })
  effectsActive!: boolean;

  @ApiProperty({
    enum: ['active', 'inactive_unequipped', 'inactive_unattuned'],
    description: 'Estado dos efeitos permanentes do item',
  })
  effectsStatus!: 'active' | 'inactive_unequipped' | 'inactive_unattuned';

  @ApiPropertyOptional({
    example: 1.5,
    description: 'Peso unitário em kg (parseado de phb_item.weight)',
  })
  weightKg!: number;

  @ApiPropertyOptional({
    example: 'weapon-charm-blade-1',
    description: 'Encanto de arma preso a este item (slug do catálogo)',
  })
  attachedCharmSlug!: string | null;

  @ApiPropertyOptional({
    example: 'Encanto de Arma: Lâmina +1',
    description: 'Nome do encanto preso (quando attachedCharmSlug está definido)',
  })
  attachedCharmName!: string | null;
}

export class InventoryEncumbranceDto {
  @ApiProperty({ example: 12.5, description: 'Peso total carregado (kg)' })
  totalWeightKg!: number;

  @ApiProperty({
    example: 75,
    description: 'Capacidade de carga = Força × 7,5 kg',
  })
  carryingCapacityKg!: number;

  @ApiProperty({
    example: false,
    description: 'True quando totalWeightKg > carryingCapacityKg',
  })
  encumbered!: boolean;
}

export class CharacterInventoryResponseDto {
  @ApiProperty({ type: [InventoryItemResponseDto] })
  items!: InventoryItemResponseDto[];

  @ApiProperty({ type: InventoryEncumbranceDto })
  encumbrance!: InventoryEncumbranceDto;
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

  @ApiPropertyOptional({
    enum: ['armor', 'main_hand', 'off_hand', 'shield', 'worn', 'carried'],
  })
  @IsOptional()
  @IsIn(['armor', 'main_hand', 'off_hand', 'shield', 'worn', 'carried'])
  equipmentSlot?:
    | 'armor'
    | 'main_hand'
    | 'off_hand'
    | 'shield'
    | 'worn'
    | 'carried';

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

  @ApiPropertyOptional({
    example: true,
    description:
      'Marcar / desmarcar como Arma de Pacto (Bruxo com Pacto da Lâmina; no máx. 1)',
  })
  @IsOptional()
  @IsBoolean()
  pactWeapon?: boolean;
}

export class AttachWeaponCharmDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  @IsNotEmpty()
  weaponSlug!: string;

  @ApiProperty({ example: 'weapon-charm-blade-1' })
  @IsString()
  @IsNotEmpty()
  charmSlug!: string;
}

export class DetachWeaponCharmDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  @IsNotEmpty()
  weaponSlug!: string;
}
