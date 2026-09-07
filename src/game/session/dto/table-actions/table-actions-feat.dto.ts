import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsOptional, IsString } from 'class-validator';

export class UseFeatTableActionDto {
  @ApiProperty({ example: 'healer' })
  @IsString()
  featSlug!: string;

  @ApiProperty({ example: 'healer-combat-medic' })
  @IsString()
  actionSlug!: string;

  @ApiPropertyOptional({
    example: 'escada',
    description: 'Item da tabela Fabricação Rápida (artisan-craft)',
  })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({
    example: true,
    description: 'Força ligar/desligar toggle de circunstância (snow/água/frio)',
  })
  @IsOptional()
  @IsBoolean()
  enabled?: boolean;
}
