import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
  ValidateIf,
} from 'class-validator';

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

  @ApiPropertyOptional({
    example: true,
    description:
      'Default true. Se false e a campanha permitir skip, adiciona sem debitar',
  })
  @IsOptional()
  @IsBoolean()
  pay?: boolean;
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
      'Sintonizar / dessintonizar a cobertura anexada (máx. 3; só se a cobertura exige)',
  })
  @IsOptional()
  @IsBoolean()
  attachedCoverageAttuned?: boolean;

  @ApiPropertyOptional({
    example: true,
    description:
      'Marcar / desmarcar como Arma de Pacto (Bruxo com Pacto da Lâmina; no máx. 1)',
  })
  @IsOptional()
  @IsBoolean()
  pactWeapon?: boolean;

  @ApiPropertyOptional({
    example: 'bola-de-fogo',
    description: 'Vincular magia em item Enspelled único (ex.: Cajado Magificado)',
  })
  @IsOptional()
  @ValidateIf((_, value) => value != null)
  @IsString()
  @IsNotEmpty()
  boundSpellSlug?: string | null;

  @ApiPropertyOptional({
    example: 'mochila',
    description: 'Mover para recipiente (slug) ou null para raiz',
    nullable: true,
  })
  @IsOptional()
  @ValidateIf((_, value) => value != null)
  @IsString()
  containedInItemSlug?: string | null;
}
