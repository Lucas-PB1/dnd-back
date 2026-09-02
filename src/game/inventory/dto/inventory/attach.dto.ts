import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
} from 'class-validator';

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

export class AttachCoverageDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  @IsNotEmpty()
  baseItemSlug!: string;

  @ApiProperty({ example: 'arma-1-2-ou-3' })
  @IsString()
  @IsNotEmpty()
  coverageSlug!: string;

  @ApiPropertyOptional({
    example: 2,
    description: 'Obrigatório para coberturas *-1-2-ou-3',
  })
  @IsOptional()
  @IsInt()
  @IsIn([1, 2, 3])
  bonus?: 1 | 2 | 3;

  @ApiPropertyOptional({
    example: 'bola-de-fogo',
    description: 'Obrigatório para coberturas Enspelled (arma/armadura magificada)',
  })
  @IsOptional()
  @IsString()
  @IsNotEmpty()
  spellSlug?: string;
}

export class DetachCoverageDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  @IsNotEmpty()
  baseItemSlug!: string;
}
