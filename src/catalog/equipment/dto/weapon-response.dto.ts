import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class WeaponTraitDto {
  @ApiProperty({ example: 'finesse' })
  slug!: string;

  @ApiProperty({ example: 'Acuidade' })
  name!: string;

  @ApiProperty()
  description!: string;
}

export class WeaponRangeDto {
  @ApiPropertyOptional({ example: 20 })
  normal!: number | null;

  @ApiPropertyOptional({ example: 60 })
  max!: number | null;
}

export class WeaponResponseDto {
  @ApiProperty({ example: 'longsword' })
  slug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  name!: string;

  @ApiProperty({ example: 'martial' })
  category!: string;

  @ApiPropertyOptional({ example: '1d8' })
  damage!: string | null;

  @ApiPropertyOptional({ example: 'Cortante' })
  damageType!: string | null;

  @ApiPropertyOptional({ example: '1d10', description: 'Damage when used two-handed (Versatile)' })
  versatileDamage!: string | null;

  @ApiPropertyOptional()
  cost!: Record<string, unknown> | null;

  @ApiPropertyOptional()
  weight!: string | null;

  @ApiPropertyOptional({ type: WeaponRangeDto })
  range!: WeaponRangeDto | null;

  @ApiProperty({ type: [WeaponTraitDto] })
  propertyDetails!: WeaponTraitDto[];

  @ApiPropertyOptional({ type: WeaponTraitDto })
  mastery!: WeaponTraitDto | null;
}
