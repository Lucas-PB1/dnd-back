import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  ArrayMinSize,
  IsArray,
  IsBoolean,
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';

export class PurchaseInventoryLineDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  @IsNotEmpty()
  itemSlug!: string;

  @ApiPropertyOptional({ example: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  quantity?: number;

  /** Aplicar cobertura nesta linha (peça base já no inventário ou comprada na mesma TX). */
  @ApiPropertyOptional({ example: 'arma-1-2-ou-3' })
  @IsOptional()
  @IsString()
  @IsNotEmpty()
  attachCoverageSlug?: string;

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  @IsIn([1, 2, 3])
  attachCoverageBonus?: 1 | 2 | 3;

  @ApiPropertyOptional({
    example: 'longsword',
    description:
      'Host existente no inventário; se omitido e a linha for coverage, use itemSlug como coverage',
  })
  @IsOptional()
  @IsString()
  @IsNotEmpty()
  attachToBaseSlug?: string;
}

export class PurchaseInventoryDto {
  @ApiProperty({ type: [PurchaseInventoryLineDto] })
  @IsArray()
  @ArrayMinSize(1)
  @ValidateNested({ each: true })
  @Type(() => PurchaseInventoryLineDto)
  lines!: PurchaseInventoryLineDto[];

  @ApiPropertyOptional({
    example: true,
    description:
      'Default true. Se false e a campanha permitir skip, compra sem debitar',
  })
  @IsOptional()
  @IsBoolean()
  pay?: boolean;
}
