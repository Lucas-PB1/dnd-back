import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  ValidateIf,
} from 'class-validator';

export const INVENTORY_ACTION_SLUGS = [
  'attach-weapon-charm',
  'detach-weapon-charm',
  'attach-coverage',
  'detach-coverage',
  'artifact-regen',
  'sentient-conflict',
  'artifact-reroll',
] as const;

export type InventoryActionSlug = (typeof INVENTORY_ACTION_SLUGS)[number];

export class InventoryActionDto {
  @ApiProperty({
    enum: INVENTORY_ACTION_SLUGS,
    example: 'attach-coverage',
  })
  @IsString()
  @IsIn([...INVENTORY_ACTION_SLUGS])
  actionSlug!: InventoryActionSlug;

  @ApiPropertyOptional({
    example: 'longsword',
    description: 'Arma alvo (weapon-charm) ou peça base (coverage)',
  })
  @IsOptional()
  @ValidateIf((_, v) => v != null)
  @IsString()
  @IsNotEmpty()
  weaponSlug?: string;

  @ApiPropertyOptional({ example: 'longsword' })
  @IsOptional()
  @ValidateIf((_, v) => v != null)
  @IsString()
  @IsNotEmpty()
  baseItemSlug?: string;

  @ApiPropertyOptional({ example: 'weapon-charm-blade-1' })
  @IsOptional()
  @ValidateIf((_, v) => v != null)
  @IsString()
  @IsNotEmpty()
  charmSlug?: string;

  @ApiPropertyOptional({ example: 'arma-1-2-ou-3' })
  @IsOptional()
  @ValidateIf((_, v) => v != null)
  @IsString()
  @IsNotEmpty()
  coverageSlug?: string;

  @ApiPropertyOptional({
    example: 2,
    description: 'Tier +1/+2/+3 das coberturas *-1-2-ou-3',
  })
  @IsOptional()
  @IsInt()
  @IsIn([1, 2, 3])
  bonus?: 1 | 2 | 3;

  @ApiPropertyOptional({
    example: 'bola-de-fogo',
    description: 'Magia vinculada (Enspelled)',
  })
  @IsOptional()
  @ValidateIf((_, v) => v != null)
  @IsString()
  @IsNotEmpty()
  spellSlug?: string;

  @ApiPropertyOptional({
    example: 'olho-de-vecna',
    description:
      'Item de inventário (artifact-regen / sentient-conflict / artifact-reroll)',
  })
  @IsOptional()
  @ValidateIf((_, v) => v != null)
  @IsString()
  @IsNotEmpty()
  itemSlug?: string;
}
