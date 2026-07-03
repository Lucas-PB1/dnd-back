import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class WeaponResponseDto {
  @ApiProperty({ example: 'longsword' })
  slug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  name!: string;

  @ApiProperty({ example: 'martial_melee' })
  category!: string;

  @ApiPropertyOptional({ example: '1d8' })
  damage!: string | null;

  @ApiPropertyOptional({ example: 'cortante' })
  damageType!: string | null;

  @ApiPropertyOptional()
  cost!: Record<string, unknown> | null;

  @ApiPropertyOptional()
  weight!: string | null;

  @ApiPropertyOptional()
  properties!: Record<string, unknown> | null;
}
